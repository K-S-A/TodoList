'use strict'

angular.module('todoList').factory 'Project', [
  'railsResourceFactory'
  'railsSerializer'
  (railsResourceFactory, railsSerializer) ->
    railsResourceFactory
      url: '/projects'
      name: 'project'
#      extensions: ['snapshots']
      serializer: railsSerializer ->
        @only 'title', 'description'
        @resource 'tasks', 'Task'
#    resource.extend('RailsResourceSnapshotsMixin')

#    resource
]