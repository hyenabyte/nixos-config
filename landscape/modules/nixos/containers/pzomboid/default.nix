{
  lib,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.containers.pzomboid;
in {
  options.${namespace}.containers.pzomboid = with types; {
    enable = mkEnableOption "pzomboid";
    configPath = mkOpt str "/home/hyena/pzomboid" "The config folder path";
    serverName = mkOpt str "My Zomboid Server" "The server name";
  };
  config = mkIf cfg.enable {
    # Open ports in the firewall.
    networking.firewall.allowedTCPPorts = [27015];
    networking.firewall.allowedUDPPorts = [16261 16262];

    # Container
    virtualisation.oci-containers.containers = {
      pzomboid = {
        image = "renegademaster/zomboid-dedicated-server:latest";
        ports = [
          "16261:16261/udp"
          "16262:16262/udp"
          "27015:27015/tcp"
        ];
        volumes = [
          # TODO: figure out how to place these somewhere sane
          "${cfg.configPath}/ZomboidDedicatedServer:/home/steam/ZomboidDedicatedServer"
          "${cfg.configPath}/ZomboidConfig:/home/steam/Zomboid/"
        ];
        environment = {
          SERVER_NAME = cfg.serverName;
          AUTOSAVE_INTERVAL = "15";
          BIND_IP = "0.0.0.0";
          DEFAULT_PORT = "16261";
          GAME_VERSION = "public";
          GC_CONFIG = "ZGC";
          MAP_NAMES = "Muldraugh, KY";
          MAX_PLAYERS = "16";
          PAUSE_ON_EMPTY = "true";
          PUBLIC_SERVER = "true";
          RCON_PORT = "27015";
          STEAM_VAC = "false";
          TZ = "UTC";
          UDP_PORT = "16262";
          USE_STEAM = "true";

          MOD_NAMES = "49powerWagon;49ford8N;59meteor;ECTO1;63beetle;63Type2Van;67commando;67gt500;68firebird;69camaro;69mini;69mini_ItalianJob;69mini_MrBean;69mini_PitbullSpecial;70dodge;70barracuda;74amgeneralM151A2;75grandPrix;76chevyKseries;78amgeneralM35A2;78amgeneralM49A2C;78amgeneralM50A3;78amgeneralM62;80manKat1;81deloreanDMC12;81deloreanDMC12BTTF;82jeepJ10;82jeepJ10t;82jeepJ10LFS_NoVanilla;82oshkoshM911;83amgeneralM923;84gageV300;84merc;85merc;86fordE150;86fordE150dnd;86fordE150mm;86fordE150pd;86fordE150LFS_NoVanilla;86oshkoshP19A;87buickRegal;87chevySuburban;87fordB700;87cruiser;87toyotaMR2;88chevyS10;88golfMk2;88jettaMk2;89dodgeCaravan;89fordBronco;89trooper;89def110;89def90;89volvo200;90bmwE30;90fordF350ambulance;90niva;90pierceArrow;91geoMetro;91range;92amgeneralM998;92fordCVPI;92jeepYJ;92jeepYJJP18;92nissanGTR;93chevySuburban;93fordElgin;93fordF350;93mustangSSP;93fordTaurus;93townCar;97bushmaster;agrotsar;Arsenal(26)GunFighter[MAIN MOD 2.0];Authentic Z - Current;ATA_Datsun_240z;autotsartrailers;ATA_BMW_E36;ATA_Bus;ATA_Samara;ATA_Dadge;ATA_VanDeRumba;ATA_DeLorean;ATA_Mustang_66;ATA_Mustang;ATA_Jeep;ATA_Luton;ATA_Petyarbuilt;VISIBLE_BACKPACK_BACKGROUND;Basements;BedfordFalls;BetterBatteries;TowingCar;Blackwood;BB_Achievements;BB_Bicycles;BB_Utils;Brita_2;Brita;MoreCLR_desc4mood;ClothesBoxRedux;CombatText;BB_CommonSense;isoContainers;cropsNeverRot;Diederiks Tile Palooza;DescriptiveSkillTooltips;DRAW_ON_MAP;DylansTiles;LazoloDynamicBackpackUpgrades;NewEkron;EQUIPMENT_UI;ExerciseWithGear;ExtraMapSymbols;ExtraMapSymbolsUI;enAutomobileExtravaganza;1992fiorino;1990spazio147;FRUsedCars;FRUsedCarsNLF;FirstAidVHSTapes;FitnessGains;FH;FORTREDSTONE;fuelsideindicator;GeneratorTimeRemaining;Grapeseed;weapongunsmith;HNDLBR_Preppers;HTowTruck;improvedhairmenu;ImprovisedSilencers;ImprovisedSilencersVFEPatch;INVENTORY_TETRIS;JaysBuildingTweaks;JaysMoreVanillaBuilding;JaysRealisticFireplace;KillCount;KnownAndCollected;lakeivytownship;Lingering Voices;ScaniaPack;MaDZombieLoot (UPDATED 13;MapLegendUI;melos_tiles_for_miles_pack;MiniHealthPanel;ModManager;ModManagerServer;modoptions;MoodleFramework;MoreDescriptionForTraits4166;ToadTraits;ToadTraitsDynamic;MutiesContextMenuIcons;MutiesContextMenuIconsExpanded;MutiesContextMenuIconsRedrawed;MutiesContextMenuIconsStorage;NepEngineColor;NestedContainer01;nattachments;noirrsling;PLLoot;PLLootF;PLLootG;PertsPartyTiles;Pitstop;BION_PlainMoodles[;ProfessionFramework;ProjectUnderground;RavenCreek;REORDER_CONTAINERS;BB_RoadtripRadio;ScrapArmor(new version);ScrapGuns(new version);ScrapWeapons(new version);BB_SecureAccess;BLTAnnotations;shine_together;simonMDsDestroyedTiles;simonMDsTiles;SimpleConvertToBritaSRC;SkillRecoveryJournal;SmarterStorage;SpnCloth;SpnClothHideFix;SpnHair;Tactical Weapons;TakeAnyAmount;TchernoLib;damnlib;TheOnlyCure;TheWorkshop(new version);TheyKnew;tkTiles_01;P4TidyUpMeister;toyotahilux89;RS_WaterCistern;RS_WaterCistern_FR_Overwrite;RS_WaterCistern_KI5_Addon;tsarslib;UnderCoverOfDarkness;VFExpansion1;DaszhVehicleChime;VehicleRepairOverhaul;TheStar;wellsConstruction;YakiHSBasegameTexture;YakiHS";
          MOD_WORKSHOP_IDS = "2900580391;3171176891;2772575623;3005903549;3041122351;2478247379;3026723485;3258343790;2991201484;2937786633;2873290424;2913633066;2785549133;3213391371;3161951724;2799152995;3248388837;3253385114;2886832257;2968610351;2618213077;2811383142;3171184800;2805630347;2469388752;2870394916;2964003061;2566953935;3226885926;3196180339;3110911330;2489148104;3052360250;2886832936;2516123638;2522173579;3034636011;2886833398;2932549988;2441990998;2443275640;3292659291;3110913021;2952802178;2422681177;2942793445;3008795514;2409333430;2642541073;2962175696;3287727378;2846036306;3152529790;2969343830;3073430075;3001592312;3088951320;2932547723;2897390033;2728257015;2297098490;2335368829;2984487137;2282429356;2946111058;2592358528;2850439818;2743496289;2811232708;2963237571;2984482062;2681635926;2636100523;2792425535;2782258356;2808679062;2849247394;522891356;2856174410;2241990680;2536865912;3051277957;2988491347;2850135071;2460154811;2200148440;2763647806;2847911733;2286124931;2875848298;2625625421;2728416041;2337452747;3134776712;2804531012;2599752664;2996978365;2712480036;2950902979;2513537093;2701170568;3261072117;2989871420;2983702434;1510950729;3153010942;2305280257;2447729538;1516836158;2616986064;2883397918;2463499011;3105394500;3252451158;2292487242;2732662310;2799742455;2982070344;3189275874;2553809727;2881764317;2252982049;2874678809;2943876000;2892563252;2710167561;2879745353;2866258937;2694448564;2725216703;2169435993;2859296947;2685168362;1299328280;3101668503;3293222249;2973053380;2975204120;2946221823;2754567348;2786499395;2279084780;2837923608;2597946327;3008416736;1343686691;3224573169;2196102849;2901962885;3244642872;2658619264;2125659488;2122265954;3170805672;2815560151;3236042638;2862154374;2852704777;2696120270;2503622437;3290232938;2684285534;2463184726;2324223029;2985394645;2986578314;3171167894;3236152598;2680473910;2725378876;2384329562;2769706949;2968103661;2719592131;2392709985;2954422590;2667899942;2742869038;2757712197;2619072426;2852690210;2761200458";
        };
        environmentFiles = [
          config.age.secrets.pzomboid.path
        ];
      };
    };
  };
}
