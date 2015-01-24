A bare n2o project
==================

## Usage
Write follow commands in you terminal:
```` bash
git clone https://github.com/homeway/bare_n2o.git myproject
cd myproject
rebar g-d co
cp deps/mad/mad ./
./mad deps compile plan repl
````
The mad tool was often to be upgrade. You must meet some trouble if you got newest source of mad from git and use an old version mad.

## Route
the bare project use an dynamic route just like nitrogen with name 'snowstorm_n2o_route'.

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
## About N2O
### string and binary
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
### about unicode
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
### about distribut
If you run the project with mad, you had got a node context with user_drv, and there's no config to node name or session.

But we can use `net_kernel:start/1` and `erlang:set_cookie/2` to set n2o to a distribut erlang system. 