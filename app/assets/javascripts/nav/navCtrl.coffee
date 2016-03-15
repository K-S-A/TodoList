'use strict'

angular.module('todoList').controller 'NavCtrl', [
  '$scope'
  '$rootScope'
  '$timeout'
  'Auth'
  ($scope, $rootScope, $timeout, Auth) ->
    $scope.signedIn = Auth.isAuthenticated
    $scope.logout = Auth.logout
    
    Auth.currentUser().then (user) ->
      $rootScope.user = user

    $scope.$on 'devise:new-registration', (e, user) ->
      $rootScope.user = user
      $rootScope.alertMsg = 'You are registered successfully.'
      $timeout(rmAlertMsg, 3000)
      return
    
    $scope.$on 'devise:login', (e, user) ->
      $rootScope.user = user
      return
    
    $scope.$on 'devise:logout', (e, user) ->
      $rootScope.user = null
      $rootScope.alertMsg = 'You\'re signed out now.'
      return

    rmAlertMsg = ->
      $rootScope.alertMsg = null
      return

    return
]
