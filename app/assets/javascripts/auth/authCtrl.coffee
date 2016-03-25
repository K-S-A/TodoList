'use strict'

angular.module('todoList').controller 'AuthCtrl', [
  '$state'
  'Auth'
  'auths'
  ($state, Auth, auths) ->
    vm = this

    vm.user = auths.user
    vm.email_pattern = auths.email_pattern

    vm.login = ->
      Auth.login(vm.user).then (user) ->
        $state.go 'projects'
      , (error) ->
        auths.showAlert('Wrong user credentials. Check e-mail/password and try again.')
      return

    vm.register = ->
      Auth.register(vm.user).then (user) ->
        auths.setUser(user, 'You are registered successfully.')
        $state.go 'projects'
      return

    vm
]
