'use strict'

angular.module('todoList').directive 'addTask', ->
  restrict: 'A'
  scope: true
  controller: 'TasksCtrl as vm'
  link: (scope, element, attrs, ctrl, transcludeFn) ->
    element.on 'submit', ->
      if ctrl.addTask.$valid
        ctrl.create(scope.project.id).then (data) ->
          scope.project.tasks.push(data)
          ctrl.task = name: ''

angular.module('todoList').directive 'deleteTask', ->
  restrict: 'E'
  controller: 'TasksCtrl as vm'
  link: (scope, element, attrs, ctrl, transcludeFn) ->
    element.on 'click', (e) ->
      ctrl.delete(scope.task).then ->
        scope.project.tasks.splice(scope.$index, 1)

angular.module('todoList').directive 'changeTaskStatus', ->
    restrict: 'A'
    scope: '@'
    controller: 'TasksCtrl as vm'
    link: (scope, element, attrs, ctrl, transcludeFn) ->
      element.on 'click', ->
        ctrl.update({ completed: !scope.task.completed }, scope.task)
