module Systems

  Dir[File.join(File.dirname(__FILE__ ), "systems/*.rb")].each {|file| require file }

end