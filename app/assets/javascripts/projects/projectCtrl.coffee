'use strict'

angular.module('todoList').controller 'ProjectCtrl', [
  'Project'
  '$uibModalInstance'
  (Project, $uibModalInstance) ->
    vm = this

    vm.projects = Project.all
    vm.project = angular.copy(Project.current)

    vm.createProject = ->
      new Project(vm.project).create().then (data) ->
        vm.projects.unshift(data)
        $uibModalInstance.close(data.id)

    vm.updateProject = ->
      vm.project.update().then (data) ->
        if vm.projects
          index = vm.projects.indexOf(Project.current)
          vm.projects.splice(index, 1, data)
        $uibModalInstance.close(data)

    vm.cancel = ->
      $uibModalInstance.dismiss('cancel')

    vm
]
