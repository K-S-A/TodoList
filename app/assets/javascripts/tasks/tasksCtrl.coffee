'use strict'

angular.module('todoList').controller 'TasksCtrl', [
  'Task'
  (Task) ->
    vm = this

    vm.task =
      name: ''

    vm.create = (id) ->
      new Task(vm.task).$post('/projects/'+ id + '/tasks')

    vm.delete = (task) ->
      task.delete()

    vm.update = (name, task) ->
      task.name = name
      task.update()

    vm
]
