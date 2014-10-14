'use strict';

/**
 * @ngdoc function
 * @name tvpubApp.controller:HomeCtrl
 * @description
 * # HomeCtrl
 * Controller of the tvpubApp
 */
angular.module('tvpubApp')
  .controller('HomeCtrl', function ($scope, $http) {

    function createUnknownError(status) {
      return {
        status: status,
        statusText: 'Internal Server Error',
        description: 'No details available'
      };
    }

    $scope.recentlyWatched =
    [
      {
        "name": "show1",
        "description": "blah1"
      },
      {
        "name": "show2",
        "description": "blah2"
      },
      {
        "name": "show3",
        "description": "blah3"
      },
      {
        "name": "show4",
        "description": "blah4"
      },
      {
        "name": "show5",
        "description": "blah5"
      },
      {
        "name": "show6",
        "description": "blah6"
      }
    ];
    $scope.watched = true;

    $scope.friendsRecentlyWatched =
    [
      {
        "name": "show1",
        "description": "blah1"
      },
      {
        "name": "show2",
        "description": "blah2"
      },
      {
        "name": "show3",
        "description": "blah3"
      },
      {
        "name": "show4",
        "description": "blah4"
      },
      {
        "name": "show5",
        "description": "blah5"
      },
      {
        "name": "show6",
        "description": "blah6"
      }
    ];

    $scope.friendsWatched = true;

    $scope.messages =
    [
      {
        "subject": "hello!",
        "sender": "Bert"
      },
      {
        "subject": "can't believe it!!",
        "sender": "Kate"
      }
    ];

    $scope.haveMessages = true;


    // Get awesome things list
    $http({method: 'GET', url: '/api/features'}).

      success(function (data) {
        $scope.loading = false;
        $scope.awesomeThings = data;

        // Get description of each thing
        $scope.awesomeThings.forEach(function (thing) {
          thing.loading = true;

          $http({method: 'GET', url: thing.href}).
            success(function (data) {
              thing.loading = false;
              thing.description = data.description;
            }).
            error(function (data, status) {
              thing.loading = false;
              thing.error = data && data.description ? data : createUnknownError(status);
            });
        });
      }).

      error(function (data, status) {
        $scope.loading = false;
        $scope.error = data && data.description ? data : createUnknownError(status);
      });
  });
