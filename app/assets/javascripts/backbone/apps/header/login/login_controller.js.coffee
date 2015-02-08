@ExpertSystem.module "HeaderApp.Login", (Login, App, Backbone, Marionette, $, _) ->
  class Login.Controller extends App.Controllers.Base
    initialize: (options)->
      user = App.request('viewer')
      loginView = new Login.View(model: user)
      @listenTo(loginView, 'signIn:clicked', -> user.login())
      @listenTo(loginView, 'signOut:clicked', -> user.logout())
      @show loginView