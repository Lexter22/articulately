// Bundled content data for Articulately
// 5 categories × 3 difficulties × 5+ cards = 75+ flashcards total

const List<Map<String, dynamic>> kCategories = [
  {
    'id': 'daily-warmups',
    'name': 'Daily Warm-ups',
    'subtitle': 'Focus: General articulation',
  },
  {
    'id': 'hissing-snack',
    'name': 'The Hissing Snack',
    'subtitle': 'Focus: S and Z sounds',
  },
  {
    'id': 'popping-plosives',
    'name': 'Popping Plosives',
    'subtitle': 'Focus: P, B, T, D sounds',
  },
  {
    'id': 'smooth-gliders',
    'name': 'Smooth Gliders',
    'subtitle': 'Focus: L and R sounds',
  },
  {
    'id': 'tongue-busters',
    'name': 'Tongue-Busters',
    'subtitle': 'Focus: Complex combinations',
  },
];

const List<Map<String, dynamic>> kFlashcards = [
  // ─── Daily Warm-ups — Easy ───────────────────────────────────────────────
  {
    'id': 'dw-e-1',
    'text': 'Red lorry, yellow lorry.',
    'categoryId': 'daily-warmups',
    'difficulty': 'easy',
  },
  {
    'id': 'dw-e-2',
    'text': 'Toy boat. Toy boat. Toy boat.',
    'categoryId': 'daily-warmups',
    'difficulty': 'easy',
  },
  {
    'id': 'dw-e-3',
    'text': 'Unique New York.',
    'categoryId': 'daily-warmups',
    'difficulty': 'easy',
  },
  {
    'id': 'dw-e-4',
    'text': 'Good blood, bad blood.',
    'categoryId': 'daily-warmups',
    'difficulty': 'easy',
  },
  {
    'id': 'dw-e-5',
    'text': 'Which witch is which?',
    'categoryId': 'daily-warmups',
    'difficulty': 'easy',
  },
  {
    'id': 'dw-e-6',
    'text': 'Fresh French fried fish.',
    'categoryId': 'daily-warmups',
    'difficulty': 'easy',
  },

  // ─── Daily Warm-ups — Medium ─────────────────────────────────────────────
  {
    'id': 'dw-m-1',
    'text': 'How much wood would a woodchuck chuck if a woodchuck could chuck wood?',
    'categoryId': 'daily-warmups',
    'difficulty': 'medium',
  },
  {
    'id': 'dw-m-2',
    'text': 'She sells seashells by the seashore.',
    'categoryId': 'daily-warmups',
    'difficulty': 'medium',
  },
  {
    'id': 'dw-m-3',
    'text': 'Peter Piper picked a peck of pickled peppers.',
    'categoryId': 'daily-warmups',
    'difficulty': 'medium',
  },
  {
    'id': 'dw-m-4',
    'text': 'I saw Susie sitting in a shoeshine shop.',
    'categoryId': 'daily-warmups',
    'difficulty': 'medium',
  },
  {
    'id': 'dw-m-5',
    'text': 'Whether the weather is warm, whether the weather is hot, we have to put up with the weather, whether we like it or not.',
    'categoryId': 'daily-warmups',
    'difficulty': 'medium',
  },
  {
    'id': 'dw-m-6',
    'text': 'A proper copper coffee pot.',
    'categoryId': 'daily-warmups',
    'difficulty': 'medium',
  },

  // ─── Daily Warm-ups — Hard ───────────────────────────────────────────────
  {
    'id': 'dw-h-1',
    'text': 'The sixth sick sheikh\'s sixth sheep\'s sick.',
    'categoryId': 'daily-warmups',
    'difficulty': 'hard',
  },
  {
    'id': 'dw-h-2',
    'text': 'Pad kid poured curd pulled cod.',
    'categoryId': 'daily-warmups',
    'difficulty': 'hard',
  },
  {
    'id': 'dw-h-3',
    'text': 'Brisk brave brigadiers brandished broad bright blades, blunderbusses, and bludgeons.',
    'categoryId': 'daily-warmups',
    'difficulty': 'hard',
  },
  {
    'id': 'dw-h-4',
    'text': 'Can you can a can as a canner can can a can?',
    'categoryId': 'daily-warmups',
    'difficulty': 'hard',
  },
  {
    'id': 'dw-h-5',
    'text': 'How many boards could the Mongols hoard if the Mongol hordes got bored?',
    'categoryId': 'daily-warmups',
    'difficulty': 'hard',
  },
  {
    'id': 'dw-h-6',
    'text': 'Imagine an imaginary menagerie manager managing an imaginary menagerie.',
    'categoryId': 'daily-warmups',
    'difficulty': 'hard',
  },

  // ─── The Hissing Snack — Easy ────────────────────────────────────────────
  {
    'id': 'hs-e-1',
    'text': 'Six slippery snails slid slowly seaward.',
    'categoryId': 'hissing-snack',
    'difficulty': 'easy',
  },
  {
    'id': 'hs-e-2',
    'text': 'Silly Sally swiftly shooed seven silly sheep.',
    'categoryId': 'hissing-snack',
    'difficulty': 'easy',
  },
  {
    'id': 'hs-e-3',
    'text': 'Sam\'s shop stocks short spotted socks.',
    'categoryId': 'hissing-snack',
    'difficulty': 'easy',
  },
  {
    'id': 'hs-e-4',
    'text': 'Suzy sells socks in the sock shop.',
    'categoryId': 'hissing-snack',
    'difficulty': 'easy',
  },
  {
    'id': 'hs-e-5',
    'text': 'Zippers zip and zippers zap.',
    'categoryId': 'hissing-snack',
    'difficulty': 'easy',
  },
  {
    'id': 'hs-e-6',
    'text': 'Sly Sam slurps Sally\'s soup.',
    'categoryId': 'hissing-snack',
    'difficulty': 'easy',
  },

  // ─── The Hissing Snack — Medium ──────────────────────────────────────────
  {
    'id': 'hs-m-1',
    'text': 'She sells seashells by the seashore. The shells she sells are surely seashells.',
    'categoryId': 'hissing-snack',
    'difficulty': 'medium',
  },
  {
    'id': 'hs-m-2',
    'text': 'I saw Susie sitting in a shoeshine shop. Where she sits she shines, and where she shines she sits.',
    'categoryId': 'hissing-snack',
    'difficulty': 'medium',
  },
  {
    'id': 'hs-m-3',
    'text': 'Fuzzy Wuzzy was a bear. Fuzzy Wuzzy had no hair. Fuzzy Wuzzy wasn\'t very fuzzy, was he?',
    'categoryId': 'hissing-snack',
    'difficulty': 'medium',
  },
  {
    'id': 'hs-m-4',
    'text': 'Seven slick slimy snakes slowly sliding southward.',
    'categoryId': 'hissing-snack',
    'difficulty': 'medium',
  },
  {
    'id': 'hs-m-5',
    'text': 'Zebras zig and zebras zag, zipping past the zigzag flag.',
    'categoryId': 'hissing-snack',
    'difficulty': 'medium',
  },
  {
    'id': 'hs-m-6',
    'text': 'Susie works in a shoeshine shop. Where she shines she sits, and where she sits she shines.',
    'categoryId': 'hissing-snack',
    'difficulty': 'medium',
  },

  // ─── The Hissing Snack — Hard ────────────────────────────────────────────
  {
    'id': 'hs-h-1',
    'text': 'The seething sea ceaseth and thus the seething sea sufficeth us.',
    'categoryId': 'hissing-snack',
    'difficulty': 'hard',
  },
  {
    'id': 'hs-h-2',
    'text': 'Sister Suzie sewing shirts for soldiers. Such skill at sewing shirts our shy young sister Suzie shows.',
    'categoryId': 'hissing-snack',
    'difficulty': 'hard',
  },
  {
    'id': 'hs-h-3',
    'text': 'Sixty-six sick chicks sat on six slim slick slippery sticks.',
    'categoryId': 'hissing-snack',
    'difficulty': 'hard',
  },
  {
    'id': 'hs-h-4',
    'text': 'Selfish shellfish. Six selfish shellfish. Six selfish shellfish sat on six slim slick sticks.',
    'categoryId': 'hissing-snack',
    'difficulty': 'hard',
  },
  {
    'id': 'hs-h-5',
    'text': 'Scissors sizzle, thistles sizzle. Scissors sizzle, thistles sizzle. Scissors sizzle, thistles sizzle.',
    'categoryId': 'hissing-snack',
    'difficulty': 'hard',
  },
  {
    'id': 'hs-h-6',
    'text': 'Zsuzsa\'s zesty zucchini zipped past the zealous zebra\'s zigzag zone.',
    'categoryId': 'hissing-snack',
    'difficulty': 'hard',
  },

  // ─── Popping Plosives — Easy ─────────────────────────────────────────────
  {
    'id': 'pp-e-1',
    'text': 'Pad kid poured curd pulled cod.',
    'categoryId': 'popping-plosives',
    'difficulty': 'easy',
  },
  {
    'id': 'pp-e-2',
    'text': 'Big black bug bit a big black bear.',
    'categoryId': 'popping-plosives',
    'difficulty': 'easy',
  },
  {
    'id': 'pp-e-3',
    'text': 'Toy boat. Toy boat. Toy boat.',
    'categoryId': 'popping-plosives',
    'difficulty': 'easy',
  },
  {
    'id': 'pp-e-4',
    'text': 'Double bubble gum bubbles double.',
    'categoryId': 'popping-plosives',
    'difficulty': 'easy',
  },
  {
    'id': 'pp-e-5',
    'text': 'Tip top, tip top, tip top.',
    'categoryId': 'popping-plosives',
    'difficulty': 'easy',
  },
  {
    'id': 'pp-e-6',
    'text': 'Dapper Dan danced a dainty dance.',
    'categoryId': 'popping-plosives',
    'difficulty': 'easy',
  },

  // ─── Popping Plosives — Medium ───────────────────────────────────────────
  {
    'id': 'pp-m-1',
    'text': 'Peter Piper picked a peck of pickled peppers. A peck of pickled peppers Peter Piper picked.',
    'categoryId': 'popping-plosives',
    'difficulty': 'medium',
  },
  {
    'id': 'pp-m-2',
    'text': 'Betty Botter bought some butter, but the butter Betty bought was bitter.',
    'categoryId': 'popping-plosives',
    'difficulty': 'medium',
  },
  {
    'id': 'pp-m-3',
    'text': 'A big black bug bit a big black bear, making the big black bear bleed blood.',
    'categoryId': 'popping-plosives',
    'difficulty': 'medium',
  },
  {
    'id': 'pp-m-4',
    'text': 'Denise sees the fleece, Denise sees the fleas. At least Denise could sneeze and feed and freeze the fleas.',
    'categoryId': 'popping-plosives',
    'difficulty': 'medium',
  },
  {
    'id': 'pp-m-5',
    'text': 'Picky people pick Peter Pan peanut butter. Peter Pan peanut butter is the peanut butter picky people pick.',
    'categoryId': 'popping-plosives',
    'difficulty': 'medium',
  },
  {
    'id': 'pp-m-6',
    'text': 'Two tiny tigers take two taxis to town.',
    'categoryId': 'popping-plosives',
    'difficulty': 'medium',
  },

  // ─── Popping Plosives — Hard ─────────────────────────────────────────────
  {
    'id': 'pp-h-1',
    'text': 'Brisk brave brigadiers brandished broad bright blades, blunderbusses, and bludgeons — balancing them badly.',
    'categoryId': 'popping-plosives',
    'difficulty': 'hard',
  },
  {
    'id': 'pp-h-2',
    'text': 'Betty Botter bought some butter, but the butter Betty bought was bitter, so Betty Botter bought some better butter to make the bitter butter better.',
    'categoryId': 'popping-plosives',
    'difficulty': 'hard',
  },
  {
    'id': 'pp-h-3',
    'text': 'Peter Piper picked a peck of pickled peppers. Did Peter Piper pick a peck of pickled peppers? If Peter Piper picked a peck of pickled peppers, where\'s the peck of pickled peppers Peter Piper picked?',
    'categoryId': 'popping-plosives',
    'difficulty': 'hard',
  },
  {
    'id': 'pp-h-4',
    'text': 'Daddy draws doors. Daddy draws doors. Daddy draws doors.',
    'categoryId': 'popping-plosives',
    'difficulty': 'hard',
  },
  {
    'id': 'pp-h-5',
    'text': 'Tiptoe through the tulips to the top of the tower, tapping the tippy-top tiles.',
    'categoryId': 'popping-plosives',
    'difficulty': 'hard',
  },
  {
    'id': 'pp-h-6',
    'text': 'Bumblebees briefly buzzed by the big blue barn before bouncing back beyond the brook.',
    'categoryId': 'popping-plosives',
    'difficulty': 'hard',
  },

  // ─── Smooth Gliders — Easy ───────────────────────────────────────────────
  {
    'id': 'sg-e-1',
    'text': 'Red lorry, yellow lorry, red lorry, yellow lorry.',
    'categoryId': 'smooth-gliders',
    'difficulty': 'easy',
  },
  {
    'id': 'sg-e-2',
    'text': 'Lily ladles little lemon lollipops.',
    'categoryId': 'smooth-gliders',
    'difficulty': 'easy',
  },
  {
    'id': 'sg-e-3',
    'text': 'Round and round the rugged rock the ragged rascal ran.',
    'categoryId': 'smooth-gliders',
    'difficulty': 'easy',
  },
  {
    'id': 'sg-e-4',
    'text': 'Lola loves lollipops and lemon drops.',
    'categoryId': 'smooth-gliders',
    'difficulty': 'easy',
  },
  {
    'id': 'sg-e-5',
    'text': 'Really leery, rarely Larry.',
    'categoryId': 'smooth-gliders',
    'difficulty': 'easy',
  },
  {
    'id': 'sg-e-6',
    'text': 'Larry likes lively lizards lounging lazily.',
    'categoryId': 'smooth-gliders',
    'difficulty': 'easy',
  },

  // ─── Smooth Gliders — Medium ─────────────────────────────────────────────
  {
    'id': 'sg-m-1',
    'text': 'How many cans can a canner can if a canner can can cans? A canner can can as many cans as a canner can if a canner can can cans.',
    'categoryId': 'smooth-gliders',
    'difficulty': 'medium',
  },
  {
    'id': 'sg-m-2',
    'text': 'Lesser leather never weathered wetter weather better.',
    'categoryId': 'smooth-gliders',
    'difficulty': 'medium',
  },
  {
    'id': 'sg-m-3',
    'text': 'Rolling red wagons race rapidly round the rural road.',
    'categoryId': 'smooth-gliders',
    'difficulty': 'medium',
  },
  {
    'id': 'sg-m-4',
    'text': 'Lovely lemon linens lie lightly on the long low ledge.',
    'categoryId': 'smooth-gliders',
    'difficulty': 'medium',
  },
  {
    'id': 'sg-m-5',
    'text': 'Rural ruler, rural ruler, rural ruler.',
    'categoryId': 'smooth-gliders',
    'difficulty': 'medium',
  },
  {
    'id': 'sg-m-6',
    'text': 'Rory the warrior and Roger the worrier were reared wrongly in a rural brewery.',
    'categoryId': 'smooth-gliders',
    'difficulty': 'medium',
  },

  // ─── Smooth Gliders — Hard ───────────────────────────────────────────────
  {
    'id': 'sg-h-1',
    'text': 'The thirty-three thieves thought that they thrilled the throne throughout Thursday.',
    'categoryId': 'smooth-gliders',
    'difficulty': 'hard',
  },
  {
    'id': 'sg-h-2',
    'text': 'Literally literary. Literally literary. Literally literary.',
    'categoryId': 'smooth-gliders',
    'difficulty': 'hard',
  },
  {
    'id': 'sg-h-3',
    'text': 'Red leather, yellow leather, red leather, yellow leather, red leather, yellow leather.',
    'categoryId': 'smooth-gliders',
    'difficulty': 'hard',
  },
  {
    'id': 'sg-h-4',
    'text': 'Lilly ladles little lemon lollipops, licking lollipops lightly, leaving little lemon lollipop licks.',
    'categoryId': 'smooth-gliders',
    'difficulty': 'hard',
  },
  {
    'id': 'sg-h-5',
    'text': 'Around the rugged rocks the ragged rascal ran, racing rapidly round the rough rocky ridge.',
    'categoryId': 'smooth-gliders',
    'difficulty': 'hard',
  },
  {
    'id': 'sg-h-6',
    'text': 'Lorry lorry lorry, rally rally rally, really really really, rarely rarely rarely.',
    'categoryId': 'smooth-gliders',
    'difficulty': 'hard',
  },

  // ─── Tongue-Busters — Easy ───────────────────────────────────────────────
  {
    'id': 'tb-e-1',
    'text': 'Unique New York, unique New York, you know you need unique New York.',
    'categoryId': 'tongue-busters',
    'difficulty': 'easy',
  },
  {
    'id': 'tb-e-2',
    'text': 'Which witch switched the Swiss wristwatches?',
    'categoryId': 'tongue-busters',
    'difficulty': 'easy',
  },
  {
    'id': 'tb-e-3',
    'text': 'Eleven benevolent elephants.',
    'categoryId': 'tongue-busters',
    'difficulty': 'easy',
  },
  {
    'id': 'tb-e-4',
    'text': 'Freshly fried fresh flesh.',
    'categoryId': 'tongue-busters',
    'difficulty': 'easy',
  },
  {
    'id': 'tb-e-5',
    'text': 'Knapsack straps. Knapsack straps. Knapsack straps.',
    'categoryId': 'tongue-busters',
    'difficulty': 'easy',
  },
  {
    'id': 'tb-e-6',
    'text': 'Mixed biscuits, mixed biscuits.',
    'categoryId': 'tongue-busters',
    'difficulty': 'easy',
  },

  // ─── Tongue-Busters — Medium ─────────────────────────────────────────────
  {
    'id': 'tb-m-1',
    'text': 'If two witches were watching two watches, which witch would watch which watch?',
    'categoryId': 'tongue-busters',
    'difficulty': 'medium',
  },
  {
    'id': 'tb-m-2',
    'text': 'I thought I thought of thinking of thanking you.',
    'categoryId': 'tongue-busters',
    'difficulty': 'medium',
  },
  {
    'id': 'tb-m-3',
    'text': 'The cheeky chipmunk chewed through the chunky chocolate chip cookies.',
    'categoryId': 'tongue-busters',
    'difficulty': 'medium',
  },
  {
    'id': 'tb-m-4',
    'text': 'Freshly fried flying fish, freshly fried flying fish, freshly fried flying fish.',
    'categoryId': 'tongue-busters',
    'difficulty': 'medium',
  },
  {
    'id': 'tb-m-5',
    'text': 'A skunk sat on a stump and thunk the stump stunk, but the stump thunk the skunk stunk.',
    'categoryId': 'tongue-busters',
    'difficulty': 'medium',
  },
  {
    'id': 'tb-m-6',
    'text': 'Crisscross applesauce. Crisscross applesauce. Crisscross applesauce.',
    'categoryId': 'tongue-busters',
    'difficulty': 'medium',
  },

  // ─── Tongue-Busters — Hard ───────────────────────────────────────────────
  {
    'id': 'tb-h-1',
    'text': 'The sixth sick sheikh\'s sixth sheep\'s sick. The sixth sick sheikh\'s sixth sheep\'s sick.',
    'categoryId': 'tongue-busters',
    'difficulty': 'hard',
  },
  {
    'id': 'tb-h-2',
    'text': 'Imagine an imaginary menagerie manager managing an imaginary menagerie. Now imagine the imaginary menagerie manager managing two imaginary menageries.',
    'categoryId': 'tongue-busters',
    'difficulty': 'hard',
  },
  {
    'id': 'tb-h-3',
    'text': 'Theophilus Thistle, the successful thistle-sifter, in sifting a sieve of unsifted thistles, thrust three thousand thistles through the thick of his thumb.',
    'categoryId': 'tongue-busters',
    'difficulty': 'hard',
  },
  {
    'id': 'tb-h-4',
    'text': 'How much ground would a groundhog hog if a groundhog could hog ground? A groundhog would hog all the ground he could hog if a groundhog could hog ground.',
    'categoryId': 'tongue-busters',
    'difficulty': 'hard',
  },
  {
    'id': 'tb-h-5',
    'text': 'Willy\'s real rear wheel. Willy\'s real rear wheel. Willy\'s real rear wheel.',
    'categoryId': 'tongue-busters',
    'difficulty': 'hard',
  },
  {
    'id': 'tb-h-6',
    'text': 'Through three cheese trees three free fleas flew. While these fleas flew, freezy breeze blew. Freezy breeze made these three trees freeze.',
    'categoryId': 'tongue-busters',
    'difficulty': 'hard',
  },
];
