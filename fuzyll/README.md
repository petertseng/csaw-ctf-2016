# Step 1

http://fuzyll.com/files/csaw2016/start

    CSAW 2016 FUZYLL RECON PART 1 OF ?: People actually liked last year's challenge, so CSAW made me do it again... Same format as last year, new stuff you need to look up. The next part is at /csaw2016/<the form of colorblindness I have>.

Searching the blog, we can find http://fuzyll.com/2015/enchroma-glasses/

# Step 2

http://fuzyll.com/files/csaw2016/deuteranomaly

Just open it with a text editor and you get to see it.

    CSAW 2016 FUZYLL RECON PART 2 OF ?: No, strawberries don't look exactly like this, but it's reasonably close. You know what else I can't see well? /csaw2016/<the first defcon finals challenge i ever scored points on>

LinkedIn tells us Fuzyll participated in DEFCON CTFs 19, 20, 21, 22.
It was difficult to find the challenge names; the best resource our team found was https://www.defcon.org/html/torrent/DEF%20CON%2019%20ctf.torrent from which we tried all names and found the answer.

# Step 3

http://fuzyll.com/files/csaw2016/tomato

We are greeted with a string of odd characters, and have to make a sensible message out of them.

This work is explained in [tomato.rb](./tomato.rb)

It's been pointed out that we should have tried different encodings before trying to bake our own translation.

Oops. Either way, we get a reasonably readable message out of it anyway:

    CSAW 2016 FUZYLL RECON PART 3 Of ?? I dOn't even like tOMatOes? Anyway? Outside Of CTFs? I've been ?laying a fair aMOunt Of WOrld Of WarCraft Over the ?ast year ?never thOught I'd be saying that after CataclysM? but here we are?? The next ?art is at ?csaw2016??My Main WOW character's naMe??

We can find http://fuzyll.com/2015/blackfathom-deep-dish/ on the blog.
Now let's look for some information on the founding members.

* http://blackfathom.org/2015/03/26/preparing-for-daring-deliveries.html
* http://blackfathom.org/contact.html

# Step 4

http://fuzyll.com/files/csaw2016/elmrik

We are greeted with some Ruby code that does a base 52 encoding, and we have to write the decoder.

This decoder is in [elmrik.rb](./elmrik.rb)

    CSAW 2016 FUZYLL RECON PART 4 OF ?: In addition to WoW raiding, I've also been playing a bunch of Smash Bros. This year, I competed in my first major tournament! I got wrecked in every event I competed in, but I still had fun being in the crowd. This tournament in particular had a number of upsets (including Ally being knocked into losers of my Smash 4 pool). On stream, after one of these big upsets in Smash 4, you can see me in the crowd with a shirt displaying my main character! The next part is at /csaw2016/<the winning player's tag>.

https://www.reddit.com/r/smashbros/comments/4pnkud/ceo_2016_smash_4_singles_upsets_day_1/ is so kind to list us the upsets.

https://www.youtube.com/watch?v=Q6eqhPLjDhg is it.
Yoshi shirt sighted at https://www.youtube.com/watch?v=Q6eqhPLjDhg&t=11m20s

# Step 5

http://fuzyll.com/files/csaw2016/jade

It's gzipped.

    CSAW 2016 FUZYLL RECON PART 5 OF 6: I haven't spent the entire year playing video games, though. This past March, I spent time completely away from computers in Peru. This shot is from one of the more memorable stops along my hike to Machu Picchu. To make things easier on you, use only ASCII: /csaw2016<the name of these ruins>.

Use your favourite search engine to look up ruins of Peru.
This is Wiñay Wayna.

# Step 6

http://fuzyll.com/files/csaw2016/winaywayna

    CSAW 2016 FUZYLL RECON PART 6 OF 6: Congratulations! Here's your flag{WH4T_4_L0NG_4ND_STR4NG3_TRIP_IT_H45_B33N}.
