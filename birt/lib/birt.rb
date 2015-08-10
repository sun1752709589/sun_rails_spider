require "birt/routing"
require "birt/version"
require "birt/engine"
require 'rexml/document'
require 'base64'
require 'pry'
require 'mysql2'
require 'rails'


%w{ controllers helpers views}.each do |dir|
  path = File.join(File.dirname(__FILE__), 'app', dir)
  $LOAD_PATH << path
  ActiveSupport::Dependencies.autoload_paths << path
  ActiveSupport::Dependencies.autoload_once_paths.delete(path)
end
Dir.glob("#{File.dirname(__FILE__)}/birt/core/*.rb") { |f| require f }
Dir.glob("#{File.dirname(__FILE__)}/birt/core/table/*.rb") { |f| require f }
Dir.glob("#{File.dirname(__FILE__)}/birt/core/chart/*.rb") { |f| require f }


module Birt
  module_function
  def birt(rptdesign_name)
    "<div class=\"birt\" data-rptdesign=\"#{rptdesign_name}.rptdesign\"></div>"
  end
end
