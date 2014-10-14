'use strict';

/**
 * @ngdoc overview
 * @name tvpubApp
 * @description
 * # tvpubApp
 *
 * Main module of the application.
 */
angular
  .module('tvpubApp', [
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch'
  ])
  .config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrl'
      })
      .when('/about', {
        templateUrl: 'views/about.html',
        controller: 'AboutCtrl'
      })
      .when('/home', {
        templateUrl: 'views/home.html',
        controller: 'HomeCtrl'
      })
      .when('/viewShow', {
        templateUrl: 'views/viewshow.html',
        controller: 'ViewshowCtrl'
      })
      .otherwise({
        redirectTo: '/'
      });
  });
