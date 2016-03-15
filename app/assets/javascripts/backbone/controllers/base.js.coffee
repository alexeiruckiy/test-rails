@ExpertSystem.module "Controllers", (Controllers, App, Backbone, Marionette, $, _) ->

  class Controllers.Base extends Marionette.Controller
    constructor: (options = {}) ->
      @cid = _.uniqueId()
      @region = options.region
      super options

    destroy: (args...) ->
      App.execute('storage:unregister', @cid)
      delete @region
      delete @options
      super args

    show: (view) ->
       @region.show(view)

    register: (entity)->
      App.execute('storage:register', @cid, entity)
