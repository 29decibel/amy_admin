GuomiAdmin.Views ||= {}

class GuomiAdmin.Views.Form extends Backbone.View
  template: JST['amy_admin/templates/base/form']
  initialize: (options)->
    # ini
    @model = options.model
    @model.on 'change',@render
    @meta_info = GuomiAdmin.meta_info[@model.model_name()]
    @render()
  events:
    'click button.save'   : 'save'
    'click button.back' : 'go_back'
  save:(e)=>
    e.preventDefault()
    data = GuomiAdmin.Utils.formData(@$el.find('form'))
    view = @$el.find('form')
    self = this
    @model.save data,
      success:->
        GuomiAdmin.Utils.alert("Saved...",view,'alert-success')
        self.go_back(e)
      error:(model,rsp,jqr)->
        error_json = $.parseJSON(rsp.responseText)
        message = ''
        for attr,errors of error_json.errors
          message += "#{attr}---#{errors.join(',')}\n"
        GuomiAdmin.Utils.alert(message,view,'alert-error')
  go_back:(e)=>
    e.preventDefault()
    window.location.href = "#list/#{@model.model_name()}"
  render: =>
    @$el.html(@template(model:@model))
