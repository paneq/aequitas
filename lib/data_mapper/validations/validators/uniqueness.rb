# -*- encoding: utf-8 -*-

require 'data_mapper/validations/validator'

module DataMapper
  module Validations
    module Validators
      class Uniqueness < Validator

        include DataMapper::Assertions

        def initialize(attribute_name, options = {})
          if options.has_key?(:scope)
            assert_kind_of('scope', options[:scope], Array, Symbol)
          end

          super

          set_optional_by_default
        end

        def call(target)
          return true if valid?(target)

          error_message = @options[:message] || ValidationErrors.default_error_message(:taken, attribute_name)
          add_error(target, error_message, attribute_name)

          false
        end

        def valid?(target)
          value = target.validation_property_value(attribute_name)
          return true if optional?(value)

          opts = {
            :fields        => target.model.key(target.repository.name),
            attribute_name => value,
          }

          Array(@options[:scope]).each { |subject|
            unless target.respond_to?(subject)
              raise(ArgumentError,"Could not find property to scope by: #{subject}. Note that :unique does not currently support arbitrarily named groups, for that you should use :unique_index with an explicit validates_uniqueness_of.")
            end

            opts[subject] = target.__send__(subject)
          }

          resource = DataMapper.repository(target.repository.name) do
            target.model.first(opts)
          end

          return true if resource.nil?
          target.saved? && resource.key == target.key
        end

      end # class Uniqueness

      # Validate the uniqueness of a field
      #
      def validates_uniqueness_of(*attributes)
        validators.add(Validators::Uniqueness, *attributes)
      end

    end # module Validators
  end # module Validations
end # module DataMapper