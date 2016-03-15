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
      rmAlertMsg()
      return
    
    $scope.$on 'devise:login', (e, user) ->
      $rootScope.alertMsg = 'You are authorized successfully.'
      $rootScope.user = user
      rmAlertMsg()
      return
    
    $scope.$on 'devise:logout', (e, user) ->
      $rootScope.user = null
      $rootScope.alertMsg = 'You are signed out now.'
      rmAlertMsg()
      return

    rmAlertMsg = ->
      $timeout(->
        $rootScope.alertMsg = null
      , 3000)
      return
    return
]
