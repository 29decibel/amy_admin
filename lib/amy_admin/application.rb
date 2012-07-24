require 'api'

module AmyAdmin
  # one admin application
  # stores all config infos
  class Application

    def register model_name,infos={}
      @meta_infos ||= {}
      @meta_infos[model_name] = infos
      define_controllers
      draw_routes
    end

    def api(info)
      @apis << info
      define_controllers
      draw_routes
    end

    def draw_routes
      Guomi::Application.routes.draw do
        GuoAdmin.draw_routes(self)
      end
    end


    def draw_routes(route)
      ms = @meta_infos
      end_points = @apis
      route.instance_eval do
        namespace :guo_admin do
          get "dashboard" => "dashboard#home"
          root :to => "dashboard#home"
          # resource relate routes
          ms.each do |model_name,infos|
            model_name = model_name.to_s
            resources model_name do
              # define collection routes
              collection do
                get :page_stats
                # custom actions
                if cas = infos[:collection_actions]
                  cas.each {|a| send(a[:method],a[:name]) }
                end
              end
              # define member routes
              member do
                if cas = infos[:member_actions]
                  cas.each {|a| send(a[:method],a[:name]) }
                end
              end
            end
          end
          # custom apis
          end_points.each do |api|
            send(api[:method],api[:name] => "dashboard##{api[:name]}")
            ::Amy::DashboardController.instance_eval do
              define_method api[:name],api[:action]
            end
          end
        end
      end
    end

    def define_controller(model_name,infos)
      model_name = model_name.to_s
      model = model_name.classify.constantize
      controller_class = "::AmyAdmin::#{model_name.classify.pluralize}Controller"
      eval("class #{controller_class} < InheritedResources::Base;end")
      controller_class.constantize.instance_eval do
        defaults :resource_class => model
        before_filter :authenticate_admin_user!
        respond_to :json
        # define scopes
        has_scope :page, :default => 1
        if infos[:scopes]
          infos[:scopes].each do |s|
            has_scope s.to_sym
          end
        end
        # define collection actions
        (infos[:collection_actions] || []).each {|action| define_method(action[:name],action[:action]) }
        # define member actions
        (infos[:member_actions] || []).each {|action| define_method(action[:name],action[:action]) }
        # add page stats
        define_method :page_stats do
          count = model.count
          respond_with({ total: count,page:(count/50 + (count%50==0 ? 0 : 1)) },location: '')
        end
        # append search paras to end of chain
        define_method :collection do
          @search = end_of_association_chain.metasearch(params[:q])
          @search.relation
        end
      end
    end

    def define_controllers(meta_infos)
      meta_infos.each do |model_name,infos|
        define_controller(model_name,infos)
      end
    end

  end
end
