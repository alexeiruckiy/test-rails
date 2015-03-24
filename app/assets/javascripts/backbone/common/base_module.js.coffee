@ExpertSystem.module 'Common', (Common, App, Backbone, Marionette, $, _) ->
  class Common.BaseModule extends Marionette.Module
    initController: (controllerClass, options)->
      @_previous.destroy() if @_previous
      @_previous = new controllerClass(options)
