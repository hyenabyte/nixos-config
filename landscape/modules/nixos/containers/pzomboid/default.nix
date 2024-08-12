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
    serverName = mkOpt str "zomboid" "The server name";
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
          STEAM_VAC = "true";
          TZ = "UTC";
          UDP_PORT = "16262";
          USE_STEAM = "true";

          MOD_NAMES = "FixTooltipLag;MutiesContextMenuIconsExpanded;MutiesContextMenuIconsRedrawed;MutiesContextMenuIconsStorage;TheyKnew;TowingCar;BLTAnnotations;BION_PlainMoodles;Basements;BB_Utils;BB_CommonSense;Brita_2;Brita;DescriptiveSkillTooltips;MoreDescriptionForTraits4166;SkillRecoveryJournal;TakeAnyAmount;DaszhVehicleChime;weapongunsmith;ScrapArmor(new version);ScrapGuns(new version);ScrapWeapons(new version);TheWorkshop(new version);ProfessionFramework;improvedhairmenu;enAutomobileExtravaganza;HNDLBR_Preppers;VehicleRepairOverhaul;ToadTraits;ToadTraitsDynamic;tsarslib;fuelsideindicator;49powerWagon;49ford8N;59meteor;ECTO1;63beetle;63Type2Van;67commando;67gt500;68firebird;69camaro;69mini;69mini_ItalianJob;69mini_MrBean;69mini_PitbullSpecial;70dodge;70barracuda;74amgeneralM151A2;75grandPrix;76chevyKseries;78amgeneralM35A2;78amgeneralM49A2C;78amgeneralM50A3;78amgeneralM62;80manKat1;81deloreanDMC12;81deloreanDMC12BTTF;82jeepJ10;82jeepJ10t;82oshkoshM911;83amgeneralM923;84gageV300;84merc;86fordE150;86fordE150dnd;86fordE150mm;86fordE150pd;86oshkoshP19A;87buickRegal;87chevySuburban;87fordB700;87toyotaMR2;88chevyS10;89dodgeCaravan;89fordBronco;89trooper;89volvo200;90bmwE30;90fordF350ambulance;90pierceArrow;91geoMetro;91range;92amgeneralM998;92fordCVPI;92jeepYJ;92jeepYJJP18;92nissanGTR;93chevySuburban;93fordElgin;93fordF350;93mustangSSP;93fordTaurus;93townCar;97bushmaster;isoContainers;damnlib;rSemiTruck;ScaniaPack;MaDZombieLoot (UPDATED 13/12/22 13:30);ImprovisedSilencers;ImprovisedSilencersVFEPatch;BB_SecureAccess;FirstAidVHSTapes;MutiesContextMenuIcons;JaysBuildingTweaks;JaysMoreVanillaBuilding;JaysRealisticFireplace;NepEngineColor;MapLegendUI;ModManager;ModManagerServer;TheStar;nattachments;noirrsling;VISIBLE_BACKPACK_BACKGROUND;DRAW_ON_MAP;EQUIPMENT_UI;INVENTORY_TETRIS;REORDER_CONTAINERS;REORDER_THE_HOTBAR;TheOnlyCure;P4TidyUpMeister;shine_together;82jeepJ10LFS;82jeepJ10LFS_NoVanilla;86fordE150LFS;86fordE150LFS_NoVanilla;CombatText;wellsConstruction;FH;Lingering Voices;MiniHealthPanel;SpnCloth;SpnClothHideFix;SpnHair;Tactical Weapons;modoptions;KillCount;MoodleFramework;TchernoLib;cropsNeverRot;SimpleConvertToBritaSRC;RS_WaterCistern;RS_WaterCistern_FR_Overwrite;RS_WaterCistern_KI5_Addon;MoreCLR_desc4mood;KnownAndCollected;GeneratorTimeRemaining;ExtraMapSymbols;ExtraMapSymbolsUI;RotatorsLib;YakiHSBasegameTexture;YakiHS;rWaterTrailer;rWaterTrailerSemi";
          MOD_WORKSHOP_IDS = "2915430406;3293222249;2725378876;2241990680;2815560151;3008416736;2849247394;2850135071;2875848298;2460154811;2200148440;3134776712;2685168362;2503622437;2985394645;2742869038;3105394500;2658619264;2125659488;2122265954;2680473910;1343686691;2732662310;3261072117;3252451158;2757712197;1299328280;2392709985;2616986064;2900580391;3171176891;2772575623;3005903549;3041122351;2478247379;3026723485;3258343790;2991201484;2937786633;2873290424;2913633066;2785549133;3213391371;3161951724;2799152995;3248388837;3253385114;2886832257;2618213077;2811383142;3171184800;2805630347;2870394916;2566953935;3226885926;3196180339;3110911330;3052360250;2886832936;3034636011;2886833398;2932549988;3292659291;3110913021;2952802178;2942793445;3008795514;2409333430;2642541073;2962175696;3287727378;2846036306;3152529790;2969343830;3073430075;3001592312;3088951320;2932547723;2897390033;2625625421;3171167894;2759339330;2943876000;2892563252;2799742455;3170805672;3153010942;3101668503;3189275874;2973053380;2975204120;2710167561;2694448564;2725216703;2619072426;2754567348;2786499395;2808679062;2804531012;2950902979;2982070344;2901962885;2903771337;3236152598;2769706949;3236042638;2968610351;2964003061;2286124931;2852690210;2447729538;2874678809;2866258937;2684285534;2463184726;2324223029;2169435993;2553809727;2859296947;2986578314;2728416041;2696120270;2719592131;2763647806;2881764317;2883397918;2701170568;2732594572;2761200458;2732639855";

          # MOD_NAMES = "";
          # MOD_WORKSHOP_IDS = "";
        };
        environmentFiles = [
          config.age.secrets.pzomboid.path
        ];
      };
    };
  };
}
