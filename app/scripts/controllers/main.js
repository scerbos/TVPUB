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


    var CreditCard = $resource('api/features/:featureId',
      {featureId:'@id'}, {
        charge: {method:'POST', params:{charge:true}}
      });

    var cards = CreditCard.query(function() {
      var card = cards[0];
      console.log(cards);


      // $scope.loading = false;
      // $scope.awesomeThings = data;

    });
    // console.log(cards);


    // Get awesome things list
    $http({method: 'GET', url: '/api/features'}).

      success(function (data) {
        $scope.loading = false;
        $scope.awesomeThings = data;

        console.log(data);

        // Get description of each thing
        $scope.awesomeThings.forEach(function (thing) {
          thing.loading = true;

          console.log(thing.href);

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
