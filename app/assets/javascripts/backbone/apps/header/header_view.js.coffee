@ExpertSystem.module 'HeaderApp', (HeaderApp, App, Backbone, Marionette, $, _) ->
  class HeaderApp.HeaderView extends Marionette.LayoutView
    template: 'header/templates/header'
    regions:
      navigationRegion: '#navigation-region',
      loginRegion: '#login-region'