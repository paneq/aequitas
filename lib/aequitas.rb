# -*- encoding: utf-8 -*-

require 'date'
require 'backports'
require 'bigdecimal'
require 'bigdecimal/util'
require 'forwardable'
require 'adamantium'
require 'equalizer'
require 'abstract_type'
require 'ice_nine'
require 'ice_nine/core_ext/object'

# Library namespace
module Aequitas

  # Define constant singleton class
  #
  # @param [Class] klass
  # @param [Symbol] name
  #
  # @return [self]
  #
  # @api private
  #
  def self.singleton_constant(klass, name, &block)
    subclass = Class.new(klass) do
      # Return inspection string
      #
      # @return [String]
      #
      # @api private
      #
      def inspect
        klass = self.class
        "#{klass.superclass.name}::#{klass.name}".freeze
      end
    end
    subclass.class_eval(&block)
    klass.const_set(name, subclass.new)
    self
  end

end 

require 'aequitas/support/blank'
require 'aequitas/evaluator'
require 'aequitas/dsl'
require 'aequitas/dsl/evaluator'
require 'aequitas/class_methods'
require 'aequitas/instance_methods'
require 'aequitas/validator'
require 'aequitas/validator/builder'
require 'aequitas/builder'
require 'aequitas/builder/nullary'
require 'aequitas/matcher'
require 'aequitas/matcher/unary'
require 'aequitas/matcher/unary/attribute'
require 'aequitas/matcher/unary/not'
require 'aequitas/matcher/binary'
require 'aequitas/matcher/binary/and'
require 'aequitas/matcher/binary/or'
require 'aequitas/matcher/binary/xor'
require 'aequitas/matcher/nullary'
require 'aequitas/matcher/nullary/proc'
require 'aequitas/matcher/nullary/format'
require 'aequitas/matcher/nullary/primitive'
require 'aequitas/matcher/nullary/inclusion'
require 'aequitas/matcher/nullary/equality'
require 'aequitas/matcher/nullary/identity'
require 'aequitas/matcher/nullary/greater_than'
require 'aequitas/matcher/nullary/less_than'
require 'aequitas/matcher/nullary/value'
require 'aequitas/rule'
require 'aequitas/rule/guard'
require 'aequitas/rule/nullary'
require 'aequitas/rule/nullary/confirmation'
require 'aequitas/rule/nullary/attribute'
require 'aequitas/rule/nullary/attribute/format'
require 'aequitas/rule/nullary/attribute/length'
require 'aequitas/rule/nullary/attribute/absence'
require 'aequitas/rule/nullary/attribute/presence'
require 'aequitas/rule/nullary/attribute/primitive'
require 'aequitas/rule/nullary/attribute/inclusion'
require 'aequitas/rule/nullary/attribute/predicate'
require 'aequitas/version'
require 'aequitas/violation'
require 'aequitas/result'
