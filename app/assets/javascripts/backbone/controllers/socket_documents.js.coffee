@ExpertSystem.module 'Controllers', (Controllers, App, Backbone, Marionette, $, _) ->
  class Controllers.SocketDocuments extends Marionette.Controller
    initialize: (options)->
      { @storage } = options
      channel = App.dispatcher.subscribe_private('document')
      channel.bind 'new', (entity)=> @onDocumentNew(entity)
      channel.bind 'change', (entity)=> @onDocumentChange(entity)
      channel.bind 'destroy', (entity)=> @onDocumentDestroy(entity)

    onDocumentNew: (entity)->
      
    onDocumentChange: (entity)->
      needle = @storage.filter(entity, 'document')
      _.each(needle, (model)-> model.set(entity))

    onDocumentDestroy: (entity)->
