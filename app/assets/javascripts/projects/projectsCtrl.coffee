'use strict'

angular.module('todoList').controller 'ProjectsCtrl', [
  'Project'
  'Task'
  '$uibModal'
  '$anchorScroll'
  '$window'
  '$state'
  (Project, Task, $uibModal, $anchorScroll, $window, $state) ->
    vm = this

    vm.projects = Project.all
    vm.project = Project.current

    vm.sortableOptions =
      connectWith: '.row tbody'
      handle: '.glyphicon-sort'
      start: ->
        vm.beforeSorting = angular.copy(vm.projects)
      update: (e, ui) ->
        ui = ui.item.sortable
        params =
          id: ui.model.id
          priorityPosition: ui.dropindex
          projectId: ui.droptarget.attr('data-project-id')

        unless ui.moved
          new Task(params).update().catch ->
            vm.projects = vm.beforeSorting

    vm.add = ->
      modalInstance = $uibModal.open(
        templateUrl: 'projects/_new_form.html'
        controller: 'ProjectCtrl as vm'
        size: 'lg',
        resolve: focus:
          setTimeout ->
            angular.element('input:first').focus())

      modalInstance.result
      .finally ->
        Project.current = {}
      .then (id) ->
        $anchorScroll()
        setTimeout ->
          angular.element('#task_form_' + id + ' input').focus()

    vm.edit = (project) ->
      modalInstance = $uibModal.open(
        templateUrl: 'projects/_edit_form.html'
        controller: 'ProjectCtrl as vm'
        size: 'lg'
        resolve: data: ['Project', (Project) ->
          Project.current = project])

      modalInstance.result
      .finally ->
        if $state.current.name = 'projects'
          Project.current = {}
      .then (data) ->
        angular.extend(vm.project, data)

    vm.destroy = (project, index) ->
      if $window.confirm('Are you sure?')
        project.delete().then ->
          if index > -1
            vm.projects.splice(index, 1)
          else
            $state.go 'projects'

    vm
]
