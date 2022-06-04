--- @class ColorString
ColorString = setmetatable({}, ColorString)

ColorString.__index = ColorString

ColorString.__call = function()
    return "ColorString"
end

function ColorString.new()
    local _ColorString = {
        Text = ""
    }

    return setmetatable(_ColorString, ColorString)
end

function ColorString:RedOrange(text)
    self.Text = self.Text .. TextColors.RedOrange .. text
    return self
end

function ColorString:LightGreen(text)
    self.Text = self.Text .. TextColors.LightGreen .. text
    return self
end

function ColorString:LightYellow(text)
    self.Text = self.Text .. TextColors.LightYellow .. text
    return self
end

function ColorString:DarkBlue(text)
    self.Text = self.Text .. TextColors.DarkBlue .. text
    return self
end

function ColorString:LightBlue(text)
    self.Text = self.Text .. TextColors.LightBlue .. text
    return self
end

function ColorString:Violet(text)
    self.Text = self.Text .. TextColors.Violet .. text
    return self
end

function ColorString:White(text)
    self.Text = self.Text .. TextColors.White .. text
    return self
end

function ColorString:BloodRed(text)
    self.Text = self.Text .. TextColors.BloodRed .. text
    return self
end

function ColorString:Fuchsia(text)
    self.Text = self.Text .. TextColors.Fuchsia .. text
    return self
end

function ColorString:End()
    self.Text = self.Text .. "^7"
    return self.Text
end

TextFormat = {
    Bold = "^*",
    Underline = "^_",
    StrikeThrough = "^~",
    UnderlineStrikeThrough = "^=",
    BoldUnderlineStrikeThrough = "^*^=",
    Cancel = "^r"
}

TextColors = {
    RedOrange = "^1",
    LightGreen = "^2",
    LightYellow = "^3",
    DarkBlue = "^4",
    LightBlue = "^5",
    Violet = "^6",
    White = "^7",
    BloodRed = "^8",
    Fuchsia = "^9"
}




Command = setmetatable({}, Command)

Command.__index = Command

Command.__call = function()
    return "Command"
end

--- @class CommandOptions
CommandOptions = {
    --- @type string
    Default = ""
}

function Command.new(trigger)
    local _Command = {
        Trigger = trigger,
        ArgsList = {},
        Restrictors = {},
        Handler = nil
    }

    return setmetatable(_Command, Command)
end

--- @param name string
---@param options CommandOptions
function Command:String(name, options)
    table.insert(self.ArgsList, {
        type = "string",
        name = name
    })
    return self
end

function Command:Number(name)
    table.insert(self.ArgsList, {
        type = "number",
        name = name
    })
    return self
end

function Command:Boolean(name)
    table.insert(self.ArgsList, {
        type = "boolean",
        name = name
    })
    return self
end

--- @param handler fun(source: number): boolean
function Command:Restrict(handler)
    table.insert(self.Restrictors, handler)
    return self
end

--- @param handler fun(source: number)
function Command:SetHandler(handler)
    self.Handler = handler
    return self
end

function Command:Register()
    RegisterCommand(self.Trigger, function(source, args)
        local numRestrict = #self.Restrictors
        local passed = 0
        for k,v in pairs(self.Restrictors) do
            local val = v()
            if val == true then
                passed = passed + 1
            end
        end

        if passed ~= numRestrict then
            Error.new("Restrictors failed for command", self.Trigger):Print()
            return
        end

        for k,v in pairs(self.ArgsList) do
            if v.type == "boolean" then
                if args[k] == "true" or args[k] == "false" or args[k] == "1" or args[k] == "0" then
                    if args[k] == "true" then args[k] = true end
                    if args[k] == "1" then args[k] = true end
                    if args[k] == "false" then args[k] = false end
                    if args[k] == "0" then args[k] = false end
                end
            elseif v.type == "number" then
                local out = tonumber(args[k])
                if out == nil then
                    Error.new("Could not assert to number"):Print()
                    return
                end
                args[k] = out
            end
        end
        self.Handler(source, table.unpack(args))
    end)
end




MaterialHash = {
    None = 0x0,
    Unk = 0x962c3f7b,
    Concrete = 0x46ca81e8,
    ConcretePothole = 0x1567bf52,
    ConcreteDusty = 0xbf59b491,
    Tarmac = 0x10dd5498,
    TarmacPainted = 0xb26eefb0,
    TarmacPothole = 0x70726a55,
    RumbleStrip = 0xf116bc2d,
    BreezeBlock = 0xc72165d6,
    Rock = 0xcdeb5023,
    RockMossy = 0xf8902ac8,
    Stone = 0x2d9c1e0d,
    Cobblestone = 0x2257a573,
    Brick = 0x61b1f936,
    Marble = 0x73ef7697,
    PavingSlab = 0x71ab3fee,
    SandstoneSolid = 0x23500534,
    SandstoneBrittle = 0x7209440e,
    SandLoose = 0xa0ebf7e4,
    SandCompact = 0x1e6d775e,
    SandWet = 0x363cbcd5,
    SandTrack = 0x8e4d8aff,
    SandUnderwater = 0xbc4922a4,
    SandDryDeep = 0x1e5e7a48,
    SandWetDeep = 0x4ccc2aff,
    Ice = 0xd125aa55,
    IceTarmac = 0x8ce6e7d9,
    SnowLoose = 0x8c8308ca,
    SnowCompact = 0xcba23987,
    SnowDeep = 0x608abc80,
    SnowTarmac = 0x5c67c62a,
    GravelSmall = 0x38bbd00c,
    GravelLarge = 0x7edc5571,
    GravelDeep = 0xeabd174e,
    GravelTrainTrack = 0x72c668b6,
    DirtTrack = 0x8f9cd58f,
    MudHard = 0x8c31b7ea,
    MudPothole = 0x129eca2a,
    MudSoft = 0x61826e7a,
    MudUnderwater = 0xefb2df09,
    MudDeep = 0x42251dc0,
    Marsh = 0xd4c07e2,
    MarshDeep = 0x5e73a22e,
    Soil = 0xd63ccddb,
    ClayHard = 0x4434dfe7,
    ClaySoft = 0x216ff3f0,
    GrassLong = 0xe47a3e41,
    Grass = 0x4f747b87,
    GrassShort = 0xb34e900d,
    Hay = 0x92b69883,
    Bushes = 0x22ad7b72,
    Twigs = 0xc98f5b61,
    Leaves = 0x8653c6cd,
    Woodchips = 0xed932e53,
    TreeBark = 0x8dd4ebb9,
    MetalSolidSmall = 0xa9bc4217,
    MetalSolidMedium = 0xea34e8f8,
    MetalSolidLarge = 0x2cd49bd1,
    MetalHollowSmall = 0xf3b93b,
    MetalHollowMedium = 0x6e3dbfb8,
    MetalHollowLarge = 0xdd3cdcf9,
    MetalChainlinkSmall = 0x2d6e26cd,
    MetalChainlinkLarge = 0x781fa34,
    MetalCorrugatedIron = 0x31b80ad6,
    MetalGrille = 0xe699f485,
    MetalRailing = 0x7d368d93,
    MetalDuct = 0x68feb9fd,
    MetalGarageDoor = 0xf2373de9,
    MetalManhole = 0xd2ffa63d,
    WoodSolidSmall = 0xe82a6f1c,
    WoodSolidMedium = 0x2114b37d,
    WoodSolidLarge = 0x309f8bb7,
    WoodSolidPolished = 0x789c7ab,
    WoodFloorDusty = 0xd35443de,
    WoodHollowSmall = 0x76d9ac2f,
    WoodHollowMedium = 0xea3746bd,
    WoodHollowLarge = 0xc8d738e7,
    WoodChipboard = 0x461d0e9b,
    WoodOldCreaky = 0x2b13503d,
    WoodHighDensity = 0x981e5200,
    WoodLattice = 0x77e08a22,
    Ceramic = 0xb94a2eb5,
    RoofTile = 0x689e0e75,
    RoofFelt = 0xab87c845,
    Fibreglass = 0x50b728db,
    Tarpaulin = 0xd9b1cde0,
    Plastic = 0x846bc4ff,
    PlasticHollow = 0x25612338,
    PlasticHighDensity = 0x9f154729,
    PlasticClear = 0x9126e8cb,
    PlasticHollowClear = 0x2e0ecf63,
    PlasticHighDensityClear = 0xb038852e,
    FibreglassHollow = 0xd256ed46,
    Rubber = 0xf7503f13,
    RubberHollow = 0xd1461b30,
    Linoleum = 0x11436942,
    Laminate = 0x6e02c9aa,
    CarpetSolid = 0x27e49616,
    CarpetSolidDusty = 0x973ae44,
    CarpetFloorboard = 0xacc354b1,
    Cloth = 0x7519e5d,
    PlasterSolid = 0xddc7963f,
    PlasterBrittle = 0xf0fc7afe,
    CardboardSheet = 0xe18dff5,
    CardboardBox = 0xac038918,
    Paper = 0x1c42f3bc,
    Foam = 0x30341454,
    FeatherPillow = 0x4ffb413f,
    Polystyrene = 0x97476a9d,
    Leather = 0xddff4e0c,
    Tvscreen = 0x553be97c,
    SlattedBlinds = 0x2827cbd9,
    GlassShootThrough = 0x37e12a0b,
    GlassBulletproof = 0xe931a0e,
    GlassOpaque = 0x596c55d1,
    Perspex = 0x9f73e76c,
    CarMetal = 0xfa73fca1,
    CarPlastic = 0x7f630ae2,
    CarSofttop = 0xc59bc28a,
    CarSofttopClear = 0x7efdf110,
    CarGlassWeak = 0x4a57ffca,
    CarGlassMedium = 0x23ef48bc,
    CarGlassStrong = 0x3fd6150a,
    CarGlassBulletproof = 0x995da5e6,
    CarGlassOpaque = 0x1e94b2b7,
    Water = 0x19f81600,
    Blood = 0x4fe54a,
    Oil = 0xda2e9567,
    Petrol = 0x9e98536c,
    FreshMeat = 0x33c7d38f,
    DriedMeat = 0xa9dc9a13,
    EmissiveGlass = 0x5978a2ed,
    EmissivePlastic = 0x3f28abac,
    VfxMetalElectrified = 0xed92fc47,
    VfxMetalWaterTower = 0x2473b1bf,
    VfxMetalSteam = 0xd6cbf212,
    VfxMetalFlame = 0x13d5cb0d,
    PhysNoFriction = 0x63545f03,
    PhysGolfBall = 0x9b0a74ca,
    PhysTennisBall = 0xf0b2ff05,
    PhysCaster = 0xf1f990e5,
    PhysCasterRusty = 0x7830c8f1,
    PhysCarVoid = 0x50384f9d,
    PhysPedCapsule = 0xee9e1045,
    PhysElectricFence = 0xba428cab,
    PhysElectricMetal = 0x87f87187,
    PhysBarbedWire = 0xa402c0c0,
    PhysPooltableSurface = 0x241b6c19,
    PhysPooltableCushion = 0x39fde2bb,
    PhysPooltableBall = 0xd36536c6,
    Buttocks = 0x1cd01a28,
    ThighLeft = 0xe48cc7c1,
    ShinLeft = 0x26e885f4,
    FootLeft = 0x72d0c8e7,
    ThighRight = 0xf1dff3f9,
    ShinRight = 0xe56a0745,
    FootRight = 0xae64a1d4,
    Spine0 = 0x8d6c3adc,
    Spine1 = 0xbc0b421b,
    Spine2 = 0x56e0ca1d,
    Spine3 = 0x1f3c404,
    ClavicleLeft = 0xa8676eaf,
    UpperArmLeft = 0xe194cb2a,
    LowerArmLeft = 0x3e4a6464,
    HandLeft = 0x6bdcca1,
    ClavicleRight = 0xa32da7da,
    UpperArmRight = 0x5979c903,
    LowerArmRight = 0x69f8ee36,
    HandRight = 0x774441b4,
    Neck = 0x666b1694,
    Head = 0xd42acc0f,
    AnimalDefault = 0x110f7216,
    CarEngine = 0x8dbdd298,
    Puddle = 0x3b982e13,
    ConcretePavement = 0x78239b1a,
    BrickPavement = 0xbb9ca6d8,
    PhysDynamicCoverBound = 0x85f61ac9,
    VfxWoodBeerBarrel = 0x3b7f59ce,
    WoodHighFriction = 0x8070dcf9,
    RockNoinst = 0x79e4953,
    BushesNoinst = 0x55e5aaee,
    MetalSolidRoadSurface = 0xd48aa0f2,
    StuntRampSurface = 0x8388fa6c,
    Temp01 = 0x2c848051,
    Temp02 = 0x8a1a9241,
    Temp03 = 0x71e96559,
    Temp04 = 0x72add5e0,
    Temp05 = 0xacee6610,
    Temp06 = 0x3f4163f1,
    Temp07 = 0x96c43f1e,
    Temp08 = 0x5016ecd6,
    Temp09 = 0x3d285b19,
    Temp10 = 0x3c5f90a,
    Temp11 = 0x2d45692,
    Temp12 = 0x29e0c642,
    Temp13 = 0x9e65f2a7,
    Temp14 = 0xd97f800a,
    Temp15 = 0xa1961c15,
    Temp16 = 0xa5d57dd7,
    Temp17 = 0x3c514932,
    Temp18 = 0x50c38df2,
    Temp19 = 0xd0356f62,
    Temp20 = 0x85a387eb,
    Temp21 = 0xc2251964,
    Temp22 = 0xdb059fff,
    Temp23 = 0x1bb7608f,
    Temp24 = 0x750d8481,
    Temp25 = 0x745d8e31,
    Temp26 = 0xbd775456,
    Temp27 = 0x3500f64a,
    Temp28 = 0xb9af9a0e,
    Temp29 = 0x40475ab5,
    Temp30 = 0xcfebb4,
}


PedHash = {
    Michael = 225514697,
    Franklin = 2602752943,
    Trevor = 2608926626,
    Abigail = 1074457665,
    Agent = 3614493108,
    Agent14 = 4227433577,
    AmandaTownley = 1830688247,
    Andreas = 1206185632,
    Ashley = 2129936603,
    AviSchwartzman = 939183526,
    Ballasog = 2802535058,
    Bankman = 2426248831,
    Barry = 797459875,
    Bestmen = 1464257942,
    Beverly = 3181518428,
    Brad = 3183167778,
    Bride = 1633872967,
    Car3Guy1 = 2230970679,
    Car3Guy2 = 1975732938,
    Casey = 3774489940,
    Chef = 1240128502,
    Chef2 = 2240322243,
    Clay = 1825562762,
    Claypain = 2634057640,
    Cletus = 3865252245,
    CrisFormage = 678319271,
    Dale = 1182012905,
    DaveNorton = 365775923,
    Denise = 2181772221,
    Devin = 1952555184,
    DoaMan = 1646160893,
    Dom = 2620240008,
    Dreyfuss = 3666413874,
    DrFriedlander = 3422293493,
    EdToh = 712602007,
    Fabien = 3499148112,
    FbiSuit01 = 988062523,
    Floyd = 2981205682,
    G = 2216405299,
    Groom = 4274948997,
    Hao = 1704428387,
    Hunter = 3457361118,
    Janet = 225287241,
    JayNorris = 2050158196,
    Jewelass = 257763003,
    JimmyBoston = 3986688045,
    JimmyDisanto = 1459905209,
    JoeMinuteman = 3189787803,
    JohnnyKlebitz = 2278195374,
    Josef = 3776618420,
    Josh = 2040438510,
    KarenDaniels = 3948009817,
    KerryMcintosh = 1530648845,
    LamarDavis = 1706635382,
    Lazlow = 3756278757,
    LesterCrest = 1302784073,
    Lifeinvad01 = 1401530684,
    Lifeinvad02 = 666718676,
    Magenta = 4242313482,
    Malc = 4055673113,
    Manuel = 4248931856,
    Marnie = 411185872,
    MaryAnn = 2741999622,
    Maude = 1005070462,
    Michelle = 3214308084,
    Milton = 3408943538,
    Molly = 2936266209,
    MrK = 3990661997,
    MrsPhillips = 946007720,
    MrsThornhill = 503621995,
    Natalia = 3726105915,
    NervousRon = 3170921201,
    Nigel = 3367442045,
    OldMan1a = 1906124788,
    OldMan2 = 4011150407,
    Omega = 1625728984,
    ONeil = 768005095,
    Orleans = 1641334641,
    Ortega = 648372919,
    Paper = 2577072326,
    Patricia = 3312325004,
    Popov = 645279998,
    Paige = 357551935,
    Priest = 1681385341,
    PrologueDriver = 2237544099,
    PrologueSec01 = 1888624839,
    PrologueSec02 = 666086773,
    RampGang = 3845001836,
    RampHic = 1165307954,
    RampHipster = 3740245870,
    RampMex = 3870061732,
    Rashkovsky = 940326374,
    RoccoPelosi = 3585757951,
    RussianDrunk = 1024089777,
    ScreenWriter = 4293277303,
    SiemonYetarian = 1283141381,
    Solomon = 2260598310,
    SteveHains = 941695432,
    Stretch = 915948376,
    Talina = 3885222120,
    Tanisha = 226559113,
    TaoCheng = 3697041061,
    TaosTranslator = 2089096292,
    TennisCoach = 2721800023,
    Terry = 1728056212,
    TomEpsilon = 3447159466,
    Tonya = 3402126148,
    TracyDisanto = 3728026165,
    TrafficWarden = 1461287021,
    TylerDixon = 1382414087,
    VagosSpeak = 4194109068,
    Wade = 2459507570,
    WeiCheng = 2867128955,
    Zimbor = 188012277,
    AbigailCutscene = 2306246977,
    AgentCutscene = 3614493108,
    Agent14Cutscene = 1841036427,
    AmandaTownleyCutscene = 2515474659,
    AndreasCutscene = 3881194279,
    AnitaCutscene = 117698822,
    AntonCutscene = 2781317046,
    AshleyCutscene = 650367097,
    AviSchwartzmanCutscene = 2560490906,
    BallasogCutscene = 2884567044,
    BankmanCutscene = 2539657518,
    BarryCutscene = 1767447799,
    BeverlyCutscene = 3027157846,
    BradCutscene = 4024807398,
    BradCadaverCutscene = 1915268960,
    BrideCutscene = 2193587873,
    BurgerDrugCutscene = 2363277399,
    Car3Guy1Cutscene = 71501447,
    Car3Guy2Cutscene = 327394568,
    CarBuyerCutscene = 2362341647,
    CaseyCutscene = 3935738944,
    ChefCutscene = 2739391114,
    Chef2Cutscene = 2925257274,
    ChinGoonCutscene = 2831296918,
    ClayCutscene = 3687553076,
    CletusCutscene = 3404326357,
    CopCutscene = 2595446627,
    CrisFormageCutscene = 3253960934,
    CustomerCutscene = 2756669323,
    DaleCutscene = 216536661,
    DaveNortonCutscene = 2240226444,
    DebraCutscene = 3973074921,
    DeniseCutscene = 1870669624,
    DeniseFriendCutscene = 3045926185,
    DevinCutscene = 788622594,
    DomCutscene = 1198698306,
    DreyfussCutscene = 1012965715,
    DrFriedlanderCutscene = 2745392175,
    FabienCutscene = 1191403201,
    FbiSuit01Cutscene = 1482427218,
    FloydCutscene = 103106535,
    FosRepCutscene = 466359675,
    GCutscene = 2727244247,
    GroomCutscene = 2058033618,
    GroveStrDlrCutscene = 3898166818,
    GuadalopeCutscene = 261428209,
    GurkCutscene = 3272931111,
    HaoCutscene = 3969814300,
    HughCutscene = 1863555924,
    HunterCutscene = 1531218220,
    ImranCutscene = 3812756443,
    JackHowitzerCutscene = 1153203121,
    JanetCutscene = 808778210,
    JanitorCutscene = 3254803008,
    JewelassCutscene = 1145088004,
    JimmyBostonCutscene = 60192701,
    JimmyDisantoCutscene = 3100414644,
    JoeMinutemanCutscene = 4036845097,
    JohnnyKlebitzCutscene = 4203395201,
    JosefCutscene = 1167549130,
    JoshCutscene = 1158606749,
    KarenDanielsCutscene = 1269774364,
    LamarDavisCutscene = 1162230285,
    LazlowCutscene = 949295643,
    LesterCrestCutscene = 3046438339,
    Lifeinvad01Cutscene = 1918178165,
    MagentaCutscene = 1477887514,
    ManuelCutscene = 4222842058,
    MarnieCutscene = 1464721716,
    MartinMadrazoCutscene = 1129928304,
    MaryannCutscene = 161007533,
    MaudeCutscene = 3166991819,
    MerryWeatherCutscene = 1631478380,
    MichelleCutscene = 1890499016,
    MiltonCutscene = 3077190415,
    MollyCutscene = 1167167044,
    MoviePremFemaleCutscene = 1270514905,
    MoviePremMaleCutscene = 2372398717,
    MrKCutscene = 3284966005,
    MrsPhillipsCutscene = 3422397391,
    MrsThornhillCutscene = 1334976110,
    NataliaCutscene = 1325314544,
    NervousRonCutscene = 2023152276,
    NigelCutscene = 3779566603,
    OldMan1aCutscene = 518814684,
    OldMan2Cutscene = 2566514544,
    OmegaCutscene = 2339419141,
    OrleansCutscene = 2905870170,
    OrtegaCutscene = 3235579087,
    OscarCutscene = 4095687067,
    PaigeCutscene = 1528799427,
    PaperCutscene = 1798879480,
    PopovCutscene = 1635617250,
    PatriciaCutscene = 3750433537,
    PornDudesCutscene = 793443893,
    PriestCutscene = 1299047806,
    PrologueDriverCutscene = 4027271643,
    PrologueSec01Cutscene = 2141384740,
    PrologueSec02Cutscene = 512955554,
    RampGangCutscene = 3263172030,
    RampHicCutscene = 2240582840,
    RampHipsterCutscene = 569740212,
    RampMarineCutscene = 1634506681,
    RampMexCutscene = 4132362192,
    RashkovskyCutscene = 411081129,
    ReporterCutscene = 776079908,
    RoccoPelosiCutscene = 2858686092,
    RussianDrunkCutscene = 1179785778,
    ScreenWriterCutscene = 2346790124,
    SiemonYetarianCutscene = 3230888450,
    SolomonCutscene = 4140949582,
    SteveHainsCutscene = 2766184958,
    StretchCutscene = 2302502917,
    Stripper01Cutscene = 2934601397,
    Stripper02Cutscene = 2168724337,
    TanishaCutscene = 1123963760,
    TaoChengCutscene = 2288257085,
    TaosTranslatorCutscene = 1397974313,
    TennisCoachCutscene = 1545995274,
    TerryCutscene = 978452933,
    TomCutscene = 1776856003,
    TomEpsilonCutscene = 2349847778,
    TonyaCutscene = 1665391897,
    TracyDisantoCutscene = 101298480,
    TrafficWardenCutscene = 3727243251,
    UndercoverCopCutscene = 4017642090,
    VagosSpeakCutscene = 1224690857,
    WadeCutscene = 3529955798,
    WeiChengCutscene = 819699067,
    ZimborCutscene = 3937184496,
    Boar = 3462393972,
    Cat = 1462895032,
    ChickenHawk = 2864127842,
    Chimp = 2825402133,
    Chop = 351016938,
    Cormorant = 1457690978,
    Cow = 4244282910,
    Coyote = 1682622302,
    Crow = 402729631,
    Deer = 3630914197,
    Dolphin = 2344268885,
    Fish = 802685111,
    Hen = 1794449327,
    HammerShark = 1015224100,
    Humpback = 1193010354,
    Husky = 1318032802,
    KillerWhale = 2374682809,
    MountainLion = 307287994,
    Pig = 2971380566,
    Pigeon = 111281960,
    Poodle = 1125994524,
    Pug = 1832265812,
    Rabbit = 3753204865,
    Rat = 3283429734,
    Retriever = 882848737,
    Rhesus = 3268439891,
    Rottweiler = 2506301981,
    Seagull = 3549666813,
    Shepherd = 1126154828,
    Stingray = 2705875277,
    TigerShark = 113504370,
    Westy = 2910340283,
    Abner = 4037813798,
    AlDiNapoli = 4042020578,
    Antonb = 3479321132,
    Armoured01 = 3455013896,
    Babyd = 3658575486,
    Bankman01 = 3272005365,
    Baygor = 1380197501,
    Benny = 3300333010,
    BikeHire01 = 1984382277,
    BikerChic = 4198014287,
    BoatStaff01M = 3361671816,
    BoatStaff01F = 848542878,
    BurgerDrug = 2340239206,
    Chip = 610290475,
    Claude01 = 3237179831,
    ClubHouseBar01 = 1914945105,
    CocaineFemale01 = 1897303236,
    CocaineMale01 = 3455927962,
    ComJane = 3064628686,
    Corpse01 = 773063444,
    Corpse02 = 228356856,
    CounterfeitFemale01 = 1074385436,
    CounterfeitMale01 = 2625926338,
    Cyclist01 = 755956971,
    DeadHooker = 1943971979,
    Drowned = 1943971979,
    ExArmy01 = 1161072059,
    ExecutivePAMale01 = 983887149,
    ExecutivePAFemale01 = 2913175640,
    Famdd01 = 866411749,
    FibArchitect = 874722259,
    FibMugger01 = 2243544680,
    FibSec01 = 1558115333,
    FilmDirector = 728636342,
    FilmNoir = 732742363,
    Finguru01 = 1189322339,
    ForgeryFemale01 = 3691903615,
    ForgeryMale01 = 325317957,
    FreemodeFemale01 = 2627665880,
    FreemodeMale01 = 1885233650,
    Glenstank01 = 1169888870,
    Griff01 = 3293887675,
    Guido01 = 3333724719,
    GunVend01 = 3005388626,
    Hacker = 2579169528,
    HeliStaff01 = 431423238,
    Hippie01 = 4030826507,
    Hotposh01 = 2526768638,
    Imporage = 880829941,
    Jesus01 = 3459037009,
    Jewelass01 = 4040474158,
    JewelSec01 = 2899099062,
    JewelThief = 3872144604,
    Justin = 2109968527,
    Mani = 3367706194,
    Markfost = 479578891,
    Marston01 = 943915367,
    MethFemale01 = 3778572496,
    MethMale01 = 1293671805,
    MilitaryBum = 1191548746,
    Miranda = 1095737979,
    Mistress = 1573528872,
    Misty01 = 3509125021,
    MovieStar = 894928436,
    MPros01 = 1822283721,
    Niko01 = 4007317449,
    Paparazzi = 1346941736,
    Party01 = 921110016,
    PartyTarget = 2180468199,
    PestContDriver = 994527967,
    PestContGunman = 193469166,
    Pogo01 = 3696858125,
    Poppymich = 602513566,
    Princess = 3538133636,
    Prisoner01 = 2073775040,
    PrologueHostage01 = 3306347811,
    PrologueMournFemale01 = 2718472679,
    PrologueMournMale01 = 3465937675,
    RivalPaparazzi = 1624626906,
    ShopKeep01 = 416176080,
    SpyActor = 2886641112,
    SpyActress = 1535236204,
    StripperLite = 695248020,
    Taphillbilly = 2585681490,
    Tramp01 = 1787764635,
    VagosFun01 = 3299219389,
    WillyFist = 2423691919,
    WeedFemale01 = 1596374223,
    WeedMale01 = 2648833641,
    Zombie01 = 2890614022,
    Acult01AMM = 1413662315,
    Acult01AMO = 1430544400,
    Acult01AMY = 3043264555,
    Acult02AMO = 1268862154,
    Acult02AMY = 2162532142,
    AfriAmer01AMM = 3513928062,
    Airhostess01SFY = 1567728751,
    AirworkerSMY = 1644266841,
    Ammucity01SMY = 2651349821,
    AmmuCountrySMM = 233415434,
    ArmBoss01GMM = 4058522530,
    ArmGoon01GMM = 4255728232,
    ArmGoon02GMY = 3310258058,
    ArmLieut01GMM = 3882958867,
    Armoured01SMM = 2512875213,
    Armoured02SMM = 1669696074,
    Armymech01SMY = 1657546978,
    Autopsy01SMY = 2988916046,
    Autoshop01SMM = 68070371,
    Autoshop02SMM = 4033578141,
    Azteca01GMY = 1752208920,
    BallaEast01GMY = 4096714883,
    BallaOrig01GMY = 588969535,
    Ballas01GFY = 361513884,
    BallaSout01GMY = 599294057,
    Barman01SMY = 3852538118,
    Bartender01SFY = 2014052797,
    Baywatch01SFY = 1250841910,
    Baywatch01SMY = 189425762,
    Beach01AFM = 808859815,
    Beach01AFY = 3349113128,
    Beach01AMM = 1077785853,
    Beach01AMO = 2217202584,
    Beach01AMY = 3523131524,
    Beach02AMM = 2021631368,
    Beach02AMY = 600300561,
    Beach03AMY = 3886638041,
    Beachvesp01AMY = 2114544056,
    Beachvesp02AMY = 3394697810,
    Bevhills01AFM = 3188223741,
    Bevhills01AFY = 1146800212,
    Bevhills01AMM = 1423699487,
    Bevhills01AMY = 1982350912,
    Bevhills02AFM = 2688103263,
    Bevhills02AFY = 1546450936,
    Bevhills02AMM = 1068876755,
    Bevhills02AMY = 1720428295,
    Bevhills03AFY = 549978415,
    Bevhills04AFY = 920595805,
    Blackops01SMY = 3019107892,
    Blackops02SMY = 2047212121,
    Blackops03SMY = 1349953339,
    Bodybuild01AFM = 1004114196,
    Bouncer01SMM = 2681481517,
    Breakdance01AMY = 933205398,
    Busboy01SMY = 3640249671,
    Busicas01AMY = 2597531625,
    Business01AFY = 664399832,
    Business01AMM = 2120901815,
    Business01AMY = 3382649284,
    Business02AFM = 532905404,
    Business02AFY = 826475330,
    Business02AMY = 3014915558,
    Business03AFY = 2928082356,
    Business03AMY = 2705543429,
    Business04AFY = 3083210802,
    Busker01SMO = 2912874939,
    CCrew01SMM = 3387290987,
    Chef01SMY = 261586155,
    ChemSec01SMM = 788443093,
    ChemWork01GMM = 4128603535,
    ChiBoss01GMM = 3118269184,
    ChiCold01GMM = 275618457,
    ChiGoon01GMM = 2119136831,
    ChiGoon02GMM = 4285659174,
    CiaSec01SMM = 1650288984,
    Clown01SMY = 71929310,
    Cntrybar01SMM = 436345731,
    Construct01SMY = 3621428889,
    Construct02SMY = 3321821918,
    Cop01SFY = 368603149,
    Cop01SMY = 1581098148,
    Cyclist01AMY = 4257633223,
    Dealer01SMY = 3835149295,
    Devinsec01SMY = 2606068340,
    Dhill01AMY = 4282288299,
    Dockwork01SMM = 349680864,
    Dockwork01SMY = 2255894993,
    Doctor01SMM = 3564307372,
    Doorman01SMY = 579932932,
    Downtown01AFM = 1699403886,
    Downtown01AMY = 766375082,
    DwService01SMY = 1976765073,
    DwService02SMY = 4119890438,
    Eastsa01AFM = 2638072698,
    Eastsa01AFY = 4121954205,
    Eastsa01AMM = 4188468543,
    Eastsa01AMY = 2756120947,
    Eastsa02AFM = 1674107025,
    Eastsa02AFY = 70821038,
    Eastsa02AMM = 131961260,
    Eastsa02AMY = 377976310,
    Eastsa03AFY = 1371553700,
    Epsilon01AFY = 1755064960,
    Epsilon01AMY = 2010389054,
    Epsilon02AMY = 2860711835,
    Factory01SFY = 1777626099,
    Factory01SMY = 1097048408,
    Famca01GMY = 3896218551,
    Famdnf01GMY = 3681718840,
    Famfor01GMY = 2217749257,
    Families01GFY = 1309468115,
    Farmer01AMM = 2488675799,
    FatBla01AFM = 4206136267,
    FatCult01AFM = 3050275044,
    Fatlatin01AMM = 1641152947,
    FatWhite01AFM = 951767867,
    FemBarberSFM = 373000027,
    FibOffice01SMM = 3988550982,
    FibOffice02SMM = 653289389,
    FibSec01SMM = 2072724299,
    Fireman01SMY = 3065114024,
    Fitness01AFY = 1165780219,
    Fitness02AFY = 331645324,
    Gaffer01SMM = 2841034142,
    GarbageSMY = 4000686095,
    Gardener01SMM = 1240094341,
    Gay01AMY = 3519864886,
    Gay02AMY = 2775713665,
    Genfat01AMM = 115168927,
    Genfat02AMM = 330231874,
    Genhot01AFY = 793439294,
    Genstreet01AFO = 1640504453,
    Genstreet01AMO = 2908022696,
    Genstreet01AMY = 2557996913,
    Genstreet02AMY = 891398354,
    GentransportSMM = 411102470,
    Golfer01AFY = 2111372120,
    Golfer01AMM = 2850754114,
    Golfer01AMY = 3609190705,
    Grip01SMY = 815693290,
    Hairdress01SMM = 1099825042,
    Hasjew01AMM = 1809430156,
    Hasjew01AMY = 3782053633,
    Highsec01SMM = 4049719826,
    Highsec02SMM = 691061163,
    Hiker01AFY = 813893651,
    Hiker01AMY = 1358380044,
    Hillbilly01AMM = 1822107721,
    Hillbilly02AMM = 2064532783,
    Hippie01AFY = 343259175,
    Hippy01AMY = 2097407511,
    Hipster01AFY = 2185745201,
    Hipster01AMY = 587703123,
    Hipster02AFY = 2549481101,
    Hipster02AMY = 349505262,
    Hipster03AFY = 2780469782,
    Hipster03AMY = 1312913862,
    Hipster04AFY = 429425116,
    Hooker01SFY = 42647445,
    Hooker02SFY = 348382215,
    Hooker03SFY = 51789996,
    Hwaycop01SMY = 1939545845,
    Indian01AFO = 3134700416,
    Indian01AFY = 153984193,
    Indian01AMM = 3721046572,
    Indian01AMY = 706935758,
    JanitorSMM = 2842417644,
    Jetski01AMY = 767028979,
    Juggalo01AFY = 3675473203,
    Juggalo01AMY = 2445950508,
    KorBoss01GMM = 891945583,
    Korean01GMY = 611648169,
    Korean02GMY = 2414729609,
    KorLieut01GMY = 2093736314,
    Ktown01AFM = 1388848350,
    Ktown01AFO = 1204772502,
    Ktown01AMM = 3512565361,
    Ktown01AMO = 355916122,
    Ktown01AMY = 452351020,
    Ktown02AFM = 1090617681,
    Ktown02AMY = 696250687,
    Lathandy01SMM = 2659242702,
    Latino01AMY = 321657486,
    Lifeinvad01SMM = 3724572669,
    LinecookSMM = 3684436375,
    Lost01GFY = 4250220510,
    Lost01GMY = 1330042375,
    Lost02GMY = 1032073858,
    Lost03GMY = 850468060,
    Lsmetro01SMM = 1985653476,
    Maid01SFM = 3767780806,
    Malibu01AMM = 803106487,
    Mariachi01SMM = 2124742566,
    Marine01SMM = 4074414829,
    Marine01SMY = 1702441027,
    Marine02SMM = 4028996995,
    Marine02SMY = 1490458366,
    Marine03SMY = 1925237458,
    Methhead01AMY = 1768677545,
    MexBoss01GMM = 1466037421,
    MexBoss02GMM = 1226102803,
    MexCntry01AMM = 3716251309,
    MexGang01GMY = 3185399110,
    MexGoon01GMY = 653210662,
    MexGoon02GMY = 832784782,
    MexGoon03GMY = 2521633500,
    MexLabor01AMM = 2992445106,
    MexThug01AMY = 810804565,
    Migrant01SFY = 3579522037,
    Migrant01SMM = 3977045190,
    MimeSMY = 1021093698,
    Motox01AMY = 1694362237,
    Motox02AMY = 2007797722,
    MovAlien01 = 1684083350,
    MovPrem01SFY = 587253782,
    Movprem01SMM = 3630066984,
    Movspace01SMM = 3887273010,
    Musclbeac01AMY = 1264920838,
    Musclbeac02AMY = 3374523516,
    OgBoss01AMM = 1746653202,
    Paparazzi01AMM = 3972697109,
    Paramedic01SMM = 3008586398,
    PestCont01SMY = 1209091352,
    Pilot01SMM = 3881519900,
    Pilot01SMY = 2872052743,
    Pilot02SMM = 4131252449,
    PoloGoon01GMY = 1329576454,
    PoloGoon02GMY = 2733138262,
    Polynesian01AMM = 2849617566,
    Polynesian01AMY = 2206530719,
    Postal01SMM = 1650036788,
    Postal02SMM = 1936142927,
    Prisguard01SMM = 1456041926,
    PrisMuscl01SMY = 1596003233,
    Prisoner01SMY = 2981862233,
    PrologueHostage01AFM = 379310561,
    PrologueHostage01AMM = 2534589327,
    Ranger01SFY = 2680682039,
    Ranger01SMY = 4017173934,
    Roadcyc01AMY = 4116817094,
    Robber01SMY = 3227390873,
    RsRanger01AMO = 1011059922,
    Runner01AFY = 3343476521,
    Runner01AMY = 623927022,
    Runner02AMY = 2218630415,
    Rurmeth01AFY = 1064866854,
    Rurmeth01AMM = 1001210244,
    Salton01AFM = 3725461865,
    Salton01AFO = 3439295882,
    Salton01AMM = 1328415626,
    Salton01AMO = 539004493,
    Salton01AMY = 3613420592,
    Salton02AMM = 1626646295,
    Salton03AMM = 2995538501,
    Salton04AMM = 2521108919,
    SalvaBoss01GMY = 2422005962,
    SalvaGoon01GMY = 663522487,
    SalvaGoon02GMY = 846439045,
    SalvaGoon03GMY = 62440720,
    SbikeAMO = 1794381917,
    Scdressy01AFY = 3680420864,
    Scientist01SMM = 1092080539,
    Scrubs01SFY = 2874755766,
    Security01SMM = 3613962792,
    Sheriff01SFY = 1096929346,
    Sheriff01SMY = 2974087609,
    ShopHighSFM = 2923947184,
    ShopLowSFY = 2842568196,
    ShopMaskSMY = 1846684678,
    ShopMidSFY = 1055701597,
    Skater01AFY = 1767892582,
    Skater01AMM = 3654768780,
    Skater01AMY = 3250873975,
    Skater02AMY = 2952446692,
    Skidrow01AFM = 2962707003,
    Skidrow01AMM = 32417469,
    Snowcop01SMM = 451459928,
    Socenlat01AMM = 193817059,
    Soucent01AFM = 1951946145,
    Soucent01AFO = 1039800368,
    Soucent01AFY = 744758650,
    Soucent01AMM = 1750583735,
    Soucent01AMO = 718836251,
    Soucent01AMY = 3877027275,
    Soucent02AFM = 4079145784,
    Soucent02AFO = 2775443222,
    Soucent02AFY = 1519319503,
    Soucent02AMM = 2674735073,
    Soucent02AMO = 1082572151,
    Soucent02AMY = 2896414922,
    Soucent03AFY = 2276611093,
    Soucent03AMM = 2346291386,
    Soucent03AMO = 238213328,
    Soucent03AMY = 3287349092,
    Soucent04AMM = 3271294718,
    Soucent04AMY = 2318861297,
    Soucentmc01AFM = 3454621138,
    Staggrm01AMO = 2442448387,
    Stbla01AMY = 3482496489,
    Stbla02AMY = 2563194959,
    Stlat01AMY = 2255803900,
    Stlat02AMM = 3265820418,
    Stripper01SFY = 1381498905,
    Stripper02SFY = 1846523796,
    StripperLiteSFY = 1544875514,
    Strperf01SMM = 2035992488,
    Strpreach01SMM = 469792763,
    StrPunk01GMY = 4246489531,
    StrPunk02GMY = 228715206,
    Strvend01SMM = 3465614249,
    Strvend01SMY = 2457805603,
    Stwhi01AMY = 605602864,
    Stwhi02AMY = 919005580,
    Sunbathe01AMY = 3072929548,
    Surfer01AMY = 3938633710,
    Swat01SMY = 2374966032,
    Sweatshop01SFM = 824925120,
    Sweatshop01SFY = 2231547570,
    Tattoo01AMO = 2494442380,
    Tennis01AFY = 1426880966,
    Tennis01AMM = 1416254276,
    Topless01AFY = 2633130371,
    Tourist01AFM = 1347814329,
    Tourist01AFY = 1446741360,
    Tourist01AMM = 3365863812,
    Tourist02AFY = 2435054400,
    Tramp01AFM = 1224306523,
    Tramp01AMM = 516505552,
    Tramp01AMO = 390939205,
    TrampBeac01AFM = 2359345766,
    TrampBeac01AMM = 1404403376,
    Tranvest01AMM = 3773208948,
    Tranvest02AMM = 4144940484,
    Trucker01SMM = 1498487404,
    Ups01SMM = 2680389410,
    Ups02SMM = 3502104854,
    Uscg01SMY = 3389018345,
    Vagos01GFY = 1520708641,
    Valet01SMY = 999748158,
    Vindouche01AMY = 3247667175,
    Vinewood01AFY = 435429221,
    Vinewood01AMY = 1264851357,
    Vinewood02AFY = 3669401835,
    Vinewood02AMY = 1561705728,
    Vinewood03AFY = 933092024,
    Vinewood03AMY = 534725268,
    Vinewood04AFY = 4209271110,
    Vinewood04AMY = 835315305,
    Waiter01SMY = 2907468364,
    WinClean01SMY = 1426951581,
    Xmech01SMY = 1142162924,
    Xmech02SMY = 3189832196,
    Xmech02SMYMP = 1755203590,
    Yoga01AFY = 3290105390,
    Yoga01AMY = 2869588309,
}


VehicleHash = {
    Adder = 3078201489,
    Airbus = 1283517198,
    Airtug = 1560980623,
    Akuma = 1672195559,
    Alpha = 767087018,
    Ambulance = 1171614426,
    Annihilator = 837858166,
    Apc = 562680400,
    Ardent = 159274291,
    ArmyTanker = 3087536137,
    ArmyTrailer = 2818520053,
    ArmyTrailer2 = 2657817814,
    Asea = 2485144969,
    Asea2 = 2487343317,
    Asterope = 2391954683,
    Avarus = 2179174271,
    Bagger = 2154536131,
    BaleTrailer = 3895125590,
    Baller = 3486135912,
    Baller2 = 142944341,
    Baller3 = 1878062887,
    Baller4 = 634118882,
    Baller5 = 470404958,
    Baller6 = 666166960,
    Banshee = 3253274834,
    Banshee2 = 633712403,
    Barracks = 3471458123,
    Barracks2 = 1074326203,
    Barracks3 = 630371791,
    Bati = 4180675781,
    Bati2 = 3403504941,
    Benson = 2053223216,
    Besra = 1824333165,
    BestiaGTS = 1274868363,
    BF400 = 86520421,
    BfInjection = 1126868326,
    Biff = 850991848,
    Bifta = 3945366167,
    Bison = 4278019151,
    Bison2 = 2072156101,
    Bison3 = 1739845664,
    BJXL = 850565707,
    Blade = 3089165662,
    Blazer = 2166734073,
    Blazer2 = 4246935337,
    Blazer3 = 3025077634,
    Blazer4 = 3854198872,
    Blazer5 = 2704629607,
    Blimp = 4143991942,
    Blimp2 = 3681241380,
    Blista = 3950024287,
    Blista2 = 1039032026,
    Blista3 = 3703315515,
    Bmx = 1131912276,
    BoatTrailer = 524108981,
    BobcatXL = 1069929536,
    Bodhi2 = 2859047862,
    Boxville = 2307837162,
    Boxville2 = 4061868990,
    Boxville3 = 121658888,
    Boxville4 = 444171386,
    Boxville5 = 682434785,
    Brawler = 2815302597,
    Brickade = 3989239879,
    Brioso = 1549126457,
    BType = 117401876,
    BType2 = 3463132580,
    BType3 = 3692679425,
    Buccaneer = 3612755468,
    Buccaneer2 = 3281516360,
    Buffalo = 3990165190,
    Buffalo2 = 736902334,
    Buffalo3 = 237764926,
    Bulldozer = 1886712733,
    Bullet = 2598821281,
    Burrito = 2948279460,
    Burrito2 = 3387490166,
    Burrito3 = 2551651283,
    Burrito4 = 893081117,
    Burrito5 = 1132262048,
    Bus = 3581397346,
    Buzzard = 788747387,
    Buzzard2 = 745926877,
    CableCar = 3334677549,
    Caddy = 1147287684,
    Caddy2 = 3757070668,
    Caddy3 = 3525819835,
    Camper = 1876516712,
    Carbonizzare = 2072687711,
    CarbonRS = 11251904,
    Cargobob = 4244420235,
    Cargobob2 = 1621617168,
    Cargobob3 = 1394036463,
    Cargobob4 = 2025593404,
    CargoPlane = 368211810,
    Casco = 941800958,
    Cavalcade = 2006918058,
    Cavalcade2 = 3505073125,
    Cheetah = 2983812512,
    Cheetah2 = 223240013,
    Chimera = 6774487,
    Chino = 349605904,
    Chino2 = 2933279331,
    Cliffhanger = 390201602,
    Coach = 2222034228,
    Cog55 = 906642318,
    Cog552 = 704435172,
    CogCabrio = 330661258,
    Cognoscenti = 2264796000,
    Cognoscenti2 = 3690124666,
    Comet2 = 3249425686,
    Comet3 = 2272483501,
    Contender = 683047626,
    Coquette = 108773431,
    Coquette2 = 1011753235,
    Coquette3 = 784565758,
    Cruiser = 448402357,
    Crusader = 321739290,
    Cuban800 = 3650256867,
    Cutter = 3288047904,
    Daemon = 2006142190,
    Daemon2 = 2890830793,
    Defiler = 822018448,
    Diablous = 4055125828,
    Diablous2 = 1790834270,
    Dilettante = 3164157193,
    Dilettante2 = 1682114128,
    Dinghy = 1033245328,
    Dinghy2 = 276773164,
    Dinghy3 = 509498602,
    Dinghy4 = 867467158,
    DLoader = 1770332643,
    DockTrailer = 2154757102,
    Docktug = 3410276810,
    Dodo = 3393804037,
    Dominator = 80636076,
    Dominator2 = 3379262425,
    Double = 2623969160,
    Dubsta = 1177543287,
    Dubsta2 = 3900892662,
    Dubsta3 = 3057713523,
    Dukes = 723973206,
    Dukes2 = 3968823444,
    Dump = 2164484578,
    Dune = 2633113103,
    Dune2 = 534258863,
    Dune3 = 1897744184,
    Dune4 = 3467805257,
    Dune5 = 3982671785,
    Duster = 970356638,
    Elegy = 196747873,
    Elegy2 = 3728579874,
    Emperor = 3609690755,
    Emperor2 = 2411965148,
    Emperor3 = 3053254478,
    Enduro = 1753414259,
    EntityXF = 3003014393,
    Esskey = 2035069708,
    Exemplar = 4289813342,
    F620 = 3703357000,
    Faction = 2175389151,
    Faction2 = 2504420315,
    Faction3 = 2255212070,
    Faggio = 2452219115,
    Faggio2 = 55628203,
    Faggio3 = 3005788552,
    FBI = 1127131465,
    FBI2 = 2647026068,
    FCR = 627535535,
    FCR2 = 3537231886,
    Felon = 3903372712,
    Felon2 = 4205676014,
    Feltzer2 = 2299640309,
    Feltzer3 = 2728226064,
    FireTruk = 1938952078,
    Fixter = 3458454463,
    Flatbed = 1353720154,
    Forklift = 1491375716,
    FMJ = 1426219628,
    FQ2 = 3157435195,
    Freight = 1030400667,
    FreightCar = 184361638,
    FreightCont1 = 920453016,
    FreightCont2 = 240201337,
    FreightGrain = 642617954,
    FreightTrailer = 3517691494,
    Frogger = 744705981,
    Frogger2 = 1949211328,
    Fugitive = 1909141499,
    Furoregt = 3205927392,
    Fusilade = 499169875,
    Futo = 2016857647,
    Gargoyle = 741090084,
    Gauntlet = 2494797253,
    Gauntlet2 = 349315417,
    GBurrito = 2549763894,
    GBurrito2 = 296357396,
    Glendale = 75131841,
    GP1 = 1234311532,
    GrainTrailer = 1019737494,
    Granger = 2519238556,
    Gresley = 2751205197,
    Guardian = 2186977100,
    Habanero = 884422927,
    Hakuchou = 1265391242,
    Hakuchou2 = 4039289119,
    HalfTrack = 4262731174,
    Handler = 444583674,
    Hauler = 1518533038,
    Hauler2 = 387748548,
    Hexer = 301427732,
    Hotknife = 37348240,
    Huntley = 486987393,
    Hydra = 970385471,
    Infernus = 418536135,
    Infernus2 = 2889029532,
    Ingot = 3005245074,
    Innovation = 4135840458,
    Insurgent = 2434067162,
    Insurgent2 = 2071877360,
    Insurgent3 = 2370534026,
    Intruder = 886934177,
    Issi2 = 3117103977,
    ItaliGTB = 2246633323,
    ItaliGTB2 = 3812247419,
    Jackal = 3670438162,
    JB700 = 1051415893,
    Jester = 2997294755,
    Jester2 = 3188613414,
    Jet = 1058115860,
    Jetmax = 861409633,
    Journey = 4174679674,
    Kalahari = 92612664,
    Khamelion = 544021352,
    Kuruma = 2922118804,
    Kuruma2 = 410882957,
    Landstalker = 1269098716,
    Lazer = 3013282534,
    LE7B = 3062131285,
    Lectro = 640818791,
    Lguard = 469291905,
    Limo2 = 4180339789,
    Lurcher = 2068293287,
    Luxor = 621481054,
    Luxor2 = 3080673438,
    Lynx = 482197771,
    Mamba = 2634021974,
    Mammatus = 2548391185,
    Manana = 2170765704,
    Manchez = 2771538552,
    Marquis = 3251507587,
    Marshall = 1233534620,
    Massacro = 4152024626,
    Massacro2 = 3663206819,
    Maverick = 2634305738,
    Mesa = 914654722,
    Mesa2 = 3546958660,
    Mesa3 = 2230595153,
    MetroTrain = 868868440,
    Miljet = 165154707,
    Minivan = 3984502180,
    Minivan2 = 3168702960,
    Mixer = 3510150843,
    Mixer2 = 475220373,
    Monroe = 3861591579,
    Monster = 3449006043,
    Moonbeam = 525509695,
    Moonbeam2 = 1896491931,
    Mower = 1783355638,
    Mule = 904750859,
    Mule2 = 3244501995,
    Mule3 = 2242229361,
    Nemesis = 3660088182,
    Nero = 1034187331,
    Nero2 = 1093792632,
    Nightblade = 2688780135,
    Nightshade = 2351681756,
    NightShark = 433954513,
    Nimbus = 2999939664,
    Ninef = 1032823388,
    Ninef2 = 2833484545,
    Omnis = 3517794615,
    Oppressor = 884483972,
    Oracle = 1348744438,
    Oracle2 = 3783366066,
    Osiris = 1987142870,
    Packer = 569305213,
    Panto = 3863274624,
    Paradise = 1488164764,
    Patriot = 3486509883,
    PBus = 2287941233,
    PCJ = 3385765638,
    Penetrator = 2536829930,
    Penumbra = 3917501776,
    Peyote = 1830407356,
    Pfister811 = 2465164804,
    Phantom = 2157618379,
    Phantom2 = 2645431192,
    Phantom3 = 177270108,
    Phoenix = 2199527893,
    Picador = 1507916787,
    Pigalle = 1078682497,
    Police = 2046537925,
    Police2 = 2667966721,
    Police3 = 1912215274,
    Police4 = 2321795001,
    Policeb = 4260343491,
    PoliceOld1 = 2758042359,
    PoliceOld2 = 2515846680,
    PoliceT = 456714581,
    Polmav = 353883353,
    Pony = 4175309224,
    Pony2 = 943752001,
    Pounder = 2112052861,
    Prairie = 2844316578,
    Pranger = 741586030,
    Predator = 3806844075,
    Premier = 2411098011,
    Primo = 3144368207,
    Primo2 = 2254540506,
    PropTrailer = 356391690,
    Prototipo = 2123327359,
    Radi = 2643899483,
    RakeTrailer = 390902130,
    RancherXL = 1645267888,
    RancherXL2 = 1933662059,
    RallyTruck = 2191146052,
    RapidGT = 2360515092,
    RapidGT2 = 1737773231,
    Raptor = 3620039993,
    RatBike = 1873600305,
    RatLoader = 3627815886,
    RatLoader2 = 3705788919,
    Reaper = 234062309,
    Rebel = 3087195462,
    Rebel2 = 2249373259,
    Regina = 4280472072,
    RentalBus = 3196165219,
    Rhapsody = 841808271,
    Rhino = 782665360,
    Riot = 3089277354,
    Ripley = 3448987385,
    Rocoto = 2136773105,
    Romero = 627094268,
    Rubble = 2589662668,
    Ruffian = 3401388520,
    Ruiner = 4067225593,
    Ruiner2 = 941494461,
    Ruiner3 = 777714999,
    Rumpo = 1162065741,
    Rumpo2 = 2518351607,
    Rumpo3 = 1475773103,
    Ruston = 719660200,
    SabreGT = 2609945748,
    SabreGT2 = 223258115,
    Sadler = 3695398481,
    Sadler2 = 734217681,
    Sanchez = 788045382,
    Sanchez2 = 2841686334,
    Sanctus = 1491277511,
    Sandking = 3105951696,
    Sandking2 = 989381445,
    Savage = 4212341271,
    Schafter2 = 3039514899,
    Schafter3 = 2809443750,
    Schafter4 = 1489967196,
    Schafter5 = 3406724313,
    Schafter6 = 1922255844,
    Schwarzer = 3548084598,
    Scorcher = 4108429845,
    Scrap = 2594165727,
    Seashark = 3264692260,
    Seashark2 = 3678636260,
    Seashark3 = 3983945033,
    Seminole = 1221512915,
    Sentinel = 1349725314,
    Sentinel2 = 873639469,
    Serrano = 1337041428,
    Seven70 = 2537130571,
    Shamal = 3080461301,
    Sheava = 819197656,
    Sheriff = 2611638396,
    Sheriff2 = 1922257928,
    Shotaro = 3889340782,
    Skylift = 1044954915,
    SlamVan = 729783779,
    SlamVan2 = 833469436,
    SlamVan3 = 1119641113,
    Sovereign = 743478836,
    Specter = 1886268224,
    Specter2 = 1074745671,
    Speeder = 231083307,
    Speeder2 = 437538602,
    Speedo = 3484649228,
    Speedo2 = 728614474,
    Squalo = 400514754,
    Stalion = 1923400478,
    Stalion2 = 3893323758,
    Stanier = 2817386317,
    Stinger = 1545842587,
    StingerGT = 2196019706,
    Stockade = 1747439474,
    Stockade3 = 4080511798,
    Stratum = 1723137093,
    Stretch = 2333339779,
    Stunt = 2172210288,
    Submersible = 771711535,
    Submersible2 = 3228633070,
    Sultan = 970598228,
    SultanRS = 3999278268,
    Suntrap = 4012021193,
    Superd = 1123216662,
    Supervolito = 710198397,
    Supervolito2 = 2623428164,
    Surano = 384071873,
    Surfer = 699456151,
    Surfer2 = 2983726598,
    Surge = 2400073108,
    Swift2 = 1075432268,
    Swift = 3955379698,
    T20 = 1663218586,
    Taco = 1951180813,
    Tailgater = 3286105550,
    Tampa = 972671128,
    Tampa2 = 3223586949,
    Tampa3 = 3084515313,
    Tanker = 3564062519,
    Tanker2 = 1956216962,
    TankerCar = 586013744,
    Taxi = 3338918751,
    Technical = 2198148358,
    Technical2 = 1180875963,
    Technical3 = 1356124575,
    Tempesta = 272929391,
    Thrust = 1836027715,
    TipTruck = 48339065,
    TipTruck2 = 3347205726,
    Titan = 1981688531,
    Torero = 1504306544,
    Tornado = 464687292,
    Tornado2 = 1531094468,
    Tornado3 = 1762279763,
    Tornado4 = 2261744861,
    Tornado5 = 2497353967,
    Tornado6 = 2736567667,
    Toro = 1070967343,
    Toro2 = 908897389,
    Tourbus = 1941029835,
    TowTruck = 2971866336,
    TowTruck2 = 3852654278,
    TR2 = 2078290630,
    TR3 = 1784254509,
    TR4 = 2091594960,
    Tractor = 1641462412,
    Tractor2 = 2218488798,
    Tractor3 = 1445631933,
    TrailerLogs = 2016027501,
    TrailerLarge = 1502869817,
    Trailers = 3417488910,
    Trailers2 = 2715434129,
    Trailers3 = 2236089197,
    Trailers4 = 3194418602,
    TrailerSmall = 712162987,
    TrailerSmall2 = 2413121211,
    Trash = 1917016601,
    Trash2 = 3039269212,
    TRFlat = 2942498482,
    TriBike = 1127861609,
    TriBike2 = 3061159916,
    TriBike3 = 3894672200,
    TrophyTruck = 101905590,
    TrophyTruck2 = 3631668194,
    Tropic = 290013743,
    Tropic2 = 1448677353,
    Tropos = 1887331236,
    Tug = 2194326579,
    Turismor = 408192225,
    Turismo2 = 3312836369,
    TVTrailer = 2524324030,
    Tyrus = 2067820283,
    UtilliTruck = 516990260,
    UtilliTruck2 = 887537515,
    UtilliTruck3 = 2132890591,
    Vacca = 338562499,
    Vader = 4154065143,
    Vagner = 1939284556,
    Valkyrie = 2694714877,
    Valkyrie2 = 1543134283,
    Velum = 2621610858,
    Velum2 = 1077420264,
    Verlierer2 = 1102544804,
    Vestra = 1341619767,
    Vigero = 3469130167,
    Vindicator = 2941886209,
    Virgo = 3796912450,
    Virgo2 = 3395457658,
    Virgo3 = 16646064,
    Volatus = 2449479409,
    Voltic = 2672523198,
    Voltic2 = 989294410,
    Voodoo = 2006667053,
    Voodoo2 = 523724515,
    Vortex = 3685342204,
    Warrener = 1373123368,
    Washington = 1777363799,
    Wastelander = 2382949506,
    Windsor = 1581459400,
    Windsor2 = 2364918497,
    Wolfsbane = 3676349299,
    XA21 = 917809321,
    XLS = 1203490606,
    XLS2 = 3862958888,
    Youga = 65402552,
    Youga2 = 1026149675,
    Zentorno = 2891838741,
    Zion = 3172678083,
    Zion2 = 3101863448,
    ZombieA = 3285698347,
    ZombieB = 3724934023,
    ZType = 758895617,
}


WeaponHash = {
    Knife = 2578778090,
    Nightstick = 1737195953,
    Hammer = 1317494643,
    Bat = 2508868239,
    GolfClub = 1141786504,
    Crowbar = 2227010557,
    Bottle = 4192643659,
    SwitchBlade = 3756226112,
    Pistol = 453432689,
    CombatPistol = 1593441988,
    APPistol = 584646201,
    Pistol50 = 2578377531,
    FlareGun = 1198879012,
    MarksmanPistol = 3696079510,
    Revolver = 3249783761,
    MicroSMG = 324215364,
    SMG = 736523883,
    AssaultSMG = 4024951519,
    CombatPDW = 171789620,
    AssaultRifle = 3220176749,
    CarbineRifle = 2210333304,
    AdvancedRifle = 2937143193,
    CompactRifle = 1649403952,
    MG = 2634544996,
    CombatMG = 2144741730,
    PumpShotgun = 487013001,
    SawnOffShotgun = 2017895192,
    AssaultShotgun = 3800352039,
    BullpupShotgun = 2640438543,
    DoubleBarrelShotgun = 4019527611,
    StunGun = 911657153,
    SniperRifle = 100416529,
    HeavySniper = 205991906,
    GrenadeLauncher = 2726580491,
    GrenadeLauncherSmoke = 1305664598,
    RPG = 2982836145,
    Minigun = 1119849093,
    Grenade = 2481070269,
    StickyBomb = 741814745,
    SmokeGrenade = 4256991824,
    BZGas = 2694266206,
    Molotov = 615608432,
    FireExtinguisher = 101631238,
    PetrolCan = 883325847,
    SNSPistol = 3218215474,
    SpecialCarbine = 3231910285,
    HeavyPistol = 3523564046,
    BullpupRifle = 2132975508,
    HomingLauncher = 1672152130,
    ProximityMine = 2874559379,
    Snowball = 126349499,
    VintagePistol = 137902532,
    Dagger = 2460120199,
    Firework = 2138347493,
    Musket = 2828843422,
    MarksmanRifle = 3342088282,
    HeavyShotgun = 984333226,
    Gusenberg = 1627465347,
    Hatchet = 4191993645,
    Railgun = 1834241177,
    Unarmed = 2725352035,
    KnuckleDuster = 3638508604,
    Machete = 3713923289,
    MachinePistol = 3675956304,
    Flashlight = 2343591895,
    Ball = 600439132,
    Flare = 1233104067,
    NightVision = 2803906140,
    Parachute = 4222310262,
    SweeperShotgun = 317205821,
    BattleAxe = 3441901897,
    CompactGrenadeLauncher = 125959754,
    MiniSMG = 3173288789,
    PipeBomb = 3125143736,
    PoolCue = 2484171525,
    Wrench = 419712736,
    PistolMk2 = 0xbfe256d4,
    AssaultRifleMk2 = 0x394f415c,
    CarbineRifleMk2 = 0xfad1f1c9,
    CombatMGMk2 = 0xdbbd7280,
    HeavySniperMk2 = 0xa914799,
    SMGMk2 = 0x78a97cd0,
}

VehicleWeaponHash = {
    Invalid = -1,
    Tank = 1945616459,
    SpaceRocket = -123497569,
    PlaneRocket = -821520672,
    PlayerLaser = -268631733,
    PlayerBullet = 1259576109,
    PlayerBuzzard = 1186503822,
    PlayerHunter = -1625648674,
    PlayerLazer = -494786007,
    EnemyLaser = 1566990507,
    SearchLight = -844344963,
    Radar = -764006018,
}

AmmoType = {
    Melee = 0,
    FireExtinguisher = 0x5106b43c,
    Flare = 0x6bccf76f,
    FlareGun = 0x45f0e965,
    PetrolCan = 0xca6318a1,
    Shotgun = 0x90083d3b,
    Pistol = 0x743d4f54,
    Ball = 0xff956666,
    Snowball = 0x8218416d,
    Sniper = 0x4c98087b,
    AssaultRifle = 0xd05319f,
    SMG = 0x6c7d23b8,
    Molotov = 0x5633f9d5,
    StunGun = 0xb02eade0,
    MG = 0x6aa1343f,
    GrenadeLauncher = 0x3bcca5ee,
    RPG = 0x67dd81f2,
    Minigun = 0x9fc5c882,
    Firework = 0xaf23ee0f,
    Railgun = 0x794446fd,
    HomingLauncher = 0x99150e2d,
    Grenade = 0x3bd313b1,
    StickyBomb = 0x5424b617,
    ProximityMine = 0xaf2208a7,
    PipeBomb = 0x155663f8,
    SmokeGrenade = 0xe60e08a6,
    BZGas = 0x9b747ea4,
}



ErrorCache = {}

--- @class Error
Error = setmetatable({}, Error)

Error.__index = Error

Error.__call = function()
    return "Error"
end

--- Creates a new instance of the `Error` class
--- @param message string The content of this error message
function Error.new(message)
    local _Error = {
        Message = message
    }
    table.insert(ErrorCache, message)
    return setmetatable(_Error, Error)
end

--- Prints the error message
function Error:Print()
    print("^1" .. self.Message .. "^7")
end


--- @class NotificationString
NotificationString = setmetatable({}, NotificationString)

NotificationString.__index = NotificationString

NotificationString.__call = function()
    return "NotificationString"
end


function NotificationString.new()
    local _NotificationString = {
        Text = ""
    }

    return setmetatable(_NotificationString, NotificationString)
end

function NotificationString:Format(format, text)
    self.Text = self.Text .. format .. text
    return self
end

function NotificationString:Icon(icon)
    self.Text = self.Text .. " " .. icon
    return self
end

function NotificationString:End()
    self.Text = self.Text .. NotifyColors.Default
    return self.Text
end

NotifyColors = {
    Blue = "~b~",
    Green = "~g~",
    Black = "~l~",
    Purple = "~p~",
    Red = "~r~",
    White = "~w~",
    Yellow = "~y~",
    Orange = "~o~",
    Grey = "~c~",
    DarkGrey = "~m~",
    Black = "~u~",
    Default = "~s~",
}

NotifyIcons = {
    WantedStar = "~ws~",
    Verified = "~|~",
    RockStar = "~∑~",
    Lock = "~Ω~",
    Race = "~BLIP_RACE~"
}


Threads = {}

---@class Thread
Thread = setmetatable({}, Thread)

Thread.__call = function()
    return "Thread"
end

Thread.__index = Thread

---@param name string
---@param handler fun(thread: Thread): any
function Thread.new(name, wait, handler)
    if type(tonumber(wait)) ~= "number" then wait = 0 end
    if wait < 0 then wait = 0 end
    local tmpFun = function()

    end
    local _Thread = {
        _Name = name,
        _Handler = handler or tmpFun,
        _Running = false,
        _Wait = wait or 0,
        _Deferral = function()
        end,
        _Stats = {
            LongestRun = 0,
            TimesRun = 0
        }
    }

    return setmetatable(_Thread, Thread)
end

---@param running boolean
function Thread:Running(running)
    if type(running) ~= "boolean" then return self._Running end
    self._Running = running
end

---@param wait number
function Thread:Wait(wait)
    if type(tonumber(wait)) ~= "number" then return self._Wait end
    if wait < 0 then wait = 0 end
    self._Wait = wait
end

---@param handler fun(handler: Thread): any
function Thread:Handler(handler)
    if type(handler) ~= "function" then return self._Handler end
    self._Handler = handler
end

---@param handler fun(handler: Thread): any
function Thread:Deferral(handler)
    if type(handler) ~= "function" then return self._Deferral end
    self._Deferral = handler
end

function Thread:Name()
    return self._Name
end

function Thread:Start()
    if self:Running() == true then print(ColorString.new():RedOrange("thread [" .. self:Name() .. "] already running"):End()) end
    self._Stats.TimesRun = self._Stats.TimesRun + 1
    self:Running(true)
    TriggerEvent('fxl:threadCreated', self:Name())
    Citizen.CreateThread(function()
        while self:Running() == true do
            Citizen.Wait(self:Wait())
            if self:Running() == false then
                break
            end
            local start = GetGameTimer()
            local res = self:Handler()(self)
            local duration = GetGameTimer() - start
            if duration > self._Stats.LongestRun then
                self._Stats.LongestRun = duration
                if self:Wait() > 0 then
                    TriggerEvent('fxl:updateThreadStat', self:Name(), "LongestRun", duration)
                end
            end
        end
        self:Deferral()(self)
    end)
end

function Thread:Stop()
    self:Running(false)
end

if GetCurrentResourceName() == "fxl" then
    AddEventHandler("fxl:threadCreated", function(threadName)
        if Threads[threadName] == nil then
            Threads[threadName] = {
                Runs = 1,
                LongestTime = 0,
                Stats = {}
            }
        else
            Threads[threadName].Runs = Threads[threadName].Runs + 1
        end
    end)

    AddEventHandler("fxl:updateThreadStat", function(threadName, stat, value)
        if Threads[threadName] then
            Threads[threadName].Stats[stat] = value
        end
    end)

    AddEventHandler('fxl:getThread', function(threadName, cb)
        if Threads[threadName] ~= nil then
            if type(cb) == "function" then
                cb(Threads[threadName])
            end
        else
            if type(cb) == "function" then
                cb(nil)
            end
        end
    end)
end


table.contains = function(table, value)
    for k,v in pairs(table) do
        if value == v then
            return true
        end
    end
    return false
end

--- @class Vector3
Vector3 = setmetatable({}, Vector3)

Vector3.__index = Vector3

Vector3.__call = function()
    return "Vector3"
end

--- Creates an instance of the `Vector3` class
--- @param x number
--- @param y number
--- @param z number
function Vector3.new(x, y, z)
    local _Vector3 = {
        X = x + 0.0,
        Y = y + 0.0,
        Z = z + 0.0
    }

    return setmetatable(_Vector3, Vector3)
end

--- Gets the distance between two Vector3
---@param pos Vector3
---@return number
function Vector3:DistanceTo(pos)
    return #(pos:Native() - self:Native())
end

function Vector3:Native()
    return vector3(self.X, self.Y, self.Z)
end

---@param vec Vector3
---@return Vector3
function Vector3:Subtract(vec)
    return Vector3.new(self.X - vec.X, self.Y - vec.Y, self.Z - vec.Z)
end

---@param vec Vector3|number
function Vector3:Add(vec)
    ---@type number|nil
    local fvec = tonumber(vec)
    if type(fvec) == "number" then
        return Vector3.new(self.X + fvec, self.Y + fvec, self.Z + fvec)
    end
    return Vector3.new(self.X + vec.X, self.Y + vec.Y, self.Z + vec.Z)
end

function Vector3:Multiply(vec)
    local fvec = tonumber(vec)
    if type(fvec) == "number" then
        return Vector3.new(self.X * fvec, self.Y * fvec, self.Z * fvec)
    end

    return Vector3.new(self.X * vec.X, self.Y * vec.Y, self.Z * vec.Z)
end

function Vector3:Divide(vec)
    local fvec = tonumber(vec)
    if type(fvec) == "number" then
        return Vector3.new(self.X / vec, self.Y / vec, self.Z / vec)
    end
    return Vector3.new(self.X / vec.X, self.Y / vec.Y, self.Z / vec.Z)
end

function Vector3:DotProduct(vec)
    return self.X * vec.X + self.Y + vec.Y, self.Z + vec.Z
end

function Vector3:CrossProduct(vec)
    local x = self.Y * vec.Z - self.Z * vec.Y;
    local y = self.Y * vec.x - self.Z * vec.Y;
    local z = self.Y * vec.y - self.Z * vec.X;

    return Vector3.new(x,y,z)
end

function Vector3:DistanceSquared(vec)
    local nvec = self:Subtract(vec)
    return self:DotProduct(nvec)
end

function Vector3:Length()
    return self:DistanceSquared(self)
end

function Vector3:Normalize()
    return self:Divide(self, self:Length())
end

---@class Vec3
Vec3 = {
    ---@type number
    x = 0,
    ---@type number
    x = 0,
    ---@type number
    x = 0
}


