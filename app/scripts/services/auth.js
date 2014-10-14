'use strict';

/**
 * @ngdoc service
 * @name tvpubApp.auth
 * @description
 * # auth
 * Factory in the tvpubApp.
 */
angular.module('tvpubApp')
  .factory('Auth', function ($http, $cookies, User, $q) {
    var currentUser = {};

    // Public API here
    return {
      /**
       * Authenticate user and save token
       *
       * @param  {Object}   user     - login info
       * @param  {Function} callback - optional
       * @return {Promise}
       */
      login: function(user, callback) {
        var cb = callback || angular.noop;
        var deferred = $q.defer();

        $http.post('api/auth/login', {
          email: user.email,
          password: user.password
        }).
        success(function(data) {
          currentUser = User.get();
          deferred.resolve(data);
          return cb();
        }).
        error(function(err) {
          this.logout();
          deferred.reject(err);
          return cb(err);
        }.bind(this));

        return deferred.promise;
      },

      /**
       * Delete access token and user info
       *
       * @param  {Function}
       */
      logout: function() {
        currentUser = {}

        $http.post('api/auth/logout');
      },

      /**
       * Create a new user
       *
       * @param  {Object}   user     - user info
       * @param  {Function} callback - optional
       * @return {Promise}
       */
      createUser: function(user, callback) {
        var cb = callback || angular.noop;

        return User.save(user,
          function(data) {
            currentUser = User.get();
            return cb(user);
          },
          function(err) {
            this.logout();
            return cb(err);
          }.bind(this)).$promise;
      },

      /**
       * Gets all available info on authenticated user
       *
       * @return {Object} user
       */
      getCurrentUser: function(onSuccess, onFailure) {
        var cbsuc = onSuccess || angular.noop;
        var cberr = onFailure || angular.noop;

        if (currentUser.hasOwnProperty('permissions')) {
          return cbsuc(currentUser);
        } else {
          User.get(
          function(user) {
            currentUser = user;
            return cbsuc(user);
          }, function(err) {
            currentUser = {};
            return cberr(err);
          });
        }
      },

      /**
       * Check if a user is logged in
       *
       * @return {Boolean}
       */
      isLoggedIn: function() {
        return currentUser.hasOwnProperty('permissions');
      },

      /**
       * Waits for currentUser to resolve before checking if user is logged in
       */
      isLoggedInAsync: function(cb) {
        if(currentUser.hasOwnProperty('permissions')) {
          currentUser.$promise.then(function() {
            cb(true);
          }).catch(function() {
            cb(false);
          });
        } else {
          cb(false);
        }
      },
    };
  });
