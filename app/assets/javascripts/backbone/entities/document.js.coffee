@ExpertSystem.module 'Entities.Document', (Document, App, Backbone, Marionette, $, _) ->
  class Document.Model extends Backbone.Model
    defaults:
      name: ''
      description: ''
    urlRoot: ->
      _.result(@collection, 'url') || _.result(Document.Collection.prototype, 'url')
    initialize: (options = {})->
      @pages = options.pages || new Document.Pages([], document: @)

    addNewPage: (attrs = {})->
      attrs.document_id = @id
      page = new Document.Page(attrs)
      @pages.add(page)
      page

    saveNewPage: (attrs = {})->
      page = @addNewPage(attrs)
      url = _.result(@, 'url') + _.result(page, 'url')
      page.save({}, url: url)
      page

    fetchDocument: (options = {})->
      onSuccess = =>
        @trigger('document:pages:fetch', @, @pages)
        options.success(@, @pages) if options.success
      @fetch(silent: options.silent, success: =>
        @trigger('document:fetch', @)
        @fetchPages(onSuccess)
      )

    fetchPages: (onSuccess = ->)->
      url = _.result(@, 'url') + @pages.url
      @pages.fetch(url: url, reset: true, silent: true, success: onSuccess)

    saveDocument: (attrs = {}, options = {})->
      pages = @pages
      new_options = _.extend({}, options)
      new_options.success = ()->
        options.success.apply(@, arguments) if options.success
        pages.saveAll()
      if @isNew()
        @save(attrs, new_options)
      else
        @save.apply(@, arguments)
        @pages.saveAll()

  class Document.Collection extends Backbone.Collection
    url: '/documents'
    models: Document.Model

  class Document.Page extends Backbone.Model
    urlRoot: ->
      _.result(@collection, 'url') || _.result(Document.Collection.prototype, 'url')

    savePage: ->
      unless @collection.document.isNew()
        @set({document_id: @collection.document.id}, {silent: true})
        @save.apply(@, arguments)

  class Document.Pages extends Backbone.Collection
    model: Document.Page
    url: '/pages'
    initialize: (models, options = {})->
      @document = options.document

    saveAll: ->
      @each (page)->
        page.savePage()

  App.reqres.setHandler 'document', (id) ->
    new Document.Model(if id then {id: id} else {})

  App.reqres.setHandler 'document:page', (document)->
    page = new Document.Page()
    document.pages.add(page)
    page