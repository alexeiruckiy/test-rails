@ExpertSystem.module 'Models.User', (User, App, Backbone, Marionette, $, _) ->
  class User.Model extends Backbone.Model
    defaults:
      name: ''
      email: ''
      password: ''
      password_confirmation: ''
    urlRoot: ->
      _.result(@collection, 'url') || _.result(User.Collection::, 'url')

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


  class User.Collection extends Backbone.Collection
    url: '/users'
    models: User.Model


  App.reqres.setHandler 'viewer', ->
    unless @viewer
      @viewer = new User.Model(id: parseInt($.cookie('user_id')))
      @viewer.on('user:login:success', -> @fetch())
    @viewer

  App.reqres.setHandler 'viewer:set', (user)->
    viewer = App.request('viewer')
    viewer.clear(silent:true).set(user.attributes)
    viewer

  App.reqres.setHandler 'users', ->
    users = new User.Collection
    users.fetch(reset: true)
    users

  App.reqres.setHandler 'user', (id) ->
    if id
      user = new User.Model(id: id)
      user.fetch()
    else
      user = new User.Model
    user