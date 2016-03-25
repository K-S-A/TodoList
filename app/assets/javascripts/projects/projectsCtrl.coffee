'use strict'

angular.module('todoList').controller 'ProjectsCtrl', [
  'Project'
  '$uibModal'
  '$anchorScroll'
  '$window'
  '$state'
  (Project, $uibModal, $anchorScroll, $window, $state) ->
    vm = this
    console.log(Project, $uibModal, $anchorScroll, $window, $state)
    vm.projects = Project.all
    vm.project = Project.current

    vm.add = ->
      modalInstance = $uibModal.open(
        templateUrl: 'projects/_new_form.html'
        controller: 'ProjectCtrl as vm'
        size: 'lg')

      modalInstance.result.finally ->
        Project.current = {}
      .then ->
        $anchorScroll()

    vm.edit = (project) ->
      modalInstance = $uibModal.open(
        templateUrl: 'projects/_edit_form.html'
        controller: 'ProjectCtrl as vm'
        size: 'lg'
        resolve: data: ['Project', (Project) ->
          Project.current = project])

      modalInstance.result.finally ->
        if $state.current.name = 'projects'
          Project.current = {}
      .then (data) ->
        vm.project = data

    vm.destroy = (project) ->
      if $window.confirm('Are you sure?')
        #console.log($state.current.name is 'projects')
        project.delete().then ->
          if $state.current.name is 'project'
            $state.go 'projects'
          else
            index = vm.projects.indexOf(project)
            vm.projects.splice(index, 1)

    vm
]
