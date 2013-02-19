module Deep
  module Matchers

    def object_deep_eql(expected)
      ObjectDeepEql.new(expected)
    end

    class ObjectDeepEql

      def initialize(expectation)
        @expectation = expectation
      end

      def matches?(target)
        result  = true
        @target = target
        case @expectation
          when Hash
            result &&= @target.is_a?(Hash) && @target.keys.count == @expectation.keys.count
            @expectation.keys.each do |key|
              result &&= @target.has_key?(key) &&
                ObjectDeepEql.new(@expectation[key]).matches?(@target[key])
            end
          when Array
            result &&= @target.is_a?(Array) && @target.count == @expectation.count
            @expectation.each_index do |index|
              result &&= ObjectDeepEql.new(@expectation[index]).matches?(@target[index])
            end
          else
            # Hack: To do the deep object matching that I need (only) ...
            # Hack: We don't recurse on these basic classes or anything that has an instance method '=='
            # Hack: Probably *not* a complete list for other purposes!!!)
            # Hack: Be aware, Time does NOT have an instance method '==' (although it responds_to it, like all Objects).
            if [Time, String, Fixnum, Float, Symbol, TrueClass, FalseClass, NilClass].include?(cls = @expectation.class) ||
              cls.instance_methods(false).include?(:==)
              result &&= @target == @expectation
            else
              result &&= @target.is_a?(@expectation.class)
              @expectation.class.instance_methods(false).each do |im|
                # Hack: ignores methods that take any args!!!
                next unless result && @expectation.method(im).arity == 0
                result &&= @target.respond_to?(im) && ObjectDeepEql.new(@expectation.send(im)).matches?(@target.send(im))
              end
            end
        end
        result
      end

      def failure_message_for_should
        "expected #{@target.inspect} to be object_deep_eql with #{@expectation.inspect}"
      end

      def failure_message_for_should_not
        "expected #{@target.inspect} not to be in object_deep_eql with #{@expectation.inspect}"
      end
    end

  end
end
