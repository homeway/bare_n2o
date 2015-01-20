%% -*- mode: nitrogen -*-
-module(index).
-compile(export_all).
-include_lib("n2o/include/wf.hrl").
-include("app.hrl").

main() ->
    #dtl{file = bare, app=?APP,bindings=[{body,body()}]}.

body() ->
    [
        #h2{body="Hello n2o!"}
    ].