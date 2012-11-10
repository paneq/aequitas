#encoding: utf-8

module Aequitas
  class Rule
    class Format < self
      TYPE = :invalid

      FORMATS = {}
      # TODO: evaluate re-implementing custom error messages per format type
      # previously these strings were wrapped in lambdas, which were, at one
      # point, invoked with #try_call with the humanized attribute name and value
      FORMAT_MESSAGES = {
        :email_address => '%s is not a valid email address',
        :url           => '%s is not a valid URL',
      }

      equalize(:format)

      # @raise [UnknownValidationFormat]
      #   if the :as (or :with) option is a Symbol that is not a key in FORMATS,
      #   or if the provided format is not a Regexp, Symbol or Proc
      def self.rules_for(attribute_name, options)
        format = options.values_at(:as, :with).compact.first

        rule =
          case format
          when Symbol
            regexp = FORMATS.fetch(format) do
              raise UnknownValidationFormat, "No such predefined format '#{format}'"
            end
            self::Regexp.new(attribute_name, options.merge(:format => regexp, :format_name => format))
          when ::Regexp
            self::Regexp.new(attribute_name, options.merge(:format => format))
          when ::Proc
            self::Proc.new(attribute_name, options.merge(:format => format))
          else
            raise UnknownValidationFormat, "Expected a Regexp, Symbol, or Proc format. Got: #{format.inspect}"
          end

        Array(rule)
      end

      attr_reader :format

      def initialize(attribute_name, options)
        super

        @format = options.fetch(:format)
      end

      def valid_value?(value)
        expected_format?(value)
      rescue ::Encoding::CompatibilityError
        # This is to work around a bug in jruby - see formats/email.rb
        false
      end

    end # class Format
  end # class Rule
end # module Aequitas
