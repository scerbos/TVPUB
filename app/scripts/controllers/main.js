'use strict';

/**
 * @ngdoc function
 * @name tvpubApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the tvpubApp
 */
angular.module('tvpubApp')
  .controller('MainCtrl', function ($scope, $http, $resource) {

    function createUnknownError(status) {
      return {
        status: status,
        statusText: 'Internal Server Error',
        description: 'No details available'
      };
    }

    $scope.awesomeThings = [];
    $scope.loading = true;

    var Features = $resource('api/features/:featureId', {featureId:'@id'}, {});

    var allFeatures = Features.query(function() {
      $scope.loading = false;
      $scope.awesomeThings = allFeatures;
    });

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

    // Get awesome things list
    // $http({method: 'GET', url: '/api/features'}).

    //   success(function (data) {
    //     $scope.loading = false;
    //     $scope.awesomeThings = data;

    //     console.log(data);

    //     // Get description of each thing
    //     $scope.awesomeThings.forEach(function (thing) {
    //       thing.loading = true;

    //       console.log(thing.href);

    //       $http({method: 'GET', url: thing.href}).
    //         success(function (data) {
    //           thing.loading = false;
    //           thing.description = data.description;
    //         }).
    //         error(function (data, status) {
    //           thing.loading = false;
    //           thing.error = data && data.description ? data : createUnknownError(status);
    //         });
    //     });
    //   }).

    //   error(function (data, status) {
    //     $scope.loading = false;
    //     $scope.error = data && data.description ? data : createUnknownError(status);
    //   });
  });
