'use strict';

/**
 * @ngdoc service
 * @name tvpubApp.User
 * @description
 * # User
 * Factory in the tvpubApp.
 */
angular.module('tvpubApp')
  .factory('User', function ($resource) {
    return $resource('/api/users/:id/:controller', {
      id: '@_id'
    },
    {
      changePassword: {
        method: 'PUT',
        params: {
          controller:'password'
        }
      },
      get: {
        method: 'GET',
        params: {
          id:'me'
        }
      }
    });
  });
