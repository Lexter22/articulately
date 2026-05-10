-- ─── Seed: Categories ────────────────────────────────────────────────────────
insert into public.categories (id, name, subtitle) values
  ('daily-warmups',    'Daily Warm-ups',    'Focus: General articulation'),
  ('hissing-snack',    'The Hissing Snack', 'Focus: S and Z sounds'),
  ('popping-plosives', 'Popping Plosives',  'Focus: P, B, T, D sounds'),
  ('smooth-gliders',   'Smooth Gliders',    'Focus: L and R sounds'),
  ('tongue-busters',   'Tongue-Busters',    'Focus: Complex combinations');

-- ─── Seed: Flashcards ────────────────────────────────────────────────────────

-- Daily Warm-ups — Easy
insert into public.flashcards (id, text, category_id, difficulty) values
  ('dw-e-1', 'Red lorry, yellow lorry.',      'daily-warmups', 'easy'),
  ('dw-e-2', 'Toy boat. Toy boat. Toy boat.', 'daily-warmups', 'easy'),
  ('dw-e-3', 'Unique New York.',              'daily-warmups', 'easy'),
  ('dw-e-4', 'Good blood, bad blood.',        'daily-warmups', 'easy'),
  ('dw-e-5', 'Which witch is which?',         'daily-warmups', 'easy'),
  ('dw-e-6', 'Fresh French fried fish.',      'daily-warmups', 'easy');

-- Daily Warm-ups — Medium
insert into public.flashcards (id, text, category_id, difficulty) values
  ('dw-m-1', 'How much wood would a woodchuck chuck if a woodchuck could chuck wood?', 'daily-warmups', 'medium'),
  ('dw-m-2', 'She sells seashells by the seashore.',                                   'daily-warmups', 'medium'),
  ('dw-m-3', 'Peter Piper picked a peck of pickled peppers.',                          'daily-warmups', 'medium'),
  ('dw-m-4', 'I saw Susie sitting in a shoeshine shop.',                               'daily-warmups', 'medium'),
  ('dw-m-5', 'Whether the weather is warm, whether the weather is hot, we have to put up with the weather, whether we like it or not.', 'daily-warmups', 'medium'),
  ('dw-m-6', 'A proper copper coffee pot.',                                             'daily-warmups', 'medium');

-- Daily Warm-ups — Hard
insert into public.flashcards (id, text, category_id, difficulty) values
  ('dw-h-1', 'The sixth sick sheikh''s sixth sheep''s sick.',                                        'daily-warmups', 'hard'),
  ('dw-h-2', 'Pad kid poured curd pulled cod.',                                                      'daily-warmups', 'hard'),
  ('dw-h-3', 'Brisk brave brigadiers brandished broad bright blades, blunderbusses, and bludgeons.', 'daily-warmups', 'hard'),
  ('dw-h-4', 'Can you can a can as a canner can can a can?',                                         'daily-warmups', 'hard'),
  ('dw-h-5', 'How many boards could the Mongols hoard if the Mongol hordes got bored?',              'daily-warmups', 'hard'),
  ('dw-h-6', 'Imagine an imaginary menagerie manager managing an imaginary menagerie.',              'daily-warmups', 'hard');

-- The Hissing Snack — Easy
insert into public.flashcards (id, text, category_id, difficulty) values
  ('hs-e-1', 'Six slippery snails slid slowly seaward.',      'hissing-snack', 'easy'),
  ('hs-e-2', 'Silly Sally swiftly shooed seven silly sheep.', 'hissing-snack', 'easy'),
  ('hs-e-3', 'Sam''s shop stocks short spotted socks.',       'hissing-snack', 'easy'),
  ('hs-e-4', 'Suzy sells socks in the sock shop.',            'hissing-snack', 'easy'),
  ('hs-e-5', 'Zippers zip and zippers zap.',                  'hissing-snack', 'easy'),
  ('hs-e-6', 'Sly Sam slurps Sally''s soup.',                 'hissing-snack', 'easy');

-- The Hissing Snack — Medium
insert into public.flashcards (id, text, category_id, difficulty) values
  ('hs-m-1', 'She sells seashells by the seashore. The shells she sells are surely seashells.',                            'hissing-snack', 'medium'),
  ('hs-m-2', 'I saw Susie sitting in a shoeshine shop. Where she sits she shines, and where she shines she sits.',         'hissing-snack', 'medium'),
  ('hs-m-3', 'Fuzzy Wuzzy was a bear. Fuzzy Wuzzy had no hair. Fuzzy Wuzzy wasn''t very fuzzy, was he?',                  'hissing-snack', 'medium'),
  ('hs-m-4', 'Seven slick slimy snakes slowly sliding southward.',                                                         'hissing-snack', 'medium'),
  ('hs-m-5', 'Zebras zig and zebras zag, zipping past the zigzag flag.',                                                   'hissing-snack', 'medium'),
  ('hs-m-6', 'Susie works in a shoeshine shop. Where she shines she sits, and where she sits she shines.',                 'hissing-snack', 'medium');

-- The Hissing Snack — Hard
insert into public.flashcards (id, text, category_id, difficulty) values
  ('hs-h-1', 'The seething sea ceaseth and thus the seething sea sufficeth us.',                                                       'hissing-snack', 'hard'),
  ('hs-h-2', 'Sister Suzie sewing shirts for soldiers. Such skill at sewing shirts our shy young sister Suzie shows.',                 'hissing-snack', 'hard'),
  ('hs-h-3', 'Sixty-six sick chicks sat on six slim slick slippery sticks.',                                                           'hissing-snack', 'hard'),
  ('hs-h-4', 'Selfish shellfish. Six selfish shellfish. Six selfish shellfish sat on six slim slick sticks.',                          'hissing-snack', 'hard'),
  ('hs-h-5', 'Scissors sizzle, thistles sizzle. Scissors sizzle, thistles sizzle. Scissors sizzle, thistles sizzle.',                 'hissing-snack', 'hard'),
  ('hs-h-6', 'Zsuzsa''s zesty zucchini zipped past the zealous zebra''s zigzag zone.',                                                'hissing-snack', 'hard');

-- Popping Plosives — Easy
insert into public.flashcards (id, text, category_id, difficulty) values
  ('pp-e-1', 'Pad kid poured curd pulled cod.',     'popping-plosives', 'easy'),
  ('pp-e-2', 'Big black bug bit a big black bear.', 'popping-plosives', 'easy'),
  ('pp-e-3', 'Toy boat. Toy boat. Toy boat.',       'popping-plosives', 'easy'),
  ('pp-e-4', 'Double bubble gum bubbles double.',   'popping-plosives', 'easy'),
  ('pp-e-5', 'Tip top, tip top, tip top.',          'popping-plosives', 'easy'),
  ('pp-e-6', 'Dapper Dan danced a dainty dance.',   'popping-plosives', 'easy');

-- Popping Plosives — Medium
insert into public.flashcards (id, text, category_id, difficulty) values
  ('pp-m-1', 'Peter Piper picked a peck of pickled peppers. A peck of pickled peppers Peter Piper picked.',                        'popping-plosives', 'medium'),
  ('pp-m-2', 'Betty Botter bought some butter, but the butter Betty bought was bitter.',                                           'popping-plosives', 'medium'),
  ('pp-m-3', 'A big black bug bit a big black bear, making the big black bear bleed blood.',                                       'popping-plosives', 'medium'),
  ('pp-m-4', 'Denise sees the fleece, Denise sees the fleas. At least Denise could sneeze and feed and freeze the fleas.',         'popping-plosives', 'medium'),
  ('pp-m-5', 'Picky people pick Peter Pan peanut butter. Peter Pan peanut butter is the peanut butter picky people pick.',         'popping-plosives', 'medium'),
  ('pp-m-6', 'Two tiny tigers take two taxis to town.',                                                                            'popping-plosives', 'medium');

-- Popping Plosives — Hard
insert into public.flashcards (id, text, category_id, difficulty) values
  ('pp-h-1', 'Brisk brave brigadiers brandished broad bright blades, blunderbusses, and bludgeons — balancing them badly.',                                                                                                                              'popping-plosives', 'hard'),
  ('pp-h-2', 'Betty Botter bought some butter, but the butter Betty bought was bitter, so Betty Botter bought some better butter to make the bitter butter better.',                                                                                     'popping-plosives', 'hard'),
  ('pp-h-3', 'Peter Piper picked a peck of pickled peppers. Did Peter Piper pick a peck of pickled peppers? If Peter Piper picked a peck of pickled peppers, where''s the peck of pickled peppers Peter Piper picked?',                                 'popping-plosives', 'hard'),
  ('pp-h-4', 'Daddy draws doors. Daddy draws doors. Daddy draws doors.',                                                                                                                                                                                 'popping-plosives', 'hard'),
  ('pp-h-5', 'Tiptoe through the tulips to the top of the tower, tapping the tippy-top tiles.',                                                                                                                                                          'popping-plosives', 'hard'),
  ('pp-h-6', 'Bumblebees briefly buzzed by the big blue barn before bouncing back beyond the brook.',                                                                                                                                                    'popping-plosives', 'hard');

-- Smooth Gliders — Easy
insert into public.flashcards (id, text, category_id, difficulty) values
  ('sg-e-1', 'Red lorry, yellow lorry, red lorry, yellow lorry.',       'smooth-gliders', 'easy'),
  ('sg-e-2', 'Lily ladles little lemon lollipops.',                     'smooth-gliders', 'easy'),
  ('sg-e-3', 'Round and round the rugged rock the ragged rascal ran.',  'smooth-gliders', 'easy'),
  ('sg-e-4', 'Lola loves lollipops and lemon drops.',                   'smooth-gliders', 'easy'),
  ('sg-e-5', 'Really leery, rarely Larry.',                             'smooth-gliders', 'easy'),
  ('sg-e-6', 'Larry likes lively lizards lounging lazily.',             'smooth-gliders', 'easy');

-- Smooth Gliders — Medium
insert into public.flashcards (id, text, category_id, difficulty) values
  ('sg-m-1', 'How many cans can a canner can if a canner can can cans? A canner can can as many cans as a canner can if a canner can can cans.', 'smooth-gliders', 'medium'),
  ('sg-m-2', 'Lesser leather never weathered wetter weather better.',                                                                           'smooth-gliders', 'medium'),
  ('sg-m-3', 'Rolling red wagons race rapidly round the rural road.',                                                                           'smooth-gliders', 'medium'),
  ('sg-m-4', 'Lovely lemon linens lie lightly on the long low ledge.',                                                                          'smooth-gliders', 'medium'),
  ('sg-m-5', 'Rural ruler, rural ruler, rural ruler.',                                                                                          'smooth-gliders', 'medium'),
  ('sg-m-6', 'Rory the warrior and Roger the worrier were reared wrongly in a rural brewery.',                                                  'smooth-gliders', 'medium');

-- Smooth Gliders — Hard
insert into public.flashcards (id, text, category_id, difficulty) values
  ('sg-h-1', 'The thirty-three thieves thought that they thrilled the throne throughout Thursday.',                              'smooth-gliders', 'hard'),
  ('sg-h-2', 'Literally literary. Literally literary. Literally literary.',                                                     'smooth-gliders', 'hard'),
  ('sg-h-3', 'Red leather, yellow leather, red leather, yellow leather, red leather, yellow leather.',                          'smooth-gliders', 'hard'),
  ('sg-h-4', 'Lilly ladles little lemon lollipops, licking lollipops lightly, leaving little lemon lollipop licks.',            'smooth-gliders', 'hard'),
  ('sg-h-5', 'Around the rugged rocks the ragged rascal ran, racing rapidly round the rough rocky ridge.',                      'smooth-gliders', 'hard'),
  ('sg-h-6', 'Lorry lorry lorry, rally rally rally, really really really, rarely rarely rarely.',                               'smooth-gliders', 'hard');

-- Tongue-Busters — Easy
insert into public.flashcards (id, text, category_id, difficulty) values
  ('tb-e-1', 'Unique New York, unique New York, you know you need unique New York.', 'tongue-busters', 'easy'),
  ('tb-e-2', 'Which witch switched the Swiss wristwatches?',                         'tongue-busters', 'easy'),
  ('tb-e-3', 'Eleven benevolent elephants.',                                          'tongue-busters', 'easy'),
  ('tb-e-4', 'Freshly fried fresh flesh.',                                            'tongue-busters', 'easy'),
  ('tb-e-5', 'Knapsack straps. Knapsack straps. Knapsack straps.',                   'tongue-busters', 'easy'),
  ('tb-e-6', 'Mixed biscuits, mixed biscuits.',                                       'tongue-busters', 'easy');

-- Tongue-Busters — Medium
insert into public.flashcards (id, text, category_id, difficulty) values
  ('tb-m-1', 'If two witches were watching two watches, which witch would watch which watch?',          'tongue-busters', 'medium'),
  ('tb-m-2', 'I thought I thought of thinking of thanking you.',                                        'tongue-busters', 'medium'),
  ('tb-m-3', 'The cheeky chipmunk chewed through the chunky chocolate chip cookies.',                   'tongue-busters', 'medium'),
  ('tb-m-4', 'Freshly fried flying fish, freshly fried flying fish, freshly fried flying fish.',        'tongue-busters', 'medium'),
  ('tb-m-5', 'A skunk sat on a stump and thunk the stump stunk, but the stump thunk the skunk stunk.', 'tongue-busters', 'medium'),
  ('tb-m-6', 'Crisscross applesauce. Crisscross applesauce. Crisscross applesauce.',                   'tongue-busters', 'medium');

-- Tongue-Busters — Hard
insert into public.flashcards (id, text, category_id, difficulty) values
  ('tb-h-1', 'The sixth sick sheikh''s sixth sheep''s sick. The sixth sick sheikh''s sixth sheep''s sick.',                                                                                                                    'tongue-busters', 'hard'),
  ('tb-h-2', 'Imagine an imaginary menagerie manager managing an imaginary menagerie. Now imagine the imaginary menagerie manager managing two imaginary menageries.',                                                          'tongue-busters', 'hard'),
  ('tb-h-3', 'Theophilus Thistle, the successful thistle-sifter, in sifting a sieve of unsifted thistles, thrust three thousand thistles through the thick of his thumb.',                                                     'tongue-busters', 'hard'),
  ('tb-h-4', 'How much ground would a groundhog hog if a groundhog could hog ground? A groundhog would hog all the ground he could hog if a groundhog could hog ground.',                                                     'tongue-busters', 'hard'),
  ('tb-h-5', 'Willy''s real rear wheel. Willy''s real rear wheel. Willy''s real rear wheel.',                                                                                                                                 'tongue-busters', 'hard'),
  ('tb-h-6', 'Through three cheese trees three free fleas flew. While these fleas flew, freezy breeze blew. Freezy breeze made these three trees freeze.',                                                                     'tongue-busters', 'hard');
