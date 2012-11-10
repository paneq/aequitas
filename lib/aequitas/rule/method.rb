# -*- encoding: utf-8 -*-

module Aequitas
  class Rule
    class Method < self

      equalize(:method)

      attr_reader :method, :violation_type

      def initialize(attribute_name, options={})
        super

        @method         = options.fetch(:method,         attribute_name)
        @violation_type = options.fetch(:violation_type, :unsatisfied_condition)
      end

      def validate(resource)
        result, error_message = resource.__send__(method)

        if result
          nil
        else
          Violation.new(resource, self)
        end
      end

    end # class Method
  end # class Rule
end # module Aequitas
