require 'rspec'

describe 'My behaviour' do

  class NewComponent
    @@default_arguments = {:always_there => 100}
    def initialize(object_attribute_hash = {})
      arguments = @@default_arguments.merge(object_attribute_hash)
      arguments.map { |(k, v)|
        writer_m = "#{k}="
        self.class.send(:attr_accessor, k) unless respond_to?(writer_m)
        public_send("#{k}=", v)
      }
    end
  end

  it 'should do something' do
    puts NewComponent.new(:something => 1, :other => 2).inspect

  end
end