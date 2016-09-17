# First, I assumed (correctly) that the first few bytes of the file are:
crib = 'CSAW 2016 FUZYLL RECON PART 3 OF'
stuff = File.read('tomato')
knowns = crib.each_byte.zip(stuff.each_byte).each_with_object({}) { |(a, b), h| h[b] = a }
puts knowns.sort_by(&:last).to_h

# I examined the crib and interpolated these values in:
knowns[244] = 52
knowns[245] = 53
knowns[194] = 66
knowns[196] = 68
knowns[212] = 77
knowns[216] = 81
knowns[229] = 86
knowns[231] = 88

# And I extrapolated these values
knowns[247] = 55
knowns[248] = 56
knowns[249] = 57

#puts knowns.sort_by(&:last).to_h

# I assumed that the characters before the second occurrence of 2016 were csaw
knowns[0x83] = ?c.ord
knowns[0xA2] = ?s.ord
knowns[0x81] = ?a.ord
knowns[0xA6] = ?w.ord
# These are interpolated from the above
knowns[0xA5] = ?v.ord
knowns[0xA4] = ?u.ord
knowns[0xA3] = ?t.ord
knowns[0x82] = ?b.ord

puts knowns.sort_by(&:last).to_h

# TOMATOES
knowns[0x94] = ?M.ord
knowns[0x85] = ?e.ord
# interpolate
knowns[0x84] = ?d.ord

# don't
knowns[0x95] = ?n.ord
knowns[0x7D] = ?'.ord

# outside gives i, plus interpolation
knowns[0x86] = ?f.ord
knowns[0x87] = ?g.ord
knowns[0x88] = ?h.ord
knowns[0x89] = ?i.ord

# I've
knowns[0xC9] = ?I.ord

# character
knowns[0x99] = ?r.ord

# like (and interpolate)
knowns[0x93] = ?l.ord
knowns[0x92] = ?k.ord
knowns[0x91] = ?j.ord

# year (and interpolate)
knowns[0xA8] = ?y.ord
knowns[0xA7] = ?x.ord

puts stuff.each_byte.map { |x| (knowns[x] || ??.ord).chr }.join
# I'm not bothering to find out the rest, since the message is readable enough from this.
