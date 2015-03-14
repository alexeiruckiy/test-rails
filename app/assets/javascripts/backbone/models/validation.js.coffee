@ExpertSystem.module 'Models.Validation', (Validation, App, Backbone, Marionette, $, _) ->
  class Validation.Collection extends Backbone.Collection
    url: '/validations'

  App.reqres.setHandler 'validations', ->
    unless @validations
      @validations = new Validation.Collection
    @validations