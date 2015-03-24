@ExpertSystem.module 'Common', (Common, App, Backbone, Marionette, $, _) ->
  App.commands.setHandler 'show:alert', (text, type)-> App.rootView.showAlert(text, type)