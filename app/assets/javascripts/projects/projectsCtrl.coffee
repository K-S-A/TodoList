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
      update: (e, ui) ->
        item = ui.item.sortable
        params =
          id: item.model.id
          priorityPosition: item.dropindex
          projectId: item.droptarget.attr('data-project-id')

        unless item.moved
          new Task(params).update()

    vm.add = ->
      modalInstance = $uibModal.open(
        templateUrl: 'projects/_new_form.html'
        controller: 'ProjectCtrl as vm'
        size: 'lg',
        resolve: focus:
          setTimeout ->
            angular.element('#title').focus())

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
          if $state.current.name is 'project'
            $state.go 'projects'
          else
            vm.projects.splice(index, 1)

    vm
]
