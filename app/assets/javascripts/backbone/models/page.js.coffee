@ExpertSystem.module 'Models', (Models, App, Backbone, Marionette, $, _) ->
  class Models.Page extends Backbone.Model
    urlRoot: ->
      _.result(@collection, 'url') || _.result(App.Collections.Documents::, 'url')

    savePage: ->
      unless @collection.document.isNew()
        @set({document_id: @collection.document.id}, {silent: true})
        @save.apply(@, arguments)