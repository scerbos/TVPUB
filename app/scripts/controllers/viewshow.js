'use strict';

/**
 * @ngdoc function
 * @name tvpubApp.controller:ViewshowCtrl
 * @description
 * # ViewshowCtrl
 * Controller of the tvpubApp
 */
angular.module('tvpubApp')
  .controller('ViewshowCtrl', function ($scope, $http) {

    function createUnknownError(status) {
      return {
        status: status,
        statusText: 'Internal Server Error',
        description: 'No details available'
      };
    }

    $scope.tvshow =
    [
      {
        "title": "Parks & Recreation",
        "description": "Parks & Rec...",
        "status": "ON AIR"
      }
    ];
    $scope.hasStatus = true;

    $scope.actors =
    [
      {
        "name": "Amy Poehler"
      },
      {
        "name": "Rashida Jones"
      }
    ];
    $scope.hasActors = true;

    $scope.seasons =
    [
      {
        "number": "1"
      },
      {
        "number": "2"
      }
    ];
    $scope.hasSeasons = true;

    $scope.episodes =
    [
      {
        "number": "1",
        "name": "name1",
        "description": "description1"
      },
      {
        "number": "2",
        "name": "name2",
        "description": "description2"
      }
    ];
    $scope.hasEpisodes = true;


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
