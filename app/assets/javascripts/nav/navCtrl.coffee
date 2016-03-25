'use strict'

angular.module('todoList').controller 'NavCtrl', [
  'Auth'
  'auths'
  (Auth, auths) ->
    vm = this

    vm.user = auths.user
    vm.signedIn = Auth.isAuthenticated

    vm.logout = ->
      Auth.logout().then ->
        auths.setUser({}, 'You are signed out now.')
      return

    vm
]
