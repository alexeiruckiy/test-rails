@ExpertSystem.module 'Entities', (Entities, App, Backbone, Marionette, $, _) ->
  class Entities.BaseEntity extends Backbone.Model
    toJSON: ->
      attrs = super
      delete attrs['id']
      attrs

    hasChanged: (attr)->
      if attr
        super attr
      else
        super && !super 'id'

  Entities