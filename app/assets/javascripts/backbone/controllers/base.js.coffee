@ExpertSystem.module "Controllers", (Controllers, App, Backbone, Marionette, $, _) ->
	
	class Controllers.Base extends Marionette.Controller
		constructor: (options = {}) ->
			@region = options.region
			super options

		destroy: (args...) ->
			delete @region
			delete @options
			super args

		show: (view) ->
       @region.show(view)