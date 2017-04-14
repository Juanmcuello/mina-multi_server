Mina Multi Server
====

This is an extremely simple gem that adds multi-server support to [Mina][mina]
tasks. In order to avoid complexity, each task is executed **sequentially**. You
should look at other solutions if you need parallel execution.

[mina]: https://github.com/mina-deploy/mina

## Installation

gem install mina-multi_server

## Usage

Set a `servers` array in your deploy.rb with the hostnames of the servers where
you want the tasks to be executed on.

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

Each remote task will be executed for each server of `servers` array, setting
`ENV['domain']` to each server. Mina [checks][checks] ENV[`domain`] when fetching the
`domain` to be used by the task. Using the `ENV` keeps the `domain` var of Mina
untouched, so you can still use it for other task (such as `ssh`). In addition,
`ENV['domain']` is also restored to its previous value in case it was set.

For non-remote tasks, each task will be executed only once and `servers` var
will not be used.

Tasks will be executed one after the other, sequentially.

[checks]: https://github.com/mina-deploy/mina/blob/master/lib/mina/configuration.rb#L27

## Running tasks on a single server

Mina-multi_server includes a `select` task that lets you pick the server where you
want the task to be executed on. You just need to call it before the main task.
You will also need to require `mina/multi_server/select` in your deploy.rb.

```ruby
# deploy.rb

require 'mina/multi_server'
require 'mina/multi_server/select'

task :production do
  set :servers, ['server-1.example.com', 'server-2.example.com']
end

# ...
```

```
$ mina production select ssh

Select server:
1. server-1.example.com
2. server-2.example.com
>
```
After you select an option, the `domain` var that Mina uses will be set to the
selected server. In addition, the `servers` array will be reduced to a
single-item array including only the selected server.
