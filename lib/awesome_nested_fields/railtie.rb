module AwesomeNestedFields
  class Railtie < ::Rails::Railtie
    config.before_configuration do
      config.action_view.javascript_expansions[:defaults] << 'jquery.nested-fields'
    end

    initializer "AwesomeNestedFields.init" do |app|
     module_path =  File.expand_path('../../..', __FILE__)+ '/app/helpers/'
     require(module_path+'awesome_nested_fields_helper')  

      ActionView::Base.class_eval do
        include AwesomeNestedFieldsHelper
      end
    end
    
  end
end
