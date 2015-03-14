@ExpertSystem.module 'MainApp', (MainApp, App, Backbone, Marionette, $, _) ->

  class MainApp.PresentationView extends App.Views.LayoutView
    template: 'main/views/templates/presentation'
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
