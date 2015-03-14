@ExpertSystem.module 'HeaderApp', (HeaderApp, App, Backbone, Marionette, $, _) ->
  class HeaderApp.LoginView extends App.Views.Base
    className: 'login-view'
    template: 'header/views/templates/login'
    ui:
      login_link: '.js-login-link'
    events:
      'click .js-sign-in': 'onClickSignIn'
      'click .js-sign-out': 'onClickSignOut'
    modelEvents:
      'user:login:success user:logout:success': 'checkViewState'
    bindings:
      '.profile-link': 'text:name'

    onRender: ->
      @checkViewState()

    onShow: ->
      @ui.login_link.popover
        title: 'Enter username/password'
        html: true
        content: Marionette.Renderer.getTemplate('header/views/templates/login-form')()
        placement: 'bottom'
        viewport: @$el.closest('.login-region')
      @ui.login_link.on('shown.bs.popover', => @bindUIElements())

    onClickSignIn: ->
      @trigger('signIn:clicked')

    onClickSignOut: ->
      @trigger('signOut:clicked')

    checkViewState: ->
      if @model.isSignedIn()
        @$el.addClass('logged')
      else
        @clearForm()
        @$el.removeClass('logged')