@ExpertSystem.module 'MainApp', (MainApp, App, Backbone, Marionette, $, _) ->
  class MainApp.FrontController extends App.Controllers.Base
    initialize: (options = {}) ->
      contentView = new Marionette.ItemView
        template: 'main/views/templates/front'
        className: 'front-wrapper'
      @show contentView