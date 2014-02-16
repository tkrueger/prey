class Component
  @@default_arguments = {}
  def initialize(object_attribute_hash = {})
    arguments = @@default_arguments.merge(object_attribute_hash)
    arguments.map { |(k, v)|
      writer_m = "#{k}="
      self.class.send(:attr_accessor, k) unless respond_to?(writer_m)
      public_send("#{k}=", v)
    }
  end
end