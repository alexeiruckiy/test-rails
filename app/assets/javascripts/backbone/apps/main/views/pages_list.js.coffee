@ExpertSystem.module 'MainApp', (MainApp, App, Backbone, Marionette, $, _) ->
  class MainApp.PagesListView extends Marionette.CompositeView
    template: 'main/views/templates/pages_list'
    childView: Marionette.ItemView.extend(template: 'main/views/templates/page')
    childViewContainer: '.pages'
    events:
      'click .js-add': -> @triggerMethod('add:click')
    templateHelpers: ->
      editState: @getOption('editState')
      printButtons: ->
        '<div class="presentation-controls btn-group">
                        <button type="button" class="btn btn-success js-add">+</button>
                        <button type="button" class="btn btn-alert js-remove">-</button>
                 </div>' if @editState

