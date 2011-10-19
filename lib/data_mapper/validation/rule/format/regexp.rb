# -*- encoding: utf-8 -*-

require 'data_mapper/validation/rule/format'

module DataMapper
  module Validation
    class Rule
      module Format

        class Regexp < Rule

          include Format

          EQUALIZE_ON = superclass::EQUALIZE_ON.dup << :format << :format_name

          equalize *EQUALIZE_ON


          attr_reader :format_name

          def initialize(attribute_name, options = {})
            super

            @format_name = options.fetch(:format_name, nil)
          end

          def valid?(resource)
            value = resource.validation_property_value(attribute_name)
            return true if optional?(value)

            # FIXME: Calling to_s on Addressable instance does not seem 
            # like a good way here. This list with explict to_s calls 
            # could grow unto an unmanagable clumb
            match_value = case value
            when Numeric,Addressable::URI
              value.to_s
            else
              value
            end
            match_value =~ self.format
          rescue ::Encoding::CompatibilityError
            # This is to work around a bug in jruby - see formats/email.rb
            false
          end

          # TODO: integrate format into error message key?
          # def error_message_args
          #   if format_name.is_a?(Symbol)
          #     [ :"invalid_#{format_name}", attribute_name ]
          #   else
          #     [ :invalid, attribute_name ]
          #   end
          # end

        end # class Regexp

      end # module Format
    end # class Rule
  end # module Validation
end # module DataMapper
