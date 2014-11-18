@ExpertSystem.module 'PopupApp.SignUp', (SignUp, App, Backbone, Marionette, $, _) ->
  class SignUp.View extends App.Views.Base
    template: 'popup/signup/templates/sign-up'
    ui:{
      modal: '#signUpModal'
    }
    events: {
      'click .create-button': 'onCreateClick'
    }
    onShow: ->
      @ui.modal.modal()

    hide: ->
      @ui.modal.modal 'hide'

    onCreateClick: (event)->
      @trigger 'createAccout:clicked', @model

  SignUp