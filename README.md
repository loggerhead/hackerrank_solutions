The problem link is <https://www.hackerrank.com/RELATIVE_PATH/FILENAME>

# Run
# Erlang
```shell
# file name must same as module name
ln -f FILENAME.erl solution.erl
# compile, run `solution:main()` and wait input from stdin
erlc solution.erl && cat | erl -noshell -s solution main
# press `CTRL+D` to enter EOF for ending input
```