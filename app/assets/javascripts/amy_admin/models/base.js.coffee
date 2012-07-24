GuomiAdmin.Models ||= {}
GuomiAdmin.Collections ||= {}

class GuomiAdmin.Models.Base extends Backbone.Model
  url:->
    "/amy_admin/#{@model_name()}/#{@id || ''}"
  model_name:->
    @_model_name || @collection.model_name || ''
  show_fields:->
    GuomiAdmin.Utils.columns(@model_name(),'show')
  form_fields:->
    fields = GuomiAdmin.Utils.columns(@model_name(),'form')
    _.each ['id','created_at','updated_at'],(w)->
      id_index = fields.indexOf(w)
      if id_index >= 0
        fields.splice(id_index,1)
    fields
  custom_action:(name,type)=>
    self = this
    $.ajax "/amy_admin/#{@model_name()}/#{@id}/#{name}",{type:type,success:(rsp,aa)->
      alert 'operation success'
    }
  meta_info:->
    @_meta_info ||= (GuomiAdmin.meta_info[@model_name()] || [])
  relations_of:(type)->
    _.select @meta_info().associations||[],(ass)->
      ass.macro is type and GuomiAdmin.meta_info[ass.plural_name]
  has_many_relations:->
    @relations_of('has_many')
  belongs_to_relations:->
    @relations_of('belongs_to')
  relation_column:(column_name)->
    cols = _.select @meta_info().associations||[],(ass)->
      ass.macro is 'belongs_to' and ass.foreign_key is column_name
    cols[0]
  display_value:(col)=>
    r_col = @relation_column(col)
    window.yy=this
    if r_col
      if @get(col) then "<a href='#show/#{r_col.plural_name}/#{@get(col)}'>#{r_col.name}(#{@get(col)})</a>" else ''
    else
      @get(col)

class GuomiAdmin.Collections.Base extends Backbone.Collection
  model: GuomiAdmin.Models.Base
  initialize:->
    @page = 1
    @query_scopes = {}
    @search_query = {}
  scopes:->
    @ss ||= (GuomiAdmin.meta_info[@model_name]['scopes']||[])
  url:->
    "/amy_admin/#{@model_name}?#{@query_para()}"
  query_para:->
    query = {}
    # page info
    query.page = @page
    # scope info
    $.extend query,@query_scopes
    # query info
    $.extend query,{q:@search_query}
    $.param query
  custom_action:(name,type)=>
    self = this
    $.ajax "/amy_admin/#{@model_name}/#{name}",{type:type,success:(rsp,aa)->
      self.add(new GuomiAdmin.Models.Base(rsp))
    }
  # default will be all
  index_columns:->
    GuomiAdmin.Utils.columns(@model_name,'index')
  page_info:(callback)->
    $.get "/amy_admin/#{@model_name}/page_stats.json",success:(rsp)->
      callback(rsp)
