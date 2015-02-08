@ExpertSystem.module 'HeaderApp.Login', (Login, App, Backbone, Marionette, $, _) ->
  class Login.View extends App.Views.Base
    template: 'header/login/templates/login'
    ui:
      form: '.login-form'
    events:
      'click .js-sign-in': 'onClickSignIn'
      'click .js-sign-out': 'onClickSignOut'
    modelEvents:
      'user:login:success user:logout:success': 'checkViewState'
    bindings:
      '.profile-link': 'text:name'

    onRender: ->
      @checkViewState()

    onClickSignIn: ->
      @trigger('signIn:clicked')

    onClickSignOut: ->
      @trigger('signOut:clicked')

    checkViewState: ->
      if @model.isSignedIn()
        @ui.form.addClass('logged')
      else
        @clearForm()
        @ui.form.removeClass('logged')