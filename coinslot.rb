# This was a straight-forward problem,
# because the denominations are such that a greedy solution will always work.
# You would not be able to use a greedy solution this with:
# input=63, coins=[50, 21, 1]
#
# After 400 correct answers, you get the flag.

require 'socket'

def read_until(f, cs, verbose: false)
  buf = []
  loop {
    b = f.read(1)
    buf << b
    puts buf.join.strip if verbose
    return buf.join.strip if cs.include?(b)
  }
rescue
  puts "had read: '#{buf.join.strip}'"
  raise
end

COINS = [
  ['$10,000 bills:', 1000000],
  ['$5,000 bills:', 500000],
  ['$1,000 bills:', 100000],
  ['$500 bills:', 50000],
  ['$100 bills:', 10000],
  ['$50 bills:', 5000],
  ['$20 bills:', 2000],
  ['$10 bills:', 1000],
  ['$5 bills:', 500],
  ['$1 bills:', 100],
  ['half-dollars (50c):', 50],
  ['quarters (25c):', 25],
  ['dimes (10c):', 10],
  ['nickels (5c):', 5],
  ['pennies (1c):', 1],
].freeze.each(&:freeze)

def make_change(coins, cents_left)
  coins.each_with_object({}) { |(name, cents), h|
    h[name] = cents_left / cents
    cents_left %= cents
  }
end

f = TCPSocket.open('misc.chal.csaw.io', 8000)
n = 0
cs = []

READ_CAREFULLY = false

loop {
  input = f.readline
  puts ">> input: #{input}"
  dollars, cents = input.split(?.)
  # I was actually paranoid that dollars might include commas, like $12,345.67,
  # but this fear turned out to be unfounded
  cents_left = dollars[1..-1].to_i * 100 + cents.to_i
  cs << cents_left
  n += 1
  puts "!! cents: #{cents_left}"

  h = make_change(COINS, cents_left)
  puts h

  if READ_CAREFULLY
    # I was paranoid that the input would take on different forms
    # - maybe different denominations of bills/coins?
    # - maybe they would come in a different order?
    # But this turned out unnecessary.
    loop {
      a = read_until(f, [?:, "\n"], verbose: n >= 500)
      if a == 'correct!'
        puts ">> #{a}"
        break
      end
      puts ">> coin/bill: #{a}"
      puts "<< #{h[a]}"
      f.puts(h[a])
    }
  else
    f.puts(h.values.join("\n"))
    # this reads all the prompts plus the "correct!"
    puts f.readline
  end

  puts "#{n} prompts: #{cs}"
}
