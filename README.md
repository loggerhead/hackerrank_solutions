The problem link is <https://www.hackerrank.com/challenges/FILENAME>

# Run
# Erlang
```shell
ln -f FILENAME.erl solution.erl
# compile, run `solution:main()` and wait input from stdin
erlc solution.erl && cat | erl -noshell -s solution main
# press `CTRL+D` to input EOF for end input
```