angular.module('todoList').controller 'AuthCtrl', [
  '$rootScope'
  '$scope'
  '$state'
  'Auth'
  ($rootScope, $scope, $state, Auth) ->
    vm = this

    vm.user = {}
    vm.email_pattern = '^([a-z0-9_.-]+@[a-z]+\\.[a-z]{2,5})$'

    vm.login = ->
      Auth.login(vm.user).then ->
        $state.go 'home'
      , (error) ->
        $rootScope.alertMsg = 'Wrong user credentials. Check e-mail/password and try again.'

    vm.register = ->
      Auth.register(vm.user).then ->
        $state.go 'home'

    vm
]
