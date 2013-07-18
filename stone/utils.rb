#! /usr/bin/ruby -w
#

def do_proc(&action)
    action.call(1, 2, 3)    ## you can put params whatever you like
end

def do_lambda
    action = lambda { puts 'hello lambda' }   
    #action.call(self)
    action.call     ## you have to supply the right arity
end

do_proc { puts 'hello proc' }
do_lambda()
