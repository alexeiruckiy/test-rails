@ExpertSystem.module 'MainApp.SignUp', (SignUp, App, Backbone, Marionette, $, _) ->
  class SignUp.Controller extends App.Controllers.Base
    initialize: (options)->
      @user = App.request('user')
      signUpView = new SignUp.View(model: @user)
      @listenTo(signUpView, 'create:accout:click', @onCreateAccounClick)
      @show(signUpView)

    onCreateAccounClick: ->
      @user.save {}, success: (model, resp, options)->
        debugger;
        App.request('viewer:set', model)
        App.MainApp.router.navigate('', trigger: true)
