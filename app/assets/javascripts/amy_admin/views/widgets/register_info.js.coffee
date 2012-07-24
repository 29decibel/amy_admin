GuomiAdmin.Views ||= {}

class GuomiAdmin.Views.RegisterStats extends GuomiAdmin.Views.WidgetBase
  initialize: (options)->
    super(options)
  render_child: =>
    @ap("<div class='stat'>45</div>")

