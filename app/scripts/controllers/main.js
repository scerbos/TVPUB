'use strict';

/**
 * @ngdoc function
 * @name tvpubApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the tvpubApp
 */
angular.module('tvpubApp')
  .controller('MainCtrl', function ($scope, Auth, $resource) {
    var Employee = $resource('api/employees/:employeeId', {employeeId:'@id'}, {'update': { method:'PUT' }});

    var allEmployees = Employee.query(function() {
      $scope.loading = false;
    });

    var oneEmployee = Employee.get({employeeId:1}, function() {});

    $scope.addEmployee = function() {
      var newEmployee = new Employee({id_employee:11, emp_name:'REEVES', designation:'CLERK', date_joined:'2014-12-17', salary:3500.00, id_dept:35});
      newEmployee.$save();
    };

    $scope.updateEmployee = function() {
      Employee.update({employeeId:11}, {emp_name:'REAVES'});
    };

    $scope.deleteEmployee = function() {
      Employee.delete({employeeId:11}, function() {});
    };

    $scope.user = {};
    $scope.errors = {};
    $scope.submitted = false;

    $scope.register = function(form) {
      $scope.submitted = true;

      console.log('submitting');

      if(form.$valid) {
        console.log('creating user');
        Auth.createUser({
          email: $scope.user.email,
          password: $scope.user.password
        })
        .catch( function(err) {
          err = err.data;
          console.log(err.description);
        });
      }
    };

    $scope.logout = function() {
      Auth.logout();
    };

    $scope.login = function(form) {
      $scope.submitted = true;

      if(form.$valid) {
        Auth.login({
          email: $scope.user.email,
          password: $scope.user.password
        })
        .catch( function(err) {
          $scope.errors.other = err.message;
        });
      }
    };

    

    $scope.test = ''

    Auth.getCurrentUser( function(user) {
      $scope.test = user;

      console.log(Auth.isLoggedIn());
      Auth.isLoggedIn();
    }, function() {
      $scope.test = 'fail';
      Auth.isLoggedIn();
    });

    $scope.searchResults =
    [
      {
        "name": "show1",
        "description": "blah1",
        "image": "images/animated-television.gif"
      },
      {
        "name": "show2",
        "description": "blah2",
        "image": "images/animated-television.gif"
      },
      {
        "name": "show3",
        "description": "blah3",
        "image": "images/animated-television.gif"
      },
      {
        "name": "show4",
        "description": "blah4",
        "image": "images/animated-television.gif"
      },
      {
        "name": "show5",
        "description": "blah5",
        "image": "images/animated-television.gif"
      },
      {
        "name": "show6",
        "description": "blah6",
        "image": "images/animated-television.gif"
      }
    ];
    $scope.searched = true;

  });
