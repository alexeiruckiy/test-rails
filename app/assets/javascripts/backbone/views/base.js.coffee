@ExpertSystem.module 'Views', (Views, App, Backbone, Marionette, $, _) ->
  class Views.Base extends Marionette.ItemView
    constructor: (options = {}) ->
      @initDefaultUIElements()
      super options
      @initDefaultEvents()
      @epoxify()

    init: ->
      @ui = {} unless @ui
      _.extend @ui,
        form_control: '.js-form-control'
        form_block: '.js-form-block'
      @initDefaultEvents()

    initDefaultEvents: ->
      @listenTo @model, 'entity:error', @onError

    initDefaultUIElements: ->
      @ui = {} unless @ui
      _.extend @ui,
        form_control: '.js-form-control'
        form_block: '.js-form-block'

    onError: (model, response)->
      @clearForm()
      for item in response
        input = _.find @ui.form_control, (control)->
          item.field == control.getAttribute 'name'
        if input
          $input = $ input
          $input.next('.error-message').html(item.msg)
          $input.closest('.form-group').addClass('has-error')

    clearForm: ->
      @ui.form_block.removeClass 'has-error'

    epoxify: ->
      Backbone.Epoxy.View.mixin @
      @listenTo @, 'ui:bind', =>
        @extendBindings()
        @applyBindings()
      @listenTo @, 'before:close', @removeBindings

    extendBindings: ->
      @bindings = {} unless @bindings
      if _.isObject(@bindings)
        bindings = @bindings
        model = @model
        @ui.form_control.each ->
          name = this.getAttribute 'name'
          if !_.isUndefined(model.attributes[name])
            bindings['input[name=' + name + ']'] = 'value:' + name + ',events:["keyup"]'
            bindings['textarea[name=' + name + ']'] = 'value:' + name + ',events:["keyup"]'

    bindUIElements: ->
      super
      @trigger 'ui:bind'

  Views