A bare n2o project
==================

## Simple Usage
Write follow commands in you terminal:
```` bash
git clone https://github.com/homeway/bare_n2o.git myproject
cd myproject
rebar g-d co
cp deps/mad/mad ./
./mad deps compile plan repl
````
The mad tool was often to be upgrade. You must meet some trouble if you got newest source of mad from git and use an old version mad.

## About mad
`mad` is a friend of N2O, but it start erlang with `user_drv` instead of erl shell.

If you run the project with mad, you had got a node context with `user_drv`, and there's no config to change node name or node session.

But we can use `net_kernel:start/1` and `erlang:set_cookie/2` to set n2o to a distribut erlang system.

## Start N2O app without mad
I don't like to start erl with mad because follow reasons:
* no clearly methods to specify node session and node name
* strange problem for io:format/2 output
* strange problem for newline output for my mac

I start N2O project by my way:
```` bash
erl -pa deps/snowstorm_n2o/ebin -eval "snowstorm_console:start()"
````
You can write this in your .sh or .bat file.

## Auto compile
nitrogen use `sync` to auto compile project, and N2O use `active`.

`active` is a importent tool to auto recompile `erlydtl` template.

But `sync` can autoload test after compile.

In fact, you can use `sync` and `active` together.

```` bash
erl -sync executable notification_center
````

I wrote some code follow.
As you can guess, I there is test module `abc_test`, it will be executed when I save `abc.erl`.

```` erlang
-module(onsync).
-export([go/0, stop/0]).

go() ->
    sync:go(),
    application:start(snowstorm),
    application:start(sample),
    RunTests = fun(Mods) ->
        ToTest1 = [Mod || Mod <- Mods, erlang:function_exported(Mod, test, 0)],
        ToTest2 = lists:filtermap(fun(M) ->
            M2 = list_to_atom(atom_to_list(M) ++ "_test"),
            code:ensure_loaded(M2),
            case erlang:function_exported(M2, test, 0) of
                true -> {true, M2};
                _ -> false
            end
        end, Mods),
        lists:map(fun(M) ->
            case M:test() of
                ok ->
                    sync_notify:growl_success("test ok");
                _ ->
                    sync_notify:growl_errors("test failed")
            end
        end, lists:flatten(ToTest1 ++ ToTest2))
    end,
    sync:onsync(RunTests).

stop() -> sync:stop().
````

## Route
The bare project use an dynamic route just like nitrogen with name `snowstorm_n2o_route`.

example1:
````
/user/index
user_index
````

example2:
````
/user/show/001
user_show
````

example3:
````
/user/chat/to/account_139432432
user_chat_to
````

## About N2O
### String and Binary
In N2O you must be careful to use string and unicode.

For example, the class must be atom or binary in dsl:
``` erlang
body() -> #panel{class= <<"main-box">>}.
```
or
``` erlang
body() -> #panel{class= 'main-box'}.
```
and the code bellow is wrong:
``` erlang
body() -> #panel{class= "main-box"}.
```
### Do with Unicode
You can write id name with unicode, but you must use binary like this:
``` erlang
V1 = unicode:characters_to_binary("中文名字"),
body() -> #textbox{id= <<"名称"/utf8>>, value= V}.
```
You must use a right way to query the value:
``` erlang
V = list_to_binary(wf:q(<<"名称"/utf8>>))
```
and the code bellow is wrong:
``` erlang
V = unicode:characters_to_binary(wf:q(<<"名称"/utf8>>))
``` 
