@ExpertSystem.module 'HeaderApp.Login', (Login, App, Backbone, Marionette, $, _) ->
  class Login.View extends App.Views.Base
    template: 'header/login/templates/login'
    ui:{
      form: '.login-form'
      profile_link: '.profile-link'
    }
    events:
      'click .sign-up-button': 'onClickSignUp'
      'click .sign-in-button': 'onClickSignIn'
      'click .sign-out-button': 'onClickSignOut'

    modelEvents:
      'user:successLogin user:successLogout': 'checkViewState'

    bindings:
      '.profile-link': 'text:name'


    onError: ->
      @clearForm()
      super

    onRender: ->
      @checkViewState()

    onClickSignUp: ->
      @trigger 'signUp:clicked'

    onClickSignIn: ->
      @trigger 'signIn:clicked'

    onClickSignOut: ->
      @trigger 'signOut:clicked'

    checkViewState: ->
      if @model.isSignedIn()
        @ui.form.addClass 'logged'
      else
        @clearForm()
        @ui.form.removeClass 'logged'

  Login