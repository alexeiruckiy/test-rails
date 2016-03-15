@ExpertSystem.module 'Collections', (Collections, App, Backbone, Marionette, $, _) ->

  class Collections.Validations extends Backbone.Collection
    url: '/validations'