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

gQuoteLevels = {1,2,4,6,8,11,13,16,18,21,23}

gQuotes = {
--[[lv 1]]    "ACT I: ESCAPE\nAndrew: I'm surprised we made it out of there. I thought we were done for.\nChristian: Nick didn't make it out, how are we going to be able to rescue him.\nAndrew: We will get him out somehow, but we can't help him if we're dead.\nChristian: You're right. Watch out! What are those!",
--[[lv 2]]    "Christian: I've been hearing rumors of a rebellion. Uprisings have started around the kingdom.\nAndrew: This is great news! Soon the empire will be overrun. Years of oppression ended.", "",
--[[lv 4]]    "Andrew: We're approaching the castle again. We can rescue our allies.\nChristian: New reports have stated that the empire has released monsters of incredible power to stomp out the rebllion. Do you believe that?\nAndrew: I don't see how it's possible, but we will surely see for ourselves soon.", "",
--[[lv 6]]    "ACT II: INNATE BETRAYAL\nAndrew: We thought we had lost you.\nNick: Hah! A dungeon can't break my body or spirit.\nChristian: And Cameron, I thought you were dead.\nCameron: ...\nAndrew: What's wrong with him, it's like he's sleepwalking.\nNick: No clue, we were separated in the dungeon but I could hear him screaming in the torture chamber. And then one day, silence...", "",
--[[lv 8]]    "Nick: The rebellion is moving it's efforts towards Hilltop.\nCameron: Hill... Top.\nAndrew: Did Cameron just speak?\nChristian: What is it about Hilltop?\nChristian: Stay... Away.\nAndrew: Don't worry, we can keep you safe.\nChristian: No... Run!", "", "",
--[[lv 11]]   "ACT III: THE QUEST\nNick: The rebels have taken Cameron to one of their medical camps for extensive treatment.\nAndrew: Did they say anything about his condition. I'm worried.\nNick: They think that whatever happened in that torture chamber is manifesting itself.\nChristian: When will we see him again, his wounds looked severe.\nNick: They can't foresee any improvements at this time.\nAndrew: May the Gods have mercy on his soul.", "",
--[[lv 13]]   "Christian: I still don't understand why the rebels sent us to find this cure.\nNick: Because you two have the highest chances of getting it quickly.\nChristian: We should be on the frontlines.\nNick: Trust in their judgement, I have and we are so close to our goal.", "", "",
--[[lv 16]]   "ACT IV: SOMETHING WICKED COMES\nChristian: Andrew, I've been getting the feeling that we are being followed.\nAndrew: Normally, I'd chalk that up to paranoia, but I have to say that I agree with you. And something's up with Nick.\nChristian: Do you think he might have been tortured as well.\nAndrew: It's different from Cameron. I can't quite pin it down.", "",
--[[lv 18]]   "Nick: Have you guys been hearing that howling at night.\nChristian: Yes, and I think it's been getting closer.\nAndrew: We should hurry up and get this back to the camp.\nNick: I couldn't agree more.", "", "",
--[[lv 21]]   "ACT V: RETRIBUTION\nChristian: Did you think it was weird how that creature tracked us so perfectly.\nAndrew: None of our usual twists and tricks worked on it.\nNick: Morning fellas, you both look troubled.\nChristian: Nothing Nick, we are just tired from that engagement.\nAndrew: I wonder how many more of those fearsome beasts are out there.\nNick: I wouldn't expect to see more of them. I think you've gotten most of them now.", "",
--[[lv 23]]   "Nick: We're approaching the empires last stronghold. The rebels will be closing in soon. We just need to take out the gatekeeper."
}

gSaveQuotes = {
    "We can take them this time."
}

gBossQuotes = {
    "In dead of night they lurk. The chilling reach is death at a touch.\nFlee mortal, run far and pray, or stay and join us.",
    "These are not the Golems of Lore. Born of clay and fused with life. Monstrous possession brings fury and death.\nAndrew: Cameron? What's happening?\nCameron: Pain\nChristian: He's changing , we never should have come here.\nAndrew: Can we stop this. Should we do something?\nNick Wait, give him space.\nChristian: No! He's changing, help him.",
    "You search in vain for the fountain of youth.\nNever pausing to question your own knowledge, so uncouth.\n",
    'At dusk, a whimper.\nAt night, they howl.\nRays of respite, solace in sunlight.',
    'The gate has been kept and the rituals are done. Transforming this land into brimstone and ash.'
}

gEndings = {
    "'Only the dead have seen the end of war' -Plato"
}