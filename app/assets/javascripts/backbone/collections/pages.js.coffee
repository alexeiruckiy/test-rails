@ExpertSystem.module 'Collections', (Collections, App, Backbone, Marionette, $, _) ->

  class Collections.Pages extends Backbone.Collection
    model: App.Models.Page
    url: '/pages'
    initialize: (models, options = {})->
      @document = options.document
    saveAll: ->
      @each (page)->
        page.savePage()