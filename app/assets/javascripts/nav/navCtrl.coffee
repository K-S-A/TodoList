'use strict'

angular.module('todoList').controller 'NavCtrl', [
  '$scope'
  'Auth'
  'auths'
  ($scope, Auth, auths) ->
    Auth.currentUser()

    $scope.$on 'devise:login', (e, user) ->
      auths.setUser(user, 'You are authorized successfully.')

    vm = this

    vm.user = auths.user
    vm.signedIn = Auth.isAuthenticated

    vm.logout = ->
      Auth.logout().then ->
        auths.setUser({}, 'You are signed out now.')
      return

    vm
]
