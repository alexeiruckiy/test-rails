@ExpertSystem = do (Backbone, Marionette, $) ->
  App = new Marionette.Application

  App.addRegions
    headerRegion: '#header-region'
    mainRegion: '#main-region'
    footerRegion: '#footer-region'
    popupRegion: '#popup-region'

  App.addInitializer ->
    App.module('HeaderApp').start()
    App.module('MainApp').start()
    App.module('PopupApp').start()

  App.on 'start', ->
    @X_CSRF_TOKEN = $('meta[name="csrf-token"]').attr('content')
    if Backbone.history
      Backbone.history.start(pushState: true)
    user = App.request('viewer')
    if user.isSignedIn()
      user.fetch()
    validations = App.request('validations')
    validations.fetch()

  $(document).on 'click', "a[href^='/']", (event) ->
    event.preventDefault()
    href = event.currentTarget.getAttribute('href')
    url = href.replace(/^\//, '').replace('\#\!\/', '')
    Backbone.Router.prototype.navigate(url, trigger: true)

  App