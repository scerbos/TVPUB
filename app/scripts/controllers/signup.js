'use strict';

/**
 * @ngdoc function
 * @name tvpubApp.controller:SignupCtrl
 * @description
 * # SignupCtrl
 * Controller of the tvpubApp
 */
angular.module('tvpubApp')
  .controller('SignupCtrl', function ($scope, Auth, $location) {
    $scope.user = {};
    $scope.errors = {};

    $scope.register = function(form) {
      $scope.submitted = true;

      if(form.$valid) {
        Auth.createUser({
          name: $scope.user.name,
          email: $scope.user.email,
          password: $scope.user.password
        })
        .then( function() {
          // Account created, redirect to home
          $location.path('/');
        })
        .catch( function(err) {
          err = err.data;
          $scope.errors = {};
        });
      }
    };
  });
