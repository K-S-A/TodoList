angular.module('todoList').controller 'AuthCtrl', [
  '$scope'
  '$state'
  'Auth'
  ($scope, $state, Auth) ->
    $scope.user = {}
    $scope.valClass = (item) ->
      o = if $scope.loginForm[item].$dirty then (if $scope.loginForm[item].$valid then 'has-success' else 'has-error') else ''
      o

    $scope.login = ->
      Auth.login($scope.user).then ->
        $state.go 'home'
        return
      return

    $scope.register = ->
      Auth.register($scope.user).then ->
        $state.go 'home'
        return
      return

    $scope.logout = ->
      Auth.logout()
      return

    return
]
