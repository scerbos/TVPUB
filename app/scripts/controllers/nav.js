'use strict';

/**
 * @ngdoc function
 * @name tvpubApp.controller:NavCtrl
 * @description
 * # NavCtrl
 * Controller of the tvpubApp
 */
angular.module('tvpubApp')
  .controller('NavCtrl', function ($scope, $location, Auth) {
    $scope.isCollapsed = true;
    $scope.isLoggedIn = Auth.isLoggedIn;
    $scope.isAdmin = false; //Auth.isAdmin();
    
    Auth.getCurrentUser(function(user) {
      $scope.getCurrentUser = user;
    }, function() {
      $scope.getCurrentUser = '';
    });

    $scope.logout = function() {
      Auth.logout();
      $location.path('/#/login');
    };

    $scope.isActive = function(route) {
      return route === $location.path();
    };
  });
