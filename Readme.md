a bare n2o project
==================

##Usage
write follow commands in you terminal:
```` bash
git clone https://github.com/homeway/bare_n2o.git myproject
cd myproject
rebar g-d co
cp deps/mad/mad ./
./mad deps compile plan repl
````

##Route
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
