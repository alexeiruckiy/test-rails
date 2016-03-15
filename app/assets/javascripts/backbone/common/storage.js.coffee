@ExpertSystem.module 'Common', (Common, App, Backbone, Marionette, $, _) ->

  class Common.Storage
    constructor: ->
      @_store = {}

    getEntityName: (entity)->
      entity.constructor.name.toLowerCase()

    prepareStore: (name)->
      unless @_store[name]
        @_store[name] = []
        @trigger('store:prepared', name, @)
      @_store[name]

    register: (cid, entity)->
      entityName = @getEntityName(entity)
      store = @prepareStore(entityName)
      store[cid] ||= []
      needle = _.find(store[cid], (model)-> model.cid == entity.cid)
      store[cid].push(entity) unless needle
      entity

    unregisterByCid: (cid)->
      _.each @_store, (store)-> delete store[cid]

    filter: (entity, entityName)->
      ret = []
      _.each @_store[entityName], (models)->
       needle = _.filter(models, (model)-> model.id == entity.id)
       ret = ret.concat(needle)
      ret

  _.extend(Common.Storage::, Backbone.Events)

