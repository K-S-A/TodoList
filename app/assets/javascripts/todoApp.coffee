'use strict'

angular.module('todoList', [
  'ui.router'
  'templates'
  'Devise'
]).config [
  '$stateProvider'
  '$urlRouterProvider'
  ($stateProvider, $urlRouterProvider) ->
    $stateProvider.state('home',
      url: '/home'
      templateUrl: 'auth/_login.html'
      controller: 'AuthCtrl'
      ).state('login',
      url: '/login'
      templateUrl: 'auth/_login.html'
      controller: 'AuthCtrl as vm'
      onEnter: [
        '$state'
        'Auth'
        ($state, Auth) ->
          Auth.currentUser().then ->
            $state.go 'home'
            return
          return
      ]).state 'register',
      url: '/register'
      templateUrl: 'auth/_register.html'
      controller: 'AuthCtrl as vm'
      onEnter: [
        '$state'
        'Auth'
        ($state, Auth) ->
          Auth.currentUser().then ->
            $state.go 'home'
            return
          return
      ]

    $urlRouterProvider.otherwise 'home'
    return
]
