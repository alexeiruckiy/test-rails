@ExpertSystem.module 'Entities.Document', (Document, App, Backbone, Marionette, $, _) ->
  class Document.Model extends App.Entities.BaseEntity
    defaults:
      name: ''
      description: ''
    urlRoot: ->
      _.result(@collection, 'url') || _.result(Document.Collection.prototype, 'url')
    initialize: (options={})->
      @pages = options.pages || new Document.Pages([], document: this)


    addNewPage: (attrs={})->
      page = new Document.Page attrs
      @pages.add page
      page

    fetchDocument: (onSuccess=->)->
      @fetch success:=>
        @pages.fetch reset: true, success: onSuccess


    saveDocument: (attrs={}, options={})->
      pages = @pages
      new_options = _.extend {}, options
      new_options.success = ()->
        options.success.apply(@, arguments) if options.success
        pages.saveAll()
      if @isNew()
        @save attrs, new_options
      else
        @save.apply @, arguments
        @pages.saveAll()

  class Document.Collection extends Backbone.Collection
    url: '/documents'
    models: Document.Model

  class Document.Page extends App.Entities.BaseEntity
    urlRoot: ->
      _.result(@collection, 'url') || _.result(Document.Collection.prototype, 'url')

    savePage: ->
      unless @collection.document.isNew()
        if @isNew()
          @save.apply @, arguments
        else if @hasChanged()
          @save.apply @, arguments

  class Document.Pages extends Backbone.Collection
    model: Document.Page
    url: ->
      _.result(@document, 'url') + '/pages'
    initialize: (models, options={})->
      @document = options.document

    saveAll: ->
      @each (page)->
        page.savePage()

  App.reqres.setHandler 'document', (id) ->
    new Document.Model if id then {id: id} else {}


  App.reqres.setHandler 'document:page', (document)->
    page = new Document.Page()
    document.pages.add page
    page


  Document