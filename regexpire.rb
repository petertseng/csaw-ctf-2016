# You don't need to provide a full regex parser!
# The regexes given are very simple!
# [], (), and {} are only given at the top level (NEVER nested)
#
# After 1000 correct answers, you get the flag.

require 'socket'

GROUPS = {
  '\W' => ?!,
  '\w' => ?w,
  '\D' => ?a,
  '\d' => ?1,
}.freeze.each_value(&:freeze)

R = /\\./

def bracket_term(r)
  term(r).tr(?-, '')
end

def term(r)
  r.gsub(R, GROUPS)
end

def find(regex, sofar = [])
  return sofar.join if regex.empty?
  case regex[0]
  when ?[
    close = regex.index(?])
    choices = bracket_term(regex[1...close])
    return find(regex[(close + 1)..-1], sofar << choices.chars.sample)
  when ?(
    close = regex.index(?))
    choices = regex[1...close]
    return find(regex[(close + 1)..-1], sofar << choices.split(?|).sample)
  when ?{
    close = regex.index(?})
    repeat = regex[1...close].to_i
    return find(regex[(close + 1)..-1], sofar.concat([sofar.last] * (repeat - 1)))
  when ?+, ?*
    return find(regex[1..-1], sofar)
  when '\\'
    return find(regex[2..-1], sofar << term(regex[0..1]))
  else
    return find(regex[1..-1], sofar << regex[0])
  end
end

f = TCPSocket.open('misc.chal.csaw.io', 8001)
# Dump the line that says "Can you match these regexes?"
puts f.readline

n = 0

loop {
  n += 1
  input = f.readline
  puts ">> input #{n}: #{input}"
  answer = find(input)
  puts "<< answer #{n}: #{answer}"
  f.puts(answer)
}
