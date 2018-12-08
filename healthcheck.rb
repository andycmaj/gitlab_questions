#!/usr/bin/env ruby

# gem install net-ping
require 'net/ping'

# parses human-readable duration strings, such as '5m', '30s', etc.
class Duration
	TOKENS = {
	  "s" => (1),
	  "m" => (60),
	  "h" => (60 * 60),
	  "d" => (60 * 60 * 24)
	}

	attr_reader :in_seconds

	def initialize(input)
	  @input = input
	  @in_seconds = 0
	  parse
	end

	def parse
	  @input.scan(/(\d+)(\w)/).each do |value, unit|
		@in_seconds += value.to_i * TOKENS[unit]
	  end
	end
  end

# checks whether the current time has caught up with the desired end_time
def time_is_up(end_time)
  DateTime.now >= end_time
end

# takes a simple average of an array of values
def avg(values)
  values.reduce(:+) / values.length
end

url = "https://gitlab.com"
duration_input = ARGV[0]
duration = Duration.new(duration_input).in_seconds
end_time = DateTime.now + (duration / 86400.0)

@http = Net::Ping::HTTP.new(url)
ping_durations = []
failure_count = 0
count = 0

puts "pinging #{url} until #{end_time.strftime("%T")} local time (#{duration_input})"

until time_is_up(end_time)
	count += 1
	if @http.ping
		ping_durations << @http.duration
		puts "host replied in #{@http.duration}"
	else
		failure_count += 1
		puts "failed to ping: #{@http.exception}"
	end
end

# p99 calculation
sorted = ping_durations.sort_by { |duration| -duration }
p99_cutoff_index = (sorted.length * 0.01).ceil

puts "Average round-trip is #{avg(ping_durations)}"
puts "p99 duration is #{avg(sorted[0..p99_cutoff_index])}"
puts "#{failure_count} pings failed"