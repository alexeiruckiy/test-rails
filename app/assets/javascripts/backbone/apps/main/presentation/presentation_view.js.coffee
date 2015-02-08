@ExpertSystem.module 'MainApp.Presentation', (Presentation, App, Backbone, Marionette, $, _) ->

  class Presentation.View extends App.Views.LayoutView
    template: 'main/presentation/templates/presentation-layout'
    className: 'presentation-view'
    regions:
      pagesManageRegion: '#pages-manage-region'
    bindings:
      '[data-field=name]': 'text:name'
      '[data-field=description]': 'text:description'
    templateHelpers: ->
      model = @model
      printEditLink: ->
        "<a href='/presentations/#{@id}/edit'>Edit presentation</a>" if App.request('viewer').canEdit(model)
