unless File.exist?('enc')
  require 'base64'
  File.open('enc', ?w) { |fo|
    fo.write(Base64.decode64(File.read('enc.base64')))
  }
end

def write(fi, foname, key)
  File.open(foname, ?w) { |fo|
    fi.each_byte.with_index { |b, i| fo.write((b ^ key[i % KEYSIZE]).chr) }
  }
end

# sleeping_dist.py is kind enough to tell us the keysize is 12.
KEYSIZE = 12
fi = File.read('enc')
# We know that the first 8 bytes of a PNG are:
crib = [0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a]
key = [0] * KEYSIZE

# Take a stab in the dark and guess that the file is XORed with the key.
crib.zip(fi.each_byte).each_with_index { |(c, x), i| key[i] = c ^ x }
puts key.map(&:chr).join
# WoAh_A_K - good start. We can guess that the next two chars are "ey",
# but let's not make any assumptions yet.

# Write out the file and inspect it for anything interesting.
write(fi, '1.png', key)

# Partway through the file, we see <rd.CeZscriptio
# It's reasonable to assume this is <rdf:Descriptio
# (originally assumed it should be lowercase d,
# but inspection of the resulting output tells us it should be D,
# since many strings had weird capitalisation if using d)
# Source bytes: 03 43 65 5a

key[8] = 0x03 ^ ?f.ord
key[9] = 0x43 ^ ?:.ord
key[10] = 0x65 ^ ?D.ord
key[11] = 0x5a ^ ?e.ord

puts key.map(&:chr).join
# That's: WoAh_A_Key!?

write(fi, '2.png', key)
# Read this file to get the flag.
