task :select do
  ensure!(:servers)
  puts 'Select server:'

  fetch(:servers).each_with_index do |item, index|
    puts "#{index + 1}. #{item}"
  end
  print '> '

  begin
    exit 1 unless (result = STDIN.gets.to_i) > 0
    exit 1 unless (server = fetch(:servers)[result - 1])

    set :domain, server
    set :servers, [server]
  rescue Interrupt
    print "\n"
    exit 1
  end
end
