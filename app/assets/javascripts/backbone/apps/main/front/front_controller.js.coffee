@ExpertSystem.module 'MainApp.Front', (Front, App, Backbone, Marionette, $, _) ->
  class Front.Controller extends App.Controllers.Base
    initialize: (options = {}) ->
      contentView = new Marionette.ItemView
        template: 'main/front/templates/front'
        className: 'front-wrapper'
      @show contentView