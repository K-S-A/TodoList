angular.module('todoList').controller 'AuthCtrl', [
  '$scope'
  '$state'
  'Auth'
  ($scope, $state, Auth) ->
    vm = this
    vm.user = {}
    vm.email_pattern = '^([a-z0-9_.-]+@[a-z]+\\.[a-z]{2,5})$'

    vm.login = ->
      Auth.login(vm.user).then ->
        $state.go 'home'

    vm.register = ->
      Auth.register(vm.user).then ->
        $state.go 'home'

    vm.logout = ->
      Auth.logout()

    vm
]
