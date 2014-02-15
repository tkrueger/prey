module JavaImports

  PROJECT_ROOT = File.expand_path('..', File.dirname(__FILE__))
  #$: << File.join(PROJECT_ROOT, "lib")
  Dir[File.join(PROJECT_ROOT, "vendor/*.jar")].each {|jar| require jar}

  require 'java'
  require 'jruby/core_ext'

  java_import 'com.jme3.math.Vector3f'
end