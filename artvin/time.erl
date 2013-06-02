-module(time).
-compile(export_all).

get_epoch() -> 
    calendar:datetime_to_gregorian_seconds(calendar:universal_time())-719528*24*3600.

get_now() -> 
    calendar:now_to_local_time(now()).
