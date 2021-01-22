#! /usr/bin/env ruby

if ARGV.length != 1
  $stderr.puts "Usage: #{$0} input"
  exit 1
end

data = File.read ARGV[0]
data.force_encoding Encoding::BINARY

def readline
  x = $stdin.readline.gsub(/#.*/, '').strip
  x.empty? ? readline : x
end

until $stdin.eof?
  begin
    pattern = readline
    repl = readline
  rescue EOFError => e
    break
  end

  r = Regexp.compile(pattern.split(/ /).map do |x|
    if    x =~ /^[0-9a-fA-F]{1,2}$/; Regexp.quote x.to_i(16).chr
    elsif x =~ /^\?{1,2}$/;          '.'
    else raise RuntimeError, "Ivalid pattern #{x.inspect}"; end
  end.join, Regexp::MULTILINE, 'n')

  count = 0
  mat = nil
  data.gsub! r do |m|
    # $stderr.puts "Match %s: 0x%x" % [pattern, Regexp.last_match.offset(0).first]
    if (count += 1) != 1
      tm = Regexp.last_match.offset(0).first
      s = "Pattern multiple matches: %s (first 0x%x, second 0x%x)" % [pattern, mat, tm]
      raise RuntimeError, s
    end
    mat = Regexp.last_match.offset(0).first

    repl.split(/ /).each_with_index.map do |x, i|
      if    x =~ /^[0-9a-fA-F]{1,2}$/; x.to_i(16).chr
      elsif x =~ /^!([0-9]+)$/;        m[$1.to_i]
      elsif x =~ /^!{1,2}$/;           m[i]
      else raise RuntimeError, "Invalid replacement #{x.inspect}"; end
    end.join
  end
  raise RuntimeError, "Pattern didn't match: #{pattern}" if count == 0
end

$stdout.write data
