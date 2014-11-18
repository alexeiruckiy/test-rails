@ExpertSystem.module 'MainApp.Presentation', (Presentation, App, Backbone, Marionette, $, _) ->

  class Presentation.CanvasView extends Marionette.ItemView
    className: 'document-paper'

    initialize: ->
      presentationView = Marionette.getOption @, 'presentationView'
      if presentationView
        @listenTo presentationView, 'presentation:primitive:select', @onPresenstationPrimitiveSelect

    events:
      'click' : 'onPaperClick'

    modelEvents:
      'change:content': ->
        @paper.fromJSON @model.get 'content'

    onRender: ->
      @paper = Raphael(@el, 600,400)
      @paper.fromJSON @model.get 'content'

    onPresenstationPrimitiveSelect: (primitive_name)->
      @activePrimitive = primitive_name

    onPaperClick: (event)->
      $target = $(event.currentTarget)
      offsetX = event.offsetX || event.clientX - $target.offset().left
      offsetY = event.offsetY || event.clientY - $target.offset().top

      switch @activePrimitive
        when 'text'
          @paper.text offsetX, offsetY, 'qwerty'
        when 'figure'
          @paper.circle offsetX, offsetY, 40

      @trigger 'canvas:change', @model, @paper.toJSON()

  Presentation