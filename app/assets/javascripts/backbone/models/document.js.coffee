@ExpertSystem.module 'Models.Document', (Document, App, Backbone, Marionette, $, _) ->
  class Document.Model extends Backbone.Model
    defaults:
      name: ''
      description: ''
    urlRoot: ->
      _.result(@collection, 'url') || _.result(Document.Collection::, 'url')
    initialize: (options = {})->
      @pages = options.pages || new Document.Pages([], document: @)

    addNewPage: (attrs = {})->
      attrs.document_id = @id
      page = new Document.Page(attrs)
      @pages.add(page)
      page

    savePage: (page, options = {})->
      @pages.add(page, {merge: true})
      url = _.result(@, 'url') + _.result(page, 'url')
      page.save({}, _.extend({url: url}, options))

    fetchPages: (onSuccess = ->)->
      url = _.result(@, 'url') + @pages.url
      @pages.fetch(url: url, reset: true, silent: true, success: onSuccess)

    saveDocument: (attrs = {}, options = {})->
      pages = @pages
      new_options = _.extend({}, options)
      new_options.success = ->
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
      _.result(@collection, 'url') || _.result(Document.Collection::, 'url')

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

  App.reqres.setHandler 'documents', ->
    new Document.Collection()

  App.reqres.setHandler 'document', (id) ->
    new Document.Model(if id then {id: id} else {})

  App.reqres.setHandler 'document:page', (document)->
    page = new Document.Page()
    document.pages.add(page)
    page

  App.reqres.setHandler 'page', ->
    new Document.Page()