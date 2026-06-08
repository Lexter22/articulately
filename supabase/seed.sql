-- ============================================================
-- Articulately: Schema + Seed Data
-- Run this in your Supabase SQL Editor
-- ============================================================

-- Schema
CREATE TABLE IF NOT EXISTS categories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  subtitle TEXT NOT NULL DEFAULT '',
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS flashcards (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  text TEXT NOT NULL,
  category_id UUID NOT NULL REFERENCES categories(id) ON DELETE CASCADE,
  difficulty TEXT NOT NULL CHECK (difficulty IN ('easy', 'medium', 'hard')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_flashcards_category_difficulty
  ON flashcards(category_id, difficulty);

-- ============================================================
-- Categories
-- ============================================================

INSERT INTO categories (id, name, subtitle) VALUES
  ('11111111-1111-1111-1111-111111111111', 'Classic Twisters', 'Timeless tongue twisters everyone knows'),
  ('22222222-2222-2222-2222-222222222222', 'Alliteration Station', 'Repeating sounds to trip you up'),
  ('33333333-3333-3333-3333-333333333333', 'S & Sh Sounds', 'Master the sibilant sounds'),
  ('44444444-4444-4444-4444-444444444444', 'R & L Sounds', 'Roll and lilt your way through'),
  ('55555555-5555-5555-5555-555555555555', 'Speed Rounds', 'Short and fast — say them 3x quickly'),
  ('66666666-6666-6666-6666-666666666666', 'Silly Sentences', 'Ridiculous phrases for fun practice');

-- ============================================================
-- Classic Twisters
-- ============================================================

-- Easy
INSERT INTO flashcards (text, category_id, difficulty) VALUES
  ('She sells seashells by the seashore', '11111111-1111-1111-1111-111111111111', 'easy'),
  ('Red lorry, yellow lorry', '11111111-1111-1111-1111-111111111111', 'easy'),
  ('Toy boat, toy boat, toy boat', '11111111-1111-1111-1111-111111111111', 'easy'),
  ('Fresh French fried fish', '11111111-1111-1111-1111-111111111111', 'easy'),
  ('I scream, you scream, we all scream for ice cream', '11111111-1111-1111-1111-111111111111', 'easy'),
  ('A proper copper coffee pot', '11111111-1111-1111-1111-111111111111', 'easy'),
  ('Black bug bit a big black bear', '11111111-1111-1111-1111-111111111111', 'easy'),
  ('Eleven benevolent elephants', '11111111-1111-1111-1111-111111111111', 'easy'),
  ('Six slippery snails slid slowly seaward', '11111111-1111-1111-1111-111111111111', 'easy'),
  ('How much wood would a woodchuck chuck', '11111111-1111-1111-1111-111111111111', 'easy');

-- Medium
INSERT INTO flashcards (text, category_id, difficulty) VALUES
  ('Peter Piper picked a peck of pickled peppers', '11111111-1111-1111-1111-111111111111', 'medium'),
  ('Betty Botter bought some butter but she said this butter is bitter', '11111111-1111-1111-1111-111111111111', 'medium'),
  ('How can a clam cram in a clean cream can', '11111111-1111-1111-1111-111111111111', 'medium'),
  ('Fuzzy Wuzzy was a bear, Fuzzy Wuzzy had no hair', '11111111-1111-1111-1111-111111111111', 'medium'),
  ('I saw Susie sitting in a shoeshine shop', '11111111-1111-1111-1111-111111111111', 'medium'),
  ('Whether the weather be fine or whether the weather be not', '11111111-1111-1111-1111-111111111111', 'medium'),
  ('A skunk sat on a stump and thunk the stump stunk', '11111111-1111-1111-1111-111111111111', 'medium'),
  ('If a dog chews shoes whose shoes does he choose', '11111111-1111-1111-1111-111111111111', 'medium'),
  ('Lesser leather never weathered wetter weather better', '11111111-1111-1111-1111-111111111111', 'medium'),
  ('Can you can a canned can into an un-canned can', '11111111-1111-1111-1111-111111111111', 'medium');

-- Hard
INSERT INTO flashcards (text, category_id, difficulty) VALUES
  ('The sixth sick sheik''s sixth sheep''s sick', '11111111-1111-1111-1111-111111111111', 'hard'),
  ('Pad kid poured curd pulled cod', '11111111-1111-1111-1111-111111111111', 'hard'),
  ('Brisk brave brigadiers brandished broad bright blades', '11111111-1111-1111-1111-111111111111', 'hard'),
  ('If you must cross a course cross cow across a crowded cow crossing, cross the cross coarse cow carefully', '11111111-1111-1111-1111-111111111111', 'hard'),
  ('Imagine an imaginary menagerie manager managing an imaginary menagerie', '11111111-1111-1111-1111-111111111111', 'hard'),
  ('She stood on the balcony inexplicably mimicking him hiccuping and amicably welcoming him in', '11111111-1111-1111-1111-111111111111', 'hard'),
  ('Rory the warrior and Roger the worrier were reared wrongly in a rural brewery', '11111111-1111-1111-1111-111111111111', 'hard'),
  ('The thirty-three thieves thought that they thrilled the throne throughout Thursday', '11111111-1111-1111-1111-111111111111', 'hard'),
  ('Six Czech cricket critics', '11111111-1111-1111-1111-111111111111', 'hard'),
  ('Scissors sizzle, thistles sizzle', '11111111-1111-1111-1111-111111111111', 'hard');

-- ============================================================
-- Alliteration Station
-- ============================================================

-- Easy
INSERT INTO flashcards (text, category_id, difficulty) VALUES
  ('Big blue balloons bounced brightly', '22222222-2222-2222-2222-222222222222', 'easy'),
  ('Cute cats carry colorful cups', '22222222-2222-2222-2222-222222222222', 'easy'),
  ('Daring dogs dig deep ditches', '22222222-2222-2222-2222-222222222222', 'easy'),
  ('Friendly frogs flip flat flapjacks', '22222222-2222-2222-2222-222222222222', 'easy'),
  ('Green grass grows on grassy ground', '22222222-2222-2222-2222-222222222222', 'easy'),
  ('Happy hippos hop on hilltops', '22222222-2222-2222-2222-222222222222', 'easy'),
  ('Jolly jugglers juggle joyfully', '22222222-2222-2222-2222-222222222222', 'easy'),
  ('Kind kings knit knobby knots', '22222222-2222-2222-2222-222222222222', 'easy'),
  ('Lucky lizards leap over logs', '22222222-2222-2222-2222-222222222222', 'easy'),
  ('Merry mice make marvelous muffins', '22222222-2222-2222-2222-222222222222', 'easy');

-- Medium
INSERT INTO flashcards (text, category_id, difficulty) VALUES
  ('Peter''s purple parakeet prances through the park proudly', '22222222-2222-2222-2222-222222222222', 'medium'),
  ('Seven slippery seals swam silently southward', '22222222-2222-2222-2222-222222222222', 'medium'),
  ('Tiny Tim tripped twice trying to tiptoe to town', '22222222-2222-2222-2222-222222222222', 'medium'),
  ('Willy''s wild wolf walloped the walrus weekly', '22222222-2222-2222-2222-222222222222', 'medium'),
  ('Busy bees buzz beside blue blossoming bushes', '22222222-2222-2222-2222-222222222222', 'medium'),
  ('Careful cooks create crispy crunchy cookies constantly', '22222222-2222-2222-2222-222222222222', 'medium'),
  ('Dashing dancers danced during dinner deliberately', '22222222-2222-2222-2222-222222222222', 'medium'),
  ('Eager eagles elegantly eat eight eels each evening', '22222222-2222-2222-2222-222222222222', 'medium'),
  ('Fickle foxes find fresh figs fairly fast', '22222222-2222-2222-2222-222222222222', 'medium'),
  ('Grumpy gorillas grab green grapes greedily', '22222222-2222-2222-2222-222222222222', 'medium');

-- Hard
INSERT INTO flashcards (text, category_id, difficulty) VALUES
  ('Briskly bragging, Brad''s brutal brute of a brother brandished a broom', '22222222-2222-2222-2222-222222222222', 'hard'),
  ('Particularly purposeful penguins plod patiently past perplexed pelicans', '22222222-2222-2222-2222-222222222222', 'hard'),
  ('Several sophisticated scientists simultaneously synthesized seventeen solutions', '22222222-2222-2222-2222-222222222222', 'hard'),
  ('Tremendously talented typists type tremendously tricky texts tirelessly', '22222222-2222-2222-2222-222222222222', 'hard'),
  ('Vivacious Vivian voraciously viewed various vintage violin videos', '22222222-2222-2222-2222-222222222222', 'hard'),
  ('Wretched writers wrestle wretchedly with wrist-wrecking writing rhythms', '22222222-2222-2222-2222-222222222222', 'hard'),
  ('Preshrunk silk shirts shrink swiftly in the shimmering sunshine', '22222222-2222-2222-2222-222222222222', 'hard'),
  ('Critically acclaimed clowns click clacking castanets clumsily', '22222222-2222-2222-2222-222222222222', 'hard'),
  ('Grotesque gargoyles guard the great grey granite gateway', '22222222-2222-2222-2222-222222222222', 'hard'),
  ('Flabbergasted flamingos flamboyantly flock to floating flower festivals', '22222222-2222-2222-2222-222222222222', 'hard');

-- ============================================================
-- S & Sh Sounds
-- ============================================================

-- Easy
INSERT INTO flashcards (text, category_id, difficulty) VALUES
  ('She sees cheese', '33333333-3333-3333-3333-333333333333', 'easy'),
  ('So this is the sushi shop', '33333333-3333-3333-3333-333333333333', 'easy'),
  ('Silly sheep sleep soundly', '33333333-3333-3333-3333-333333333333', 'easy'),
  ('Sam''s shop stocks short spotted socks', '33333333-3333-3333-3333-333333333333', 'easy'),
  ('She says she shall sew a sheet', '33333333-3333-3333-3333-333333333333', 'easy'),
  ('Six sharp smart sharks', '33333333-3333-3333-3333-333333333333', 'easy'),
  ('Selfish shellfish', '33333333-3333-3333-3333-333333333333', 'easy'),
  ('Sure the ship''s shipshape, sir', '33333333-3333-3333-3333-333333333333', 'easy'),
  ('Short swords, sharp swords', '33333333-3333-3333-3333-333333333333', 'easy'),
  ('Shiny shoes, soggy shoes', '33333333-3333-3333-3333-333333333333', 'easy');

-- Medium
INSERT INTO flashcards (text, category_id, difficulty) VALUES
  ('Specific Pacific ships shift positions', '33333333-3333-3333-3333-333333333333', 'medium'),
  ('Shy Shelly says she shall sew sheets', '33333333-3333-3333-3333-333333333333', 'medium'),
  ('She stood on the shore and was surely surprised', '33333333-3333-3333-3333-333333333333', 'medium'),
  ('The sun shines on shop signs and show shoes', '33333333-3333-3333-3333-333333333333', 'medium'),
  ('Susie''s sister sewed shirts for soldiers', '33333333-3333-3333-3333-333333333333', 'medium'),
  ('Six short slow shepherds sheared six sheep', '33333333-3333-3333-3333-333333333333', 'medium'),
  ('She sells Swiss sweets which she swiftly sweeps', '33333333-3333-3333-3333-333333333333', 'medium'),
  ('Seth at Sainsbury''s sells thick socks', '33333333-3333-3333-3333-333333333333', 'medium'),
  ('Surely Shirley shall sell Sheila''s shirts shortly', '33333333-3333-3333-3333-333333333333', 'medium'),
  ('The shrewd shrew sold Sarah seven silver fish slices', '33333333-3333-3333-3333-333333333333', 'medium');

-- Hard
INSERT INTO flashcards (text, category_id, difficulty) VALUES
  ('She stood on the balcony inexplicably mimicking him hiccuping and simultaneously welcoming him in', '33333333-3333-3333-3333-333333333333', 'hard'),
  ('Sixth sick sheik sips his sixth shot of Scotch, sure', '33333333-3333-3333-3333-333333333333', 'hard'),
  ('Shasta''s statistics show sophisticated systematic synthesis', '33333333-3333-3333-3333-333333333333', 'hard'),
  ('Sheldon shuts his shop shutters before the sharp sunshine scorches the shoes', '33333333-3333-3333-3333-333333333333', 'hard'),
  ('Should such a shapeless sash such shabby stitches show', '33333333-3333-3333-3333-333333333333', 'hard'),
  ('Sheep shouldn''t sleep in shacks, sheep should sleep in sheds', '33333333-3333-3333-3333-333333333333', 'hard'),
  ('Six Swiss ships swiftly shifted, sixty-six sick chicks sat on six slim sticks', '33333333-3333-3333-3333-333333333333', 'hard'),
  ('Sophisticated statisticians simultaneously solve several simultaneous simulations', '33333333-3333-3333-3333-333333333333', 'hard'),
  ('She sells sea shells on the sea shore, the shells she sells are surely seashells for sure', '33333333-3333-3333-3333-333333333333', 'hard'),
  ('Susan shineth shoes and socks; socks and shoes shines Susan', '33333333-3333-3333-3333-333333333333', 'hard');

-- ============================================================
-- R & L Sounds
-- ============================================================

-- Easy
INSERT INTO flashcards (text, category_id, difficulty) VALUES
  ('Red leather, yellow leather', '44444444-4444-4444-4444-444444444444', 'easy'),
  ('Literally literary', '44444444-4444-4444-4444-444444444444', 'easy'),
  ('Really leery, rarely Larry', '44444444-4444-4444-4444-444444444444', 'easy'),
  ('Rolling red wagons', '44444444-4444-4444-4444-444444444444', 'easy'),
  ('A lump of red lead', '44444444-4444-4444-4444-444444444444', 'easy'),
  ('Loyal royal lawyer', '44444444-4444-4444-4444-444444444444', 'easy'),
  ('Larry''s lizard likes lettuce', '44444444-4444-4444-4444-444444444444', 'easy'),
  ('Round and round the rugged rock', '44444444-4444-4444-4444-444444444444', 'easy'),
  ('Truly rural', '44444444-4444-4444-4444-444444444444', 'easy'),
  ('Real rare rear wheels', '44444444-4444-4444-4444-444444444444', 'easy');

-- Medium
INSERT INTO flashcards (text, category_id, difficulty) VALUES
  ('A laurel-crowned clown rolled around the realm', '44444444-4444-4444-4444-444444444444', 'medium'),
  ('Red bulb, blue bulb, red bulb, blue bulb', '44444444-4444-4444-4444-444444444444', 'medium'),
  ('Literally literary literature', '44444444-4444-4444-4444-444444444444', 'medium'),
  ('Larry sent the latter a letter later', '44444444-4444-4444-4444-444444444444', 'medium'),
  ('Clearly the rolling rally relies on regular rulers', '44444444-4444-4444-4444-444444444444', 'medium'),
  ('The regal rural ruler regularly runs relays', '44444444-4444-4444-4444-444444444444', 'medium'),
  ('Rarely riled, Riley relied on really rallying lyrics', '44444444-4444-4444-4444-444444444444', 'medium'),
  ('Laura''s really large lorry rolled along the road', '44444444-4444-4444-4444-444444444444', 'medium'),
  ('Light reflected off the lake rippled relentlessly', '44444444-4444-4444-4444-444444444444', 'medium'),
  ('Roland regularly rolled barrels along the river', '44444444-4444-4444-4444-444444444444', 'medium');

-- Hard
INSERT INTO flashcards (text, category_id, difficulty) VALUES
  ('Rory the warrior and Roger the worrier were reared wrongly in a rural brewery', '44444444-4444-4444-4444-444444444444', 'hard'),
  ('The regularly irregularroller recklessly rolled all around the realm', '44444444-4444-4444-4444-444444444444', 'hard'),
  ('Literally literary literature literally littering literature literally', '44444444-4444-4444-4444-444444444444', 'hard'),
  ('A really leery Larry rolls readily along the lonely railroad', '44444444-4444-4444-4444-444444444444', 'hard'),
  ('Rural rulers regularly require relatively reliable rural lorries', '44444444-4444-4444-4444-444444444444', 'hard'),
  ('Larry literally left his leather roller on the lower library level', '44444444-4444-4444-4444-444444444444', 'hard'),
  ('Leisurely exploring, the royal ruler relentlessly roamed through lush rural regions', '44444444-4444-4444-4444-444444444444', 'hard'),
  ('The lateral literary laureate related the latest lore from the realm', '44444444-4444-4444-4444-444444444444', 'hard'),
  ('Clearly cruel Claire crawled relentlessly along the craggy rural ridge', '44444444-4444-4444-4444-444444444444', 'hard'),
  ('Parallel rural rollercoasters regularly lure reluctant learners', '44444444-4444-4444-4444-444444444444', 'hard');

-- ============================================================
-- Speed Rounds
-- ============================================================

-- Easy
INSERT INTO flashcards (text, category_id, difficulty) VALUES
  ('Unique New York', '55555555-5555-5555-5555-555555555555', 'easy'),
  ('Irish wristwatch', '55555555-5555-5555-5555-555555555555', 'easy'),
  ('Thin sticks, thick bricks', '55555555-5555-5555-5555-555555555555', 'easy'),
  ('Good blood, bad blood', '55555555-5555-5555-5555-555555555555', 'easy'),
  ('Peggy Babcock', '55555555-5555-5555-5555-555555555555', 'easy'),
  ('Knapsack straps', '55555555-5555-5555-5555-555555555555', 'easy'),
  ('Cooks cook cupcakes quickly', '55555555-5555-5555-5555-555555555555', 'easy'),
  ('Black back bat', '55555555-5555-5555-5555-555555555555', 'easy'),
  ('Flash place, flash place', '55555555-5555-5555-5555-555555555555', 'easy'),
  ('Mixed biscuits', '55555555-5555-5555-5555-555555555555', 'easy');

-- Medium
INSERT INTO flashcards (text, category_id, difficulty) VALUES
  ('Toy boat, toy boat, toy boat, toy boat', '55555555-5555-5555-5555-555555555555', 'medium'),
  ('Red lorry, yellow lorry, red lorry, yellow lorry', '55555555-5555-5555-5555-555555555555', 'medium'),
  ('Which witch wished which wicked wish', '55555555-5555-5555-5555-555555555555', 'medium'),
  ('Six thick thistle sticks', '55555555-5555-5555-5555-555555555555', 'medium'),
  ('Fred fed Ted bread and Ted fed Fred bread', '55555555-5555-5555-5555-555555555555', 'medium'),
  ('Crisp crusts crackle and crunch', '55555555-5555-5555-5555-555555555555', 'medium'),
  ('Three free throws, three free throws', '55555555-5555-5555-5555-555555555555', 'medium'),
  ('Cheap sheep soup, cheap sheep soup', '55555555-5555-5555-5555-555555555555', 'medium'),
  ('Six sticky skeletons, six sticky skeletons', '55555555-5555-5555-5555-555555555555', 'medium'),
  ('Greek grapes, Greek grapes, Greek grapes', '55555555-5555-5555-5555-555555555555', 'medium');

-- Hard
INSERT INTO flashcards (text, category_id, difficulty) VALUES
  ('Pad kid poured curd pulled cod, pad kid poured curd pulled cod', '55555555-5555-5555-5555-555555555555', 'hard'),
  ('Sixth sick sheik''s sixth sheep''s sick, sixth sick sheik''s sixth sheep''s sick', '55555555-5555-5555-5555-555555555555', 'hard'),
  ('Toy boat, toy boat, toy boat, toy boat, toy boat, toy boat', '55555555-5555-5555-5555-555555555555', 'hard'),
  ('Unique New York, unique New York, you know you need unique New York', '55555555-5555-5555-5555-555555555555', 'hard'),
  ('Irish wristwatch, Swiss wristwatch, Irish wristwatch, Swiss wristwatch', '55555555-5555-5555-5555-555555555555', 'hard'),
  ('Red lorry yellow lorry red lorry yellow lorry red lorry yellow lorry', '55555555-5555-5555-5555-555555555555', 'hard'),
  ('Six Czech cricket critics, six Czech cricket critics', '55555555-5555-5555-5555-555555555555', 'hard'),
  ('Truly rural, truly rural, truly rural, truly rural', '55555555-5555-5555-5555-555555555555', 'hard'),
  ('Good blood bad blood, good blood bad blood, good blood bad blood', '55555555-5555-5555-5555-555555555555', 'hard'),
  ('Peggy Babcock Peggy Babcock Peggy Babcock Peggy Babcock', '55555555-5555-5555-5555-555555555555', 'hard');

-- ============================================================
-- Silly Sentences
-- ============================================================

-- Easy
INSERT INTO flashcards (text, category_id, difficulty) VALUES
  ('A big bug bit the little beetle', '66666666-6666-6666-6666-666666666666', 'easy'),
  ('Babbling baby Bobby blew big bubbles', '66666666-6666-6666-6666-666666666666', 'easy'),
  ('Daddy draws doors in dusty dirt', '66666666-6666-6666-6666-666666666666', 'easy'),
  ('Giggly geese gobble grapes in the garden', '66666666-6666-6666-6666-666666666666', 'easy'),
  ('Hippos hide behind huge hairy hedges', '66666666-6666-6666-6666-666666666666', 'easy'),
  ('Nine nimble noblemen nibble nuts nightly', '66666666-6666-6666-6666-666666666666', 'easy'),
  ('Pirates prefer pickled peppers and pizza', '66666666-6666-6666-6666-666666666666', 'easy'),
  ('Quacking queens question quiet quails', '66666666-6666-6666-6666-666666666666', 'easy'),
  ('Tommy tickled twenty turtles till they tumbled', '66666666-6666-6666-6666-666666666666', 'easy'),
  ('Wiggly worms wander wildly on wet Wednesdays', '66666666-6666-6666-6666-666666666666', 'easy');

-- Medium
INSERT INTO flashcards (text, category_id, difficulty) VALUES
  ('A tutor who tooted a flute tried to tutor two tooters to toot', '66666666-6666-6666-6666-666666666666', 'medium'),
  ('The bootblack bought the black boot back from the big bloke', '66666666-6666-6666-6666-666666666666', 'medium'),
  ('Chester Cheetah chews a chunk of cheap cheddar cheese', '66666666-6666-6666-6666-666666666666', 'medium'),
  ('A flea and a fly flew up in a flue, trapped in the flu', '66666666-6666-6666-6666-666666666666', 'medium'),
  ('How many boards could the Mongols hoard if the Mongol hordes got bored', '66666666-6666-6666-6666-666666666666', 'medium'),
  ('Octopus ocular optical illusions occasionally occur', '66666666-6666-6666-6666-666666666666', 'medium'),
  ('Double bubble gum bubbles double while double bubble gum double bubbles', '66666666-6666-6666-6666-666666666666', 'medium'),
  ('Shredded Swiss cheese spreads swiftly through the sandwich', '66666666-6666-6666-6666-666666666666', 'medium'),
  ('Betty bought a bit of butter but the butter Betty bought was bitter', '66666666-6666-6666-6666-666666666666', 'medium'),
  ('Canned clam can''t clap in cramped clam cans', '66666666-6666-6666-6666-666666666666', 'medium');

-- Hard
INSERT INTO flashcards (text, category_id, difficulty) VALUES
  ('If two witches were watching two watches which witch would watch which watch', '66666666-6666-6666-6666-666666666666', 'hard'),
  ('Through three cheese trees three free fleas flew while three fat trees blew', '66666666-6666-6666-6666-666666666666', 'hard'),
  ('The great Greek grape growers grow great Greek grapes in the greatest Greek grape grove', '66666666-6666-6666-6666-666666666666', 'hard'),
  ('A pessimistic pest persists in testing pesticides on presumptuous pests', '66666666-6666-6666-6666-666666666666', 'hard'),
  ('If practice makes perfect and perfect needs practice, I''m perfectly practiced and practically perfect', '66666666-6666-6666-6666-666666666666', 'hard'),
  ('Gobbling gargoyles gobbled gobbling goblins while the gobbling goblins gobbled gobbets', '66666666-6666-6666-6666-666666666666', 'hard'),
  ('A Tudor who tooted a flute tried to tutor two Tudor tooters to toot, is it harder to toot or to tutor two tooters', '66666666-6666-6666-6666-666666666666', 'hard'),
  ('The epitome of femininity sat on the settee sipping her peppermint tea prettily', '66666666-6666-6666-6666-666666666666', 'hard'),
  ('Theophilus Thistle the successful thistle sifter, in sifting a sieve full of unsifted thistles', '66666666-6666-6666-6666-666666666666', 'hard'),
  ('If one doctor doctors another doctor, does the doctor who doctors the doctor doctor the doctor the way the doctor is doctoring doctors', '66666666-6666-6666-6666-666666666666', 'hard');
