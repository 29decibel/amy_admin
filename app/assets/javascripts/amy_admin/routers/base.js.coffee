GuomiAdmin.Routers ||= {}

class GuomiAdmin.Routers.MainRouter extends Backbone.Router
  initialize: ->
    # init
    # setup user session deal with error
    $(document).ajaxError (e, xhr, options) ->
      if xhr.status is 401
        alert "Please login again"
        window.location.herf ='/'
      console.log xhr.responseText
      console.log xhr.status
  routes:
    '.*'                : 'dashboard'
    'list/:model'       : 'list'
    'show/:model/:id'   : 'show'
    'edit/:model/:id'   : 'edit'
    'new/:model'       : 'new'

  list:(model)->
    # check the view exist before
    view_name = "#{model}_list"
    coll = GuomiAdmin.Collections[view_name]
    need_fetch = false
    unless coll
      coll = new GuomiAdmin.Collections.Base()
      coll.model_name = model
      GuomiAdmin.Collections[view_name] = coll
      need_fetch = true
    # create base index
    view_class = GuomiAdmin.Views.Custom["#{model[0].toUpperCase()+model[1..-1]}Index"] || GuomiAdmin.Views.Index
    page = new GuomiAdmin.Views.Index({collection:coll,style:'table'})
    coll.fetch() if need_fetch
    $('.main').html(page.el)

  show:(model,id)->
    # check if the model exist
    view_name = "#{model}_list"
    coll = GuomiAdmin.Collections[view_name]
    record = if coll then coll.get(id) else null
    unless record
      record = new GuomiAdmin.Models.Base(id:id)
      record._model_name = model
      $('.main').html("begin fetch infos")
      record.fetch()
    view = new GuomiAdmin.Views.Show({model:record})
    $('.main').html(view.el)

  edit:(model,id)->
    # check if the model exist
    view_name = "#{model}_list"
    coll = GuomiAdmin.Collections[view_name]
    record = if coll then coll.get(id) else null
    unless record
      record = new GuomiAdmin.Models.Base(id:id)
      record._model_name = model
      $('.main').html("begin fetch infos")
      record.fetch()
    view = new GuomiAdmin.Views.Form({model:record})
    $('.main').html(view.el)

  new:(model)->
    # create model
    record = new GuomiAdmin.Models.Base()
    record._model_name = model
    # create view
    record_view = new GuomiAdmin.Views.Form({model:record})
    $('.main').html(record_view.el)

  dashboard:->
    $('.main').html('')
    rstats = new GuomiAdmin.Views.RegisterStats({header:'User Registrations'})
    $('.main').append(rstats.el)
    rstats = new GuomiAdmin.Views.RegisterStats({header:'User Requests'})
    $('.main').append(rstats.el)
    rstats = new GuomiAdmin.Views.RegisterStats({header:'User Requests'})
    $('.main').append(rstats.el)
    rstats = new GuomiAdmin.Views.RegisterStats({header:'User Requests'})
    $('.main').append(rstats.el)
    rstats = new GuomiAdmin.Views.RegisterStats({header:'User Requests'})
    $('.main').append(rstats.el)
    rstats = new GuomiAdmin.Views.RegisterStats({header:'User Requests'})
    $('.main').append(rstats.el)

