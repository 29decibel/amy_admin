GuomiAdmin.Views ||= {}

class GuomiAdmin.Views.WidgetBase extends Backbone.View
  template: JST['amy_admin/templates/widget_base']
  className: 'widget'
  tagName: 'section'
  initialize: (options)->
    @header = options?.header || ''
    @render()
  events:
    'click button.refresh' : 'refetch'
  loading:=>
    @$el.append("<div class='widget-loading'>Loading...</div>")
  refetch:->
    console.log 'fetch'
  ap:(content)=>
    @$el.find('article').append(content)
  render: =>
    @$el.find('.widget-loading').remove()
    @$el.html(@template({view:this}))
    if @render_child
      @render_child()

