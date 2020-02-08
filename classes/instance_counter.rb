module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instance_counter
      @count ||= 0
      @count += 1
    end

    def instances
      @count
    end

  end

  module InstanceMethods

    private

    def register_instance
      self.class.instance_counter
    end

  end
end
