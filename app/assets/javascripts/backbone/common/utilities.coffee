@ExpertSystem.module 'Common', (Common, App, Backbone, Marionette, $, _) ->

  App.commands.setHandler 'show:alert', (text, type)-> App.rootView.showAlert(text, type)

  App.reqres.setHandler 'storage', ->
    unless @storage
      @storage = new Common.Storage
      @storage.on 'store:prepared', (name, storage)-> App.execute('init:store:controller', storage, name)
    @storage

  App.commands.setHandler 'storage:register', (cid, entity)->
    App.request('storage').register(cid, entity)

  App.commands.setHandler 'storage:unregister', (cid)->
    App.request('storage').unregisterByCid(cid)

  App.reqres.setHandler 'validations', ->
    @validations = new App.Collections.Validations unless @validations
    @validations

  App.reqres.setHandler 'viewer', ->
    unless @viewer
      @viewer = new App.Models.User(id: parseInt($.cookie('user_id')))
      @viewer.on('user:login:success', -> @fetch())
    @viewer

  App.reqres.setHandler 'viewer:set', (user)->
    viewer = App.request('viewer')
    viewer.clear(silent:true).set(user.attributes)
    viewer

  App.reqres.setHandler 'user', (id) ->
    if id
      user = new App.Models.User(id: id)
      user.fetch()
    else
      user = new App.Models.User
    user

  App.reqres.setHandler 'documents', -> new App.Collections.Documents

  App.reqres.setHandler 'document', (id) ->
    new App.Models.Document(if id then {id: id} else {})

  App.reqres.setHandler 'document:page', (document)->
    page = new App.Models.Document
    document.pages.add(page)
    page

  App.reqres.setHandler 'page', -> new App.Models.Page

  App.commands.setHandler 'init:store:controller', (storage, entityName)->
    switch entityName
      when 'document' then new App.Controllers.SocketDocuments(storage: storage)
      else throw 'Can\'t init new store controller with name: ' + entityName
