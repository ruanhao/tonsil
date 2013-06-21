#! /usr/bin/ruby -w

## (1) The Kernel.local_variables method returns an Array of Symbols, each of which names a local
##     variable defined in the current scope, in reverse chronological order.
## (2) The names of an object’s instance variables are returned as an Array of Symbols by
##     Kernel#instance_variables in the order they were assigned.
## (3) Kernel.trace_var(global) accepts a Symbol naming a global variable and a block. Every time
##     the named variable is assigned to, the block is called with the new value.
local_val = 'local value'
puts "local_val: #{local_val}"
puts local_variables
