<?php

namespace Api;

use Api\Model\Features;
use \Slim\Slim;
use \Exception;

// TODO Move all "features" things to a class with index() and get() methods
class Application extends Slim
{
    public $configDirectory;
    public $config;
    public $connection;

    protected function initConfig()
    {
      $config = array();
      if (!file_exists($this->configDirectory) || !is_dir($this->configDirectory)) {
        throw new Exception('Config directory is missing: ' . $this->configDirectory, 500);
      }
      foreach (preg_grep('/\\.php$/', scandir($this->configDirectory)) as $filename) {
        $config = array_replace_recursive($config, include $this->configDirectory . '/' . $filename);
      }
      return $config;
    }

    protected function dbConfig()
    {
      //Create Database connection
      $db = mysqli_connect("localhost","employees","employees","employees");

      // Check connection
      if (mysqli_connect_errno()) {
        echo "Failed to connect to MySQL: " . mysqli_connect_error();
      }
    
      //Replace * in the query with the column names.
      $result = $db->query("select * from employee");  
      
      //Create an array
      $json_response = array();
      
      while ($row = $result->fetch_array(MYSQL_ASSOC)) {
          $row_array['id_employee'] = $row['id_employee'];
          $row_array['emp_name'] = $row['emp_name'];
          $row_array['designation'] = $row['designation'];
          $row_array['date_joined'] = $row['date_joined'];
          $row_array['salary'] = $row['salary'];
          $row_array['id_dept'] = $row['id_dept'];
          
          //push the values in the array
          array_push($json_response,$row_array);
      }
      // echo json_encode($json_response);
      
      //Close the database connection
      $result->close();
      $db->close();

      return json_encode($json_response);
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



      // /features
      $this->get('/api/features', function () {
        $features = new Features($this->config['features']);
        $this->response->headers->set('Content-Type', 'application/json');
        $this->response->setBody(json_encode($features->getFeatures()));
      });

      $this->get('/api/features/:id', function ($id) {
        $features = new Features($this->config['features']);
        $feature = $features->getFeature($id);
        if ($feature === null) {
            return $this->notFound();
        }
        $this->response->headers->set('Content-Type', 'application/json');
        $this->response->setBody(json_encode($feature));
      });

      // /test
      $this->get('/api/employees', function () {
        $employees = $this->dbConfig();
        $this->response->headers->set('Content-Type', 'application/json');
        $this->response->setBody($employees);
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
