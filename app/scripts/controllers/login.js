'use strict';

/**
 * @ngdoc function
 * @name tvpubApp.controller:LoginCtrl
 * @description
 * # LoginCtrl
 * Controller of the tvpubApp
 */
angular.module('tvpubApp')
  .controller('LoginCtrl', function ($scope, Auth, $location) {
    $scope.errors = {};
    $scope.user = {};

    $scope.login = function(form) {
      $scope.submitted = true;

      if(form.$valid) {
        Auth.login({
          email: $scope.user.email,
          password: $scope.user.password
        })
        .then( function() {
          // Logged in, redirect to home
          $location.path('/');
        })
        .catch( function(err) {
          $scope.errors.other = err.message;
        });
      }
    };
   
  });
