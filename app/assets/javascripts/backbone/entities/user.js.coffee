@ExpertSystem.module 'Entities.User', (User, App, Backbone, Marionette, $, _) ->
  class User.Model extends Backbone.Model
    initialize: ->
      @on 'error', (model, resp, options)->
        @trigger 'entity:error', @, resp.responseJSON
    defaults:
      name: ''
      email: ''
      password: ''
      password_confirmation: ''
    urlRoot: ->
      _.result(@collection, 'url') || _.result(User.Collection.prototype, 'url')

    validate: (attrs, options)->
      errors = []
      validations = App.request 'validations'
      for field of attrs
        f_validations = validations.where
                        field: field
                        entity: 'user'
        for f_validation in f_validations
          regex = new RegExp f_validation.get('rule'), 'i'
          unless regex.test attrs[field]
            errors.push
              field: field
              msg: f_validation.get 'message'
      if errors.length
        @trigger 'entity:error', @, errors

    save: (key, val, options)->
#      if @isNew()
#        if key == null || typeof key == 'object'
#          options = val
#          attrs = options.attrs || {}
#          options.attrs = _.extend({}, {user: @toJSON()}, attrs)
      super

    login: ->
      @sync 'create', @, {
        url: '/users/sign_in'
        attrs:
          name: @get('name')
          password: @get('password')
        success: (attrs, response, options)=>
          @set 'id', attrs.id
          @onSuccessLogin attrs
          @.trigger 'user:successLogin', @
        error: (options, response, statusText)=>
          @.trigger 'entity:error', @, JSON.parse(options.responseText)
      }

    logout: ->
      @sync 'delete', @,
        url: '/users/sign_out'
        complete: =>
          @clear({silent:true}).set(@.defaults)
          @onSuccessLogout()
          @trigger 'user:successLogout'

    onSuccessLogin: (attrs)->
      $.cookie 'user_id', attrs.id

    onSuccessLogout: ->
      $.removeCookie 'user_id'

    isSignedIn: ->
      return !@isNew() && $.cookie 'user_id'


  class User.Collection extends Backbone.Collection
    url: '/users'
    models: User.Model


  App.reqres.setHandler 'viewer', ->
    unless @viewer
      @viewer = new User.Model
        id: $.cookie 'user_id'
    @viewer

  App.reqres.setHandler 'viewer:set', (user)->
    viewer = App.request 'viewer'
    viewer.clear().set(user.attributes)
    viewer


  App.reqres.setHandler 'users', ->
    users = new User.Collection
    users.fetch
      reset: true
    users

  App.reqres.setHandler 'user', (id) ->
    user = new User.Model
      id: id
    user.fetch()
    user

  App.reqres.setHandler 'user:new', ->
    new User.Model()

  User