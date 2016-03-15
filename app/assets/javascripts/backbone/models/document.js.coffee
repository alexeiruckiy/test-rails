@ExpertSystem.module 'Models', (Models, App, Backbone, Marionette, $, _) ->
  class Models.Document extends Backbone.Model
    defaults:
      name: ''
      description: ''

    urlRoot: ->
      _.result(@collection, 'url') || _.result(App.Collections.Documents::, 'url')

    initialize: (options = {})->
      @pages = options.pages || new App.Collections.Pages([], document: @)

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