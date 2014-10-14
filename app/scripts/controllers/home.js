'use strict';

/**
 * @ngdoc function
 * @name tvpubApp.controller:HomeCtrl
 * @description
 * # HomeCtrl
 * Controller of the tvpubApp
 */
angular.module('tvpubApp')
  .controller('HomeCtrl', function ($scope, Auth, $http, $resource) {
    var Series = $resource('api/user/:uid/series/:sid', {uid:'@id', sid:'@id'});

    Auth.getCurrentUser(function(user) {
      $scope.getCurrentUser = user;

      $scope.recentlyWatched = Series.query({uid:user.id}, function() {
        $scope.loading = false;
      });
    }); 

    $scope.removeSeries = function(sid) {
      Auth.getCurrentUser(function(user) {
        Series.delete({uid:user.id, sid:sid}, function() {
          $scope.recentlyWatched = Series.query({uid:user.id}, function() {
            $scope.loading = false;
          });
        });
      });
    }
    

    // $scope.recentlyWatched = 
    // [
    //   {
    //     "name": "show1",
    //     "description": "blah1"
    //   },
    //   {
    //     "name": "show2",
    //     "description": "blah2"
    //   },
    //   {
    //     "name": "show3",
    //     "description": "blah3"
    //   },
    //   {
    //     "name": "show4",
    //     "description": "blah4"
    //   },
    //   {
    //     "name": "show5",
    //     "description": "blah5"
    //   },
    //   {
    //     "name": "show6",
    //     "description": "blah6"
    //   }
    // ];
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

  });
