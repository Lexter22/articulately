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

-- Ensure id column has a default (fixes tables created without it)
ALTER TABLE flashcards ALTER COLUMN id SET DEFAULT gen_random_uuid();

CREATE INDEX IF NOT EXISTS idx_flashcards_category_difficulty
  ON flashcards(category_id, difficulty);

-- Unique constraint to allow ON CONFLICT for idempotent inserts
CREATE UNIQUE INDEX IF NOT EXISTS idx_flashcards_text_category_difficulty
  ON flashcards(text, category_id, difficulty);

-- ============================================================
-- Categories
-- ============================================================

INSERT INTO categories (id, name, subtitle) VALUES
  ('11111111-1111-1111-1111-111111111111', 'Classic Twisters', 'Timeless tongue twisters everyone knows'),
  ('22222222-2222-2222-2222-222222222222', 'Alliteration Station', 'Repeating sounds to trip you up'),
  ('33333333-3333-3333-3333-333333333333', 'S & Sh Sounds', 'Master the sibilant sounds'),
  ('44444444-4444-4444-4444-444444444444', 'R & L Sounds', 'Roll and lilt your way through'),
  ('55555555-5555-5555-5555-555555555555', 'Speed Rounds', 'Short and fast — say them 3x quickly'),
  ('66666666-6666-6666-6666-666666666666', 'Silly Sentences', 'Ridiculous phrases for fun practice')
ON CONFLICT (id) DO NOTHING;

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
  ('How much wood would a woodchuck chuck', '11111111-1111-1111-1111-111111111111', 'easy'),
  ('Rubber baby buggy bumpers', '11111111-1111-1111-1111-111111111111', 'easy'),
  ('Three thin thinkers thinking thick thoughtful thoughts', '11111111-1111-1111-1111-111111111111', 'easy'),
  ('Blue bluebird blinks beside the brook', '11111111-1111-1111-1111-111111111111', 'easy'),
  ('Which wristwatches are Swiss wristwatches', '11111111-1111-1111-1111-111111111111', 'easy'),
  ('Snakes slither silently along the sand', '11111111-1111-1111-1111-111111111111', 'easy')
ON CONFLICT (text, category_id, difficulty) DO NOTHING;

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
  ('Can you can a canned can into an un-canned can', '11111111-1111-1111-1111-111111111111', 'medium'),
  ('The big black bug bled blue-black blood on the bed', '11111111-1111-1111-1111-111111111111', 'medium'),
  ('Swan swam over the sea, swim swan swim', '11111111-1111-1111-1111-111111111111', 'medium'),
  ('Near an ear, a nearer ear, a nearly eerie ear', '11111111-1111-1111-1111-111111111111', 'medium'),
  ('Fred fed Ted bread and Ted fed Fred bread in bed', '11111111-1111-1111-1111-111111111111', 'medium'),
  ('Kitty caught the kitten in the kitchen', '11111111-1111-1111-1111-111111111111', 'medium')
ON CONFLICT (text, category_id, difficulty) DO NOTHING;

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
  ('Scissors sizzle, thistles sizzle', '11111111-1111-1111-1111-111111111111', 'hard'),
  ('A synonym for cinnamon is a cinnamon synonym', '11111111-1111-1111-1111-111111111111', 'hard'),
  ('The seething sea ceaseth and thus the seething sea sufficeth us', '11111111-1111-1111-1111-111111111111', 'hard'),
  ('Seventy-seven benevolent elephants elegantly elevated eleven elderly elves', '11111111-1111-1111-1111-111111111111', 'hard'),
  ('Supposed to be pistachio, supposed to be pistachio, supposed to be pistachio', '11111111-1111-1111-1111-111111111111', 'hard'),
  ('Freshly fried fresh flesh, freshly fried fresh flesh', '11111111-1111-1111-1111-111111111111', 'hard')
ON CONFLICT (text, category_id, difficulty) DO NOTHING;

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
  ('Merry mice make marvelous muffins', '22222222-2222-2222-2222-222222222222', 'easy'),
  ('Noisy newts nibble nectarines nightly', '22222222-2222-2222-2222-222222222222', 'easy'),
  ('Playful puppies pounce past puddles', '22222222-2222-2222-2222-222222222222', 'easy'),
  ('Quiet quails quiver quickly', '22222222-2222-2222-2222-222222222222', 'easy'),
  ('Tall tigers tiptoe through tulips', '22222222-2222-2222-2222-222222222222', 'easy'),
  ('Witty walruses wobble wildly westward', '22222222-2222-2222-2222-222222222222', 'easy')
ON CONFLICT (text, category_id, difficulty) DO NOTHING;

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
  ('Grumpy gorillas grab green grapes greedily', '22222222-2222-2222-2222-222222222222', 'medium'),
  ('Hungry hawks hover high above the hilltop habitat', '22222222-2222-2222-2222-222222222222', 'medium'),
  ('Inventive insects investigate interesting inventions indoors', '22222222-2222-2222-2222-222222222222', 'medium'),
  ('Jealous jaguars jostle for juicy jungle fruit', '22222222-2222-2222-2222-222222222222', 'medium'),
  ('Kangaroos keep kicking kernels across the kitchen', '22222222-2222-2222-2222-222222222222', 'medium'),
  ('Lazy llamas lounge lazily on lush lawns', '22222222-2222-2222-2222-222222222222', 'medium')
ON CONFLICT (text, category_id, difficulty) DO NOTHING;

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
  ('Flabbergasted flamingos flamboyantly flock to floating flower festivals', '22222222-2222-2222-2222-222222222222', 'hard'),
  ('Meticulous mathematicians meticulously manipulate multifarious matrices', '22222222-2222-2222-2222-222222222222', 'hard'),
  ('Obstinate ostriches ostentatiously orchestrate outlandish operations offshore', '22222222-2222-2222-2222-222222222222', 'hard'),
  ('Rambunctious rhinoceroses recklessly rampage through remote rural regions', '22222222-2222-2222-2222-222222222222', 'hard'),
  ('Unbelievably unruly unicorns unanimously undertook unprecedented uphill unicycling', '22222222-2222-2222-2222-222222222222', 'hard'),
  ('Zany zebras zealously zigzagged through zeppelin-filled zones', '22222222-2222-2222-2222-222222222222', 'hard')
ON CONFLICT (text, category_id, difficulty) DO NOTHING;

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
  ('Shiny shoes, soggy shoes', '33333333-3333-3333-3333-333333333333', 'easy'),
  ('Sunshine city, shadow city', '33333333-3333-3333-3333-333333333333', 'easy'),
  ('Sharon shows Simon some seashells', '33333333-3333-3333-3333-333333333333', 'easy'),
  ('Sassy squirrels steal snacks', '33333333-3333-3333-3333-333333333333', 'easy'),
  ('Ships sail south on sunny Sundays', '33333333-3333-3333-3333-333333333333', 'easy'),
  ('Shush, the shy sheep is sleeping', '33333333-3333-3333-3333-333333333333', 'easy')
ON CONFLICT (text, category_id, difficulty) DO NOTHING;

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
  ('The shrewd shrew sold Sarah seven silver fish slices', '33333333-3333-3333-3333-333333333333', 'medium'),
  ('Sixty-six sick chicks sat on six slim sticks', '33333333-3333-3333-3333-333333333333', 'medium'),
  ('Sean shaved several cedar shingles on Saturday', '33333333-3333-3333-3333-333333333333', 'medium'),
  ('Shaggy sheep shouldn''t sleep in a shack', '33333333-3333-3333-3333-333333333333', 'medium'),
  ('Sly Sam slurps Sally''s soup in the shade', '33333333-3333-3333-3333-333333333333', 'medium'),
  ('Shelter the sunshine seekers from the sharp shower', '33333333-3333-3333-3333-333333333333', 'medium')
ON CONFLICT (text, category_id, difficulty) DO NOTHING;

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
  ('Susan shineth shoes and socks; socks and shoes shines Susan', '33333333-3333-3333-3333-333333333333', 'hard'),
  ('Seventeen slimy slugs in shiny silk shorts shot the sunshine sheriff', '33333333-3333-3333-3333-333333333333', 'hard'),
  ('Shall Stacey''s shabby shop stock short silk shirts or stylish shimmer shifts', '33333333-3333-3333-3333-333333333333', 'hard'),
  ('Successive suspicious shadows slithered silently past the shuttered shopfront', '33333333-3333-3333-3333-333333333333', 'hard'),
  ('Simultaneously, seven serious surgeons stitched sixteen severed sinews', '33333333-3333-3333-3333-333333333333', 'hard'),
  ('The soldier''s shoulder surely shall show some signs of serious strain soon', '33333333-3333-3333-3333-333333333333', 'hard')
ON CONFLICT (text, category_id, difficulty) DO NOTHING;

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
  ('Real rare rear wheels', '44444444-4444-4444-4444-444444444444', 'easy'),
  ('Lily''s lovely lollipop is lemon', '44444444-4444-4444-4444-444444444444', 'easy'),
  ('Rascal ran along the railroad', '44444444-4444-4444-4444-444444444444', 'easy'),
  ('Lemurs leap lightly over ledges', '44444444-4444-4444-4444-444444444444', 'easy'),
  ('River rocks roll rapidly', '44444444-4444-4444-4444-444444444444', 'easy'),
  ('Lovely little lavender lilies', '44444444-4444-4444-4444-444444444444', 'easy')
ON CONFLICT (text, category_id, difficulty) DO NOTHING;

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
  ('Roland regularly rolled barrels along the river', '44444444-4444-4444-4444-444444444444', 'medium'),
  ('Raquel''s relatives relentlessly rearrange the library', '44444444-4444-4444-4444-444444444444', 'medium'),
  ('Eleven little llamas lounged by the lily lake', '44444444-4444-4444-4444-444444444444', 'medium'),
  ('Lorraine''s lawyer laughed at Larry''s legal letter', '44444444-4444-4444-4444-444444444444', 'medium'),
  ('The early learner''s ruler rolled right off the rail', '44444444-4444-4444-4444-444444444444', 'medium'),
  ('Reliable railroad lines run parallel along the river', '44444444-4444-4444-4444-444444444444', 'medium')
ON CONFLICT (text, category_id, difficulty) DO NOTHING;

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
  ('Parallel rural rollercoasters regularly lure reluctant learners', '44444444-4444-4444-4444-444444444444', 'hard'),
  ('Relentlessly reliable railroad lawyers rarely relax along the riverfront', '44444444-4444-4444-4444-444444444444', 'hard'),
  ('The elaborate elaborate elaboration elaborately elaborated the elaborateness', '44444444-4444-4444-4444-444444444444', 'hard'),
  ('Larry''s really irregular literary repertoire rarely relies on realism', '44444444-4444-4444-4444-444444444444', 'hard'),
  ('Literally rolling through rural literary realms, the laureate laughed relentlessly', '44444444-4444-4444-4444-444444444444', 'hard'),
  ('Reluctant learners regularly enrolled in Larry''s legendary lateral literature lectures', '44444444-4444-4444-4444-444444444444', 'hard')
ON CONFLICT (text, category_id, difficulty) DO NOTHING;

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
  ('Mixed biscuits', '55555555-5555-5555-5555-555555555555', 'easy'),
  ('Crisp crust crackles', '55555555-5555-5555-5555-555555555555', 'easy'),
  ('Big whip, big whip', '55555555-5555-5555-5555-555555555555', 'easy'),
  ('Top cop, top cop', '55555555-5555-5555-5555-555555555555', 'easy'),
  ('Preshrunk shirts', '55555555-5555-5555-5555-555555555555', 'easy'),
  ('Quick kiss, quick kiss', '55555555-5555-5555-5555-555555555555', 'easy')
ON CONFLICT (text, category_id, difficulty) DO NOTHING;

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
  ('Greek grapes, Greek grapes, Greek grapes', '55555555-5555-5555-5555-555555555555', 'medium'),
  ('Specific Pacific, specific Pacific, specific Pacific', '55555555-5555-5555-5555-555555555555', 'medium'),
  ('Seventy-seven stitches, seventy-seven stitches', '55555555-5555-5555-5555-555555555555', 'medium'),
  ('Lemon liniment, lemon liniment', '55555555-5555-5555-5555-555555555555', 'medium'),
  ('Double bubble gum, double bubble gum', '55555555-5555-5555-5555-555555555555', 'medium'),
  ('Blue black bugs bleed blue black blood', '55555555-5555-5555-5555-555555555555', 'medium')
ON CONFLICT (text, category_id, difficulty) DO NOTHING;

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
  ('Peggy Babcock Peggy Babcock Peggy Babcock Peggy Babcock', '55555555-5555-5555-5555-555555555555', 'hard'),
  ('Knapsack straps, knapsack straps, knapsack straps, knapsack straps', '55555555-5555-5555-5555-555555555555', 'hard'),
  ('Mixed biscuits mixed biscuits mixed biscuits mixed biscuits', '55555555-5555-5555-5555-555555555555', 'hard'),
  ('Flash message, flash message, flash message, flash message', '55555555-5555-5555-5555-555555555555', 'hard'),
  ('Rubber baby buggy bumpers, rubber baby buggy bumpers, rubber baby buggy bumpers', '55555555-5555-5555-5555-555555555555', 'hard'),
  ('Eleven benevolent elephants, eleven benevolent elephants, eleven benevolent elephants', '55555555-5555-5555-5555-555555555555', 'hard')
ON CONFLICT (text, category_id, difficulty) DO NOTHING;

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
  ('Wiggly worms wander wildly on wet Wednesdays', '66666666-6666-6666-6666-666666666666', 'easy'),
  ('Yawning yaks yodel yesterday''s yams', '66666666-6666-6666-6666-666666666666', 'easy'),
  ('Zipping zebras zigzag past the zoo', '66666666-6666-6666-6666-666666666666', 'easy'),
  ('Clever crows collect crispy crackers', '66666666-6666-6666-6666-666666666666', 'easy'),
  ('Fuzzy ferrets found five forks', '66666666-6666-6666-6666-666666666666', 'easy'),
  ('Bouncing bunnies bake banana bread', '66666666-6666-6666-6666-666666666666', 'easy')
ON CONFLICT (text, category_id, difficulty) DO NOTHING;

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
  ('Canned clam can''t clap in cramped clam cans', '66666666-6666-6666-6666-666666666666', 'medium'),
  ('Twelve twin-screwed steel steam cruisers crossed the channel', '66666666-6666-6666-6666-666666666666', 'medium'),
  ('Supposed to be pistachio but suspiciously peach', '66666666-6666-6666-6666-666666666666', 'medium'),
  ('Moose noshing much mush makes moose''s mouth mushy', '66666666-6666-6666-6666-666666666666', 'medium'),
  ('The winkle shop owner winked while wrapping whelks', '66666666-6666-6666-6666-666666666666', 'medium'),
  ('Babbling brook brought brown bread for breakfast', '66666666-6666-6666-6666-666666666666', 'medium')
ON CONFLICT (text, category_id, difficulty) DO NOTHING;

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
  ('If one doctor doctors another doctor, does the doctor who doctors the doctor doctor the doctor the way the doctor is doctoring doctors', '66666666-6666-6666-6666-666666666666', 'hard'),
  ('Can you imagine an imaginary menagerie manager imagining managing an imaginary menagerie', '66666666-6666-6666-6666-666666666666', 'hard'),
  ('Thirty-three thousand thirsty thinkers thought they''d thoroughly thank those three thespians', '66666666-6666-6666-6666-666666666666', 'hard'),
  ('The bottom of the butter bucket is the buttered bucket bottom', '66666666-6666-6666-6666-666666666666', 'hard'),
  ('Brethren, the breadth of the breeze breathed bravely across the breach', '66666666-6666-6666-6666-666666666666', 'hard'),
  ('Five frantic frogs fled from fifty fierce fishes swimming frantically forward', '66666666-6666-6666-6666-666666666666', 'hard')
ON CONFLICT (text, category_id, difficulty) DO NOTHING;
