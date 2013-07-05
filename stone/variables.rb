#! /usr/bin/ruby -w

## (1) The Kernel.local_variables method returns an Array of Symbols, each of which names a local
##     variable defined in the current scope, in reverse chronological order.
## (2) The names of an object’s instance variables are returned as an Array of Symbols by
##     Kernel#instance_variables in the order they were assigned.
## (3) Kernel.trace_var(global) accepts a Symbol naming a global variable and a block. Every time
##     the named variable is assigned to, the block is called with the new value.

## When Array acts as RValue, it is splatted automatically
def test_assign
    a, b, c = *( 1 .. 2 ), 3
    puts "a: #{a}, b: #{b}, c: #{c}"
end

class Test
    @class_var = 'hello world'
    def self.show_var
        @class_var
    end

    def show_class_var
        puts self.class.show_var
    end
end

def test_class_variable
    instance = Test.new
    instance.show_class_var
end


test_assign
test_class_variable
