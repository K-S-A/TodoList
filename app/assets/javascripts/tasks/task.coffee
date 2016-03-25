'use strict'

angular.module('todoList').factory 'Task', [
  'railsResourceFactory'
  'railsSerializer'
  (railsResourceFactory, railsSerializer) ->
    railsResourceFactory
      url: '/tasks'
      name: 'task'
      serializer: railsSerializer ->
        @only 'name'

]