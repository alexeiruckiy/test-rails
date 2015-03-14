@ExpertSystem = do (Backbone, Marionette, $) ->
  App = new Marionette.Application
  App.Behaviors = {}

  App.on 'before:start', ->
    @rootView = new App.Views.RootView()

  App.on 'start', ->
    @X_CSRF_TOKEN = $('meta[name="csrf-token"]').attr('content')
    Backbone.history.start(pushState: true) if Backbone.history
    user = App.request('viewer')
    user.fetch() if user.isSignedIn()
    validations = App.request('validations')
    validations.fetch()

  $(document).on 'click', 'a[href^="/"]', (event) ->
    event.preventDefault()
    href = event.currentTarget.getAttribute('href')
    url = href.replace(/^\//, '').replace('\#\!\/', '')
    Backbone.Router.prototype.navigate(url, trigger: true)

  App