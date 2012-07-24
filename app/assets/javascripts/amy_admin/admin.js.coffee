#= require_self
#= require_tree ./libs
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.GuomiAdmin =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {
    Custom:{}
  }
  Utils:
    formData:(form)->
      result = {}
      for key in $(form).serializeArray()
        control = $(form).find("[name=#{key.name}]")
        if control.attr('type')=='checkbox'
          result[key.name] = if key.value=='on' then true else false
        else
          result[key.name] = key.value
        # add unchecked values
        for cv in $(form).find('[type=checkbox]')
          result[$(cv).attr('name')] = $(cv).prop('checked')
      result
    alert:(msg,parent_view,css_class)->
      info = $("<div class='alert #{css_class}'>#{msg}<a class='close' data-dismiss='alert' href='#'>&times;</a></div>")
      # remove previous one if exist
      $(parent_view).find('.alert').remove()
      # append the new alert infos
      $(parent_view).prepend(info)
      # remove_info = ->
      #   info.remove()
      # setTimeout remove_info,20000
    columns:(model_name,type)->
      custom_cols = GuomiAdmin.meta_info[model_name][type]
      if custom_cols != undefined
        return custom_cols
      # the default one
      _.map GuomiAdmin.meta_info[model_name].columns,(c)->
        c.name
    form_field:(model_name,field,value)->
      col_info = _.select GuomiAdmin.meta_info[model_name].columns,(c)->
        c.name==field
      if value==undefined
        value=''
      col_info = col_info[0] || {}
      switch col_info.type
        when 'text' then "<textarea class='input-xxlarge' rows='10' name='#{field}'>#{value}</textarea>"
        when 'boolean' then "<input name='#{field}' type='checkbox' #{if value then "checked='checked'" else ''}></input>"
        else
          "<input type='text' name='#{field}' value='#{value}'></input>"

