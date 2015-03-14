@ExpertSystem.module 'MainApp', (MainApp, App, Backbone, Marionette, $, _) ->
  class MainApp.MyPresentationsController extends App.Controllers.Base
    initialize: (options = {})->
      documents = App.request('documents')
      documents.fetch()
      @show new MainApp.PresentationsListView(collection: documents)
#      @show new MainApp.MyPresentationsView()