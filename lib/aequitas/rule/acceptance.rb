# -*- encoding: utf-8 -*-

require 'aequitas/rule'

module Aequitas
  class Rule
    # TODO: update this to inherit from Rule::Within::Set
    class Acceptance < Rule

      equalize_on superclass.equalizer.keys + [:accept]

      DEFAULT_ACCEPTED_VALUES = [ '1', 1, 'true', true, 't' ]

      attr_reader :accept

      def initialize(attribute_name, options = {})
        super

        @accept = Array(options.fetch(:accept, DEFAULT_ACCEPTED_VALUES))

        allow_nil! unless defined?(@allow_nil)
      end

      def valid?(resource)
        value = attribute_value(resource)
        return true if exempt_value?(value)
        accept.include?(value)
      end

      def violation_type(resource)
        :accepted
      end

    private

      # TODO: isn't this superfluous considering Rule#optional?
      def exempt_value?(value)
        allow_nil? && value.nil?
      end

    end # class Acceptance
  end # class Rule
end # module Aequitas
