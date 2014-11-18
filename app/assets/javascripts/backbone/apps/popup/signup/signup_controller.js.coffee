@ExpertSystem.module 'PopupApp.SignUp', (SignUp, App, Backbone, Marionette, $, _) ->
  class SignUp.Controller extends App.Controllers.Base
    initialize: ()->
      @signUpView = new SignUp.View
        model: App.request 'user:new'
      @listenTo @signUpView, 'createAccout:clicked', @createAccount
      @show @signUpView

    createAccount: (user)->
      user.save null,
        success: ()=>
          @signUpView.hide()

  SignUp
