Mina Multi Server
====

This is an extremely simple gem that adds multi-server support to Mina tasks. In
order to avoid complexity, each task is executed **sequentially**. You should
look at other solutions if you need parallel execution.

## Installation

gem install mina-multi_server

## Usage

Set a `server` array in your deploy.rb with the hostnames of the servers where
you want the tasks to be executed.

When using `mina-multi_server`, there is no need to set a `domain` var as Mina
requires.


```ruby
# deploy.rb

require 'mina/multi_server'

task :production do
  set :servers, ['server-1.example.com', 'server-2.example.com']
end

# ...

```

```console
$ mina production deploy
```

## How it works

Each remote task will be executed for each server, setting Mina's `domain` var
to each value of the `servers` array.

For non-remote tasks, each task will be executed only once, `servers` var will
not be used and no `domain` var will be set.

Tasks will be executed one after the other, sequentially.
