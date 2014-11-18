@ExpertSystem.module 'MainApp.Presentation', (Presentation, App, Backbone, Marionette, $, _) ->
  class Presentation.LayoutView extends Marionette.LayoutView
    template: 'main/presentation/templates/presentation-layout'
    regions:
      presentationRegion: '#presentation-region'
      infoRegion: '#presentation-info-region'
      controlsRegion: '#presentation-controls-region'
      pagesRegion: '#presentation-pages-region'

    serializeData: ->
      data = {}
      data = @model.toJSON() if @model
      data.view_state = @getOption('state') || null
      data

  Presentation