@ExpertSystem.module 'Collections', (Collections, App, Backbone, Marionette, $, _) ->

  class Collections.Users extends Backbone.Collection
    url: '/users'
    models: App.Models.User