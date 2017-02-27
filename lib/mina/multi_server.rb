module Mina
  class Commands
    alias :mina_run :run

    def run(backend)
      backend == :remote ? on_each_server { mina_run(backend) } : mina_run(backend)
    end
  end

  module Helpers::Internal
    def on_each_server
      ensure!(:servers)
      fetch(:servers).each do |server|
        print_stdout "Server: #{server}"
        set(:domain, server)
        yield
      end
    end
  end
end
