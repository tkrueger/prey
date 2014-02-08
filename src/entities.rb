class Entities
  require_relative 'entity'
  Dir[File.join(File.dirname(__FILE__ ), 'entities/*.rb')].each {|file| require file }
end