module AmyAdmin
  module API

    def columns(model_name)
      model_name.columns.map {|a| {:name=>a.name,:type => a.type }}
    end

    def meta_infos_json
      @meta_infos.each_with_object({}) do |kv,result|
        result[kv[0]] = kv[1]
        # all columns info
        result[kv[0]][:columns] = columns(kv[0].to_s.classify.constantize)
        # display name
        result[kv[0]][:display_name] = I18n.t("activerecord.models.#{kv[0].to_s.singularize}")
        # all associations
        result[kv[0]][:associations] = kv[0].to_s.classify.constantize.reflect_on_all_associations.map do |asso|
          {
            :name => asso.name,
            :class_name => asso.class_name,
            :macro => asso.macro,
            :foreign_key => asso.foreign_key,
            :plural_name => asso.plural_name
          }
        end
      end
    end

  end
end
