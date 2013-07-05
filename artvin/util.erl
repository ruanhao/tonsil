-module(util).
-compile(export_all).

get_pid() ->
    os:getpid().

system(Cmd) -> 
    From    = self(),
    Timeout = 5000,
    Worker = spawn(fun() -> 
                Res  = os:cmd(Cmd),
                From ! {ok, Res} end),
    receive
        {ok, Res} -> Res
    after
        Timeout -> 
            exit(Worker, kill),
            fail
    end.


get_epoch() -> 
    calendar:datetime_to_gregorian_seconds(calendar:universal_time())-719528*24*3600.

get_now() -> 
    calendar:now_to_local_time(now()).
