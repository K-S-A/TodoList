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

angular.module('todoList').directive 'selectTask', ->
    restrict: 'A'
    #scope: true
    link: (scope, element, attrs, ctrl, transcludeFn) ->
      element.on 'change', ->
        findChecked = ->
          result = false
          scope.project.tasks.forEach (task) ->
            result = true if task.checked
          result

        scope.task.checked = element.is(':checked')

        scope.project.selected = scope.task.checked || findChecked()        
        scope.$apply()

angular.module('todoList').directive 'listIcon', ->
    restrict: 'A'
    link: (scope, element, attrs, ctrl, transcludeFn) ->
      element.removeClass('glyphicon-plus')
      element.addClass('glyphicon-trash')

      scope.$watch (scope) ->
        scope.project.selected
      , ->
        element.toggleClass("glyphicon-plus glyphicon-trash")

angular.module('todoList').directive 'removeSelectedTasks', ->
    restrict: 'A'
    controller: 'TasksCtrl'
    link: (scope, element, attrs, ctrl, transcludeFn) ->
      element.on 'click', ->
        tasks = scope.project.tasks
        unselected = []

        tasks.map (task, i) ->
          if task.checked
            ctrl.delete(task)
          else
            unselected.push(task)

        scope.project.tasks = unselected
        scope.project.selected = false
