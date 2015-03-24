@ExpertSystem.module 'MainApp', (MainApp, App, Backbone, Marionette, $, _) ->
  class MainApp.PresentationsListView extends Marionette.CompositeView
    template: 'main/views/templates/presentations_list'
    childViewContainer: '#presentations-list>tbody'
    childView: MainApp.PresentationsListItemView
