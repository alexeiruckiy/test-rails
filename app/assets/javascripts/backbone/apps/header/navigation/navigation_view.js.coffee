@ExpertSystem.module "HeaderApp.Navigation", (Navigation, App, Backbone, Marionette, $, _) ->
  class Navigation.NavigationView extends Marionette.ItemView
    template: 'header/navigation/templates/navigation'
    ui:
      items : '.navigation a'
      sub_items: '.sub-navigation a'

    checkState: (href)->
      return
      @ui.items.each ->
         unless this.pathname.substr(1).indexOf href
           $(this).parent().addClass 'active'
         else
           $(this).parent().removeClass 'active'
      @ui.sub_items.each ->
        if this.pathname.substr(1) == href
          $(this).parent().addClass 'active'
        else
          $(this).parent().removeClass 'active'




  Navigation