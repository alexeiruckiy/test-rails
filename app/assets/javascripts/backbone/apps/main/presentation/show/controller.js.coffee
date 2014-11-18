@ExpertSystem.module 'MainApp.Presentation', (Presentation, App, Backbone, Marionette, $, _) ->
  class Presentation.ShowController extends Marionette.Controller
    initialize: (options)->
      options.document.fetchDocument =>
        new Presentation.PagesController document: options.document, region: options.region

  Presentation