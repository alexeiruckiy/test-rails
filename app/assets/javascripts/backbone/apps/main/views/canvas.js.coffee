@ExpertSystem.module 'MainApp', (MainApp, App, Backbone, Marionette, $, _) ->
  class MainApp.CanvasView extends Marionette.ItemView
    className: 'document-paper'
    events:
      'click' : 'onPaperClick'
    modelEvents:
      'change:content': -> @paper.fromJSON(@model.get('content'))

    onRender: ->
      @paper = Raphael(@el, 520,390)
      @paper.fromJSON(@model.get('content'))

    onPaperClick: (event)->
      return unless @options.editState
      $target = $(event.currentTarget)
      offsetX = event.offsetX || event.clientX - $target.offset().left
      offsetY = event.offsetY || event.clientY - $target.offset().top
      activePrimitive = App.request('main:panel:primitive')
      switch activePrimitive
        when 'text'
          @paper.text offsetX, offsetY, 'qwerty'
        when 'figure'
          @paper.circle offsetX, offsetY, 40
      @trigger('canvas:change', @model, @paper.toJSON())