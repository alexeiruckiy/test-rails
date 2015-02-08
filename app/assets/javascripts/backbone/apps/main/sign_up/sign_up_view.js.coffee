@ExpertSystem.module 'MainApp.SignUp', (SignUp, App, Backbone, Marionette, $, _) ->
  class SignUp.View extends App.Views.Base
    className: 'sign-up-view'
    template: 'main/sign_up/templates/sign-up'
    events:
      'click .js-sign-up': 'onCreateClick'

    onCreateClick: (event)->
      @triggerMethod('create:accout:click', @model)