@ExpertSystem.module 'MainApp', (MainApp, App, Backbone, Marionette, $, _) ->
  class MainApp.SignUpController extends App.Controllers.Base
    initialize: (options)->
      @user = App.request('user')
      signUpView = new MainApp.SignUpView(model: @user)
      @listenTo(signUpView, 'create:accout:click', @onCreateAccounClick)
      @show(signUpView)

    onCreateAccounClick: ->
      @user.save {}, success: (model, resp, options)->
        App.request('viewer:set', model)
        App.MainApp.router.navigate('', trigger: true)
