@ExpertSystem.module 'MainApp.Presentation', (Presentation, App, Backbone, Marionette, $, _) ->
  class Presentation.PagesListView extends Marionette.CompositeView
    template: 'main/presentation/templates/manage'
    childView: Marionette.ItemView.extend template: 'main/presentation/templates/page'
    childViewContainer: '.pages'
    events:
      'click .js-add': ->
        @triggerMethod 'click:add'

  Presentation