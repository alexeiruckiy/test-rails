@ExpertSystem.module 'PopupApp', (PopupApp, App, Backbone, Marionette, $, _) ->

  class PopupApp.Controller extends App.Controllers.Base
    constructor: (options = {})->
      super options
      App.vent.on 'signUp', =>
        @signUp()

    signUp: ()->
      new PopupApp.SignUp.Controller(region: @region)

  PopupApp