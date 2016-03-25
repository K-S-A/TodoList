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
        tasks = scope.project.tasks
        index = tasks.indexOf(scope.task)
        tasks.splice(index, 1)

#angular.module('todoList').directive 'taskRow', ->
#  restrict: 'A'
#  scope: '@'
#  controller: 'TasksCtrl as vm'
#  link: (scope, element, attrs, ctrl, transcludeFn) ->
    #console.log scope.task
    #console.log ctrl
    #element.on 'click', (e) ->
      #console.log('Edited')
      #ctrl.delete(scope.task).then ->
        #scope.project.tasks.push(data)
      #  scope.task = {}
