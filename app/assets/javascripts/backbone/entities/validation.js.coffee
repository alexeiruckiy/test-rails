@ExpertSystem.module 'Entities.Validation', (Validation, App, Backbone, Marionette, $, _) ->
  class Validation.Model extends Backbone.Model
    urlRoot: ->
      _.result(@collection, 'url') || _.result(Validation.Collection.prototype, 'url')

  class Validation.Collection extends Backbone.Collection
    url: '/validations'
    model: Validation.Model

  App.reqres.setHandler 'validations', ->
    unless @validations
      @validations = new Validation.Collection
    @validations

  Validation