@ExpertSystem.module 'MainApp', (MainApp, App, Backbone, Marionette, $, _) ->
  class MainApp.SignUpView extends App.Views.Base
    className: 'sign-up-view'
    template: 'main/views/templates/sign_up'
    events:
      'click .js-sign-up': 'onCreateClick'

    onCreateClick: (event)->
      @triggerMethod('create:accout:click', @model)