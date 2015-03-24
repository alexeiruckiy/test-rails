@ExpertSystem.module 'MainApp', (MainApp, App, Backbone, Marionette, $, _) ->
  class MainApp.PresentationsListItemView extends Marionette.ItemView
    tagName: 'tr'
    template: 'main/views/templates/presentations_list_item'