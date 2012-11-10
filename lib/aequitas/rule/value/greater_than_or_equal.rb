# -*- encoding: utf-8 -*-

module Aequitas
  class Rule
    class Value
      class GreaterThanOrEqual < self
        TYPE = :greater_than_or_equal_to

        def expected_value?(value)
          value >= expected
        rescue ArgumentError
          # TODO: figure out better solution for: can't compare String with Integer
          true
        end

        def violation_data
          [ [ :minimum, expected ] ]
        end

      end # class GreaterThanOrEqual
    end # class Value
  end # class Rule
end # module Aequitas
