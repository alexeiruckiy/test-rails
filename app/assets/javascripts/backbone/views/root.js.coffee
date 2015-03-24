@ExpertSystem.module 'Views', (Views, App, Backbone, Marionette, $, _) ->
  class Views.RootView extends Marionette.LayoutView
    el: 'body'
    regions:
      headerRegion: '#header-region'
      mainRegion: '#main-region'
      footerRegion: '#footer-region'
    showAlert: (text, type = 'danger')->
      template = Marionette.Renderer.getTemplate('alert')
      @mainRegion.$el.prepend(template(text: text, type: type))