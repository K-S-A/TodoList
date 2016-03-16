'use strict'

angular.module('todoList').factory 'auths', [
  '$timeout'
  ($timeout) ->
    o =
      user: {}
      email_pattern: '^([a-z0-9_.-]+@[a-z]+\\.[a-z]{2,5})$'

    o.setUser = (user, message) ->
      user.notice = message
      angular.copy(user, o.user)
      rmMessage()
      return

    o.rmUser = (oldUser, message) ->
      angular.copy(notice: message, o.user)
      rmMessage()
      return

    o.showAlert = (message) ->
      o.user.alert = message
      rmMessage()
      return
    
    rmMessage = ->
      $timeout(->
        o.user.alert = o.user.notice = null
      , 5000)
      return

    o
]
