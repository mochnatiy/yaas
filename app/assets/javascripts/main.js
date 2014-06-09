//= require_self
//= require_tree ./services/main
//= require_tree ./filters/main
//= require_tree ./controllers/main
//= require_tree ./directives/main

var Blog = angular.module('Blog', ['ngRoute', 'ui.bootstrap']);

Blog.config(function($routeProvider, $locationProvider, $httpProvider) {
  $locationProvider.html5Mode(true);
  
  $routeProvider
    .when('/posts/new', { templateUrl: '../assets/mainCreatePost.html', controller: 'CreatePostCtrl' })
    .when('/posts/:postId', { templateUrl: '../assets/mainPost.html', controller: 'PostCtrl' })
    .when('/posts/:postId/edit', { templateUrl: '/assets/mainEditPost.html', controller: 'EditPostCtrl' })
    .otherwise({ templateUrl: '../assets/mainIndex.html', controller: 'IndexCtrl' });
  
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
});
