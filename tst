GTree Version: ki-aura 2.1.4
. [Files: 28] [Size: 29.6M]
: gtree.o (6.1K)
: gtree.h (3.3K)
: publish_cheat_sheet.txt (741B)
: option_parsing.o (3.4K)
: option_parsing.h (495B)
: tst (0B)
: print.h (705B)
: print.o (6.0K)
: before (2.1K)
: memsafe.c (1.2K)
: gtree (51.8K)
: .gitignore (149B)
: visit_hash.h (6.1K)
: visit_hash.o (5.8K)
: README.md (8B)
: gtree.c (16.5K)
: autogit (140B)
: bigoutput.txt (29.5M)
: makefile (1.2K)
: tst.txt (2.1K)
: option_parsing.c (3.2K)
: memsafe.o (1.7K)
: memsafe.h (156B)
: LICENSE (1.0K)
: print.c (7.1K)
: .DS_Store (6.0K)
: khashl.h (20.4K)
: visit_hash.c (3.0K)
├── t [Files: 1] [Size: 8B]
│   : x (8B)
│   ├── @lnc -> ../a/b/c
│   ├── lnc [Files: 2] [Size: 0B]
│   │   : @fail_dlink -> d/tmp [dangling]
│   │   : @fail_flink -> d/tmp/file [dangling]
│   │   ├── d
│   │   │   ├── @lng -> ../../../../t/e/f/g
│   │   │   ├── lng
│   │   │   │   └── h [Files: 1] [Size: 0B]
│   │   │   │       : kk (0B)
│   │   │   └── j
│   │   │       └── @lng2 -> ../../../../../t/e/f/g [recursive]
│   │   └── p
│   │       └── q
│   │           └── r [Files: 1] [Size: 35B]
│   │               : xx (35B)
│   └── e [Files: 1] [Size: 8B]
│       : @lnx (-> ../x)
│       └── f [Files: 4] [Size: 72B]
│           : tmp (18B)
│           : @link1 (-> tmp)
│           : @link2 (-> link1)
│           : @link3 (-> ../f/tmp)
│           └── g [recursive]
├── a [Files: 1] [Size: 10B]
│   : gg (10B)
│   └── b [Files: 3] [Size: 51B]
│       : y (8B)
│       : x (11B)
│       : z (32B)
│       ├── @outside_link -> /Users/matt/.local
│       ├── outside_link
│       │   ├── bin
│       │   ├── pipx
│       │   │   ├── py [Files: 1] [Size: 186B]
│       │   │   │   : CACHEDIR.TAG (186B)
│       │   │   ├── venvs
│       │   │   ├── logs [Files: 1] [Size: 841B]
│       │   │   │   : cmd_2025-09-24_16.36.27.log (841B)
│       │   │   └── .cache [Files: 1] [Size: 186B]
│       │   │       : CACHEDIR.TAG (186B)
│       │   ├── state
│       │   │   └── gh [Files: 1] [Size: 188B]
│       │   │       : state.yml (188B)
│       │   ├── nanobackups [Files: 14] [Size: 8.6K]
│       │   │   : !Users!matt!Projects!gtree!publish_cheat_sheet.txt~ (717B)
│       │   │   : !opt!homebrew!Library!Taps!ki-aura!homebrew-gex!Formula!gex.rb~.1 (435B)
│       │   │   : !opt!homebrew!Library!Taps!ki-aura!homebrew-gtree!Formula!gtree.rb~.3 (418B)
│       │   │   : !Users!matt!Projects!gtree!publish_cheat_sheet.txt~.3 (741B)
│       │   │   : !opt!homebrew!Library!Taps!ki-aura!homebrew-gtree!Formula!gtree.rb~.2 (418B)
│       │   │   : !Users!matt!Projects!gtree!publish_cheat_sheet.txt~.2 (741B)
│       │   │   : !Users!matt!Projects!gex!publish_cheat_sheet.txt~.1 (717B)
│       │   │   : !Users!matt!bin!prom~ (1.7K)
│       │   │   : !opt!homebrew!Library!Taps!ki-aura!homebrew-gtree!Formula!gtree.rb~ (435B)
│       │   │   : !Users!matt!Library!LaunchAgents!com.matt.mgupdate.plist~ (783B)
│       │   │   : !Users!matt!.myzshfuncs~ (3B)
│       │   │   : !Users!matt!Projects!gtree!publish_cheat_sheet.txt~.1 (741B)
│       │   │   : !Users!matt!bin!ptbl~ (565B)
│       │   │   : !opt!homebrew!Library!Taps!ki-aura!homebrew-gtree!Formula!gtree.rb~.1 (418B)
│       │   └── share [Files: 1] [Size: 807B]
│       │       : recently-used.xbel (807B)
│       │       ├── man
│       │       ├── ptbl
│       │       └── glances [Files: 1] [Size: 9.1K]
│       │           : glances.log (9.1K)
│       └── c [recursive]
├── gbak [Files: 18] [Size: 132.0K]
│   : gtree.o (5.8K)
│   : gtree.h (3.3K)
│   : option_parsing.o (3.2K)
│   : option_parsing.h (495B)
│   : print.h (705B)
│   : print.o (6.0K)
│   : memsafe.c (1.2K)
│   : gtree (51.8K)
│   : visit_hash.h (449B)
│   : visit_hash.o (5.7K)
│   : gtree.c (16.5K)
│   : makefile (1.2K)
│   : option_parsing.c (3.2K)
│   : memsafe.o (1.7K)
│   : memsafe.h (156B)
│   : print.c (7.1K)
│   : khashl.h (20.3K)
│   : visit_hash.c (3.1K)
└── .git [Files: 5] [Size: 4.8K]
    : COMMIT_EDITMSG (36B)
    : index (4.4K)
    : description (73B)
    : HEAD (21B)
    : config (302B)
    ├── objects
    │   ├── 9b [Files: 1] [Size: 751B]
    │   │   : 5407b9e47fd6742629237adc7b399b5f8d8c06 (751B)
    │   ├── 04 [Files: 1] [Size: 134B]
    │   │   : cda2196d2a9dbec21d435b453e0bb5d856bbba (134B)
    │   ├── 32 [Files: 1] [Size: 131B]
    │   │   : 3f3dace42ec8adc807577773bd973175cc536c (131B)
    │   ├── 35 [Files: 1] [Size: 1.4K]
    │   │   : 6896ea9bafb2460ddef5642f16d3cdbe72c052 (1.4K)
    │   ├── 67 [Files: 2] [Size: 2.8K]
    │   │   : b7a184a31718eea1f402cfeb22b0740979e7cf (103B)
    │   │   : 35ca160339c936d7aee36d05827f3951d2bd4d (2.7K)
    │   ├── 0e [Files: 3] [Size: 4.0K]
    │   │   : 076f2eaa73f7574d122204d80b8436fe450c25 (2.7K)
    │   │   : bc930abe0a168ca480269375d80755bdf4efe9 (1.4K)
    │   │   : f9d666055cd152a30a3f46ac3dd86547d615e9 (27B)
    │   ├── 05 [Files: 1] [Size: 135B]
    │   │   : eea354648815eacc56c4bc030152fadd001b35 (135B)
    │   ├── a4 [Files: 1] [Size: 290B]
    │   │   : ac73cbb010fbadbe9269e9e8b419481f7c90f7 (290B)
    │   ├── d0 [Files: 1] [Size: 20B]
    │   │   : 425fd0449299cefd63db3f3c01c9da13c17a81 (20B)
    │   ├── b3 [Files: 2] [Size: 5.8K]
    │   │   : 0e5eadde6c5c54c19cb6fcdb19206d060abc62 (167B)
    │   │   : 72e0ca08ba35ff7ff9ce6620d2841b52299687 (5.7K)
    │   ├── df [Files: 2] [Size: 685B]
    │   │   : 38c2daf96993d3830aec2683bc3161a29d485a (662B)
    │   │   : fecbaf6b4267e3342585b7b67bab53c514d8b8 (23B)
    │   ├── a2 [Files: 1] [Size: 159B]
    │   │   : 706cda848b8745a3633abd53de4780e831f13e (159B)
    │   ├── d1 [Files: 1] [Size: 26B]
    │   │   : 78b698b482632ab747887a4910eeb5ba88c0ad (26B)
    │   ├── d6 [Files: 1] [Size: 135B]
    │   │   : a1f3f88153db05822befc6d98dc6615877b0cd (135B)
    │   ├── d8 [Files: 1] [Size: 53B]
    │   │   : f82be6b19a7d08fde117eae8531912f082973d (53B)
    │   ├── e5 [Files: 1] [Size: 46B]
    │   │   : 1a1774bd2937112a3d09fa03ce5025c3627489 (46B)
    │   ├── eb [Files: 1] [Size: 34B]
    │   │   : 51e817b81b3ec9db8eacf8949f1188e4364e5b (34B)
    │   ├── c0 [Files: 1] [Size: 20B]
    │   │   : 9f483997cc0bd66ccbf93aa7f349b1a0419bb8 (20B)
    │   ├── fc [Files: 1] [Size: 134B]
    │   │   : 61968053d8c11ddcdd8a2b90329a6f4168fb65 (134B)
    │   ├── cf [Files: 1] [Size: 355B]
    │   │   : 90bf9f3867b2ee41c724c57ec5aee977f6afbb (355B)
    │   ├── ca [Files: 1] [Size: 1.4K]
    │   │   : 80700889139780db85fcc61482740709968027 (1.4K)
    │   ├── ed [Files: 1] [Size: 19B]
    │   │   : a76f7226728b0f13def6ba3452fc35bb8d3961 (19B)
    │   ├── c1 [Files: 1] [Size: 302B]
    │   │   : 902cbad0a6e629c94ff5f0e47bb74b0dc49041 (302B)
    │   ├── 20 [Files: 1] [Size: 4.7M]
    │   │   : b313f194a17801d7ded06b77440a3800318b68 (4.7M)
    │   ├── 4b [Files: 2] [Size: 184B]
    │   │   : 0bf4243a438b1d3b2abf97ca3eae58de84f367 (27B)
    │   │   : 91b4d7d0e0adf204a0254417ff6aa0f243bf21 (157B)
    │   ├── pack
    │   ├── 11 [Files: 2] [Size: 140B]
    │   │   : 6fc9e1321d41d9bba11134bde580f08da13dd4 (114B)
    │   │   : 48fa81ffdfda89f825176d9a9abd46e34acaaf (26B)
    │   ├── 16 [Files: 1] [Size: 406B]
    │   │   : c284436404729c52a4102e20e21160931ac352 (406B)
    │   ├── 89 [Files: 1] [Size: 354B]
    │   │   : 6bc372876bc450b6b4472f525b721240f01fb8 (354B)
    │   ├── 7b [Files: 2] [Size: 87B]
    │   │   : 45b9af066b9fb137cb4627bca28d18f5c80e68 (43B)
    │   │   : 51752b3b74b38239f173d844db0b64781e5055 (44B)
    │   ├── 8f [Files: 1] [Size: 73B]
    │   │   : 92f41603a0bfba33066f05f95936ab26e0ef34 (73B)
    │   ├── 10 [Files: 1] [Size: 23B]
    │   │   : 490d58db40f6a65b26e5502b2cd5512b83cb92 (23B)
    │   ├── 19 [Files: 1] [Size: 18.8K]
    │   │   : d2c849efcb6e65a77b9021276369057d536682 (18.8K)
    │   ├── 4c [Files: 1] [Size: 753B]
    │   │   : 1053a836edc110d5708c818e42887c8a1d1d75 (753B)
    │   ├── 81 [Files: 1] [Size: 47B]
    │   │   : 79e18eff656b2fdfb41c044e2d4f8a731c2c68 (47B)
    │   ├── 2a [Files: 1] [Size: 18.8K]
    │   │   : 1846682c0882040d58020c1cb42f76d67e88fb (18.8K)
    │   ├── 88 [Files: 1] [Size: 178B]
    │   │   : 9e5feaf706f4bb376bb92b685eca3404ef1cc3 (178B)
    │   ├── 07 [Files: 1] [Size: 72B]
    │   │   : 7505d2f70fe1d20c1f73a8d5f57367ac6015f9 (72B)
    │   ├── 00 [Files: 1] [Size: 1.4K]
    │   │   : ca83aee38303a7738f15deb5d3c25e4d80b3d5 (1.4K)
    │   ├── 5c [Files: 1] [Size: 483B]
    │   │   : d07704bc8c78df85234146395ad36d4c0275ad (483B)
    │   ├── info
    │   ├── 3a [Files: 1] [Size: 163B]
    │   │   : ffbb23bbd03a5b8d9bb4cf03c74f1688151673 (163B)
    │   ├── 53 [Files: 1] [Size: 5.4K]
    │   │   : 646be2c139b7a995f9a239d91dbdbd544c2320 (5.4K)
    │   ├── 30 [Files: 1] [Size: 1.4K]
    │   │   : b86e64c37b976d91b203c677acd68fe30c90f7 (1.4K)
    │   ├── 5e [Files: 1] [Size: 43B]
    │   │   : 285d87ac0fdf516ebc77d758aeeadaf92a8224 (43B)
    │   ├── 08 [Files: 1] [Size: 779B]
    │   │   : 589551d20be6739f64f5db6a3789d806e06861 (779B)
    │   ├── 55 [Files: 1] [Size: 23B]
    │   │   : c95ef9affe36c2279cdf3863da65618b5a66e4 (23B)
    │   ├── 0f [Files: 1] [Size: 8.7K]
    │   │   : 0055e5be650871efce899a8a9973ff3b25e45e (8.7K)
    │   ├── 0a [Files: 1] [Size: 752B]
    │   │   : 2818f3d241f21c23096a18cf737600d029c0bb (752B)
    │   ├── 64 [Files: 2] [Size: 396B]
    │   │   : 34636e88022e2659c0fc1b71b268e1679c73a3 (264B)
    │   │   : adfe1ed06fb2d0ee2872f48aa216c18590278a (132B)
    │   ├── bf [Files: 1] [Size: 1.4K]
    │   │   : 72b0326db5fa089da4cbb44d7cc87c3e2b7d8d (1.4K)
    │   ├── d3 [Files: 1] [Size: 27B]
    │   │   : a4356d2d190f0843a9bd6792e0f9c778ad5eb5 (27B)
    │   ├── a0 [Files: 1] [Size: 128B]
    │   │   : 14b95fd091a019ffcd93d41c2bee225f45f0aa (128B)
    │   ├── db [Files: 1] [Size: 5.7K]
    │   │   : b0af2dd346d1a94bed44d0b75193aa3159ab55 (5.7K)
    │   ├── de [Files: 1] [Size: 517B]
    │   │   : 7c21fabdce9598658715a1fe020b8065e326dc (517B)
    │   ├── b0 [Files: 1] [Size: 103B]
    │   │   : 635ccc29507824bcb1c3b057c463de7c694315 (103B)
    │   ├── b9 [Files: 1] [Size: 354B]
    │   │   : 2f857d9ed982b1478e1ec139b7e02d47be9aa4 (354B)
    │   ├── ea [Files: 1] [Size: 1.4K]
    │   │   : 9b2db4b37c499ed385b2bc99d4186204d2ee49 (1.4K)
    │   ├── cd [Files: 1] [Size: 352B]
    │   │   : 36d50da47523f9bfc4e2003325763f742c5765 (352B)
    │   ├── e6 [Files: 1] [Size: 15B]
    │   │   : 9de29bb2d1d6434b8b29ae775ad8c2e48c5391 (15B)
    │   ├── f9 [Files: 1] [Size: 8.7K]
    │   │   : 1fd45d801d0ec567740fa9c83d1487067373db (8.7K)
    │   ├── e8 [Files: 1] [Size: 43B]
    │   │   : 927828fe051f89206b396f558e7671fa93de8f (43B)
    │   ├── fa [Files: 1] [Size: 23B]
    │   │   : ecce00c47d46d795e14ed2166befee5f492c41 (23B)
    │   ├── c5 [Files: 1] [Size: 75B]
    │   │   : b944b382807d23a29b6e852024df67082b4e40 (75B)
    │   ├── f6 [Files: 1] [Size: 164B]
    │   │   : 46da4b2366a65195e369e5d4f40c95c45386ad (164B)
    │   ├── cb [Files: 2] [Size: 381B]
    │   │   : 03a373a485354205e002dd74d2b82edbdbfd4f (27B)
    │   │   : 88dfbeeed586459b333b55654d32a398e5e78c (354B)
    │   ├── ce [Files: 2] [Size: 1.1K]
    │   │   : 66ab1cfd4b39143681001f5f3a712a6ecf695b (821B)
    │   │   : 6069f995109ae7848e636737037fc65c9dbcc5 (298B)
    │   ├── e0 [Files: 2] [Size: 451B]
    │   │   : 712769acb964f37c729fb5ced8a57175dab1db (47B)
    │   │   : e4c74428e00ea5547f596a32ae777c651c262b (404B)
    │   ├── 48 [Files: 1] [Size: 548B]
    │   │   : 4e6b4f0c7a9fb2596ce147905113e51bef2f60 (548B)
    │   ├── 84 [Files: 1] [Size: 1.4K]
    │   │   : 71b307e91e21aac07925b7f5b0021ba27ea7ec (1.4K)
    │   ├── 24 [Files: 1] [Size: 748B]
    │   │   : 70029c58f66e54c435b8cdbf93f3bc7ca03315 (748B)
    │   ├── 4f [Files: 1] [Size: 1.4K]
    │   │   : d9d94b987a0fb9a673ae7c10b06b6c95130906 (1.4K)
    │   ├── 8d [Files: 1] [Size: 5.6K]
    │   │   : 800b7a4249f9790e81f601d149982ad57074fa (5.6K)
    │   ├── 12 [Files: 1] [Size: 23B]
    │   │   : 399a6a7c395c3dc68109128e57302ad94b3773 (23B)
    │   ├── 8c [Files: 2] [Size: 19.0K]
    │   │   : ce0ee2fe1a05c90c69dfe21b7a8f219c001935 (165B)
    │   │   : b9c63dfa3c7b68ad1593c8c26b8be12ee74050 (18.8K)
    │   ├── 1c [Files: 1] [Size: 18B]
    │   │   : 2f433de18bc8240b1b871e183178960fa43471 (18B)
    │   ├── 40 [Files: 1] [Size: 1.4K]
    │   │   : 824be2b9a34242bda2935433d6e663ea74b37a (1.4K)
    │   ├── 2e [Files: 1] [Size: 5.7K]
    │   │   : 7ef5d7a70e3435dcd7b751c1479e0f263a9332 (5.7K)
    │   ├── 7a [Files: 1] [Size: 43B]
    │   │   : 6a5920ae32b652ac809dc0fb2807e22339b3ec (43B)
    │   └── 25 [Files: 1] [Size: 8.6K]
    │       : a646497b17ad3858faeec816d83fa19282e7d9 (8.6K)
    ├── info [Files: 1] [Size: 240B]
    │   : exclude (240B)
    ├── logs [Files: 1] [Size: 1.3K]
    │   : HEAD (1.3K)
    │   └── refs
    │       ├── heads [Files: 1] [Size: 1.1K]
    │       │   : main (1.1K)
    │       └── remotes
    │           └── origin [Files: 1] [Size: 876B]
    │               : main (876B)
    ├── hooks [Files: 14] [Size: 25.2K]
    │   : push-to-checkout.sample (2.7K)
    │   : update.sample (3.6K)
    │   : pre-push.sample (1.3K)
    │   : pre-applypatch.sample (424B)
    │   : pre-merge-commit.sample (416B)
    │   : post-update.sample (189B)
    │   : prepare-commit-msg.sample (1.5K)
    │   : pre-receive.sample (544B)
    │   : fsmonitor-watchman.sample (4.6K)
    │   : applypatch-msg.sample (478B)
    │   : pre-commit.sample (1.6K)
    │   : sendemail-validate.sample (2.3K)
    │   : pre-rebase.sample (4.8K)
    │   : commit-msg.sample (896B)
    └── refs
        ├── heads [Files: 1] [Size: 41B]
        │   : main (41B)
        ├── tags [Files: 4] [Size: 164B]
        │   : v2.1.1 (41B)
        │   : v2.1.0 (41B)
        │   : v2.1.4 (41B)
        │   : v2.1.3 (41B)
        └── remotes
            └── origin [Files: 1] [Size: 41B]
                : main (41B)

Total Number of Directories traversed 123 (of which 4 are linked)
Maximum depth descended: 6
Total Number of Files: 200 (of which 6 are linked)
Total File Size: 34.7M
