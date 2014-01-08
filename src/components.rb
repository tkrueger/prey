module Components

  require_relative 'component'
  Dir[File.join(File.dirname(__FILE__ ), "components/*.rb")].each {|file| require file }

end