@ExpertSystem.module 'Models', (Models, App, Backbone, Marionette, $, _) ->
  class Models.User extends Backbone.Model
    defaults:
      name: ''
      email: ''
      password: ''
      password_confirmation: ''
    urlRoot: ->
      _.result(@collection, 'url') || _.result(App.Collections.Users::, 'url')

    validate: (attrs, options)->
      errors = []
      validations = App.request('validations')
      for field of attrs
        f_validations = validations.where(field: field, entity: 'user')
        for f_validation in f_validations
          regexp = new RegExp(f_validation.get('rule'), 'i')
          errors.push(field: field, msg: f_validation.get('message')) unless regexp.test(attrs[field])
      errors = false unless errors.length
      errors

    login: ->
      @sync 'create', @, {
        url: '/users/sign_in'
        attrs:
          name: @get('name')
          password: @get('password')
        success: (attrs, response, options)=>
          @set('id', attrs.id)
          @trigger('user:login:success', @)
        error: (response, statusText)=>
          @trigger('error', @, response, statusText)
      }

    logout: ->
      @sync 'delete', @, {
        url: '/users/sign_out'
        complete: =>
          @clear(silent:true).set(@defaults)
          @trigger('user:logout:success')
      }

    isSignedIn: ->
      !@isNew() && $.cookie('user_id')

    canEdit: (document)->
      document.isNew() || @id == document.get('user_id')