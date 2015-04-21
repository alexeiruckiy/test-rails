@ExpertSystem.module 'Views', (Views, App, Backbone, Marionette, $, _) ->

  EpoxyMixin =
    epoxify: ->
      Backbone.Epoxy.View.mixin(@)
      @on 'ui:bind', =>
        @extendBindings() if @extendBindings
        @applyBindings()
      @on 'before:close', @removeBindings
    bindUIElements: ->
      Marionette.View.prototype.bindUIElements.apply(@, arguments)
      @trigger 'ui:bind'

  class Views.LayoutView extends Marionette.LayoutView
    constructor: (options = {}) ->
      super options
      @epoxify()

  _.extend(Views.LayoutView.prototype, EpoxyMixin)

  class Views.Base extends Marionette.ItemView
    constructor: (options = {}) ->
      @initDefaultUIElements()
      super options
      @initDefaultEvents()
      @epoxify()

    initDefaultEvents: ->
      @listenTo(@model, 'error', @onError)
      @listenTo(@model, 'invalid', @onInvalid)

    initDefaultUIElements: ->
      @ui ||= {}
      _.extend(@ui, form_control: '.js-form-control', form_block: '.js-form-block')

    onInvalid: (model, error, options)->
      @clearForm()
      for item in error
        input = _.find @ui.form_control, (control)->
          item.field == control.getAttribute('name')
        if input
          $input = $(input)
          $input.next('.error-message').html(item.msg)
          $input.closest('.form-group').addClass('has-error')

    onError: (model, response, options)->
      @onInvalid(model, response.responseJSON, options)

    clearForm: ->
      @ui.form_block.removeClass('has-error')

    extendBindings: ->
      @bindings ||= {}
      bindings = @bindings
      model = @model
      @ui.form_control.each ->
        name = @getAttribute('name')
        unless _.isUndefined(model.attributes[name])
          bindings['[name=' + name + ']'] = 'value:' + name + ',events:["keyup"]'

  _.extend(Views.Base.prototype, EpoxyMixin)