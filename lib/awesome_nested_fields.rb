module AwesomeNestedFields
  if ::Rails.version < '3.1'
    require 'awesome_nested_fields/railtie'
  else
    require 'awesome_nested_fields/engine'
  end
  require 'awesome_nested_fields/version'
  
  module_path =  File.expand_path('../../', __FILE__)+'/app/helpers/'
  if RUBY_VERSION.include?('1.8')
    require(module_path+'awesome_nested_fields_helper18')  
  else
    require(module_path+'awesome_nested_fields_helper')  
  end
end
