'use strict';

/**
 * @ngdoc overview
 * @name cloudPosApp
 * @description
 * # cloudPosApp
 *
 * Main module of the application.
 */
angular
  .module('cloudPosApp', [
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'isteven-multi-select',
    'ngTouch',
    'templates',
    'mgcrea.ngStrap'
  ])
  .config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'main.html',
        controller: 'MainCtrl'
      })
      .when('/products', {
        templateUrl: 'products.html',
        controller: 'ProductsCtrl'
      })
      .when('/products/new', {
        templateUrl: 'product-edit.html',
        controller: 'ProductsCtrl'
      })
      .when('/products/:id/edit', {
        templateUrl: 'product-edit.html',
        controller: 'ProductsCtrl'
      })
      .when('/sales', {
        templateUrl: 'sales.html',
        controller: 'SalesCtrl'
      })
      .otherwise({
        redirectTo: '/'
      });
  });
