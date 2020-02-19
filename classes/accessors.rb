# frozen_string_literal: true

module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*methods)
      methods.each do |method|
        raise TypeError, 'method name is not symbol' unless method.is_a?(Symbol)

        define_method(method) { instance_variable_get("@#{method}") }
        define_method("#{method}=") do |value|
          instance_variable_set("@#{method}", value)
          @history ||= {}
          @history[method] ||= []
          @history[method] << value
        end
        name = method.to_s
        define_method("#{name}_history") { @history[method] }
      end
    end

    def strong_attr_accessor(name, class_name)
      raise TypeError, 'name is not symbol' unless name.is_a?(Symbol)

      define_method(name) { instance_variable_get("@#{name}") }
      define_method("#{name}=") do |value|
        raise TypeError, 'wrong type of name' unless value.is_a?(class_name)

        instance_variable_set("@#{name}", value)
      end
    end
  end
end
