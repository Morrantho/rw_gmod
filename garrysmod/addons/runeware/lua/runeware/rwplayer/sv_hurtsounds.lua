local pl = FindMetaTable("Entity");

local genderModels =
{
    ["models/player/alyx.mdl"] = "female",
    ["models/player/mossman.mdl"] = "female",
    ["models/player/mossman_arctic.mdl"] = "female",
    ["models/player/p2_chell.mdl"] = "female",
    ["models/player/group01/female_01.mdl"] = "female",
    ["models/player/group01/female_02.mdl"] = "female",
    ["models/player/group01/female_03.mdl"] = "female",
    ["models/player/group01/female_04.mdl"] = "female",
    ["models/player/group01/female_05.mdl"] = "female",
    ["models/player/group01/female_06.mdl"] = "female",
    ["models/player/group03/female_01.mdl"] = "female",
    ["models/player/group03/female_02.mdl"] = "female",
    ["models/player/group03/female_03.mdl"] = "female",
    ["models/player/group03/female_04.mdl"] = "female",
    ["models/player/group03/female_05.mdl"] = "female",
    ["models/player/group03/female_06.mdl"] = "female",
    ["models/player/group03m/female_01.mdl"] = "female",
    ["models/player/group03m/female_02.mdl"] = "female",
    ["models/player/group03m/female_03.mdl"] = "female",
    ["models/player/group03m/female_04.mdl"] = "female",
    ["models/player/group03m/female_05.mdl"] = "female",
    ["models/player/group03m/female_06.mdl"] = "female",

    ["models/player/arctic.mdl"] = "male",
    ["models/player/barney.mdl"] = "male",
    ["models/player/breen.mdl"] = "male",
    ["models/player/dod_american.mdl"] = "male",
    ["models/player/dod_german.mdl"] = "male",
    ["models/player/gman_high.mdl"] = "male",
    ["models/player/guerilla.mdl"] = "male",
    ["models/player/kleiner.mdl"] = "male",
    ["models/player/leet.mdl"] = "male",
    ["models/player/magnusson.mdl"] = "male",
    ["models/player/monk.mdl"] = "male",
    ["models/player/odessa.mdl"] = "male",
    ["models/player/phoenix.mdl"] = "male",
    ["models/player/group01/male_01.mdl"] = "male",
    ["models/player/group01/male_02.mdl"] = "male",
    ["models/player/group01/male_03.mdl"] = "male",
    ["models/player/group01/male_04.mdl"] = "male",
    ["models/player/group01/male_05.mdl"] = "male",
    ["models/player/group01/male_06.mdl"] = "male",
    ["models/player/group01/male_07.mdl"] = "male",
    ["models/player/group01/male_08.mdl"] = "male",
    ["models/player/group01/male_09.mdl"] = "male",
    ["models/player/group02/male_02.mdl"] = "male",
    ["models/player/group02/male_04.mdl"] = "male",
    ["models/player/group02/male_06.mdl"] = "male",
    ["models/player/group02/male_08.mdl"] = "male",
    ["models/player/group03/male_01.mdl"] = "male",
    ["models/player/group03/male_02.mdl"] = "male",
    ["models/player/group03/male_03.mdl"] = "male",
    ["models/player/group03/male_04.mdl"] = "male",
    ["models/player/group03/male_05.mdl"] = "male",
    ["models/player/group03/male_06.mdl"] = "male",
    ["models/player/group03/male_07.mdl"] = "male",
    ["models/player/group03/male_08.mdl"] = "male",
    ["models/player/group03/male_09.mdl"] = "male",
    ["models/player/group03m/male_01.mdl"] = "male",
    ["models/player/group03m/male_02.mdl"] = "male",
    ["models/player/group03m/male_03.mdl"] = "male",
    ["models/player/group03m/male_04.mdl"] = "male",
    ["models/player/group03m/male_05.mdl"] = "male",
    ["models/player/group03m/male_06.mdl"] = "male",
    ["models/player/group03m/male_07.mdl"] = "male",
    ["models/player/group03m/male_08.mdl"] = "male",
    ["models/player/group03m/male_09.mdl"] = "male",
    ["models/player/hostage/hostage_01.mdl"] = "male",
    ["models/player/hostage/hostage_02.mdl"] = "male",
    ["models/player/hostage/hostage_03.mdl"] = "male",
    ["models/player/hostage/hostage_04.mdl"] = "male",

    ["models/player/charple.mdl"] = "monster",
    ["models/player/corpse1.mdl"] = "monster",
    ["models/player/soldier_stripped.mdl"] = "monster",
    ["models/player/skeleton.mdl"] = "monster",
    ["models/player/zombie_classic.mdl"] = "monster",
    ["models/player/zombie_fast.mdl"] = "monster",
    ["models/player/zombie_soldier.mdl"] = "monster",

    ["models/player/combine_soldier.mdl"] = "combine",
    ["models/player/combine_soldier_prisonguard.mdl"] = "combine",
    ["models/player/combine_super_soldier.mdl"] = "combine",
    ["models/player/gasmask.mdl"] = "combine",
    ["models/player/riot.mdl"] = "combine",
    ["models/player/swat.mdl"] = "combine",
    ["models/player/urban.mdl"] = "combine",

    ["models/player/police.mdl"] = "metropolice",
    ["models/player/police_fem.mdl"] = "metropolice"

}

function pl:getGender()
    return genderModels[ self:GetModel() ] || "male"
end

local hurtSounds =
{
    ["male"] =
    {
        ["generic"] =
        {
            [1] = "vo/npc/male01/ow01.wav",
            [2] = "vo/npc/male01/ow02.wav",
            [3] = "vo/npc/male01/pain01.wav",
            [4] = "vo/npc/male01/pain02.wav",
            [5] = "vo/npc/male01/pain03.wav",
            [6] = "vo/npc/male01/pain04.wav",
            [7] = "vo/npc/male01/pain05.wav",
            [8] = "vo/npc/male01/pain06.wav",
            [9] = "vo/npc/male01/pain07.wav",
            [10] = "vo/npc/male01/pain08.wav",
            [11] = "vo/npc/male01/pain09.wav"
        },
        ["stomach"] =
        {
            [1] = "vo/npc/male01/hitingut01.wav",
            [2] = "vo/npc/male01/hitingut02.wav",
            [3] = "vo/npc/male01/mygut02.wav"
        },
        ["arm"] =
        {
            [1] = "vo/npc/male01/myarm01.wav",
            [2] = "vo/npc/male01/myarm02.wav"
        },
        ["leg"] =
        {
            [1] = "vo/npc/male01/myleg01.wav",
            [2] = "vo/npc/male01/myleg01.wav"
        }
    },
    ["female"] =
    {
        ["generic"] =
        {
            [1] = "vo/npc/female01/ow01.wav",
            [2] = "vo/npc/female01/ow02.wav",
            [3] = "vo/npc/female01/pain01.wav",
            [4] = "vo/npc/female01/pain02.wav",
            [5] = "vo/npc/female01/pain03.wav",
            [6] = "vo/npc/female01/pain04.wav",
            [7] = "vo/npc/female01/pain05.wav",
            [8] = "vo/npc/female01/pain06.wav",
            [9] = "vo/npc/female01/pain07.wav",
            [10] = "vo/npc/female01/pain08.wav",
            [11] = "vo/npc/female01/pain09.wav"
        },
        ["stomach"] =
        {
            [1] = "vo/npc/female01/hitingut01.wav",
            [2] = "vo/npc/female01/hitingut02.wav",
            [3] = "vo/npc/female01/mygut02.wav"
        },
        ["arm"] =
        {
            [1] = "vo/npc/female01/myarm01.wav",
            [2] = "vo/npc/female01/myarm02.wav"
        },
        ["leg"] =
        {
            [1] = "vo/npc/female01/myleg01.wav",
            [2] = "vo/npc/female01/myleg01.wav"
        }
    },
    ["monster"] =
    {
        ["generic"] =
        {
            [1] = "npc/zombie/zombie_pain1.wav",
            [2] = "npc/zombie/zombie_pain2.wav",
            [3] = "npc/zombie/zombie_pain3.wav",
            [4] = "npc/zombie/zombie_pain4.wav",
            [5] = "npc/zombie/zombie_pain5.wav",
            [6] = "npc/zombie/zombie_pain6.wav"
        },
        ["death"] =
        {
            [1] = "npc/zombie/zombie_die1.wav",
            [2] = "npc/zombie/zombie_die1.wav",
            [3] = "npc/zombie/zombie_die1.wav",
            [4] = "npc/zombie/zombie_die1.wav",
            [5] = "npc/zombie/zombie_die1.wav",
            [6] = "npc/zombie/zombie_die1.wav",
        }
    },
    ["combine"] =
    {
        ["generic"] =
        {
            [1] = "npc/combine_soldier/pain1.wav",
            [2] = "npc/combine_soldier/pain2.wav",
            [3] = "npc/combine_soldier/pain3.wav"
        },
        ["death"] =
        {
            [1] = "npc/combine_soldier/die1.wav",
            [2] = "npc/combine_soldier/die2.wav",
            [3] = "npc/combine_soldier/die3.wav"
        }
    },
    ["metropolice"] =
    {
        ["generic"] =
        {
            [1] = "npc/metropolice/pain1.wav",
            [2] = "npc/metropolice/pain2.wav",
            [3] = "npc/metropolice/pain3.wav",
            [4] = "npc/met,ropolice/pain4.wav"
        },
        ["death"] =
        {
            [1] = "npc/metropolice/die1.wav",
            [2] = "npc/metropolice/die2.wav",
            [3] = "npc/metropolice/die3.wav",
            [4] = "npc/metropolice/die4.wav"
        }
    }
}

function pl:doHurtSound( hit, death )

    local gender = self:getGender()
    local SndInt

    if death then
        if hurtSounds[gender]["death"] then
            SndInt = math.random(1, #hurtSounds[gender]["death"] )
            self:EmitSound( hurtSounds[gender]["death"][SndInt] )
        else
            SndInt = math.random(1, #hurtSounds[gender]["generic"] )
            self:EmitSound( hurtSounds[gender]["generic"][SndInt] )
        end
        return
    end

    if ( hit == HITGROUP_LEFTARM || hit == HITGROUP_RIGHTARM ) && hurtSounds[gender]["arm"] then
        SndInt = math.random(1, #hurtSounds[gender]["arm"] )
        self:EmitSound( hurtSounds[gender]["arm"][SndInt] )
    elseif ( hit == HITGROUP_LEFTLEG || hit == HITGROUP_RIGHTARM ) && hurtSounds[gender]["leg"] then
        SndInt = math.random(1, #hurtSounds[gender]["leg"] )
        self:EmitSound( hurtSounds[gender]["leg"][SndInt] )
    elseif hit == HITGROUP_STOMACH && hurtSounds[gender]["stomach"] then
        SndInt = math.random(1, #hurtSounds[gender]["stomach"] )
        self:EmitSound( hurtSounds[gender]["stomach"][SndInt] )
    else
        SndInt = math.random(1, #hurtSounds[gender]["generic"] )
        self:EmitSound( hurtSounds[gender]["generic"][SndInt] )
    end

end