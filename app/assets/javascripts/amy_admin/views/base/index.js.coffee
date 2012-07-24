class GuomiAdmin.Views.Index extends Backbone.View
  initialize: (options)->
    # ini
    @collection = options.collection
    @collection.on('reset',@render)
    @collection.on('add',@render)
    @style = options.style || 'table'
    @template = JST["amy_admin/templates/base/index_#{@style}"]
    @render()

  events:
    'click a.next' : 'next'
    'click a.prev' : 'prev'
    'click span.scope' : 'reset_scope'
    'click button.refresh'  : 'refresh'
    'click button.collection-action' : 'custom_action'
    'click button.delete' : 'delete_record'
    'click button.member-action' : 'member_action'

  delete_record:(e)=>
    e.preventDefault()
    # find the record
    r_view = $(e.currentTarget).closest('tr')
    r_id = r_view.data('id')
    record = @collection.get(r_id)
    record.destroy()
    r_view.remove()

  custom_action:(e)->
    e.preventDefault()
    button = $(e.currentTarget)
    @collection.custom_action(button.data('name'),button.data('method'))

  member_action:(e)->
    e.preventDefault()
    button = $(e.currentTarget)
    record_id = button.closest('tr').data('id')
    record = @collection.get(record_id)
    record.custom_action(button.data('name'),button.data('method'))

  reset_scope:(e)=>
    e.preventDefault()
    $(e.currentTarget).toggleClass('label-success')
    coll = @collection
    coll.query_scopes = {}
    scopes = @$el.find('.filters .scope.label-success').map ->
      coll.query_scopes[$(this).text()] = true
    @refresh()

  loading_sign:=>
    @$el.find('table').before("<div class='alert alert-info'>Loading...</div>")

  refresh:(e)->
    e.preventDefault() if e
    @loading_sign()
    @collection.fetch()

  next:(e)=>
    e.preventDefault()
    @loading_sign()
    @collection.page += 1
    @collection.fetch()

  prev:(e)=>
    e.preventDefault()
    unless @collection.page == 0
      @loading_sign()
      @collection.page -= 1
      @collection.fetch()

  render_page_info:=>
    @collection.page_info (rsp)->
      console.log rsp

  render: =>
    @$el.html(@template(collection:@collection))
    @render_page_info()

