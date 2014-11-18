@ExpertSystem.module "HeaderApp.Login", (Login, App, Backbone, Marionette, $, _) ->
  class Login.Controller extends App.Controllers.Base
    initialize: (options)->
      @loginView = new Login.View
        model: App.request 'viewer'

      @listenTo @loginView, 'signUp:clicked', ->
        App.vent.trigger 'signUp'
      @listenTo @loginView, 'signIn:clicked', @signIn
      @listenTo @loginView, 'signOut:clicked', @signOut
      @show @loginView

    signIn: ()->
      user = App.request 'viewer'
      @listenTo user, 'user:successLogin', (user)->
        user.fetch()
      user.login()

    signOut: ->
      user = App.request 'viewer'
      user.logout()

  Login