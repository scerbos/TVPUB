<?php

namespace Api;

use Api\Model\Features;
use \Slim\Slim;
use Illuminate\Database\Capsule\Manager as Capsule;
use Cartalyst\Sentry\Facades\Native\Sentry as Sentry;
use \Exception;

// TODO Move all "features" things to a class with index() and get() methods
class Application extends Slim
{
    public $configDirectory;
    public $config;
    public $connection;
    public $dbConn;

    protected function initConfig()
    {

        // Create a new Database connection
        $capsule = new Capsule;

        $capsule->addConnection([
            'driver'    => 'mysql',
            'host'      => 'localhost',
            'database'  => 'employees',
            'username'  => 'employees',
            'password'  => 'employees',
            'charset'   => 'utf8',
            'collation' => 'utf8_unicode_ci',
        ]);

        $capsule->bootEloquent();

        $config = array();
        if (!file_exists($this->configDirectory) || !is_dir($this->configDirectory)) {
            throw new Exception('Config directory is missing: ' . $this->configDirectory, 500);
        }
        foreach (preg_grep('/\\.php$/', scandir($this->configDirectory)) as $filename) {
            $config = array_replace_recursive($config, include $this->configDirectory . '/' . $filename);
        }
        return $config;
    }

    protected function dbConnect()
    {
        $dbData = $this->config['dbData'];

        $this->dbConn = mysqli_connect($dbData['host'], $dbData['username'], $dbData['password'], $dbData['database']);

        if ($this->dbConn->connect_error) {
            die('Error : ('. $this->dbConn->connect_errno .') '. $this->dbConn->connect_error);
        }
    }

    protected function dbSelect($queryString, $array = false)
    {
        //Replace * in the query with the column names.
        $result = $this->dbConn->query($queryString);

        if ($array) {
            while ($row = $result->fetch_array(MYSQL_ASSOC)) {
                $json_response[] = $row;
            }
        } else {
            $json_response = $result->fetch_assoc();
        }

        $result->close();

        return json_encode($json_response);
    }

    protected function dbInsert($table, $record)
    {
        $keys = array();
        $values = array();
        foreach (json_decode($record, true) as $key => $value) {
            $keys[] = mysqli_real_escape_string($this->dbConn, $key);
            $values[] = "'" . mysqli_real_escape_string($this->dbConn, $value) . "'";
        }

        $insert = 'INSERT INTO '. $table . ' (' . implode(",", $keys) . ') '
            . 'VALUES ( ' . implode(",", $values) . ' )';

        $insertRow = $this->dbConn->query($insert);

        if ($insertRow) {
            return 'Success! ID of last inserted record is : ' . $this->dbConn->insert_id .'<br />';
        } else {
            die ('Error : (' . $this->dbConn->errno . ') ' . $this->dbConn->error);
        }
    }

    protected function dbUpdate($table, $record, $selector)
    {
        $values = array();
        foreach (json_decode($record, true) as $key => $value) {
            $values[] = mysqli_real_escape_string($this->dbConn, $key) . "='"
                . mysqli_real_escape_string($this->dbConn, $value) . "'";
        }

        $update = 'UPDATE '. $table . ' SET ' . implode(",", $values) . ' WHERE ' . $selector;

        //MySqli Query
        $updateRow = $this->dbConn->query($update);

        if ($updateRow) {
            return 'Success! record updated';
        } else {
            die ('Error : (' . $this->dbConn->errno . ') ' . $this->dbConn->error);
        }
    }

    protected function dbDelete($table, $selector)
    {
        $delete = 'DELETE FROM ' . $table . ' WHERE ' . $selector;

        //MySqli Query
        $deleteRow = $this->dbConn->query($delete);

        if ($deleteRow) {
            return 'Success! record deleted';
        } else {
            die ('Error : (' . $this->dbConn->errno . ') ' . $this->dbConn->error);
        }
    }

    protected function dbClose()
    {
        $this->dbConn->close();
    }

    public function __construct(array $userSettings = array(), $configDirectory = 'config')
    {
        // Slim initialization
        parent::__construct($userSettings);
        $this->config('debug', false);
        $this->notFound(function () {
            $this->handleNotFound();
        });
        $this->error(function ($e) {
            $this->handleException($e);
        });

        // Config
        $this->configDirectory = __DIR__ . '/../../' . $configDirectory;
        $this->config = $this->initConfig();

        // /users
        $this->post('/api/users', function () {
            $data = json_decode($this->request->getBody());

            try {
                // Create the user
                $user = Sentry::createUser(array(
                    'first_name'=> $data->{'name'},
                    'email'     => $data->{'email'},
                    'password'  => $data->{'password'},
                    'activated' => true,
                ));

                // Log the user in
                Sentry::login($user, false);

                $res = json_encode($user);
            } catch (Cartalyst\Sentry\Users\LoginRequiredException $e) {
                $res = 'Login field is required.';
            } catch (Cartalyst\Sentry\Users\PasswordRequiredException $e) {
                $res = 'Password field is required.';
            } catch (Cartalyst\Sentry\Users\UserExistsException $e) {
                $res = 'User with this login already exists.';
            }

            $this->response->headers->set('Content-Type', 'application/json');
            $this->response->setBody($res);
        });

        $this->get('/api/users/me', function () {
            if (! Sentry::check()) {
                $this->response->setStatus(401);
            } else {
                $this->response->headers->set('Content-Type', 'application/json');
                $this->response->setBody(json_encode(Sentry::getUser()));
            }
        });

        // /auth
        $this->post('/api/auth/login', function () {
            $data = json_decode($this->request->getBody());

            try {
            // Login credentials
                $credentials = array(
                    'email'     => $data->{'email'},
                    'password'  => $data->{'password'},
                );

                // Authenticate the user
                $user = Sentry::authenticate($credentials, true);
                $res = json_encode($user);
            } catch (Cartalyst\Sentry\Users\LoginRequiredException $e) {
                $res = 'Login field is required.';
            } catch (Cartalyst\Sentry\Users\PasswordRequiredException $e) {
                $res = 'Password field is required.';
            } catch (Cartalyst\Sentry\Users\WrongPasswordException $e) {
                $res = 'Wrong password, try again.';
            } catch (Cartalyst\Sentry\Users\UserNotFoundException $e) {
                $res = 'User was not found.';
            } catch (Cartalyst\Sentry\Users\UserNotActivatedException $e) {
                $res = 'User is not activated.';
            }

            $this->response->headers->set('Content-Type', 'application/json');
            $this->response->setBody($res);
        });

        $this->post('/api/auth/logout', function () {
            Sentry::logout();

            $this->response->headers->set('Content-Type', 'application/json');
            $this->response->setBody('Logged Out!');
        });

        // /series
        $this->get('/api/user/:id/shows', function () {
            $this->dbConnect();
            $shows = $this->dbSelect("SELECT * FROM Series s WHERE NOT EXISTS (SELECT * FROM Users u WHERE NOT EXISTS (SELECT * FROM user_to_series us WHERE us.user_id = u.id AND us.series_id = s.id))", true);

            $this->response->headers->set('Content-Type', 'application/json');
            $this->response->setBody($shows);
            $this->dbClose();
        });

        $this->get('/api/series', function () {
            $this->dbConnect();
            $shows = $this->dbSelect("SELECT * from series", true);

            $this->response->headers->set('Content-Type', 'application/json');
            $this->response->setBody($shows);
            $this->dbClose();
        });

        $this->get('/api/series/:id', function ($id) {
            $this->dbConnect();
            $id = mysqli_real_escape_string($this->dbConn, $id);
            $shows = $this->dbSelect("SELECT * from series WHERE id = '$id'", true);

            $this->response->headers->set('Content-Type', 'application/json');
            $this->response->setBody($shows);
            $this->dbClose();
        });

        $this->post('/api/employees', function () {
            $this->dbConnect();
            $body = $this->request->getBody();
            $newEmployee = $this->dbInsert("employee", $body);

            $this->response->headers->set('Content-Type', 'application/json');
            $this->response->setBody($newEmployee);
            $this->dbClose();
        });

        $this->put('/api/employees/:id', function ($id) {
            $this->dbConnect();
            $body = $this->request->getBody();
            $id = mysqli_real_escape_string($this->dbConn, $id);
            $updatedEmployee = $this->dbUpdate("employee", $body, "id_employee = '$id'");

            $this->response->headers->set('Content-Type', 'application/json');
            $this->response->setBody($updatedEmployee);
            $this->dbClose();
        });

        $this->delete('/api/employees/:id', function ($id) {
            $this->dbConnect();
            $id = mysqli_real_escape_string($this->dbConn, $id);
            $deletedEmployee = $this->dbDelete("employee", "id_employee = '$id'");

            $this->response->headers->set('Content-Type', 'application/json');
            $this->response->setBody($deletedEmployee);
            $this->dbClose();
        });
    }

    public function handleNotFound()
    {
        throw new Exception(
            'Resource ' . $this->request->getResourceUri() . ' using '
            . $this->request->getMethod() . ' method does not exist.',
            404
        );
    }

    public function handleException(Exception $e)
    {
        $status = $e->getCode();
        $statusText = \Slim\Http\Response::getMessageForCode($status);
        if ($statusText === null) {
            $status = 500;
            $statusText = 'Internal Server Error';
        }

        $this->response->setStatus($status);
        $this->response->headers->set('Content-Type', 'application/json');
        $this->response->setBody(json_encode(array(
            'status' => $status,
            'statusText' => preg_replace('/^[0-9]+ (.*)$/', '$1', $statusText),
            'description' => $e->getMessage(),
        )));
    }

    /**
     * @return \Slim\Http\Response
     */
    public function invoke()
    {
        foreach ($this->middleware as $middleware) {
            $middleware->call();
        }
        $this->response()->finalize();
        return $this->response();
    }
}
