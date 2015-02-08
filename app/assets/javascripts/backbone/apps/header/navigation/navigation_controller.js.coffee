@ExpertSystem.module "HeaderApp.Navigation", (Navigation, App, Backbone, Marionette, $, _) ->
  class Navigation.Controller extends App.Controllers.Base
    initialize: (options)->
      @listenTo Backbone.history, 'all', (router, name, args)->
        @navigationView.checkState(Backbone.history.fragment)

      @navigationView = new Navigation.NavigationView()
      @show @navigationView


  Navigation