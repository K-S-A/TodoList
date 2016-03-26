'use strict'

angular.module('todoList', [
  'ui.router'
  'ui.bootstrap'
  'ui.sortable'
  'templates'
  'Devise'
  'rails'
  'xeditable'
]).config([
  '$stateProvider'
  '$urlRouterProvider'
  ($stateProvider, $urlRouterProvider) ->
    $stateProvider
      .state 'home',
        url: '/home'
        templateUrl: 'home/home.html'
      .state 'login',
        url: '/login'
        templateUrl: 'auth/login.html'
        controller: 'AuthCtrl as vm'
      .state 'register',
        url: '/register'
        templateUrl: 'auth/register.html'
        controller: 'AuthCtrl as vm'
      .state 'projects',
        url: '/projects'
        templateUrl: 'projects/index.html'
        controller: 'ProjectsCtrl as vm'
        resolve: data: ['Project', (Project) ->
          Project.get().then (data) ->
            Project.all = data
            Project.current = {}]
      .state 'project',
        url: '/projects/{id:[0-9]+}'
        templateUrl: 'projects/show.html'
        controller: 'ProjectsCtrl as vm'
        resolve: data: ['$state', '$stateParams', 'Project', ($state, $stateParams, Project) ->
          Project.get($stateParams.id).then (data) ->
            Project.current = data]

    $urlRouterProvider.otherwise '/home'
    return

]).run([
  '$rootScope'
  '$state'
  'Auth'
  'auths'
  'editableOptions'
  ($rootScope, $state, Auth, auths, editableOptions) ->
    editableOptions.theme = 'bs3'

    $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams, options) ->
      Auth.currentUser()
      .finally ->
        event.preventDefault()
      .then ->
        if ['login', 'register'].indexOf(toState.name) > -1
          $state.go 'projects'
      , (error) ->
        if ['login', 'register', 'home'].indexOf(toState.name) < 0
          $state.go 'login'
      return

    $rootScope.$on '$stateChangeError', (event, toState) ->
      event.preventDefault()
      auths.showAlert('URI does not exist.')
      $state.go 'projects'
      return


    $rootScope.$on 'devise:login', (e, user) ->
      auths.setUser(user, 'You are authorized successfully.')
      return

    return
])
