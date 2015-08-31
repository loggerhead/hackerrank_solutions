-module(solution).
-export([main/0]).

main() ->
    {ok, _} = io:fread("", "~s"),
    io:fwrite("Hello World~n"),
    nil.
