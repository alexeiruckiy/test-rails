@ExpertSystem.module 'MainApp.Presentation', (Presentation, App, Backbone, Marionette, $, _) ->

  class Presentation.CanvasView extends Marionette.ItemView
    className: 'document-paper'

    events:
      'click' : 'onPaperClick'

    modelEvents:
      'change:content': ->
        @paper.fromJSON @model.get 'content'

    onRender: ->
      @paper = Raphael(@el, 520,390)
      @paper.fromJSON @model.get 'content'

    onPaperClick: (event)->
      $target = $(event.currentTarget)
      offsetX = event.offsetX || event.clientX - $target.offset().left
      offsetY = event.offsetY || event.clientY - $target.offset().top

      activePrimitive = App.request('presentationView:primitive')

      switch activePrimitive
        when 'text'
          @paper.text offsetX, offsetY, 'qwerty'
        when 'figure'
          @paper.circle offsetX, offsetY, 40

      @trigger 'canvas:change', @model, @paper.toJSON()

  Presentation