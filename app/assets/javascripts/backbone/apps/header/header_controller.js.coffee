@ExpertSystem.module "HeaderApp", (HeaderApp, App, Backbone, Marionette, $, _) ->

  class HeaderApp.Controller extends App.Controllers.Base
    showHeader: ->
      headerView = new HeaderApp.HeaderView()
      @listenTo headerView, 'render', =>
        @showNavigation headerView.navigationRegion
        @showLogin headerView.loginRegion
      @show headerView

    showNavigation: (region)->
      new HeaderApp.Navigation.Controller
        region: region

    showLogin: (region)->
      new HeaderApp.Login.Controller
        region: region


    signUp: ()->

  HeaderApp