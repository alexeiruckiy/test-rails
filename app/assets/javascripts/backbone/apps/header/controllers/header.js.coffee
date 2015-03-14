@ExpertSystem.module "HeaderApp", (HeaderApp, App, Backbone, Marionette, $, _) ->
  class HeaderApp.HeaderController extends App.Controllers.Base
    initialize: ->
      headerView = new HeaderApp.HeaderView()
      @listenTo headerView, 'render', ->
        @showLogin(headerView.loginRegion)
      @show headerView

    showLogin: (region)->
      new HeaderApp.LoginController(region: region)



