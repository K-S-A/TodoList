'use strict'

angular.module('todoList').controller 'TasksCtrl', [
  'Task'
  (Task) ->
    vm = this

    vm.task =
      name: ''

    vm.create = (id) ->
      new Task(vm.task).$post('/projects/' + id + '/tasks')

    vm.delete = (task) ->
      task.delete()

    vm.update = (name, task) ->
      t = angular.copy task
      t.name = name
      t.update().then (data) ->
        angular.extend(task, data)

    vm
]
