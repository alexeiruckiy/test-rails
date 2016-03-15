@ExpertSystem.module 'Collections', (Collections, App, Backbone, Marionette, $, _) ->

  class Collections.Documents extends Backbone.Collection
    url: '/documents'
    models: App.Models.Document
