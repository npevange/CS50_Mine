--[[
    GD50
    Final Project

    -- constants --

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]
-- size of push emulator
VIRTUAL_WIDTH = 384 --576 --768
VIRTUAL_HEIGHT = 216 --324 --432

-- actual size
WINDOW_WIDTH = 1280 --1360
WINDOW_HEIGHT = 720 --768

-- global standard tile size
TILE_SIZE = 32

-- width and height of screen in tiles

SCREEN_TILE_WIDTH = VIRTUAL_WIDTH / TILE_SIZE
SCREEN_TILE_HEIGHT = VIRTUAL_HEIGHT / TILE_SIZE

--Randomizer Tiles

TILE_ID_GRASS = 1
TILE_ID_TREE = 2
TILE_ID_LAKE = 3
TILE_ID_HOUSE = 5

--Boss Zone tiles
TILE_ID_CASTLE = 4
--TODO: TILE_ID_OCEAN ??? Kraken?
-- Golem something
-- Werewolf something
-- Hell? Pentagram

gTiles = {
    1,2,3,5
}

gQuoteLevels = {1,2,3,5,6,8,9,11,12,14,15,17,18,19,21,22,24,25,27,28,30,31}
gBossLevels = {4,7,10,13,16,20,23,26,29,32}
gBlessingLevels = {5,8,11,14,21,24,27,30}

gQuotes = {
--[[lv 1]]    "ACT I: ESCAPE\n\nAndrew: I'm surprised we made it out of there. I thought we were done for.\nChristian: Nick didn't make it out, how are we going to be able to rescue him.\nAndrew: We will get him out somehow, but we can't help him if we're dead.\nChristian: You're right. Watch out, someone's coming!\n\nBlessing of the Hero: They may not know it, but their destiny is tied to the fate of the world.",
--[[lv 2]]    "Christian: I've been hearing rumors of a rebellion. Uprisings have started around the kingdom.\nAndrew: This is great news! Soon the empire will be overrun. Years of oppression ended.\nChristian: It gives me so much hope, but also a sense of deja vu.",
--[[lv 3]]    "Andrew: We're approaching the castle again. We can rescue our allies.\nChristian: New reports have stated that the empire has released monsters of incredible power to stomp out the rebllion. Do you believe that?\nAndrew: I don't see how it's possible, but we will surely see for ourselves soon.",
              "",
--[[lv 5]]    "ACT II: INNATE BETRAYAL\n\nAndrew: We thought we had lost you.\nNick: Hah! A dungeon can't break my body or spirit.\nChristian: And Cameron, I thought you were dead.\nCameron: ...\nAndrew: What's wrong with him, it's like he's sleepwalking.\nNick: No clue, we were separated in the dungeon but I could hear him screaming in the torture chamber. And then one day, silence...\n\nBlessing of Blood: Allows heroes to heal from injuring enemies.",
--[[lv 6]]    "Nick: The rebellion is moving it's efforts towards Hilltop.\nCameron: Hill... Top.\nAndrew: Did Cameron just speak?\nChristian: What is it about Hilltop?\nCameron: Stay... Away.\nAndrew: Don't worry, we can keep you safe.\nCameron: No... Run!",
              "",
--[[lv 8]]   "ACT III: THE QUEST\n\nNick: The rebels have taken Cameron to one of their medical camps for extensive treatment.\nAndrew: Did they say anything about his condition? I'm worried.\nNick: They think that whatever happened in that torture chamber is manifesting itself.\nChristian: When will we see him again? His wounds looked severe.\nNick: They can't foresee any improvements at this time.\nAndrew: May the Gods have mercy on his soul.\n\nBlessing of Stone: Gives heroes a chance to survive fatal hits in combat.",
--[[lv 9]]   "Christian: I still don't understand why the rebels sent us to find this cure.\nNick: Because you two have the highest chances of getting it quickly.\nChristian: We should be on the frontlines.\nNick: Trust in their judgement, I have and we are so close to our goal.",
              "",
--[[lv 11]]   "ACT IV: SOMETHING WICKED COMES THIS WAY\n\nChristian: Andrew, I've been getting the feeling that we are being followed.\nAndrew: Normally, I'd chalk that up to paranoia, but I have to say that I agree with you. And something's up with Nick.\nChristian: Do you think he might have been tortured as well.\nAndrew: It's different from Cameron. I can't quite pin it down.\n\nBlessing of the Tempest: An ancient cure has been harnessed.",
--[[lv 12]]   "Nick: Have you guys been hearing that howling at night.\nChristian: Yes, and I think it's been getting closer.\nAndrew: We should hurry up and get this back to the camp.\nNick: I couldn't agree more.",
              "",
--[[lv 14]]   "ACT V: REVOLUTION\n\nChristian: Did you think it was weird how that creature tracked us so perfectly.\nAndrew: None of our usual twists and tricks worked on it.\nNick: Morning fellas, you both look troubled.\nChristian: Nothing Nick, we are just tired from that engagement.\nAndrew: I wonder how many more of those fearsome beasts are out there.\nNick: I wouldn't expect to see more of them. I think you've gotten most of them now.\n\nBlessing of the Hunter: Only those who slay the Hunter can wield it's power to defeat the mightiest of foes.",
--[[lv 15]]   "Nick: We're approaching the empires last stronghold. The rebels will be closing in soon. We just need to take out the gatekeeper.",
--[[lv 16]]   "",

--[[lv 17]]   "ACT I: DEJA VU\n\nNick: I'm surprised we made it out of there. I thought we were done for.\nCameron: Andrew and Christian are still stuck in there, if they don't make it out we can't let their sacrifice be in vain.\nNick: Then let's cause some chaos on our way out.\nCameron: You're right. The Empire will face our wrath!\n\nBlessing of the Villian: Sometimes we must stoop low for the greater good.",
--[[lv 18]]   "Cameron: When we return to camp the rebellion will be refuled. We will coordinate uprisings around the kingdom for phase one.\nNick: I can't wait to make them pay for all the evil they've brought to this world.\nCameron: Let this be a shining beacon of hope.",
--[[lv 19]]   "Nick: We're approaching the castle again. If we were fast enough they might not have resurrected their blood demon yet.\nCameron: New reports have stated that the empire has been taking an increasing number of hostages to unknown locations, so we need to be prepared for the worst possible outcome.\nNick: Our shamans and priests are working hard so that we can bring our own warriors to the battleground.",
              "",
--[[lv 21]]   "ACT II: NATURAL DISASTER\n\nNick: Good to have you boys back.\nAndrew: Hah! We were just planning our escape.\nCameron: Good to see you too Christian. We had hoped you would make it out safely\nChristian: Thanks, good to be back.\nNick: You just missed one of those monsters the Empire has brought around.\nAndrew: I thought that was a myth, I still can't believe it. Such cruelty and evil.\n\nBlessing of Blood: Allows heroes to heal from injuring enemies.",
--[[lv 22]]   "Nick: Our next destination is Hilltop.\nCameron: That could be dangerous if the empire's dungeons did their work on Andrew and Christian.\nNick: It's a vital stronghold to secure so we have to take our chances.\nCameron: I'm worried, but it's your call.",
              "",
--[[lv 24]]   "ACT III: THIS WAS NEVER OUR QUEST\n\nNick: Christian will need immediate treatment at one of our specialized camps. The damage that was done to him is extensive.\nAndrew: I couldn't have guessed the Empire was capable of such terrible crimes.\nNick: They think that whatever happened in that torture chamber is manifesting itself.\nAndrew: When will we see him again, his wounds looked severe.\nNick: They can't foresee any improvements at this time.\nAndrew: May the Gods have mercy on his soul.\n\nBlessing of Stone: Gives heroes a chance to survive fatal hits in combat.",
--[[lv 25]]   "Cameron: I don't understand why we have to track down this cure.\nNick: We aren't needed on the frontlines right now, and this is the perfectexcuse to poke around and investigate.\nCameron: Well it feels like gruntwork.\nNick: Trust in their leadership, I have and we are so close to our goal.",
              "",
--[[lv 27]]   "ACT IV: SOMETHING WICKED HAS BEEN HERE\n\nNick: It seems like the legends are true. I believe that the Beast is tracking us back towards camp.\nCameron: That was one of the tales I had always hoped to actually be a myth.\nNick: We won't be able to avoid confrontation, but maybe we can reach our backup first.\nCameron: While we haven't sustained major injuries, we might be slowed too much. If it comes down to a fight for our lives, we will need to be well rested.\n\nBlessing of the Tempest: An ancient cure has been harnessed.",
--[[lv 28]]   "Nick: Every night I hear the howling growing closer.\nCameron: Do you think we can rely on all the legends to be true.\nNick: If you're thinking of leaving a sacrifice, that's horrible. I wouldn't expect that thought from you, unless you are feeling that desperate.\nCameron: The Beast is said the be an ancient evil. Unstoppable is it's might. Unfathomable is it's terror.\nNick: These other creatures have been manageable so let's keep our heads up for now.",
                "",
--[[lv 30]]   "ACT V: RETRIBUTION\n\nCameron:...\nNick: That wasn't so bad. We're still on track with the rebellion.\nCameron: What if the Empire has more of those unspeakable horrors. I don't know how much more I can take.\nNick: We're so close now. Just keep strong for a bit longer. All of our hopes and dreams, the efforts of so many have led to this.\nCameron: I hope that it is worth it.\n\nBlessing of the Hunter: Only those who slay the Hunter can wield it's power to defeat the mightiest of foes.",
--[[lv 31]]   "Nick: We're approaching the empires last stronghold. The rebels are closing in and all their escapes are sealed. This is why we fight."
}

gSaveQuotes = {
    "We can take them this time."
}

gBossQuotes = {
    "In dead of night they lurk. The chilling reach is death at a touch.\nFlee mortal, run far and pray, or stay and join us.",
    "These are not the Golems of Lore. Born of clay and fused with life. Monstrous possession brings fury and death.\nAndrew: Cameron? What's happening?\nCameron: Pain\nChristian: He's changing , we never should have come here.\nAndrew: Can we stop this. Should we do something?\nNick Wait, give him space.\nChristian: No! He's changing, help him.",
    "You search in vain for the fountain of youth.\nNever pausing to question your own knowledge, so uncouth.\n",
    'At dusk, a whimper.\nAt night, they howl.\nRays of respite, solace in sunlight.',
    'The gate has been kept and the rituals are done.\nA cycle unbroken, prophetic, and poetic.',
    "This is not the monster expected, but a son that never should have been.\nThe unholy union between bloodsucker and mortal, he stalks dusk til dawn.",
    "This Golem was not made, but born.\nA tiny sapling grown and grafted onto a soul.\nTheir wrath is gentle, a return to nature, a deadly spring bloom.",
    "You search in vain for the fountain of youth.\nA timeless river throughout history, twisting and turning like a serpent.\nBeware it's venomous bite for eternity is not what you expected.",
    'At dawn the Beast was born.\nAt Dusk, it ran free.\nMoonlight chills running through the air, hunting for sport, inescapable as the night.',
    'A thousand loops, as uniform as a sphere.\nA curse or a cure, to repeat ad infinitum.\nNever exactly the same, but never divergent.\n The gatekeeper will die, the cycle repeats, a new hero is chosen on this endless journey.'
}

gQuoteGameEnd = {
    "Thank you for embarking on this journey with us. That's all I have for now, but I hope you had a wonderful time."
}
gEndings = {
    "'Only the dead have seen the end of war' -Plato\nYou Lose\nUntil next time, traveller."
}