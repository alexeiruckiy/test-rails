@ExpertSystem.module "HeaderApp", (HeaderApp, App, Backbone, Marionette, $, _) ->
  class HeaderApp.LoginController extends App.Controllers.Base
    className: 'login-view'
    initialize: (options)->
      user = App.request('viewer')
      loginView = new HeaderApp.LoginView(model: user)
      @listenTo(loginView, 'signIn:clicked', -> user.login())
      @listenTo(loginView, 'signOut:clicked', -> user.logout())
      @show loginView