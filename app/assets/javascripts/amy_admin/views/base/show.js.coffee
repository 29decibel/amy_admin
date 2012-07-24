GuomiAdmin.Views ||= {}

class GuomiAdmin.Views.Show extends Backbone.View
  template: JST['admin/templates/base/show']
  initialize: (options)->
    # ini
    @model = options.model
    @model.on 'change',@render
    @meta_info = @model.meta_info()
    @render()
  events:
    'click button.back' : 'back'
  back:(e)->
    e.preventDefault()
    history.go(-1)
  render: =>
    @$el.html(@template(model:@model))
    window.fs = @model
    # render has_many association tables
    for ass in @model.has_many_relations() || []
      # create collection
      coll = new GuomiAdmin.Collections.Base()
      coll.model_name = ass.name
      query = {}
      query["#{ass.foreign_key}_eq"] = @model.id
      coll.search_query = query
      window.co = coll
      coll.fetch()
      # create table view
      table = new GuomiAdmin.Views.Index({collection:coll})
      @$el.find('.relations').append(table.el)
