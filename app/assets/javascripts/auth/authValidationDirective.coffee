'use strict'

angular.module('todoList').directive 'authValidation', ->
    restrict: 'A'
    require: '^form'
    link: (scope, el, attrs, formCtrl) ->
      inputEl = el[0].querySelector("[name]")
      inputNgEl = angular.element(inputEl)
      inputName = inputNgEl.attr("name")
      inputNgEl.bind "blur keyup", ->
        message = switch
          when formCtrl[inputName].$error.required
            'This field is required.'
          when formCtrl[inputName].$error.minlength
            'Password must be at least 8 characters.'
          when formCtrl[inputName].$error.maxlength
            'Maximum password length is 72.'
          when formCtrl[inputName].$error.pattern
            'Please enter correct e-mail.'

        el.find('p').remove()
        el.append('<p class="text-danger">' + message + '</p>') if message
        el.toggleClass("has-error", formCtrl[inputName].$invalid)
          .toggleClass("has-success", formCtrl[inputName].$valid)
