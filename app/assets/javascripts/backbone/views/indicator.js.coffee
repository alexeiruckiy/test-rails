@ExpertSystem.module 'Views', (Views, App, Backbone, Marionette, $, _) ->
  class Views.IndicatorView extends Marionette.ItemView
    className: 'indicator-view'
    template: 'indicator'

  Views