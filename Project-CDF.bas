$NOPREFIX
$CONSOLE
OPTION EXPLICIT
DIM cmode AS UNSIGNED BIT
IF UCASE$(COMMAND$) = "CONSOLE" THEN
    SCREENHIDE
    cmode = 1
    CONSOLE ON
    DEST CONSOLE
END IF
IF cmode = 0 THEN SCREEN NEWIMAGE(640, 480, 32) '81x30
RANDOMIZE TIMER
DISPLAY
IF DIREXISTS("Assets") = 0 THEN
    PRINT "UNABLE TO LOCATE ASSETS FOLDER."
    PRINT
    PRINT "The Assets folder MUST be placed in the same directory"
    PRINT "as the Project-CDF executable. This folder contains things"
    PRINT "like sprites, textures, sounds, and other resources Project-CDF"
    PRINT "needs to function properly, along with user generated data,"
    PRINT "such as screenshots, and the configuration file."
    PRINT
    PRINT "You cannot play without this folder"
    END
END IF
'variable dim
DIM dummy_string AS STRING
DIM dummy_variable AS INTEGER
DIM hostos AS STRING
DIM bit32 AS UNSIGNED BIT
DIM unstable AS UNSIGNED BIT
DIM corrupt AS UNSIGNED BIT
DIM true AS UNSIGNED BIT
DIM false AS UNSIGNED BIT
DIM SHARED sounds AS UNSIGNED BYTE
DIM ver AS STRING
DIM cdfcc AS INTEGER
DIM debug AS UNSIGNED BIT
DIM nocost AS UNSIGNED BIT
DIM config_file AS STRING
DIM current_second AS BYTE
DIM past_second AS BYTE
DIM frame AS INTEGER
DIM frps AS INTEGER
DIM config_cdfcc AS INTEGER
DIM error_code AS INTEGER
DIM light_theme AS LONG
DIM dark_theme AS LONG
DIM title_song AS STRING
DIM game1 AS STRING
DIM game2 AS STRING
DIM game3 AS STRING
DIM game4 AS STRING
DIM game5 AS STRING
DIM light_theme_file AS STRING
DIM dark_theme_file AS STRING
DIM mod_info_file AS STRING
DIM i AS SINGLE
DIM k AS SINGLE
DIM submenu AS BYTE
DIM pageturn AS BYTE
DIM song_handle AS LONG
DIM ingame AS UNSIGNED BYTE
DIM norefresh AS UNSIGNED BIT
DIM stage AS BYTE
DIM modded AS UNSIGNED BIT
DIM modloaded AS UNSIGNED BIT
DIM modname AS STRING


DIM turnchange AS UNSIGNED BIT
DIM turn AS UNSIGNED BYTE
DIM move_type AS BYTE
DIM move_number AS BYTE
DIM fail AS BYTE
DIM base_damage AS SINGLE
DIM true_damage AS SINGLE
DIM status AS STRING

DIM choice AS BYTE
DIM vo AS BYTE
DIM ho AS BYTE
DIM no AS BYTE
DIM sp AS BYTE
DIM hm AS UNSIGNED BIT

DIM opo AS BYTE

DIM menu_scroll AS STRING
DIM menu_confirm AS STRING
DIM turn_change AS STRING
DIM error_sound AS STRING
DIM attack_sound AS STRING
DIM defend_sound AS STRING
DIM fire_sound AS STRING
DIM fire2_sound AS STRING

DIM saving AS UNSIGNED BIT



'array dim
DIM character1 AS character
DIM character2 AS character
DIM character3 AS character
DIM character4 AS character
DIM character5 AS character
DIM character6 AS character

DIM bonus1 AS bonus
DIM bonus2 AS bonus
DIM bonus3 AS bonus
DIM bonus4 AS bonus
DIM bonus5 AS bonus
DIM bonus6 AS bonus

DIM attack1 AS move
DIM attack2 AS move
DIM attack3 AS move
DIM attack4 AS move
DIM defense1 AS move
DIM defense2 AS move
DIM defense3 AS move
DIM defense4 AS move
DIM magic1 AS move
DIM magic2 AS move
DIM magic3 AS move
DIM magic4 AS move
DIM character1special AS move
DIM character2special AS move
DIM character3special AS move
DIM character4special AS move
DIM character5special AS move
DIM character6special AS move
DIM special1 AS move
DIM special2 AS move
DIM special3 AS move
DIM active AS move
DIM player1 AS player
DIM player2 AS player
DIM player1special AS move
DIM player2special AS move


DIM net AS net
DIM about AS about
DIM settings AS settings

DIM modinfo(6) AS modinfo


true = 1
false = 0

SELECT CASE _OS$
    CASE "[WINDOWS][32BIT]"
        hostos = "Windows"
        bit32 = true
    CASE "[WINDOWS][64BIT]"
        hostos = "Windows"
    CASE "[LINUX][32BIT]"
        hostos = "Linux"
        bit32 = true
    CASE "[LINUX][64BIT]"
        hostos = "Linux"
    CASE "[MACOSX][32BIT][LINUX]"
        hostos = "Mac OS"
        bit32 = true
    CASE "[MACOSX][64BIT][LINUX]"
        hostos = "Mac OS"
    CASE ELSE
        hostos = "Other OS"
        unstable = true
        bit32 = true
END SELECT

TITLE about.name + " Version " + ver


'assign default variables
resetcfg:
IF modloaded = 0 THEN
    config_file = "Assets\UserData\config.cdf"
    mod_info_file = "Assets\UserData\modinfo.cdf"
    light_theme_file = "Assets\Graphics\lighttheme.png"
    dark_theme_file = "Assets\Graphics\darktheme.png"
    title_song = "Assets\Music\title.mp3"

    menu_scroll = "Assets\Sounds\choose.wav"
    menu_confirm = "Assets\Sounds\select.wav"
    turn_change = "Assets\Sounds\Swap.mp3"
    error_sound = "Assets\Sounds\error.wav"
    attack_sound = "Assets\Sounds\attack.mp3"
    defend_sound = "Assets\Sounds\defend.mp3"
    fire_sound = "Assets\Sounds\fire1.mp3"
    fire2_sound = "Assets\Sounds\fire2.mp3"


    game1 = "Assets\Music\Game1.mp3"
    game2 = "Assets\Music\Game2.mp3"
    game3 = "Assets\Music\Game3.mp3"
    game4 = "Assets\Music\Game4.mp3"
    game5 = "Assets\Music\Game5.mp3"
END IF

about.name = "Project-CDF"
about.description = "A turn based strategy game written in BASIC"
ver = "3.0 Test Build 14"
cdfcc = 314
debug = 0
opo = 1
settings.fps = 60
settings.fpslock = 1
settings.ldmode=0
sounds = 1
net.port = "29845"

character1.name = "Isaac"
character1.description = "A standard fighter. High Attack Stat. Special move is Omega Punch."
character1.health = 100
character1.magic = 0
character1.points_per_turn = 2
character1.magic_per_turn = 0.5
character1.attack_multiplier = 1.4
character1.defense_multiplier = 0.9
character1.magic_multiplier = 0.5
character1.sprite_sheet_x = 0
character1.sprite_sheet_y = 36

character2.name = "Olroch"
character2.description = "A Grand Wizrd. Proficient in magic. Their special move is HellBlaze."
character2.health = 80
character2.magic = 0
character2.points_per_turn = 2
character2.magic_per_turn = 1
character2.attack_multiplier = 0.8
character2.defense_multiplier = 0.9
character2.magic_multiplier = 1.6
character2.sprite_sheet_x = 305
character2.sprite_sheet_y = 37

character3.name = "Erica"
character3.description = "An attack swarmer. Doesnt do a lot of damage, but can hit many times."
character3.health = 110
character3.magic = 0
character3.points_per_turn = 3
character3.magic_per_turn = 0.5
character3.attack_multiplier = 0.9
character3.defense_multiplier = 0.8
character3.magic_multiplier = 0.6
character3.sprite_sheet_x = 305
character3.sprite_sheet_y = 37

character4.name = "Norlon"
character4.description = "A Professional weightlifter. Special move is 'Ultimate Shield'. "
character4.health = 135
character4.magic = 0
character4.points_per_turn = 2
character4.magic_per_turn = 0.25
character4.attack_multiplier = 1.15
character4.defense_multiplier = 2
character4.magic_multiplier = 1
character4.sprite_sheet_x = 305
character4.sprite_sheet_y = 37


character5.name = "ph.thorn_master"
character5.description = "A standard fighter. Proficent in combat. Special move is Omega Punch."
character5.health = 100
character5.magic = 0
character5.points_per_turn = 2
character5.magic_per_turn = 0.2
character5.attack_multiplier = 1.5
character5.defense_multiplier = 1.1
character5.magic_multiplier = 0.4
character5.sprite_sheet_x = 0
character5.sprite_sheet_y = 36



character6.name = "ph.placeholder"
character6.description = "A standard fighter. Proficent in combat. Special move is Omega Punch."
character6.health = 100
character6.magic = 0
character6.points_per_turn = 2
character6.magic_per_turn = 0.2
character6.attack_multiplier = 1.5
character6.defense_multiplier = 1.1
character6.magic_multiplier = 0.4
character6.sprite_sheet_x = 0
character6.sprite_sheet_y = 36

attack1.name = "Slap"
attack1.type = 1
attack1.description = "A Simple Slap"
attack1.description2 = "1-5 Base Damage"
attack1.accuracy = 95
attack1.cost = 1
attack1.magic_cost = 0
attack1.data0 = 1
attack1.data1 = 5
attack1.data2 = 0
attack1.data3 = 0
attack1.data4 = 0
attack1.data5 = 0

attack2.name = "Punch"
attack2.type = 1
attack2.description = "A Hard Hitting Punch"
attack2.description2 = "5-10 Base Damage"
attack2.accuracy = 90
attack2.cost = 2
attack2.magic_cost = 0
attack2.data0 = 5
attack2.data1 = 10
attack2.data2 = 0
attack2.data3 = 0
attack2.data4 = 0
attack2.data5 = 0

attack3.name = "Kick"
attack3.type = 1
attack3.description = "A Roundhouse Kick"
attack3.description2 = "10-20 Base Damage"
attack3.accuracy = 85
attack3.cost = 4
attack3.magic_cost = 0
attack3.data0 = 10
attack3.data1 = 20
attack3.data2 = 0
attack3.data3 = 0
attack3.data4 = 0
attack3.data5 = 0

attack4.name = "Body Slam"
attack4.type = 2
attack4.description = "Slam your foe hard"
attack4.description2 = "15-30 Base Damage"
attack4.accuracy = 75
attack4.cost = 8
attack4.magic_cost = 0
attack4.data0 = 15
attack4.data1 = 30
attack4.data2 = 50
attack4.data3 = 25
attack4.data4 = 3
attack4.data5 = 0

defense1.name = "Distract"
defense1.type = 3
defense1.description = "Look at me go!"
defense1.description2 = " Foe Accuracy"
defense1.accuracy = 95
defense1.cost = 1
defense1.magic_cost = 0
defense1.data0 = 0
defense1.data1 = 0
defense1.data2 = 0
defense1.data3 = 10
defense1.data4 = 1
defense1.data5 = 0

defense2.name = "Small Shield"
defense2.type = 4
defense2.description = "It is very small."
defense2.description2 = "Protects slightly"
defense2.accuracy = 97
defense2.cost = 2
defense2.magic_cost = 0
defense2.data0 = 0
defense2.data1 = 0
defense2.data2 = 0
defense2.data3 = 1.2
defense2.data4 = 3
defense2.data5 = 0

defense3.name = "Big Shield"
defense3.type = 4
defense3.description = "Larger than small."
defense3.description2 = "Protects better"
defense3.accuracy = 95
defense3.cost = 4
defense3.magic_cost = 0
defense3.data0 = 0
defense3.data1 = 0
defense3.data2 = 0
defense3.data3 = 1.4
defense3.data4 = 3
defense3.data5 = 0

defense4.name = "Third Eye"
defense4.type = 3
defense4.description = "Predict Next Move"
defense4.description2 = " Foe Accuracy"
defense4.accuracy = 85
defense4.cost = 10
defense4.magic_cost = 1
defense4.data0 = 0
defense4.data1 = 0
defense4.data2 = 0
defense4.data3 = 70
defense4.data4 = 1
defense4.data5 = 0

magic1.name = "Mushroom"
magic1.type = 7
magic1.description = "Small Healing Item"
magic1.description2 = "5-10 Health"
magic1.accuracy = 99
magic1.cost = 1
magic1.magic_cost = 0.5
magic1.data0 = 5
magic1.data1 = 10
magic1.data2 = 0
magic1.data3 = 0
magic1.data4 = 0
magic1.data5 = 0

magic2.name = "Fire Ball"
magic2.type = 5
magic2.description = "Has a chance to burn"
magic2.description2 = "4-9 Base Damage"
magic2.accuracy = 92
magic2.cost = 3
magic2.magic_cost = 2
magic2.data0 = 4
magic2.data1 = 9
magic2.data2 = 50
magic2.data3 = 1
magic2.data4 = 5
magic2.data5 = 3

magic3.name = "Leach Life"
magic3.type = 6
magic3.description = "I dont know"
magic3.description2 = "heals for half damage"
magic3.accuracy = 90
magic3.cost = 5
magic3.magic_cost = 3
magic3.data0 = 10
magic3.data1 = 20
magic3.data2 = 0
magic3.data3 = 0
magic3.data4 = 0
magic3.data5 = 0

magic4.name = "Health Mite"
magic4.type = 9
magic4.description = "Slowly Heals you"
magic4.description2 = "1-3 Health/Turn"
magic4.accuracy = 90
magic4.cost = 4
magic4.magic_cost = 1
magic4.data0 = 1
magic4.data1 = 3
magic4.data2 = 10
magic4.data3 = 0
magic4.data4 = 0
magic4.data5 = 0


special1.name = "Double Down"
special1.type = 8
special1.description = "Take your health"
special1.description2 = "To take theirs"
special1.accuracy = 88
special1.cost = 8
special1.magic_cost = 0
special1.data0 = 25
special1.data1 = 50
special1.data2 = 50
special1.data3 = 75
special1.data4 = 3
special1.data5 = 0



character1special.name = "Mega Punch"
character1special.type = 1
character1special.description = "A Simple Slap"
character1special.description2 = "1-5 Base Damage"
character1special.accuracy = 99
character1special.cost = 1
character1special.magic_cost = 0
character1special.data0 = 1
character1special.data1 = 5
character1special.data2 = 0
character1special.data3 = 0
character1special.data4 = 0
character1special.data5 = 0

character2special.name = "Hellblaze"
character2special.type = 1
character2special.description = "A Hard Hitting Punch"
character2special.description2 = "5-10 Base Damage"
character2special.accuracy = 97
character2special.cost = 2
character2special.magic_cost = 0
character2special.data0 = 5
character2special.data1 = 10
character2special.data2 = 0
character2special.data3 = 0
character2special.data4 = 0
character2special.data5 = 0

character3special.name = "Kick"
character3special.type = 1
character3special.description = "A Roundhouse Kick"
character3special.description2 = "10-20 Base Damage"
character3special.accuracy = 94
character3special.cost = 4
character3special.magic_cost = 0
character3special.data0 = 10
character3special.data1 = 20
character3special.data2 = 0
character3special.data3 = 0
character3special.data4 = 0
character3special.data5 = 0

character4special.name = "Body Slam"
character4special.type = 2
character4special.description = "Slam your foe hard"
character4special.description2 = "15-30 Base Damage"
character4special.accuracy = 90
character4special.cost = 8
character4special.magic_cost = 0
character4special.data0 = 15
character4special.data1 = 30
character4special.data2 = 50
character4special.data3 = 50
character4special.data4 = 3
character4special.data5 = 0

character5special.name = "Slap"
character5special.type = 1
character5special.description = "A Simple Slap"
character5special.description2 = "1-5 Base Damage"
character5special.accuracy = 99
character5special.cost = 1
character5special.magic_cost = 0
character5special.data0 = 1
character5special.data1 = 5
character5special.data2 = 0
character5special.data3 = 0
character5special.data4 = 0
character5special.data5 = 0

character6special.name = "Punch"
character6special.type = 1
character6special.description = "A Hard Hitting Punch"
character6special.description2 = "5-10 Base Damage"
character6special.accuracy = 97
character6special.cost = 2
character6special.magic_cost = 0
character6special.data0 = 5
character6special.data1 = 10
character6special.data2 = 0
character6special.data3 = 0
character6special.data4 = 0
character6special.data5 = 0


'type 1 standard attack
'type 2 stunning attack data 2 = chance to stun data 3 reduced accuracy data 4 lasting turns

'3 levels of priority for status effects
'level 1 standard attack defence effects
'level 2 special effects
'level 3 perminate effects

'character with a perminant leach life

'menu layout

'attack
'defense
'magic
'special move (8)
'end turn

'boss fights?


bonus1.name = "Attack Boost"
bonus1.attack_boost_multiplier = 0.2
bonus2.name = "Defense Boost"
bonus2.defense_boost_multiplier = 0.3
bonus3.name = "Magic Boost"
bonus3.magic_boost_multiplier = 0.25
bonus4.name = "Point Boost"
bonus4.points_per_turn = 1
bonus4.magic_per_turn = 0.5
bonus5.name = "Health Bonus"
bonus5.health = 25
bonus6.name = "Magic Bonus"
bonus6.magic = 10

IF DIREXISTS("Assets/Mods") THEN modded = 1

IF dummy_variable = 0 THEN
    CLS
    PRINT "Welcome to " + about.name + ", Version " + ver + ", CDFCC" + STR$(cdfcc)
    IF cmode = 1 THEN PRINT "Console mode enabled"
    DISPLAY

    SLEEP 2
    IF cmode = 0 THEN
        PRINT
        PRINT "To enable full screen mode, press ALT+ENTER."
        PRINT "Hold R to regenerate config file."
    ELSE
        PRINT
        PRINT "Go to settings to regenerate config file."
    END IF
    PRINT
    DISPLAY
    SLEEP 3
END IF
dummy_variable = 1
'save the custom variables
IF KEYDOWN(70) OR KEYDOWN(102) THEN cdfcc = 1
IF DIREXISTS("Assets\UserData") = false THEN MKDIR "Assets\UserData": PRINT "Generating config directory": DISPLAY
IF KEYDOWN(82) OR KEYDOWN(114) THEN KILL config_file
IF FILEEXISTS(config_file) = false THEN
    PRINT: PRINT "Generating default config file": DISPLAY
    save:
    OPEN config_file AS #1 LEN = 1024
    IF saving = 0 THEN
        PUT #1, 1, character1
        PUT #1, 2, character2
        PUT #1, 3, character3
        PUT #1, 4, character4
        PUT #1, 5, character5
        PUT #1, 6, character6
        PUT #1, 7, bonus1
        PUT #1, 8, bonus2
        PUT #1, 9, bonus3
        PUT #1, 10, bonus4
        PUT #1, 11, bonus5
        PUT #1, 12, bonus6
        PUT #1, 13, about
        PUT #1, 14, attack1
        PUT #1, 15, attack2
        PUT #1, 16, attack3
        PUT #1, 17, attack4
        PUT #1, 18, defense1
        PUT #1, 19, defense2
        PUT #1, 20, defense3
        PUT #1, 21, defense4
        PUT #1, 22, magic1
        PUT #1, 23, magic2
        PUT #1, 24, magic3
        PUT #1, 25, magic4
        PUT #1, 26, character1special
        PUT #1, 27, character2special
        PUT #1, 28, character3special
        PUT #1, 29, character4special
        PUT #1, 30, character5special
        PUT #1, 31, character6special
    END IF

    PUT #1, 33, settings
    PUT #1, 34, sounds
    IF saving = 0 THEN PUT #1, 35, cdfcc
    CLOSE #1
    IF saving = 1 THEN saving = 0: RETURN
END IF

'load the custome variables
load:
IF modded = 1 THEN
    OPEN mod_info_file AS #1 LEN = 4096
    FOR i = 0 TO 6
        GET #1, i + 1, modinfo(i)
    NEXT
    CLOSE #1

    config_file = RTRIM$(config_file)
    light_theme_file = RTRIM$(light_theme_file)
    dark_theme_file = RTRIM$(dark_theme_file)
    title_song = RTRIM$(title_song)

    menu_scroll = RTRIM$(menu_scroll)
    menu_confirm = RTRIM$(menu_confirm)
    turn_change = RTRIM$(turn_change)
    error_sound = RTRIM$(error_sound)
    attack_sound = RTRIM$(attack_sound)
    defend_sound = RTRIM$(defend_sound)
    fire_sound = RTRIM$(fire_sound)
    fire2_sound = RTRIM$(fire2_sound)


    game1 = RTRIM$(game1)
    game2 = RTRIM$(game2)
    game3 = RTRIM$(game3)
    game4 = RTRIM$(game4)
    game5 = RTRIM$(game5)



END IF

OPEN config_file AS #1 LEN = 1024
GET #1, 1, character1
GET #1, 2, character2
GET #1, 3, character3
GET #1, 4, character4
GET #1, 5, character5
GET #1, 6, character6
GET #1, 7, bonus1
GET #1, 8, bonus2
GET #1, 9, bonus3
GET #1, 10, bonus4
GET #1, 11, bonus5
GET #1, 12, bonus6
GET #1, 13, about
GET #1, 14, attack1
GET #1, 15, attack2
GET #1, 16, attack3
GET #1, 17, attack4
GET #1, 18, defense1
GET #1, 19, defense2
GET #1, 20, defense3
GET #1, 21, defense4
GET #1, 22, magic1
GET #1, 23, magic2
GET #1, 24, magic3
GET #1, 25, magic4
GET #1, 26, character1special
GET #1, 27, character2special
GET #1, 28, character3special
GET #1, 29, character4special
GET #1, 30, character5special
GET #1, 31, character6special
GET #1, 33, settings
GET #1, 34, sounds
GET #1, 35, config_cdfcc
CLOSE #1

IF config_cdfcc <> cdfcc THEN error_code = 100: GOTO errors
continue100:
TITLE about.name + " Version " + ver
'load game assets
light_theme = LOADIMAGE(light_theme_file)
dark_theme = LOADIMAGE(dark_theme_file)
titlescreen:
IF song_handle <> 0 THEN SNDSTOP song_handle
song_handle = PLAYMUSIC(title_song)


CLS

KEYCLEAR
PRINTMODE KEEPBACKGROUND
COLOR RGB(0, 0, 0)
submenu = 0
opo = 1
hm = 0
DO
    vo = 20
    ho = 30
    no = 4
    sp = 1

    CLS
    IF settings.ldmode = 1 THEN PUTIMAGE (0, 0), dark_theme
    IF settings.ldmode = 0 THEN PUTIMAGE (0, 0), light_theme

    IF k = -15616 THEN debug = debug + 1
    BOX 29, 20, 51, 29
    IF debug = true THEN GOSUB debug
    IF settings.ldmode = 1 THEN COLOR RGB(255, 255, 255)
    LOCATE 1, 1: PRINT "Version " + ver
    LOCATE 4, 1
    CENTERPRINT about.name
    CENTERPRINT about.description
    COLOR RGB(255, 255, 255)
    SELECT CASE submenu
        CASE 0
            LOCATE 21, 30: PRINT "  Play Game"
            LOCATE 23, 30: PRINT "  Settings"
            LOCATE 25, 30: PRINT "  What's New?"
            LOCATE 27, 30: PRINT "  Exit to Desktop"
            GOSUB menu
            IF choice = 1 THEN
                choice = 0
                IF opo = 1 THEN submenu = 1
                IF opo = 2 THEN submenu = 4
                IF opo = 3 GOTO about
                IF opo = 4 THEN SYSTEM
                IF opo = 99 THEN SYSTEM
                opo = 1
            END IF
        CASE 1
            LOCATE 21, 30: PRINT "  Local Multiplayer"
            LOCATE 23, 30: PRINT "  Host Network Game"
            LOCATE 25, 30: PRINT "  Join Network Game"
            LOCATE 27, 30: PRINT "  Back"
            GOSUB menu
            IF choice = 1 THEN
                choice = 0
                IF opo = 1 GOTO start_game
                IF opo = 2 THEN
                    IF unstable = 1 OR corrupt = 1 THEN PLAYSOUND error_sound ELSE submenu = 5
                END IF
                IF opo = 3 THEN submenu = 6
                IF opo = 4 THEN submenu = 0
                IF opo = 99 THEN submenu = 0
                opo = 1
            END IF
        CASE 2
            LOCATE 21, 30: PRINT "  Easy Difficulty"
            LOCATE 23, 30: PRINT "  Normal Difficulty"
            LOCATE 25, 30: PRINT "  Hard Difficulty"
            LOCATE 27, 30: PRINT "  Back"
            GOSUB menu
            IF choice = 1 THEN
                choice = 0
                IF opo = 1 GOTO start_game
                IF opo = 2 GOTO start_game
                IF opo = 3 GOTO start_game
                IF opo = 4 THEN submenu = 1
                IF opo = 99 THEN submenu = 1
                opo = 1
            END IF
        CASE 3
            LOCATE 21, 30: PRINT "  Host Game"
            LOCATE 23, 30: PRINT "  Join Game"
            LOCATE 25, 30: PRINT "  Join Server"
            LOCATE 27, 30: PRINT "  Back"
            GOSUB menu
            IF choice = 1 THEN
                choice = 0
                IF opo = 1 THEN submenu = 5
                IF opo = 2 THEN submenu = 6
                IF opo = 3 THEN submenu = 7
                IF opo = 4 THEN submenu = 1
                IF opo = 99 THEN submenu = 1
                opo = 1
            END IF

        CASE 4
            vo = 19
            ho = 30
            no = 9
            sp = 0

            LOCATE 20, 30: PRINT " Toggle FPS lock:"; settings.fpslock
            LOCATE 21, 30: PRINT " Change FPS Target:"; settings.fps
            LOCATE 22, 30: PRINT " Toggle Sound:"; sounds
            LOCATE 23, 30: PRINT " Network Port:"; net.port

            LOCATE 24, 30
            IF settings.ldmode = 0 THEN PRINT " Light Mode"
            IF settings.ldmode = 1 THEN PRINT " Dark Mode"
            IF modded = 1 THEN LOCATE 25, 30: PRINT " Mods"
            LOCATE 28, 30: PRINT " Back"
            GOSUB menu
            IF choice = 1 THEN
                choice = 0
                IF opo = 1 THEN settings.fpslock = settings.fpslock + 1
                IF settings.fpslock > 1 THEN settings.fpslock = 0
                IF opo = 2 THEN settings.fps = settings.fps * 2
                IF settings.fps = 224 THEN settings.fps = 15
                IF opo = 3 THEN sounds = sounds + 1
                IF sounds > 1 THEN sounds = 0
                IF opo = 4 THEN
                    DO
                    LOOP UNTIL INKEY$ = ""
                    PRINTMODE FILLBACKGROUND
                    LOCATE 23, 29: PRINT "                       "
                    PRINTMODE KEEPBACKGROUND
                    LOCATE 23, 30: INPUT " New Port"; net.port
                    DO
                    LOOP UNTIL KEYHIT = 0
                END IF
                IF opo = 5 THEN settings.ldmode = settings.ldmode + 1
                IF settings.ldmode > 1 THEN settings.ldmode = 0
                IF opo = 6 THEN submenu = 7
                IF opo = 9 THEN saving = 1: GOSUB save
                IF opo = 9 THEN GOTO titlescreen
                opo = 1
            END IF
        CASE 5
            IF settings.fps > 60 THEN settings.fps = 60
            settings.fpslock = 1
            'add code here that makes sure other game has the same framerate limit if less than 60
            COLOR RGB(0, 0, 0)
            IF settings.ldmode = 1 THEN COLOR RGB(255, 255, 255)
            LOCATE 6, 1: CENTERPRINT "Network Multiplayer is extremely experimental and"
            CENTERPRINT "may be slow, buggy, or even crash."
            CENTERPRINT ""
            CENTERPRINT "Opening Host on port " + net.port
            IF net.host = 0 THEN net.host = OPENHOST("TCP/IP:" + net.port)
            IF net.host = 0 THEN CENTERPRINT "Failed to open host"
            IF net.host <> 0 THEN CENTERPRINT "Opened Host Successfully!"
            IF net.host <> 0 THEN CENTERPRINT "You are hosting " + about.name + " on port " + net.port + ". " + STR$(net.host)
            IF net.client = 0 THEN net.client = OPENCONNECTION(net.host)
            IF net.client <> 0 THEN CENTERPRINT "Client has connected. Starting Game in 3 seconds."
            ' IF CONNECTED(net.connect) THEN centerprint "Client has connected. Select start game to play!"
            IF net.client <> 0 THEN dummy_variable = dummy_variable + 1: PRINT dummy_variable
            IF net.client <> 0 THEN IF dummy_variable = 180 THEN dummy_variable = 0: net.player = 0: GOTO connection




            COLOR RGB(255, 255, 255)
            LOCATE 28, 30: PRINT "  Cancel"
            vo = 27
            ho = 30
            no = 1
            sp = 1

            GOSUB menu
            IF choice = 1 THEN
                choice = 0
                IF opo = 1 THEN submenu = 1
            END IF

        CASE 6
            IF settings.fps > 60 THEN settings.fps = 60
            settings.fpslock = 1
            COLOR RGB(0, 0, 0)
            IF settings.ldmode = 1 THEN COLOR RGB(255, 255, 255)
            LOCATE 6, 1: CENTERPRINT "Network Multiplayer is extremely experimental and"
            CENTERPRINT "may be slow, buggy, or even crash."
            CENTERPRINT ""
            CENTERPRINT "Please enter Host IP"
            IF net.client = 0 THEN INPUT "IP:", net.ip

            CENTERPRINT "Attempting to connect to host " + net.ip + ":" + net.port
            IF net.client = 0 THEN net.client = OPENCLIENT("TCP/IP:" + net.port + ":" + net.ip)
            IF net.client = 0 THEN CENTERPRINT "Failed to connect to host"
            IF net.client <> 0 THEN CENTERPRINT "Connected to host successfully. Starting game in 3 seconds."
            IF net.client <> 0 THEN dummy_variable = dummy_variable + 1: PRINT dummy_variable
            IF net.client <> 0 THEN IF dummy_variable = 180 THEN dummy_variable = 0: net.player = 1: GOTO connection

            COLOR RGB(255, 255, 255)

        CASE 7
            vo = 19
            ho = 30
            no = 9
            sp = 0

            LOCATE 20, 30: PRINT " Install Mod"
            LOCATE 21, 30: PRINT " Remove Mod"
            LOCATE 28, 30: PRINT " Back"
            FOR i = 0 TO 6
                IF modinfo(0).name <> "" THEN
                    LOCATE i + 22, 30: PRINT " " + modinfo(i).name
                END IF
            NEXT
            GOSUB menu
            IF choice = 1 THEN
                choice = 0
                IF opo = 1 THEN
                    DO
                    LOOP UNTIL INKEY$ = ""
                    PRINTMODE FILLBACKGROUND
                    LOCATE 20, 29: PRINT "                       "
                    PRINTMODE KEEPBACKGROUND

                    DISPLAY
                    LOCATE 20, 30: INPUT "Directory Name?", dummy_string
                    PRINTMODE FILLBACKGROUND
                    LOCATE 20, 29: PRINT "                       "
                    PRINTMODE KEEPBACKGROUND

                    DISPLAY
                    LOCATE 20, 30: INPUT "Mod Number?", dummy_variable
                    IF dummy_variable >= 0 AND dummy_variable <= 6 THEN
                        PRINT "Assets\Mods\" + dummy_string + "\modinfo.cdfm"
                        OPEN "Assets\Mods\" + dummy_string + "\modinfo.cdfm" AS #1 LEN = 4096
                        GET #1, 1, modinfo(dummy_variable)
                        CLOSE #1
                        OPEN mod_info_file AS #1 LEN = 4096
                        PUT #1, dummy_variable + 1, modinfo(dummy_variable)
                        CLOSE #1

                    END IF
                    DO
                    LOOP UNTIL KEYHIT = 0

                END IF
                IF opo = 2 THEN PRINT
                IF opo = 9 THEN submenu = 4
                IF opo <> 1 AND opo <> 2 AND opo <> 9 THEN
                    IF modinfo(opo - 3).name <> "" THEN
                        config_file = modinfo(opo - 3).config_file
                        light_theme_file = modinfo(opo - 3).light_theme_file
                        dark_theme_file = modinfo(opo - 3).dark_theme_file
                        title_song = modinfo(opo - 3).title_song

                        menu_scroll = modinfo(opo - 3).menu_scroll
                        menu_confirm = modinfo(opo - 3).menu_confirm
                        turn_change = modinfo(opo - 3).turn_change
                        error_sound = modinfo(opo - 3).error_sound
                        attack_sound = modinfo(opo - 3).attack_sound
                        defend_sound = modinfo(opo - 3).defend_sound
                        fire_sound = modinfo(opo - 3).fire_sound
                        fire2_sound = modinfo(opo - 3).fire2_sound


                        game1 = modinfo(opo - 3).game1
                        game2 = modinfo(opo - 3).game2
                        game3 = modinfo(opo - 3).game3
                        game4 = modinfo(opo - 3).game4
                        game5 = modinfo(opo - 3).game5
                        modloaded = 1
                        modname = modinfo(opo - 3).name
                        GOSUB load

                    END IF
                END IF
            END IF

        CASE ELSE
            LOCATE 21, 30: PRINT "  Invalid submenu "
            LOCATE 23, 30: PRINT "  Press enter to"
            LOCATE 25, 30: PRINT "  to main menu"
            LOCATE 27, 30: PRINT "  "
            vo = 20
            ho = 30
            no = 1
            sp = 1

            GOSUB menu
            IF choice = 1 THEN
                choice = 0
                IF opo = 1 GOTO titlescreen
                IF opo = 99 GOTO titlescreen
            END IF

    END SELECT
    COLOR RGB(0, 0, 0)
    IF settings.ldmode = 1 THEN COLOR RGB(255, 255, 255)
    DISPLAY
    IF settings.fpslock = 1 THEN LIMIT settings.fps
LOOP
connection:
CLS

COLOR RGB(255, 255, 255)

'confirm cdfcc
AUTODISPLAY
SELECT CASE net.player
    CASE 0
        DELAY 1
        GET #net.client, , net.cdfcc
        IF net.cdfcc = cdfcc THEN
            net.status = 1
        ELSE net.status = 0

        END IF
        PUT #net.client, , net.status
        DELAY 1
        IF net.status = 1 THEN PRINT "CDFCC Verify: OK"
        IF net.status = 0 THEN PRINT "CDFCC Verify: FAILED"
    CASE 1
        PUT #net.client, , cdfcc
        DELAY 2

        GET #net.client, , net.status
        IF net.status = 1 THEN PRINT "CDFCC Verify: OK"
        IF net.status = 0 THEN PRINT "CDFCC Verify: FAILED"

END SELECT

IF net.status = 0 THEN GOTO titlescreen
'send config to  client

IF net.player = 0 THEN PRINT "Sending Host Configs. Please Wait..."
IF net.player = 1 THEN PRINT "Receiving Host Configs. Please Wait..."



IF debug = 1 THEN GOTO skip

COLOR RGB(0, 255, 0)
SELECT CASE net.player
    CASE 0

        PUT #net.client, , character1
        PRINT "Û";
        DELAY 1
        PUT #net.client, , character2
        PRINT "Û";
        DELAY 1
        PUT #net.client, , character3
        PRINT "Û";
        DELAY 1
        PUT #net.client, , character4
        PRINT "Û";
        DELAY 1
        PUT #net.client, , character5
        PRINT "Û";
        DELAY 1
        PUT #net.client, , character6
        PRINT "Û";
        DELAY 1
        PUT #net.client, , bonus1
        PRINT "Û";
        DELAY 1
        PUT #net.client, , bonus2
        PRINT "Û";
        DELAY 1
        PUT #net.client, , bonus3
        PRINT "Û";
        DELAY 1
        PUT #net.client, , bonus4
        PRINT "Û";
        DELAY 1
        PUT #net.client, , bonus5
        PRINT "Û";
        DELAY 1
        PUT #net.client, , bonus6
        PRINT "Û";
        DELAY 1
        PUT #net.client, , about
        PRINT "Û";
        DELAY 1
        PUT #net.client, , attack1
        PRINT "Û";
        DELAY 1
        PUT #net.client, , attack2
        PRINT "Û";
        DELAY 1
        PUT #net.client, , attack3
        PRINT "Û";
        DELAY 1
        PUT #net.client, , attack4
        PRINT "Û";
        DELAY 1
        PUT #net.client, , defense1
        PRINT "Û";
        DELAY 1
        PUT #net.client, , defense2
        PRINT "Û";
        DELAY 1
        PUT #net.client, , defense3
        PRINT "Û";
        DELAY 1
        PUT #net.client, , defense4
        PRINT "Û";
        DELAY 1
        PUT #net.client, , magic1
        PRINT "Û";
        DELAY 1
        PUT #net.client, , magic2
        PRINT "Û";
        DELAY 1
        PUT #net.client, , magic3
        PRINT "Û";
        DELAY 1
        PUT #net.client, , magic4
        PRINT "Û";
        DELAY 1
        PUT #net.client, , character1special
        PRINT "Û";
        DELAY 1
        PUT #net.client, , character2special
        PRINT "Û";
        DELAY 1
        PUT #net.client, , character3special
        PRINT "Û";
        DELAY 1
        PUT #net.client, , character4special
        PRINT "Û";
        DELAY 1
        PUT #net.client, , character5special
        PRINT "Û";
        DELAY 1
        PUT #net.client, , character6special
        PRINT "Û";
        DELAY 1
        net.status = 1
        PUT #net.client, , net.status
        PRINT "T"
        DELAY 1
    CASE 1
        net.status = 0
        DELAY 1
        GET #net.client, , character1
        PRINT "Û";
        DELAY 1
        GET #net.client, , character2
        PRINT "Û";
        DELAY 1
        GET #net.client, , character3
        PRINT "Û";
        DELAY 1
        GET #net.client, , character4
        PRINT "Û";
        DELAY 1
        GET #net.client, , character5
        PRINT "Û";
        DELAY 1
        GET #net.client, , character6
        PRINT "Û";
        DELAY 1
        GET #net.client, , bonus1
        PRINT "Û";
        DELAY 1
        GET #net.client, , bonus2
        PRINT "Û";
        DELAY 1
        GET #net.client, , bonus3
        PRINT "Û";
        DELAY 1
        GET #net.client, , bonus4
        PRINT "Û";
        DELAY 1
        GET #net.client, , bonus5
        PRINT "Û";
        DELAY 1
        GET #net.client, , bonus6
        PRINT "Û";
        DELAY 1
        GET #net.client, , about
        PRINT "Û";
        DELAY 1
        GET #net.client, , attack1
        PRINT "Û";
        DELAY 1
        GET #net.client, , attack2
        PRINT "Û";
        DELAY 1
        GET #net.client, , attack3
        PRINT "Û";
        DELAY 1
        GET #net.client, , attack4
        PRINT "Û";
        DELAY 1
        GET #net.client, , defense1
        PRINT "Û";
        DELAY 1
        GET #net.client, , defense2
        PRINT "Û";
        DELAY 1
        GET #net.client, , defense3
        PRINT "Û";
        DELAY 1
        GET #net.client, , defense4
        PRINT "Û";
        DELAY 1
        GET #net.client, , magic1
        PRINT "Û";
        DELAY 1
        GET #net.client, , magic2
        PRINT "Û";
        DELAY 1
        GET #net.client, , magic3
        PRINT "Û";
        DELAY 1
        GET #net.client, , magic4
        PRINT "Û";
        DELAY 1
        GET #net.client, , character1special
        PRINT "Û";
        DELAY 1
        GET #net.client, , character2special
        PRINT "Û";
        DELAY 1
        GET #net.client, , character3special
        PRINT "Û";
        DELAY 1
        GET #net.client, , character4special
        PRINT "Û";
        DELAY 1
        GET #net.client, , character5special
        PRINT "Û";
        DELAY 1
        GET #net.client, , character6special
        PRINT "Û";
        DELAY 1
        GET #net.client, , net.status
        PRINT net.status
        DELAY 1


END SELECT
skip:
net.online = 1



DISPLAY
start_game:
submenu = 0
KEYCLEAR
PRINTMODE KEEPBACKGROUND
COLOR RGB(0, 0, 0)
IF settings.ldmode = 1 THEN COLOR RGB(255, 255, 255)
vo = 28
ho = 4
no = 3
sp = 26
hm = 1
opo = 1
DO
    CLS
    IF settings.ldmode = 0 THEN PUTIMAGE (0, 0), light_theme
    IF settings.ldmode = 1 THEN PUTIMAGE (0, 0), dark_theme

    'box 6, 27, 75, 28
    IF debug = true THEN GOSUB debug
    IF k = -15616 THEN debug = debug + 1
    COLOR RGB(255, 255, 255)
    GOSUB menu
    COLOR RGB(0, 0, 0)
    IF settings.ldmode = 1 THEN COLOR RGB(255, 255, 255)

    SELECT CASE submenu
        CASE 0
            LOCATE 4, 1: CENTERPRINT "Page" + STR$(submenu + 1)

            IF net.online = 0 THEN LOCATE 3, 1: CENTERPRINT "Player " + STR$(turn + 1) + " Please select a character"
            IF net.online = 1 THEN LOCATE 3, 1: CENTERPRINT "Please select a character"
            LOCATE 5, 8: PRINT character1.name
            LOCATE 5, 34: PRINT character2.name
            LOCATE 5, 60: PRINT character3.name


            LOCATE 26, 5
            COLOR RGB(255, 255, 255)
            SELECT CASE opo
                CASE 1
                    PRINT character1.description

                CASE 2
                    PRINT character2.description

                CASE 3
                    PRINT character3.description

            END SELECT

            LOCATE 20, 4: PRINT "Starting Health: "; character1.health
            LOCATE 21, 4: PRINT "Attack modifier: x"; character1.attack_multiplier
            LOCATE 22, 4: PRINT "Defence modifier: x"; character1.defense_multiplier
            LOCATE 23, 4: PRINT "Magic Modifier: x"; character1.magic_multiplier
            LOCATE 24, 4: PRINT "Points per turn: "; character1.points_per_turn
            LOCATE 25, 4: PRINT "Magic per turn: "; character1.magic_per_turn
            LOCATE 20, 30: PRINT "Starting Health: "; character2.health
            LOCATE 21, 30: PRINT "Attack modifier: x"; character2.attack_multiplier
            LOCATE 22, 30: PRINT "Defence modifier: x"; character2.defense_multiplier
            LOCATE 23, 30: PRINT "Magic Modifier: x"; character2.magic_multiplier
            LOCATE 24, 30: PRINT "Points per turn: "; character2.points_per_turn
            LOCATE 25, 30: PRINT "Magic per turn: "; character2.magic_per_turn
            LOCATE 20, 56: PRINT "Starting Health: "; character3.health
            LOCATE 21, 56: PRINT "Attack modifier: x"; character3.attack_multiplier
            LOCATE 22, 56: PRINT "Defence modifier: x"; character3.defense_multiplier
            LOCATE 23, 56: PRINT "Magic Modifier: x"; character3.magic_multiplier
            LOCATE 24, 56: PRINT "Points per turn: "; character3.points_per_turn
            LOCATE 25, 56: PRINT "Magic per turn: "; character3.magic_per_turn
            LOCATE 28, 4: PRINT "  Select this character"
            LOCATE 28, 30: PRINT "  Select this character"
            LOCATE 28, 56: PRINT "  Select this character"

            COLOR RGB(0, 0, 0)
            IF settings.ldmode = 1 THEN COLOR RGB(255, 255, 255)


            IF choice = 1 THEN
                choice = 0
                IF opo = 1 GOTO characterassign
                IF opo = 2 GOTO characterassign
                IF opo = 3 GOTO characterassign

                IF opo = 99 GOTO titlescreen

            END IF
            IF pageturn <> 0 THEN submenu = 1
        CASE 1
            LOCATE 4, 1: CENTERPRINT "Page" + STR$(submenu + 1)
            IF net.online = 0 THEN LOCATE 3, 1: CENTERPRINT "Player " + STR$(turn + 1) + " Please select a character"
            IF net.online = 1 THEN LOCATE 3, 1: CENTERPRINT "Please select a character"

            LOCATE 5, 8: PRINT character4.name
            LOCATE 5, 34: PRINT character5.name
            LOCATE 5, 60: PRINT character6.name
            LOCATE 26, 5
            COLOR RGB(255, 255, 255)
            SELECT CASE opo
                CASE 1
                    PRINT character4.description

                CASE 2
                    PRINT character5.description

                CASE 3
                    PRINT character6.description

            END SELECT


            LOCATE 20, 4: PRINT "Starting Health: "; character4.health
            LOCATE 21, 4: PRINT "Attack modifier: x"; character4.attack_multiplier
            LOCATE 22, 4: PRINT "Defence modifier: x"; character4.defense_multiplier
            LOCATE 23, 4: PRINT "Magic Modifier: x"; character4.magic_multiplier
            LOCATE 24, 4: PRINT "Points per turn: "; character4.points_per_turn
            LOCATE 25, 4: PRINT "Magic per turn: "; character4.magic_per_turn
            LOCATE 20, 30: PRINT "Starting Health: "; character5.health
            LOCATE 21, 30: PRINT "Attack modifier: x"; character5.attack_multiplier
            LOCATE 22, 30: PRINT "Defence modifier: x"; character5.defense_multiplier
            LOCATE 23, 30: PRINT "Magic Modifier: x"; character5.magic_multiplier
            LOCATE 24, 30: PRINT "Points per turn: "; character5.points_per_turn
            LOCATE 25, 30: PRINT "Magic per turn: "; character5.magic_per_turn
            LOCATE 20, 56: PRINT "Starting Health: "; character6.health
            LOCATE 21, 56: PRINT "Attack modifier: x"; character6.attack_multiplier
            LOCATE 22, 56: PRINT "Defence modifier: x"; character6.defense_multiplier
            LOCATE 23, 56: PRINT "Magic Modifier: x"; character6.magic_multiplier
            LOCATE 24, 56: PRINT "Points per turn: "; character6.points_per_turn
            LOCATE 25, 56: PRINT "Magic per turn: "; character6.magic_per_turn
            LOCATE 28, 4: PRINT "  Select this character"
            LOCATE 28, 30: PRINT "  Select this character"
            LOCATE 28, 56: PRINT "  Select this character"

            COLOR RGB(0, 0, 0)
            IF settings.ldmode = 1 THEN COLOR RGB(255, 255, 255)
            IF choice = 1 THEN
                choice = 0
                IF opo = 1 GOTO characterassign
                IF opo = 2 GOTO characterassign
                IF opo = 3 GOTO characterassign

                IF opo = 99 GOTO titlescreen

            END IF
            IF pageturn <> 0 THEN submenu = 0

    END SELECT

    DISPLAY
    IF settings.fpslock = 1 THEN LIMIT settings.fps
LOOP
characterassign:
IF net.online = 1 THEN turn = net.player

SELECT CASE turn
    CASE 0
        SELECT CASE submenu
            CASE 0
                IF opo = 1 THEN
                    player1.name = character1.name
                    player1.health = character1.health
                    player1.magic = character1.magic
                    player1.points_per_turn = character1.points_per_turn
                    player1.magic_per_turn = character1.magic_per_turn
                    player1.attack_multiplier = character1.attack_multiplier
                    player1.defense_multiplier = character1.defense_multiplier
                    player1.magic_multiplier = character1.magic_multiplier
                    player1.sprite_sheet_x = character1.sprite_sheet_x
                    player1.sprite_sheet_y = character1.sprite_sheet_y
                    player1special = character1special
                END IF
                IF opo = 2 THEN
                    player1.name = character2.name
                    player1.health = character2.health
                    player1.magic = character2.magic
                    player1.points_per_turn = character2.points_per_turn
                    player1.magic_per_turn = character2.magic_per_turn
                    player1.attack_multiplier = character2.attack_multiplier
                    player1.defense_multiplier = character2.defense_multiplier
                    player1.magic_multiplier = character2.magic_multiplier
                    player1.sprite_sheet_x = character2.sprite_sheet_x
                    player1.sprite_sheet_y = character2.sprite_sheet_y
                    player1special = character2special
                END IF
                IF opo = 3 THEN
                    player1.name = character3.name
                    player1.health = character3.health
                    player1.magic = character3.magic
                    player1.points_per_turn = character3.points_per_turn
                    player1.magic_per_turn = character3.magic_per_turn
                    player1.attack_multiplier = character3.attack_multiplier
                    player1.defense_multiplier = character3.defense_multiplier
                    player1.magic_multiplier = character3.magic_multiplier
                    player1.sprite_sheet_x = character3.sprite_sheet_x
                    player1.sprite_sheet_y = character3.sprite_sheet_y
                    player1special = character3special
                END IF
            CASE 1
                IF opo = 1 THEN
                    player1.name = character4.name
                    player1.health = character4.health
                    player1.magic = character4.magic
                    player1.points_per_turn = character4.points_per_turn
                    player1.magic_per_turn = character4.magic_per_turn
                    player1.attack_multiplier = character4.attack_multiplier
                    player1.defense_multiplier = character4.defense_multiplier
                    player1.magic_multiplier = character4.magic_multiplier
                    player1.sprite_sheet_x = character4.sprite_sheet_x
                    player1.sprite_sheet_y = character4.sprite_sheet_y
                    player1special = character4special
                END IF
                IF opo = 2 THEN
                    player1.name = character5.name
                    player1.health = character5.health
                    player1.magic = character5.magic
                    player1.points_per_turn = character5.points_per_turn
                    player1.magic_per_turn = character5.magic_per_turn
                    player1.attack_multiplier = character5.attack_multiplier
                    player1.defense_multiplier = character5.defense_multiplier
                    player1.magic_multiplier = character5.magic_multiplier
                    player1.sprite_sheet_x = character5.sprite_sheet_x
                    player1.sprite_sheet_y = character5.sprite_sheet_y
                    player1special = character5special
                END IF
                IF opo = 3 THEN
                    player1.name = character6.name
                    player1.health = character6.health
                    player1.magic = character6.magic
                    player1.points_per_turn = character6.points_per_turn
                    player1.magic_per_turn = character6.magic_per_turn
                    player1.attack_multiplier = character6.attack_multiplier
                    player1.defense_multiplier = character6.defense_multiplier
                    player1.magic_multiplier = character6.magic_multiplier
                    player1.sprite_sheet_x = character6.sprite_sheet_x
                    player1.sprite_sheet_y = character6.sprite_sheet_y
                    player1special = character6special
                END IF


        END SELECT
    CASE 1
        SELECT CASE submenu
            CASE 0
                IF opo = 1 THEN
                    player2.name = character1.name
                    player2.health = character1.health
                    player2.magic = character1.magic
                    player2.points_per_turn = character1.points_per_turn
                    player2.magic_per_turn = character1.magic_per_turn
                    player2.attack_multiplier = character1.attack_multiplier
                    player2.defense_multiplier = character1.defense_multiplier
                    player2.magic_multiplier = character1.magic_multiplier
                    player2.sprite_sheet_x = character1.sprite_sheet_x
                    player2.sprite_sheet_y = character1.sprite_sheet_y
                    player2special = character1special
                END IF
                IF opo = 2 THEN
                    player2.name = character2.name
                    player2.health = character2.health
                    player2.magic = character2.magic
                    player2.points_per_turn = character2.points_per_turn
                    player2.magic_per_turn = character2.magic_per_turn
                    player2.attack_multiplier = character2.attack_multiplier
                    player2.defense_multiplier = character2.defense_multiplier
                    player2.magic_multiplier = character2.magic_multiplier
                    player2.sprite_sheet_x = character2.sprite_sheet_x
                    player2.sprite_sheet_y = character2.sprite_sheet_y
                    player2special = character2special
                END IF
                IF opo = 3 THEN
                    player2.name = character3.name
                    player2.health = character3.health
                    player2.magic = character3.magic
                    player2.points_per_turn = character3.points_per_turn
                    player2.magic_per_turn = character3.magic_per_turn
                    player2.attack_multiplier = character3.attack_multiplier
                    player2.defense_multiplier = character3.defense_multiplier
                    player2.magic_multiplier = character3.magic_multiplier
                    player2.sprite_sheet_x = character3.sprite_sheet_x
                    player2.sprite_sheet_y = character3.sprite_sheet_y
                    player2special = character3special
                END IF
            CASE 1
                IF opo = 1 THEN
                    player2.name = character4.name
                    player2.health = character4.health
                    player2.magic = character4.magic
                    player2.points_per_turn = character4.points_per_turn
                    player2.magic_per_turn = character4.magic_per_turn
                    player2.attack_multiplier = character4.attack_multiplier
                    player2.defense_multiplier = character4.defense_multiplier
                    player2.magic_multiplier = character4.magic_multiplier
                    player2.sprite_sheet_x = character4.sprite_sheet_x
                    player2.sprite_sheet_y = character4.sprite_sheet_y
                    player2special = character4special
                END IF
                IF opo = 2 THEN
                    player2.name = character5.name
                    player2.health = character5.health
                    player2.magic = character5.magic
                    player2.points_per_turn = character5.points_per_turn
                    player2.magic_per_turn = character5.magic_per_turn
                    player2.attack_multiplier = character5.attack_multiplier
                    player2.defense_multiplier = character5.defense_multiplier
                    player2.magic_multiplier = character5.magic_multiplier
                    player2.sprite_sheet_x = character5.sprite_sheet_x
                    player2.sprite_sheet_y = character5.sprite_sheet_y
                    player2special = character5special
                END IF
                IF opo = 3 THEN
                    player2.name = character6.name
                    player2.health = character6.health
                    player2.magic = character6.magic
                    player2.points_per_turn = character6.points_per_turn
                    player2.magic_per_turn = character6.magic_per_turn
                    player2.attack_multiplier = character6.attack_multiplier
                    player2.defense_multiplier = character6.defense_multiplier
                    player2.magic_multiplier = character6.magic_multiplier
                    player2.sprite_sheet_x = character6.sprite_sheet_x
                    player2.sprite_sheet_y = character6.sprite_sheet_y
                    player2special = character6special
                END IF


        END SELECT
END SELECT
IF net.online = 1 THEN GOTO bonus_pick
IF turn = 1 THEN turn = 0: GOTO bonus_pick
turn = turn + 1
GOTO start_game

bonus_pick:
CLS
submenu = 0
KEYCLEAR
PRINTMODE KEEPBACKGROUND
COLOR RGB(0, 0, 0)
IF settings.ldmode = 1 THEN COLOR RGB(255, 255, 255)
vo = 28
ho = 4
no = 3
sp = 26
hm = 1
opo = 1
DO
    CLS
    IF settings.ldmode = 0 THEN PUTIMAGE (0, 0), light_theme
    IF settings.ldmode = 1 THEN PUTIMAGE (0, 0), dark_theme

    IF debug = true THEN GOSUB debug
    IF k = -15616 THEN debug = debug + 1
    COLOR RGB(255, 255, 255)
    GOSUB menu
    COLOR RGB(0, 0, 0)
    IF settings.ldmode = 1 THEN COLOR RGB(255, 255, 255)

    SELECT CASE submenu

        CASE 0
            LOCATE 4, 1: CENTERPRINT "Page" + STR$(submenu + 1)
            IF net.online = 1 THEN LOCATE 3, 1: CENTERPRINT "Please select a bonus"
            IF net.online = 0 THEN LOCATE 3, 1: CENTERPRINT "Player " + STR$(turn + 1) + " Please select a bonus"
            LOCATE 5, 8: PRINT bonus1.name
            LOCATE 5, 34: PRINT bonus2.name
            LOCATE 5, 60: PRINT bonus3.name
            LOCATE 27, 5
            COLOR RGB(255, 255, 255)
            SELECT CASE opo
                CASE 1
                    PRINT bonus1.description

                CASE 2
                    PRINT bonus2.description

                CASE 3
                    PRINT bonus3.description

            END SELECT

            LOCATE 20, 4: PRINT "Starting Health: +"; bonus1.health
            LOCATE 21, 4: PRINT "Attack modifier: +"; bonus1.attack_boost_multiplier
            LOCATE 22, 4: PRINT "Defence modifier: +"; bonus1.defense_boost_multiplier
            LOCATE 23, 4: PRINT "Magic Modifier: +"; bonus1.magic_boost_multiplier
            LOCATE 24, 4: PRINT "Points per turn: +"; bonus1.points_per_turn
            LOCATE 25, 4: PRINT "Magic per turn: +"; bonus1.magic_per_turn
            LOCATE 26, 4: PRINT "Starting magic: +"; bonus1.magic
            LOCATE 20, 30: PRINT "Starting Health: +"; bonus2.health
            LOCATE 21, 30: PRINT "Attack modifier: +"; bonus2.attack_boost_multiplier
            LOCATE 22, 30: PRINT "Defence modifier: +"; bonus2.defense_boost_multiplier
            LOCATE 23, 30: PRINT "Magic Modifier: +"; bonus2.magic_boost_multiplier
            LOCATE 24, 30: PRINT "Points per turn: +"; bonus2.points_per_turn
            LOCATE 25, 30: PRINT "Magic per turn: +"; bonus2.magic_per_turn
            LOCATE 26, 30: PRINT "Starting magic: +"; bonus2.magic
            LOCATE 20, 56: PRINT "Starting Health: +"; bonus3.health

            LOCATE 21, 56: PRINT "Attack modifier: +"; bonus3.attack_boost_multiplier
            LOCATE 22, 56: PRINT "Defence modifier: +"; bonus3.defense_boost_multiplier
            LOCATE 23, 56: PRINT "Magic Modifier: +"; bonus3.magic_boost_multiplier
            LOCATE 24, 56: PRINT "Points per turn: +"; bonus3.points_per_turn
            LOCATE 25, 56: PRINT "Magic per turn: +"; bonus3.magic_per_turn
            LOCATE 26, 56: PRINT "Starting magic: +"; bonus3.magic
            LOCATE 28, 4: PRINT "  Select this bonus"
            LOCATE 28, 30: PRINT "  Select this bonus"
            LOCATE 28, 56: PRINT "  Select this bonus"

            COLOR RGB(0, 0, 0)
            IF settings.ldmode = 1 THEN COLOR RGB(255, 255, 255)


            IF choice = 1 THEN
                choice = 0
                IF opo = 1 GOTO bonusassign
                IF opo = 2 GOTO bonusassign
                IF opo = 3 GOTO bonusassign

                IF opo = 99 GOTO titlescreen

            END IF
            IF pageturn <> 0 THEN submenu = 1
        CASE 1
            LOCATE 4, 1: CENTERPRINT "Page" + STR$(submenu + 1)
            IF net.online = 1 THEN LOCATE 3, 1: CENTERPRINT "Please select a bonus"
            IF net.online = 0 THEN LOCATE 3, 1: CENTERPRINT "Player " + STR$(turn + 1) + " Please select a bonus"

            LOCATE 5, 8: PRINT bonus4.name
            LOCATE 5, 34: PRINT bonus5.name
            LOCATE 5, 60: PRINT bonus6.name
            LOCATE 27, 5
            COLOR RGB(255, 255, 255)
            SELECT CASE opo
                CASE 1
                    PRINT bonus4.description

                CASE 2
                    PRINT bonus5.description

                CASE 3
                    PRINT bonus6.description

            END SELECT

            LOCATE 20, 4: PRINT "Starting Health: +"; bonus4.health
            LOCATE 21, 4: PRINT "Attack modifier: +"; bonus4.attack_boost_multiplier
            LOCATE 22, 4: PRINT "Defence modifier: +"; bonus4.defense_boost_multiplier
            LOCATE 23, 4: PRINT "Magic Modifier: +"; bonus4.magic_boost_multiplier
            LOCATE 24, 4: PRINT "Points per turn: +"; bonus4.points_per_turn
            LOCATE 25, 4: PRINT "Magic per turn: +"; bonus4.magic_per_turn
            LOCATE 26, 4: PRINT "Starting magic: +"; bonus4.magic
            LOCATE 20, 30: PRINT "Starting Health: +"; bonus5.health
            LOCATE 21, 30: PRINT "Attack modifier: +"; bonus5.attack_boost_multiplier
            LOCATE 22, 30: PRINT "Defence modifier: +"; bonus5.defense_boost_multiplier
            LOCATE 23, 30: PRINT "Magic Modifier: +"; bonus5.magic_boost_multiplier
            LOCATE 24, 30: PRINT "Points per turn: +"; bonus5.points_per_turn
            LOCATE 25, 30: PRINT "Magic per turn: +"; bonus5.magic_per_turn
            LOCATE 26, 30: PRINT "Starting magic: +"; bonus5.magic
            LOCATE 20, 56: PRINT "Starting Health: +"; bonus6.health
            LOCATE 21, 56: PRINT "Attack modifier: +"; bonus6.attack_boost_multiplier
            LOCATE 22, 56: PRINT "Defence modifier: +"; bonus6.defense_boost_multiplier
            LOCATE 23, 56: PRINT "Magic Modifier: +"; bonus6.magic_boost_multiplier
            LOCATE 24, 56: PRINT "Points per turn: +"; bonus6.points_per_turn
            LOCATE 25, 56: PRINT "Magic per turn: +"; bonus6.magic_per_turn
            LOCATE 26, 56: PRINT "Starting magic: +"; bonus6.magic
            LOCATE 28, 4: PRINT "  Select this bonus"
            LOCATE 28, 30: PRINT "  Select this bonus"
            LOCATE 28, 56: PRINT "  Select this bonus"

            COLOR RGB(0, 0, 0)
            IF settings.ldmode = 1 THEN COLOR RGB(255, 255, 255)
            IF choice = 1 THEN
                choice = 0
                IF opo = 1 GOTO bonusassign
                IF opo = 2 GOTO bonusassign
                IF opo = 3 GOTO bonusassign

                IF opo = 99 GOTO titlescreen

            END IF
            IF pageturn <> 0 THEN submenu = 0


    END SELECT
    DISPLAY
    IF settings.fpslock = 1 THEN LIMIT settings.fps
LOOP
bonusassign:
IF net.online = 1 THEN turn = net.player
SELECT CASE turn
    CASE 0
        SELECT CASE submenu
            CASE 0
                IF opo = 1 THEN
                    player1.health = player1.health + bonus1.health
                    player1.magic = player1.magic + bonus1.magic
                    player1.points_per_turn = player1.points_per_turn + bonus1.points_per_turn
                    player1.magic_per_turn = player1.magic_per_turn + bonus1.magic_per_turn
                    player1.attack_multiplier = player1.attack_multiplier + bonus1.attack_boost_multiplier
                    player1.defense_multiplier = player1.defense_multiplier + bonus1.defense_boost_multiplier
                    player1.magic_multiplier = player1.magic_multiplier + bonus1.magic_boost_multiplier
                END IF
                IF opo = 2 THEN
                    player1.health = player1.health + bonus2.health
                    player1.magic = player1.magic + bonus2.magic
                    player1.points_per_turn = player1.points_per_turn + bonus2.points_per_turn
                    player1.magic_per_turn = player1.magic_per_turn + bonus2.magic_per_turn
                    player1.attack_multiplier = player1.attack_multiplier + bonus2.attack_boost_multiplier
                    player1.defense_multiplier = player1.defense_multiplier + bonus2.defense_boost_multiplier
                    player1.magic_multiplier = player1.magic_multiplier + bonus2.magic_boost_multiplier
                END IF
                IF opo = 3 THEN
                    player1.health = player1.health + bonus3.health
                    player1.magic = player1.magic + bonus3.magic
                    player1.points_per_turn = player1.points_per_turn + bonus3.points_per_turn
                    player1.magic_per_turn = player1.magic_per_turn + bonus3.magic_per_turn
                    player1.attack_multiplier = player1.attack_multiplier + bonus3.attack_boost_multiplier
                    player1.defense_multiplier = player1.defense_multiplier + bonus3.defense_boost_multiplier
                    player1.magic_multiplier = player1.magic_multiplier + bonus3.magic_boost_multiplier
                END IF
            CASE 1
                IF opo = 1 THEN
                    player1.health = player1.health + bonus4.health
                    player1.magic = player1.magic + bonus4.magic
                    player1.points_per_turn = player1.points_per_turn + bonus4.points_per_turn
                    player1.magic_per_turn = player1.magic_per_turn + bonus4.magic_per_turn
                    player1.attack_multiplier = player1.attack_multiplier + bonus4.attack_boost_multiplier
                    player1.defense_multiplier = player1.defense_multiplier + bonus4.defense_boost_multiplier
                    player1.magic_multiplier = player1.magic_multiplier + bonus4.magic_boost_multiplier
                END IF
                IF opo = 2 THEN
                    player1.health = player1.health + bonus5.health
                    player1.magic = player1.magic + bonus5.magic
                    player1.points_per_turn = player1.points_per_turn + bonus5.points_per_turn
                    player1.magic_per_turn = player1.magic_per_turn + bonus5.magic_per_turn
                    player1.attack_multiplier = player1.attack_multiplier + bonus5.attack_boost_multiplier
                    player1.defense_multiplier = player1.defense_multiplier + bonus5.defense_boost_multiplier
                    player1.magic_multiplier = player1.magic_multiplier + bonus5.magic_boost_multiplier
                END IF
                IF opo = 3 THEN
                    player1.health = player1.health + bonus6.health
                    player1.magic = player1.magic + bonus6.magic
                    player1.points_per_turn = player1.points_per_turn + bonus6.points_per_turn
                    player1.magic_per_turn = player1.magic_per_turn + bonus6.magic_per_turn
                    player1.attack_multiplier = player1.attack_multiplier + bonus6.attack_boost_multiplier
                    player1.defense_multiplier = player1.defense_multiplier + bonus6.defense_boost_multiplier
                    player1.magic_multiplier = player1.magic_multiplier + bonus6.magic_boost_multiplier
                END IF
        END SELECT
    CASE 1
        SELECT CASE submenu
            CASE 0
                IF opo = 1 THEN
                    player2.health = player2.health + bonus1.health
                    player2.magic = player2.magic + bonus1.magic
                    player2.points_per_turn = player2.points_per_turn + bonus1.points_per_turn
                    player2.magic_per_turn = player2.magic_per_turn + bonus1.magic_per_turn
                    player2.attack_multiplier = player2.attack_multiplier + bonus1.attack_boost_multiplier
                    player2.defense_multiplier = player2.defense_multiplier + bonus1.defense_boost_multiplier
                    player2.magic_multiplier = player2.magic_multiplier + bonus1.magic_boost_multiplier
                END IF
                IF opo = 2 THEN
                    player2.health = player2.health + bonus2.health
                    player2.magic = player2.magic + bonus2.magic
                    player2.points_per_turn = player2.points_per_turn + bonus2.points_per_turn
                    player2.magic_per_turn = player2.magic_per_turn + bonus2.magic_per_turn
                    player2.attack_multiplier = player2.attack_multiplier + bonus2.attack_boost_multiplier
                    player2.defense_multiplier = player2.defense_multiplier + bonus2.defense_boost_multiplier
                    player2.magic_multiplier = player2.magic_multiplier + bonus2.magic_boost_multiplier
                END IF
                IF opo = 3 THEN
                    player2.health = player2.health + bonus3.health
                    player2.magic = player2.magic + bonus3.magic
                    player2.points_per_turn = player2.points_per_turn + bonus3.points_per_turn
                    player2.magic_per_turn = player2.magic_per_turn + bonus3.magic_per_turn
                    player2.attack_multiplier = player2.attack_multiplier + bonus3.attack_boost_multiplier
                    player2.defense_multiplier = player2.defense_multiplier + bonus3.defense_boost_multiplier
                    player2.magic_multiplier = player2.magic_multiplier + bonus3.magic_boost_multiplier
                END IF
            CASE 1
                IF opo = 1 THEN
                    player2.health = player2.health + bonus4.health
                    player2.magic = player2.magic + bonus4.magic
                    player2.points_per_turn = player2.points_per_turn + bonus4.points_per_turn
                    player2.magic_per_turn = player2.magic_per_turn + bonus4.magic_per_turn
                    player2.attack_multiplier = player2.attack_multiplier + bonus4.attack_boost_multiplier
                    player2.defense_multiplier = player2.defense_multiplier + bonus4.defense_boost_multiplier
                    player2.magic_multiplier = player2.magic_multiplier + bonus4.magic_boost_multiplier
                END IF
                IF opo = 2 THEN
                    player2.health = player2.health + bonus5.health
                    player2.magic = player2.magic + bonus5.magic
                    player2.points_per_turn = player2.points_per_turn + bonus5.points_per_turn
                    player2.magic_per_turn = player2.magic_per_turn + bonus5.magic_per_turn
                    player2.attack_multiplier = player2.attack_multiplier + bonus5.attack_boost_multiplier
                    player2.defense_multiplier = player2.defense_multiplier + bonus5.defense_boost_multiplier
                    player2.magic_multiplier = player2.magic_multiplier + bonus5.magic_boost_multiplier
                END IF
                IF opo = 3 THEN
                    player2.health = player2.health + bonus6.health
                    player2.magic = player2.magic + bonus6.magic
                    player2.points_per_turn = player2.points_per_turn + bonus6.points_per_turn
                    player2.magic_per_turn = player2.magic_per_turn + bonus6.magic_per_turn
                    player2.attack_multiplier = player2.attack_multiplier + bonus6.attack_boost_multiplier
                    player2.defense_multiplier = player2.defense_multiplier + bonus6.defense_boost_multiplier
                    player2.magic_multiplier = player2.magic_multiplier + bonus6.magic_boost_multiplier
                END IF
        END SELECT


END SELECT
IF net.online = 1 THEN GOTO connect2
IF turn = 1 THEN turn = 0: LOCATE 1, 1: PRINT "Loading Data, Please Wait...": DISPLAY: GOTO game
turn = turn + 1
GOTO bonus_pick

connect2:
AUTODISPLAY
CLS
COLOR RGB(255, 255, 255)
PRINT "Waiting for Other Player"

net.status = 0
IF net.player = 0 THEN net.status = 1

SELECT CASE net.player
    CASE 0
        PUT #net.client, , net.status
    CASE 1
        DO
            GET #net.client, , net.status
        LOOP UNTIL net.status = 1
END SELECT

SELECT CASE net.player
    CASE 0
        DO
            CLOSE net.client
            net.client = OPENCONNECTION(net.host)
        LOOP UNTIL net.client <> 0
    CASE 1
        DO
            CLOSE net.client
            net.client = 0
            net.client = OPENCLIENT("TCP/IP:" + net.port + ":" + net.ip)
        LOOP UNTIL net.client <> 0
END SELECT


PRINT "Communicating Selections. Please wait..."
COLOR RGB(0, 255, 0)
SELECT CASE net.player
    CASE 0
        DELAY 1
        GET #net.client, , player2
        PRINT "Û";
        PRINT "Û";
        PUT #net.client, , player1
        DELAY 1
        DELAY 1
        GET #net.client, , player2special
        PRINT "Û";
        PRINT "Û";
        PUT #net.client, , player1special
        DELAY 1

    CASE 1
        PUT #net.client, , player2
        PRINT "Û";
        DELAY 1
        DELAY 1
        PRINT "Û";
        GET #net.client, , player1
        PUT #net.client, , player2special
        PRINT "Û";
        DELAY 1
        DELAY 1
        PRINT "Û";
        GET #net.client, , player1special




END SELECT
net.status = 0
IF net.player = 0 THEN net.status = 1


DISPLAY
game:
SNDSTOP song_handle
SELECT CASE INT(RND * 5)
    CASE 0: song_handle = PLAYMUSIC(game1)
    CASE 1: song_handle = PLAYMUSIC(game2)
    CASE 2: song_handle = PLAYMUSIC(game3)
    CASE 3: song_handle = PLAYMUSIC(game4)
    CASE 4: song_handle = PLAYMUSIC(game5)
END SELECT

CLS
ingame = 1
hm = 0
vo = 19
ho = 30
no = 5
sp = 1
turn = 1
turn = turn + 1
IF turn = 2 THEN turn = 0
submenu = 0
opo = 1
SELECT CASE turn
    CASE 0
        player1.points = player1.points + player1.points_per_turn
        player1.magic = player1.magic + player1.magic_per_turn
    CASE 1
        player2.points = player2.points + player2.points_per_turn
        player2.magic = player2.magic + player2.magic_per_turn
END SELECT
PLAYSOUND turn_change

opo = 1

DO

    CLS
    IF settings.ldmode = 0 THEN PUTIMAGE (0, 0), light_theme
    IF settings.ldmode = 1 THEN PUTIMAGE (0, 0), dark_theme

    BOX 29, 20, 51, 29
    IF k = -15616 THEN debug = debug + 1
    IF debug = true THEN GOSUB debug
    COLOR RGB(255, 255, 255)
    GOSUB menu

    LOCATE 3, 1
    COLOR RGB(0, 0, 0)
    IF settings.ldmode = 1 THEN COLOR RGB(255, 255, 255)
    CENTERPRINT "Player" + STR$(turn + 1) + "'s Turn"

    LOCATE 4, 1
    COLOR RGB(255, 255, 255)
    LOCATE 21, 4: PRINT "    Player 1"
    LOCATE 22, 4: PRINT "Current Health:"; player1.health
    LOCATE 23, 4: PRINT "Action Points: "; player1.points
    LOCATE 24, 4: PRINT "Magic Points:  "; player1.magic

    LOCATE 26, 4: PRINT "Status Effects:"
    LOCATE 27, 4: IF player1.effect1 > 0 OR player1.effect1 = -1 THEN PRINT player1.effect1name; ":"; player1.effect1 ELSE PRINT "EMPTY "
    LOCATE 27, 11: IF player1.effect2 > 0 THEN PRINT player1.effect2name; ":"; player1.effect2 ELSE PRINT "EMPTY "
    LOCATE 27, 18: IF player1.effect3 > 0 THEN PRINT player1.effect3name; ":"; player1.effect3 ELSE PRINT "EMPTY "


    LOCATE 21, 56: PRINT "    Player 2"
    LOCATE 22, 56: PRINT "Current Health:"; player2.health
    LOCATE 23, 56: PRINT "Action Points: "; player2.points
    LOCATE 24, 56: PRINT "Magic Points:  "; player2.magic
    LOCATE 26, 56: PRINT "Status Effects:"
    LOCATE 27, 56: IF player2.effect1 > 0 THEN PRINT player2.effect1name; ":"; player2.effect1 ELSE PRINT "EMPTY "
    LOCATE 27, 63: IF player2.effect2 > 0 THEN PRINT player2.effect2name; ":"; player2.effect2 ELSE PRINT "EMPTY "
    LOCATE 27, 70: IF player2.effect3 > 0 THEN PRINT player2.effect3name; ":"; player2.effect3 ELSE PRINT "EMPTY "

    COLOR RGB(255, 255, 255)

    IF submenu <> 8 AND submenu <> 10 THEN GOSUB sprite

    SELECT CASE submenu
        CASE 0
            hm = 0
            vo = 19
            ho = 30
            no = 5
            sp = 1
            IF net.online = 1 AND net.player <> turn OR turnchange = 1 THEN
                turnchange = 0
                LOCATE 21, 1: CENTERPRINT "Please Wait..."
                DISPLAY
                net.status = 0
                IF net.player = 0 THEN net.status = 1

                SELECT CASE net.player
                    CASE 0
                        PUT #net.client, , net.status
                    CASE 1
                        DO
                            GET #net.client, , net.status
                        LOOP UNTIL net.status = 1
                END SELECT

                SELECT CASE net.player
                    CASE 0
                        DO
                            CLOSE net.client
                            net.client = OPENCONNECTION(net.host)
                        LOOP UNTIL net.client <> 0
                    CASE 1
                        DO
                            CLOSE net.client
                            net.client = 0
                            net.client = OPENCLIENT("TCP/IP:" + net.port + ":" + net.ip)
                        LOOP UNTIL net.client <> 0
                END SELECT

                COLOR RGB(0, 255, 0)
                SELECT CASE net.player
                    CASE 0
                        SELECT CASE turn
                            CASE 0
                                PUT #net.client, , player2
                                DELAY 1
                                PUT #net.client, , player1
                                DELAY 1
                                PUT #net.client, , turn
                                DELAY 1
                            CASE 1
                                DELAY 1
                                GET #net.client, , player2
                                DELAY 1
                                GET #net.client, , player1
                                DELAY 1
                                GET #net.client, , turn

                        END SELECT
                    CASE 1
                        SELECT CASE turn
                            CASE 1

                                PUT #net.client, , player2
                                DELAY 1
                                PUT #net.client, , player1
                                DELAY 1
                                PUT #net.client, , turn
                                DELAY 1
                            CASE 0
                                DELAY 1
                                GET #net.client, , player2
                                DELAY 1
                                GET #net.client, , player1
                                DELAY 1
                                GET #net.client, , turn
                        END SELECT

                END SELECT
                turn = turn + 1
                IF turn = 2 THEN turn = 0
                PLAYSOUND turn_change

            END IF
            LOCATE 20, 30: PRINT "  Attack Moves"
            LOCATE 22, 30: PRINT "  Defend Moves"
            LOCATE 24, 30: PRINT "  Magic Moves"
            LOCATE 26, 30: PRINT "  Special Moves"
            LOCATE 28, 30: PRINT "  End Your Turn"
            IF choice = 1 THEN
                choice = 0
                IF opo = 1 THEN submenu = 1: opo = 1
                IF opo = 2 THEN submenu = 2: opo = 1
                IF opo = 3 THEN submenu = 3: opo = 1
                IF opo = 4 THEN submenu = 4: opo = 1
                IF opo = 5 THEN submenu = 11: opo = 1
            END IF

        CASE 1
            hm = 0
            vo = 19
            ho = 30
            no = 5
            sp = 1

            LOCATE 20, 30: PRINT "  " + attack1.name + STR$(attack1.cost) + "AP"
            LOCATE 22, 30: PRINT "  " + attack2.name + STR$(attack2.cost) + "AP"
            LOCATE 24, 30: PRINT "  " + attack3.name + STR$(attack3.cost) + "AP"
            LOCATE 26, 30: PRINT "  " + attack4.name + STR$(attack4.cost) + "AP"
            LOCATE 28, 30: PRINT "  Go Back"
            IF choice = 1 THEN
                choice = 0
                IF opo = 1 THEN move_type = 1: move_number = 1: submenu = 5
                IF opo = 2 THEN move_type = 1: move_number = 2: submenu = 5
                IF opo = 3 THEN move_type = 1: move_number = 3: submenu = 5
                IF opo = 4 THEN move_type = 1: move_number = 4: submenu = 5
                IF opo = 5 THEN submenu = 0: opo = 1
                opo = 1
            END IF
        CASE 2
            hm = 0
            vo = 19
            ho = 30
            no = 5
            sp = 1

            LOCATE 20, 30: PRINT "  " + defense1.name + STR$(defense1.cost) + "AP"
            LOCATE 22, 30: PRINT "  " + defense2.name + STR$(defense2.cost) + "AP"
            LOCATE 24, 30: PRINT "  " + defense3.name + STR$(defense3.cost) + "AP"
            LOCATE 26, 30: PRINT "  " + defense4.name + STR$(defense4.cost) + "AP"
            LOCATE 28, 30: PRINT "  Go Back"
            IF choice = 1 THEN
                choice = 0
                IF opo = 1 THEN move_type = 2: move_number = 1: submenu = 5
                IF opo = 2 THEN move_type = 2: move_number = 2: submenu = 5
                IF opo = 3 THEN move_type = 2: move_number = 3: submenu = 5
                IF opo = 4 THEN move_type = 2: move_number = 4: submenu = 5
                IF opo = 5 THEN submenu = 0: opo = 1
                opo = 1
            END IF
        CASE 3
            hm = 0
            vo = 19
            ho = 30
            no = 5
            sp = 1

            LOCATE 20, 30: PRINT "  " + magic1.name + STR$(magic1.cost) + "AP" + STR$(magic1.magic_cost) + "MP"
            LOCATE 22, 30: PRINT "  " + magic2.name + STR$(magic2.cost) + "AP" + STR$(magic2.magic_cost) + "MP"
            LOCATE 24, 30: PRINT "  " + magic3.name + STR$(magic3.cost) + "AP" + STR$(magic3.magic_cost) + "MP"
            LOCATE 26, 30: PRINT "  " + magic4.name + STR$(magic4.cost) + "AP" + STR$(magic4.magic_cost) + "MP"
            LOCATE 28, 30: PRINT "  Go Back"
            IF choice = 1 THEN
                choice = 0
                IF opo = 1 THEN move_type = 3: move_number = 1: submenu = 5
                IF opo = 2 THEN move_type = 3: move_number = 2: submenu = 5
                IF opo = 3 THEN move_type = 3: move_number = 3: submenu = 5
                IF opo = 4 THEN move_type = 3: move_number = 4: submenu = 5
                IF opo = 5 THEN submenu = 0: opo = 1
                opo = 1
            END IF

        CASE 4
            hm = 0
            vo = 19
            ho = 30
            no = 5
            sp = 1

            SELECT CASE turn
                CASE 0: LOCATE 20, 30: PRINT "  " + player1special.name + STR$(player1special.cost) + "AP"
                CASE 1: LOCATE 20, 30: PRINT "  " + player2special.name + STR$(player2special.cost) + "AP"

            END SELECT
            LOCATE 22, 30: PRINT "  " + special1.name + STR$(special1.cost) + "AP"
            LOCATE 24, 30: PRINT "  " + special2.name + STR$(special2.cost) + "AP"
            LOCATE 26, 30: PRINT "  " + special3.name + STR$(special3.cost) + "AP"

            'LOCATE 22, 30: PRINT "  " + magic2.name + "(" + STR$(magic2.cost) + " )"
            'LOCATE 24, 30: PRINT "  " + magic3.name + "(" + STR$(magic3.cost) + " )"
            'LOCATE 26, 30: PRINT "  " + magic4.name + "(" + STR$(magic4.cost) + " )"
            LOCATE 28, 30: PRINT "  Go Back"
            IF choice = 1 THEN
                choice = 0
                IF opo = 1 THEN
                    SELECT CASE turn
                        CASE 0: active = player1special: submenu = 6: move_type = 4
                        CASE 1: active = player1special: submenu = 6: move_type = 4
                    END SELECT
                END IF

                IF opo = 2 THEN move_type = 4: move_number = 2: submenu = 5
                IF opo = 3 THEN move_type = 4: move_number = 3: submenu = 5
                IF opo = 4 THEN move_type = 4: move_number = 4: submenu = 5

                IF opo = 5 THEN submenu = 0: opo = 1
            END IF


        CASE 5
            SELECT CASE move_type
                CASE 1
                    SELECT CASE move_number
                        CASE 1
                            active = attack1
                        CASE 2
                            active = attack2
                        CASE 3
                            active = attack3
                        CASE 4
                            active = attack4

                    END SELECT
                CASE 2
                    SELECT CASE move_number
                        CASE 1
                            active = defense1
                        CASE 2
                            active = defense2
                        CASE 3
                            active = defense3
                        CASE 4
                            active = defense4

                    END SELECT
                CASE 3
                    SELECT CASE move_number
                        CASE 1
                            active = magic1
                        CASE 2
                            active = magic2
                        CASE 3
                            active = magic3
                        CASE 4
                            active = magic4

                    END SELECT
                CASE 4
                    SELECT CASE move_number
                        CASE 2
                            active = special1
                        CASE 3
                            active = special2
                        CASE 4
                            active = special3
                    END SELECT
            END SELECT
            submenu = 6
            norefresh = 1

        CASE 6
            SELECT CASE turn
                CASE 0
                    IF active.cost > player1.points OR active.magic_cost > player1.magic THEN
                        submenu = move_type
                        PLAYSOUND error_sound

                    ELSE submenu = 7
                    END IF
                CASE 1
                    IF active.cost > player2.points OR active.magic_cost > player2.magic THEN
                        submenu = move_type
                        PLAYSOUND error_sound

                    ELSE submenu = 7
                    END IF
            END SELECT
            IF nocost = 1 THEN submenu = 7
            norefresh = 1
        CASE 7
            hm = 1
            vo = 28
            ho = 30
            no = 2
            sp = 10
            LOCATE 20, 1: CENTERPRINT "Move: " + active.name
            LOCATE 21, 33: PRINT "Cost: "; active.cost
            IF active.magic_cost > 0 THEN LOCATE 22, 33: PRINT "Magic Cost: "; active.magic_cost
            LOCATE 23, 30: PRINT active.description
            LOCATE 24, 30: PRINT active.description2
            LOCATE 26, 30: PRINT "Accuracy:" + STR$(active.accuracy) + "%"
            LOCATE 28, 32: PRINT "Go Back"
            LOCATE 28, 42: PRINT "Use This"
            IF choice = 1 THEN
                choice = 0
                IF opo = 1 THEN submenu = move_type

                IF opo = 2 THEN
                    IF nocost = 0 THEN
                        SELECT CASE turn
                            CASE 0
                                player1.points = player1.points - active.cost
                                player1.magic = player1.magic - active.magic_cost
                            CASE 1
                                player2.points = player2.points - active.cost
                                player2.magic = player2.magic - active.magic_cost

                        END SELECT
                    END IF
                    submenu = 8
                END IF
                opo = 1
            END IF
        CASE 8 'preanimate
            norefresh = 1
            submenu = 9
            IF net.online = 1 AND turn <> net.player THEN submenu = 10
        CASE 9 'calculate

            SELECT CASE turn
                CASE 0
                    SELECT CASE active.type
                        CASE 1
                            fail = INT(RND * 100) + 1
                            IF player1.effect1name = "STN" OR player1.effect1name = "DIS" THEN fail = fail - player1.effect1data
                            IF player1.effect2name = "STN" OR player1.effect1name = "DIS" THEN fail = fail - player1.effect2data
                            IF player1.effect3name = "STN" OR player1.effect1name = "DIS" THEN fail = fail - player1.effect3data

                            IF fail <= active.accuracy THEN
                                base_damage = INT((RND * (active.data1 - active.data0)) + active.data0) + 1
                                true_damage = INT((base_damage * player1.attack_multiplier) / player2.defense_multiplier)
                                IF player2.effect1name = "SHD" THEN true_damage = true_damage / player2.effect1data
                                IF player2.effect2name = "SHD" THEN true_damage = true_damage / player2.effect2data
                                IF player2.effect3name = "SHD" THEN true_damage = true_damage / player2.effect3data
                                player2.health = player2.health - true_damage
                                PLAYSOUND attack_sound
                            ELSE status = "Missed!"
                            END IF


                        CASE 2
                            fail = INT(RND * 100) + 1
                            IF player1.effect1name = "STN" OR player1.effect1name = "DIS" THEN fail = fail - player1.effect1data
                            IF player1.effect2name = "STN" OR player1.effect1name = "DIS" THEN fail = fail - player1.effect2data
                            IF player1.effect3name = "STN" OR player1.effect1name = "DIS" THEN fail = fail - player1.effect3data

                            IF fail <= active.accuracy THEN
                                base_damage = INT((RND * (active.data1 - active.data0)) + active.data0) + 1
                                true_damage = INT((base_damage * player1.attack_multiplier) / player2.defense_multiplier)
                                IF player2.effect1name = "SHD" THEN true_damage = true_damage / player2.effect1data
                                IF player2.effect2name = "SHD" THEN true_damage = true_damage / player2.effect2data
                                IF player2.effect3name = "SHD" THEN true_damage = true_damage / player2.effect3data

                                player2.health = player2.health - true_damage
                                PLAYSOUND attack_sound
                                IF RND * 100 + 1 <= active.data2 THEN

                                    IF player2.effect1 = 0 THEN
                                        player2.effect1 = active.data4
                                        player2.effect1name = "STN"
                                        player2.effect1data = active.data3
                                        player2.effect1priority = 1
                                        status = "Stunned!"
                                    ELSEIF player2.effect2 = 0 THEN
                                        player2.effect2 = active.data4
                                        player2.effect2name = "STN"
                                        player2.effect2data = active.data3
                                        player2.effect2priority = 1
                                        status = "Stunned!"
                                    ELSEIF player2.effect3 = 0 THEN
                                        player2.effect3 = active.data4
                                        player2.effect3name = "STN"
                                        player2.effect3data = active.data3
                                        player2.effect3priority = 1

                                        status = "Stunned!"
                                    ELSEIF player2.effect1priority < active.data5 THEN
                                        player2.effect1 = active.data4
                                        player2.effect1name = "STN"
                                        player2.effect1data = active.data3
                                        player2.effect1priority = 1
                                        status = "Stunned!"
                                    ELSEIF player2.effect2priority < active.data5 THEN
                                        player2.effect2 = active.data4
                                        player2.effect2name = "STN"
                                        player2.effect2data = active.data3
                                        player2.effect2priority = 1
                                        status = "Stunned!"

                                    ELSEIF player2.effect3priority < active.data5 THEN
                                        player2.effect3 = active.data4
                                        player2.effect3name = "STN"
                                        player2.effect3data = active.data3
                                        player2.effect3priority = 1

                                        status = "Stunned!"
                                    END IF
                                END IF
                            ELSE status = "Missed!"
                            END IF
                        CASE 3
                            fail = INT(RND * 100) + 1
                            IF player1.effect1name = "STN" OR player1.effect1name = "DIS" THEN fail = fail - player1.effect1data
                            IF player1.effect2name = "STN" OR player1.effect1name = "DIS" THEN fail = fail - player1.effect2data
                            IF player1.effect3name = "STN" OR player1.effect1name = "DIS" THEN fail = fail - player1.effect3data

                            IF fail <= active.accuracy THEN
                                PLAYSOUND defend_sound


                                IF player2.effect1 = 0 THEN
                                    player2.effect1 = active.data4
                                    player2.effect1name = "DIS"
                                    player2.effect1data = active.data3
                                    player2.effect1priority = 1
                                    status = "Distracted!"
                                ELSEIF player2.effect2 = 0 THEN
                                    player2.effect2 = active.data4
                                    player2.effect2name = "DIS"
                                    player2.effect2data = active.data3
                                    player2.effect2priority = 1
                                    status = "Distracted!"
                                ELSEIF player2.effect3 = 0 THEN
                                    player2.effect3 = active.data4
                                    player2.effect3name = "DIS"
                                    player2.effect3data = active.data3
                                    player2.effect3priority = 1

                                    status = "Distracted!"
                                ELSEIF player2.effect1priority < active.data5 THEN
                                    player2.effect1 = active.data4
                                    player2.effect1name = "DIS"
                                    player2.effect1data = active.data3
                                    player2.effect1priority = 1
                                    status = "Distracted!"
                                ELSEIF player2.effect2priority < active.data5 THEN
                                    player2.effect2 = active.data4
                                    player2.effect2name = "DIS"
                                    player2.effect2data = active.data3
                                    player2.effect2priority = 1
                                    status = "Distracted!"

                                ELSEIF player2.effect3priority < active.data5 THEN
                                    player2.effect3 = active.data4
                                    player2.effect3name = "DIS"
                                    player2.effect3data = active.data3
                                    player2.effect3priority = 1

                                    status = "Distracted!"
                                END IF

                            ELSE status = "Missed!"
                            END IF
                        CASE 4
                            fail = INT(RND * 100) + 1
                            IF player1.effect1name = "STN" OR player1.effect1name = "DIS" THEN fail = fail - player1.effect1data
                            IF player1.effect2name = "STN" OR player1.effect1name = "DIS" THEN fail = fail - player1.effect2data
                            IF player1.effect3name = "STN" OR player1.effect1name = "DIS" THEN fail = fail - player1.effect3data

                            IF fail <= active.accuracy THEN
                                PLAYSOUND defend_sound

                                IF player1.effect1 = 0 THEN
                                    player1.effect1 = active.data4
                                    player1.effect1name = "SHD"
                                    player1.effect1data = active.data3
                                    player1.effect1priority = 1
                                    status = "Shield!"
                                ELSEIF player1.effect2 = 0 THEN
                                    player1.effect2 = active.data4
                                    player1.effect2name = "SHD"
                                    player1.effect2data = active.data3
                                    player1.effect2priority = 1
                                    status = "Shield!"
                                ELSEIF player1.effect3 = 0 THEN
                                    player1.effect3 = active.data4
                                    player1.effect3name = "SHD"
                                    player1.effect3data = active.data3
                                    player1.effect3priority = 1

                                    status = "Shield!"
                                ELSEIF player1.effect1priority < active.data5 THEN
                                    player1.effect1 = active.data4
                                    player1.effect1name = "SHD"
                                    player1.effect1data = active.data3
                                    player1.effect1priority = 1
                                    status = "Shield!"
                                ELSEIF player1.effect2priority < active.data5 THEN
                                    player1.effect2 = active.data4
                                    player1.effect2name = "SHD"
                                    player1.effect2data = active.data3
                                    player1.effect2priority = 1
                                    status = "Shield!"

                                ELSEIF player1.effect3priority < active.data5 THEN
                                    player1.effect3 = active.data4
                                    player1.effect3name = "SHD"
                                    player1.effect3data = active.data3
                                    player1.effect3priority = 1

                                    status = "Shield!"
                                END IF

                            ELSE status = "Missed!"
                            END IF
                        CASE 5
                            fail = INT(RND * 100) + 1
                            IF player1.effect1name = "STN" OR player1.effect1name = "DIS" THEN fail = fail - player1.effect1data
                            IF player1.effect2name = "STN" OR player1.effect1name = "DIS" THEN fail = fail - player1.effect2data
                            IF player1.effect3name = "STN" OR player1.effect1name = "DIS" THEN fail = fail - player1.effect3data

                            IF fail <= active.accuracy THEN
                                base_damage = INT((RND * (active.data1 - active.data0)) + active.data0) + 1
                                true_damage = INT((base_damage * player1.magic_multiplier) / player2.defense_multiplier)
                                IF player2.effect1name = "SHD" THEN true_damage = true_damage / player2.effect1data
                                IF player2.effect2name = "SHD" THEN true_damage = true_damage / player2.effect2data
                                IF player2.effect3name = "SHD" THEN true_damage = true_damage / player2.effect3data

                                player2.health = player2.health - true_damage
                                PLAYSOUND fire_sound
                                IF RND * 100 + 1 <= active.data2 THEN

                                    IF player2.effect1 = 0 THEN
                                        player2.effect1 = active.data5
                                        player2.effect1name = "BRN"
                                        player2.effect1data = active.data3
                                        player2.effect1data2 = active.data4
                                        player2.effect1priority = 1
                                        status = "Burned!"
                                    ELSEIF player2.effect2 = 0 THEN
                                        player2.effect2 = active.data5
                                        player2.effect2name = "BRN"
                                        player2.effect2data = active.data3
                                        player2.effect2data2 = active.data4
                                        player2.effect2priority = 1
                                        status = "Burned!"
                                    ELSEIF player2.effect3 = 0 THEN
                                        player2.effect3 = active.data5
                                        player2.effect3name = "BRN"
                                        player2.effect3data = active.data3
                                        player2.effect3data2 = active.data4
                                        player2.effect3priority = 1

                                        status = "Burned!"
                                    ELSEIF player2.effect1priority < active.data5 THEN
                                        player2.effect1 = active.data5
                                        player2.effect1name = "BRN"
                                        player2.effect1data = active.data3
                                        player2.effect1data2 = active.data4
                                        player2.effect1priority = 1
                                        status = "Burned!"
                                    ELSEIF player2.effect2priority < active.data5 THEN
                                        player2.effect2 = active.data5
                                        player2.effect2name = "BRN"
                                        player2.effect2data = active.data3
                                        player2.effect2data2 = active.data4
                                        player2.effect2priority = 1
                                        status = "Burned!"

                                    ELSEIF player2.effect3priority < active.data5 THEN
                                        player2.effect3 = active.data5
                                        player2.effect3name = "BRN"
                                        player2.effect3data = active.data3
                                        player2.effect3data2 = active.data4
                                        player2.effect3priority = 1

                                        status = "Burned!"
                                    END IF
                                END IF
                            ELSE status = "Missed!"
                            END IF
                        CASE 6
                            fail = INT(RND * 100) + 1
                            IF player1.effect1name = "STN" OR player1.effect1name = "DIS" THEN fail = fail - player1.effect1data
                            IF player1.effect2name = "STN" OR player1.effect1name = "DIS" THEN fail = fail - player1.effect2data
                            IF player1.effect3name = "STN" OR player1.effect1name = "DIS" THEN fail = fail - player1.effect3data

                            IF fail <= active.accuracy THEN
                                base_damage = INT((RND * (active.data1 - active.data0)) + active.data0) + 1
                                true_damage = INT((base_damage * player1.magic_multiplier) / player2.defense_multiplier)
                                IF player2.effect1name = "SHD" THEN true_damage = true_damage / player2.effect1data
                                IF player2.effect2name = "SHD" THEN true_damage = true_damage / player2.effect2data
                                IF player2.effect3name = "SHD" THEN true_damage = true_damage / player2.effect3data
                                player2.health = player2.health - true_damage
                                player1.health = player1.health + true_damage / 2
                                PLAYSOUND attack_sound
                            ELSE status = "Missed!"
                            END IF
                        CASE 7
                            fail = INT(RND * 100) + 1
                            IF player1.effect1name = "STN" OR player1.effect1name = "DIS" THEN fail = fail - player1.effect1data
                            IF player1.effect2name = "STN" OR player1.effect1name = "DIS" THEN fail = fail - player1.effect2data
                            IF player1.effect3name = "STN" OR player1.effect1name = "DIS" THEN fail = fail - player1.effect3data

                            IF fail <= active.accuracy THEN
                                base_damage = INT((RND * (active.data1 - active.data0)) + active.data0) + 1
                                true_damage = INT(base_damage * player1.magic_multiplier)
                                player1.health = player1.health + true_damage
                                'playsound attack_sound
                            ELSE status = "Missed!"
                            END IF
                        CASE 8
                            fail = INT(RND * 100) + 1
                            IF player1.effect1name = "STN" OR player1.effect1name = "DIS" THEN fail = fail - player1.effect1data
                            IF player1.effect2name = "STN" OR player1.effect1name = "DIS" THEN fail = fail - player1.effect2data
                            IF player1.effect3name = "STN" OR player1.effect1name = "DIS" THEN fail = fail - player1.effect3data
                            IF fail <= active.accuracy THEN

                                base_damage = INT((RND * (active.data1 - active.data0)) + active.data0) + 1
                                true_damage = base_damage
                                IF player2.effect1 = 0 THEN
                                    player2.effect1 = active.data4
                                    player2.effect1name = "DDW"
                                    player2.effect1data = active.data2
                                    player2.effect1data2 = active.data3
                                    player2.effect1priority = 1

                                ELSEIF player2.effect2 = 0 THEN
                                    player2.effect2 = active.data4
                                    player2.effect2name = "DDW"
                                    player2.effect2data = active.data2
                                    player2.effect2data2 = active.data3
                                    player2.effect2priority = 1

                                ELSEIF player2.effect3 = 0 THEN
                                    player2.effect3 = active.data4
                                    player2.effect3name = "DDW"
                                    player2.effect3data = active.data2
                                    player2.effect3data2 = active.data3
                                    player2.effect3priority = 1

                                END IF


                                player1.health = player1.health - true_damage
                            ELSE status = "Missed!"
                            END IF
                        CASE 9
                            fail = INT(RND * 100) + 1
                            IF player1.effect1name = "STN" OR player1.effect1name = "DIS" THEN fail = fail - player1.effect1data
                            IF player1.effect2name = "STN" OR player1.effect1name = "DIS" THEN fail = fail - player1.effect2data
                            IF player1.effect3name = "STN" OR player1.effect1name = "DIS" THEN fail = fail - player1.effect3data
                            IF fail <= active.accuracy THEN
                                IF player1.effect1 = 0 THEN
                                    player1.effect1 = active.data2
                                    player1.effect1name = "HEL"
                                    player1.effect1data = active.data0
                                    player1.effect1data2 = active.data1
                                    player1.effect1priority = 1

                                ELSEIF player1.effect2 = 0 THEN
                                    player1.effect2 = active.data2
                                    player1.effect2name = "HEL"
                                    player1.effect2data = active.data0
                                    player1.effect2data2 = active.data1
                                    player1.effect2priority = 1

                                ELSEIF player1.effect3 = 0 THEN
                                    player1.effect3 = active.data2
                                    player1.effect3name = "HEL"
                                    player1.effect3data = active.data0
                                    player1.effect3data2 = active.data1
                                    player1.effect3priority = 1

                                END IF
                            ELSE status = "Missed!"
                            END IF
                    END SELECT
                CASE 1
                    SELECT CASE active.type
                        CASE 1
                            fail = INT(RND * 100) + 1
                            IF player2.effect1name = "STN" OR player2.effect1name = "DIS" THEN fail = fail - player2.effect1data
                            IF player2.effect2name = "STN" OR player2.effect1name = "DIS" THEN fail = fail - player2.effect2data
                            IF player2.effect3name = "STN" OR player2.effect1name = "DIS" THEN fail = fail - player2.effect3data

                            IF fail <= active.accuracy THEN
                                base_damage = INT((RND * (active.data1 - active.data0)) + active.data0) + 1
                                true_damage = INT((base_damage * player2.attack_multiplier) / player1.defense_multiplier)
                                IF player1.effect1name = "SHD" THEN true_damage = true_damage / player1.effect1data
                                IF player1.effect2name = "SHD" THEN true_damage = true_damage / player1.effect2data
                                IF player1.effect3name = "SHD" THEN true_damage = true_damage / player1.effect3data
                                player1.health = player1.health - true_damage
                                PLAYSOUND attack_sound
                            ELSE status = "Missed!"
                            END IF


                        CASE 2
                            fail = INT(RND * 100) + 1
                            IF player2.effect1name = "STN" OR player2.effect1name = "DIS" THEN fail = fail - player2.effect1data
                            IF player2.effect2name = "STN" OR player2.effect1name = "DIS" THEN fail = fail - player2.effect2data
                            IF player2.effect3name = "STN" OR player2.effect1name = "DIS" THEN fail = fail - player2.effect3data

                            IF fail <= active.accuracy THEN
                                base_damage = INT((RND * (active.data1 - active.data0)) + active.data0) + 1
                                true_damage = INT((base_damage * player2.attack_multiplier) / player1.defense_multiplier)
                                IF player1.effect1name = "SHD" THEN true_damage = true_damage / player1.effect1data
                                IF player1.effect2name = "SHD" THEN true_damage = true_damage / player1.effect2data
                                IF player1.effect3name = "SHD" THEN true_damage = true_damage / player1.effect3data

                                player1.health = player1.health - true_damage
                                PLAYSOUND attack_sound
                                IF RND * 100 + 1 <= active.data2 THEN

                                    IF player1.effect1 = 0 THEN
                                        player1.effect1 = active.data4
                                        player1.effect1name = "STN"
                                        player1.effect1data = active.data3
                                        player1.effect1priority = 1
                                        status = "Stunned!"
                                    ELSEIF player1.effect2 = 0 THEN
                                        player1.effect2 = active.data4
                                        player1.effect2name = "STN"
                                        player1.effect2data = active.data3
                                        player1.effect2priority = 1
                                        status = "Stunned!"
                                    ELSEIF player1.effect3 = 0 THEN
                                        player1.effect3 = active.data4
                                        player1.effect3name = "STN"
                                        player1.effect3data = active.data3
                                        player1.effect3priority = 1

                                        status = "Stunned!"
                                    ELSEIF player1.effect1priority < active.data5 THEN
                                        player1.effect1 = active.data4
                                        player1.effect1name = "STN"
                                        player1.effect1data = active.data3
                                        player1.effect1priority = 1
                                        status = "Stunned!"
                                    ELSEIF player1.effect2priority < active.data5 THEN
                                        player1.effect2 = active.data4
                                        player1.effect2name = "STN"
                                        player1.effect2data = active.data3
                                        player1.effect2priority = 1
                                        status = "Stunned!"

                                    ELSEIF player1.effect3priority < active.data5 THEN
                                        player1.effect3 = active.data4
                                        player1.effect3name = "STN"
                                        player1.effect3data = active.data3
                                        player1.effect3priority = 1

                                        status = "Stunned!"
                                    END IF
                                END IF
                            ELSE status = "Missed!"
                            END IF
                        CASE 3
                            fail = INT(RND * 100) + 1
                            IF player2.effect1name = "STN" OR player2.effect1name = "DIS" THEN fail = fail - player2.effect1data
                            IF player2.effect2name = "STN" OR player2.effect1name = "DIS" THEN fail = fail - player2.effect2data
                            IF player2.effect3name = "STN" OR player2.effect1name = "DIS" THEN fail = fail - player2.effect3data

                            IF fail <= active.accuracy THEN
                                PLAYSOUND defend_sound


                                IF player1.effect1 = 0 THEN
                                    player1.effect1 = active.data4
                                    player1.effect1name = "DIS"
                                    player1.effect1data = active.data3
                                    player1.effect1priority = 1
                                    status = "Distracted!"
                                ELSEIF player1.effect2 = 0 THEN
                                    player1.effect2 = active.data4
                                    player1.effect2name = "DIS"
                                    player1.effect2data = active.data3
                                    player1.effect2priority = 1
                                    status = "Distracted!"
                                ELSEIF player1.effect3 = 0 THEN
                                    player1.effect3 = active.data4
                                    player1.effect3name = "DIS"
                                    player1.effect3data = active.data3
                                    player1.effect3priority = 1

                                    status = "Distracted!"
                                ELSEIF player1.effect1priority < active.data5 THEN
                                    player1.effect1 = active.data4
                                    player1.effect1name = "DIS"
                                    player1.effect1data = active.data3
                                    player1.effect1priority = 1
                                    status = "Distracted!"
                                ELSEIF player1.effect2priority < active.data5 THEN
                                    player1.effect2 = active.data4
                                    player1.effect2name = "DIS"
                                    player1.effect2data = active.data3
                                    player1.effect2priority = 1
                                    status = "Distracted!"

                                ELSEIF player1.effect3priority < active.data5 THEN
                                    player1.effect3 = active.data4
                                    player1.effect3name = "DIS"
                                    player1.effect3data = active.data3
                                    player1.effect3priority = 1

                                    status = "Distracted!"
                                END IF

                            ELSE status = "Missed!"
                            END IF
                        CASE 4
                            fail = INT(RND * 100) + 1
                            IF player2.effect1name = "STN" OR player2.effect1name = "DIS" THEN fail = fail - player2.effect1data
                            IF player2.effect2name = "STN" OR player2.effect1name = "DIS" THEN fail = fail - player2.effect2data
                            IF player2.effect3name = "STN" OR player2.effect1name = "DIS" THEN fail = fail - player2.effect3data

                            IF fail <= active.accuracy THEN
                                PLAYSOUND defend_sound

                                IF player2.effect1 = 0 THEN
                                    player2.effect1 = active.data4
                                    player2.effect1name = "SHD"
                                    player2.effect1data = active.data3
                                    player2.effect1priority = 1
                                    status = "Shield!"
                                ELSEIF player2.effect2 = 0 THEN
                                    player2.effect2 = active.data4
                                    player2.effect2name = "SHD"
                                    player2.effect2data = active.data3
                                    player2.effect2priority = 1
                                    status = "Shield!"
                                ELSEIF player2.effect3 = 0 THEN
                                    player2.effect3 = active.data4
                                    player2.effect3name = "SHD"
                                    player2.effect3data = active.data3
                                    player2.effect3priority = 1

                                    status = "Shield!"
                                ELSEIF player2.effect1priority < active.data5 THEN
                                    player2.effect1 = active.data4
                                    player2.effect1name = "SHD"
                                    player2.effect1data = active.data3
                                    player2.effect1priority = 1
                                    status = "Shield!"
                                ELSEIF player2.effect2priority < active.data5 THEN
                                    player2.effect2 = active.data4
                                    player2.effect2name = "SHD"
                                    player2.effect2data = active.data3
                                    player2.effect2priority = 1
                                    status = "Shield!"

                                ELSEIF player2.effect3priority < active.data5 THEN
                                    player2.effect3 = active.data4
                                    player2.effect3name = "SHD"
                                    player2.effect3data = active.data3
                                    player2.effect3priority = 1

                                    status = "Shield!"
                                END IF

                            ELSE status = "Missed!"
                            END IF
                        CASE 5
                            fail = INT(RND * 100) + 1
                            IF player2.effect1name = "STN" OR player2.effect1name = "DIS" THEN fail = fail - player2.effect1data
                            IF player2.effect2name = "STN" OR player2.effect1name = "DIS" THEN fail = fail - player2.effect2data
                            IF player2.effect3name = "STN" OR player2.effect1name = "DIS" THEN fail = fail - player2.effect3data

                            IF fail <= active.accuracy THEN
                                base_damage = INT((RND * (active.data1 - active.data0)) + active.data0) + 1
                                true_damage = INT((base_damage * player2.magic_multiplier) / player1.defense_multiplier)
                                IF player1.effect1name = "SHD" THEN true_damage = true_damage / player1.effect1data
                                IF player1.effect2name = "SHD" THEN true_damage = true_damage / player1.effect2data
                                IF player1.effect3name = "SHD" THEN true_damage = true_damage / player1.effect3data

                                player1.health = player1.health - true_damage
                                PLAYSOUND fire_sound
                                IF RND * 100 + 1 <= active.data2 THEN

                                    IF player1.effect1 = 0 THEN
                                        player1.effect1 = active.data5
                                        player1.effect1name = "BRN"
                                        player1.effect1data = active.data3
                                        player1.effect1data2 = active.data4
                                        player1.effect1priority = 1
                                        status = "Burned!"
                                    ELSEIF player1.effect2 = 0 THEN
                                        player1.effect2 = active.data5
                                        player1.effect2name = "BRN"
                                        player1.effect2data = active.data3
                                        player1.effect2data2 = active.data4
                                        player1.effect2priority = 1
                                        status = "Burned!"
                                    ELSEIF player1.effect3 = 0 THEN
                                        player1.effect3 = active.data5
                                        player1.effect3name = "BRN"
                                        player1.effect3data = active.data3
                                        player1.effect3data2 = active.data4
                                        player1.effect3priority = 1

                                        status = "Burned!"
                                    ELSEIF player1.effect1priority < active.data5 THEN
                                        player1.effect1 = active.data5
                                        player1.effect1name = "BRN"
                                        player1.effect1data = active.data3
                                        player1.effect1data2 = active.data4
                                        player1.effect1priority = 1
                                        status = "Burned!"
                                    ELSEIF player1.effect2priority < active.data5 THEN
                                        player1.effect2 = active.data5
                                        player1.effect2name = "BRN"
                                        player1.effect2data = active.data3
                                        player1.effect2data2 = active.data4
                                        player1.effect2priority = 1
                                        status = "Burned!"

                                    ELSEIF player1.effect3priority < active.data5 THEN
                                        player1.effect3 = active.data5
                                        player1.effect3name = "BRN"
                                        player1.effect3data = active.data3
                                        player1.effect3data2 = active.data4
                                        player1.effect3priority = 1

                                        status = "Burned!"
                                    END IF
                                END IF
                            ELSE status = "Missed!"
                            END IF
                        CASE 6
                            fail = INT(RND * 100) + 1
                            IF player2.effect1name = "STN" OR player2.effect1name = "DIS" THEN fail = fail - player2.effect1data
                            IF player2.effect2name = "STN" OR player2.effect1name = "DIS" THEN fail = fail - player2.effect2data
                            IF player2.effect3name = "STN" OR player2.effect1name = "DIS" THEN fail = fail - player2.effect3data

                            IF fail <= active.accuracy THEN
                                base_damage = INT((RND * (active.data1 - active.data0)) + active.data0) + 1
                                true_damage = INT((base_damage * player2.magic_multiplier) / player1.defense_multiplier)
                                IF player1.effect1name = "SHD" THEN true_damage = true_damage / player1.effect1data
                                IF player1.effect2name = "SHD" THEN true_damage = true_damage / player1.effect2data
                                IF player1.effect3name = "SHD" THEN true_damage = true_damage / player1.effect3data
                                player1.health = player1.health - true_damage
                                player2.health = player2.health + true_damage / 2
                                PLAYSOUND attack_sound
                            ELSE status = "Missed!"
                            END IF
                        CASE 7
                            fail = INT(RND * 100) + 1
                            IF player2.effect1name = "STN" OR player2.effect1name = "DIS" THEN fail = fail - player2.effect1data
                            IF player2.effect2name = "STN" OR player2.effect1name = "DIS" THEN fail = fail - player2.effect2data
                            IF player2.effect3name = "STN" OR player2.effect1name = "DIS" THEN fail = fail - player2.effect3data

                            IF fail <= active.accuracy THEN
                                base_damage = INT((RND * (active.data1 - active.data0)) + active.data0) + 1
                                true_damage = INT(base_damage * player2.magic_multiplier)
                                player2.health = player2.health + true_damage
                                'playsound attack_sound
                            ELSE status = "Missed!"
                            END IF

                        CASE 8
                            fail = INT(RND * 100) + 1
                            IF player2.effect1name = "STN" OR player2.effect1name = "DIS" THEN fail = fail - player2.effect1data
                            IF player2.effect2name = "STN" OR player2.effect1name = "DIS" THEN fail = fail - player2.effect2data
                            IF player2.effect3name = "STN" OR player2.effect1name = "DIS" THEN fail = fail - player2.effect3data
                            IF fail <= active.accuracy THEN

                                base_damage = INT((RND * (active.data1 - active.data0)) + active.data0) + 1
                                true_damage = base_damage
                                IF player1.effect1 = 0 THEN
                                    player1.effect1 = active.data4
                                    player1.effect1name = "DDW"
                                    player1.effect1data = active.data2
                                    player1.effect1data2 = active.data3
                                    player1.effect1priority = 1

                                ELSEIF player1.effect2 = 0 THEN
                                    player1.effect2 = active.data4
                                    player1.effect2name = "DDW"
                                    player1.effect2data = active.data2
                                    player1.effect2data2 = active.data3
                                    player1.effect2priority = 1

                                ELSEIF player1.effect3 = 0 THEN
                                    player1.effect3 = active.data4
                                    player1.effect3name = "DDW"
                                    player1.effect3data = active.data2
                                    player1.effect3data2 = active.data3
                                    player1.effect3priority = 1



                                END IF
                                player2.health = player2.health - true_damage
                            ELSE status = "Missed!"

                            END IF
                        CASE 9
                            fail = INT(RND * 100) + 1
                            IF player2.effect1name = "STN" OR player2.effect1name = "DIS" THEN fail = fail - player2.effect1data
                            IF player2.effect2name = "STN" OR player2.effect1name = "DIS" THEN fail = fail - player2.effect2data
                            IF player2.effect3name = "STN" OR player2.effect1name = "DIS" THEN fail = fail - player2.effect3data
                            IF fail <= active.accuracy THEN
                                IF player2.effect1 = 0 THEN
                                    player2.effect1 = active.data2
                                    player2.effect1name = "HEL"
                                    player2.effect1data = active.data0
                                    player2.effect1data2 = active.data1
                                    player2.effect1priority = 1

                                ELSEIF player2.effect2 = 0 THEN
                                    player2.effect2 = active.data2
                                    player2.effect2name = "HEL"
                                    player2.effect2data = active.data0
                                    player2.effect2data2 = active.data1
                                    player2.effect2priority = 1

                                ELSEIF player2.effect3 = 0 THEN
                                    player2.effect3 = active.data2
                                    player2.effect3name = "HEL"
                                    player2.effect3data = active.data0
                                    player2.effect3data2 = active.data1
                                    player2.effect3priority = 1

                                END IF
                            ELSE status = "Missed!"
                            END IF

                    END SELECT

            END SELECT

            submenu = 10
            norefresh = 1
        CASE 10 'postanimate


            IF status = "Missed!" THEN
                LOCATE 21, 1
                CENTERPRINT status
            ELSE
                SELECT CASE active.type
                    CASE 1, 8
                        LOCATE 21, 30: PRINT "Base Damage:"; base_damage
                        LOCATE 23, 30: PRINT "True Damage:"; true_damage
                    CASE 2, 5
                        LOCATE 21, 30: PRINT "Base Damage:"; base_damage
                        LOCATE 23, 30: PRINT "True Damage:"; true_damage
                        LOCATE 25, 1: CENTERPRINT status
                    CASE 3, 4
                        LOCATE 21, 1
                        CENTERPRINT status
                    CASE 6
                        LOCATE 21, 30: PRINT "Base Damage:"; base_damage
                        LOCATE 23, 30: PRINT "True Damage:"; true_damage
                        LOCATE 25, 30: PRINT "Healed:"; true_damage / 2
                    CASE 7
                        LOCATE 21, 1: CENTERPRINT "Healed:" + STR$(true_damage)
                    CASE 9
                        LOCATE 21, 1: CENTERPRINT "Healing"


                END SELECT
            END IF
            dummy_variable = dummy_variable + 1
            IF dummy_variable > 120 THEN submenu = 0: dummy_variable = 0: status = ""


        CASE 11
            SELECT CASE turn
                CASE 0
                    IF player1.effect1name = "BRN" THEN
                        player1.health = player1.health - (INT((RND * (player1.effect1data2 - player1.effect1data)) + player1.effect1data) + 1): PLAYSOUND fire2_sound
                    END IF
                    IF player1.effect2name = "BRN" THEN
                        player1.health = player1.health - (INT((RND * (player1.effect2data2 - player1.effect2data)) + player1.effect2data) + 1): PLAYSOUND fire2_sound
                    END IF
                    IF player1.effect3name = "BRN" THEN
                        player1.health = player1.health - (INT((RND * (player1.effect3data2 - player1.effect3data)) + player1.effect3data) + 1): PLAYSOUND fire2_sound
                    END IF
                    IF player1.effect1name = "DDW" THEN
                        IF player1.effect1 = 1 THEN player1.health = player1.health - (INT((RND * (player1.effect1data2 - player1.effect1data)) + player1.effect1data) + 1): PLAYSOUND fire2_sound
                    END IF
                    IF player1.effect2name = "DDW" THEN
                        IF player1.effect2 = 1 THEN player1.health = player1.health - (INT((RND * (player1.effect2data2 - player1.effect2data)) + player1.effect2data) + 1): PLAYSOUND fire2_sound
                    END IF
                    IF player1.effect3name = "DDW" THEN
                        IF player1.effect3 = 1 THEN player1.health = player1.health - (INT((RND * (player1.effect3data2 - player1.effect3data)) + player1.effect3data) + 1): PLAYSOUND fire2_sound
                    END IF
                    IF player1.effect1name = "HEL" THEN
                        player1.health = player1.health + (INT((RND * (player1.effect1data2 - player1.effect1data)) + player1.effect1data) + 1): PLAYSOUND fire2_sound
                    END IF
                    IF player1.effect2name = "HEL" THEN
                        player1.health = player1.health + (INT((RND * (player1.effect2data2 - player1.effect2data)) + player1.effect2data) + 1): PLAYSOUND fire2_sound
                    END IF
                    IF player1.effect3name = "HEL" THEN
                        player1.health = player1.health + (INT((RND * (player1.effect3data2 - player1.effect3data)) + player1.effect3data) + 1): PLAYSOUND fire2_sound
                    END IF



                    IF player1.effect1 > 0 THEN player1.effect1 = player1.effect1 - 1
                    IF player1.effect1 = 0 THEN
                        player1.effect1name = ""
                        player1.effect1data = 0
                        player1.effect1data2 = 0
                        player1.effect1priority = 0
                    END IF

                    IF player1.effect2 > 0 THEN player1.effect2 = player1.effect2 - 1
                    IF player1.effect2 = 0 THEN
                        player1.effect2name = ""
                        player1.effect2data = 0
                        player1.effect2data2 = 0
                        player1.effect2priority = 0
                    END IF

                    IF player1.effect3 > 0 THEN player1.effect3 = player1.effect3 - 1
                    IF player1.effect3 = 0 THEN
                        player1.effect3name = ""
                        player1.effect3data = 0
                        player1.effect3data2 = 0
                        player1.effect3priority = 0
                    END IF

                CASE 1
                    IF player2.effect1name = "BRN" THEN
                        player2.health = player2.health - (INT((RND * (player2.effect1data2 - player2.effect1data)) + player2.effect1data) + 1): PLAYSOUND fire2_sound
                    END IF
                    IF player2.effect2name = "BRN" THEN
                        player2.health = player2.health - (INT((RND * (player2.effect2data2 - player2.effect2data)) + player2.effect2data) + 1): PLAYSOUND fire2_sound
                    END IF
                    IF player2.effect3name = "BRN" THEN
                        player2.health = player2.health - (INT((RND * (player2.effect3data2 - player2.effect3data)) + player2.effect3data) + 1): PLAYSOUND fire2_sound
                    END IF
                    IF player2.effect1name = "DDW" THEN
                        IF player2.effect1 = 1 THEN player2.health = player2.health - (INT((RND * (player2.effect1data2 - player2.effect1data)) + player2.effect1data) + 1): PLAYSOUND fire2_sound
                    END IF
                    IF player2.effect2name = "DDW" THEN
                        IF player2.effect2 = 1 THEN player2.health = player2.health - (INT((RND * (player2.effect2data2 - player2.effect2data)) + player2.effect2data) + 1): PLAYSOUND fire2_sound
                    END IF
                    IF player2.effect3name = "DDW" THEN
                        IF player2.effect3 = 1 THEN player2.health = player2.health - (INT((RND * (player2.effect3data2 - player2.effect3data)) + player2.effect3data) + 1): PLAYSOUND fire2_sound
                    END IF
                    IF player2.effect1name = "HEL" THEN
                        player2.health = player2.health + (INT((RND * (player2.effect1data2 - player2.effect1data)) + player2.effect1data) + 1): PLAYSOUND fire2_sound
                    END IF
                    IF player2.effect2name = "HEL" THEN
                        player2.health = player2.health + (INT((RND * (player2.effect2data2 - player2.effect2data)) + player2.effect2data) + 1): PLAYSOUND fire2_sound
                    END IF
                    IF player2.effect3name = "HEL" THEN
                        player2.health = player2.health + (INT((RND * (player2.effect3data2 - player2.effect3data)) + player2.effect3data) + 1): PLAYSOUND fire2_sound
                    END IF


                    IF player2.effect1 > 0 THEN player2.effect1 = player2.effect1 - 1
                    IF player2.effect1 = 0 THEN
                        player2.effect1name = ""
                        player2.effect1data = 0
                        player2.effect1data2 = 0
                        player2.effect1priority = 0
                    END IF
                    IF player2.effect2 > 0 THEN player2.effect2 = player2.effect2 - 1
                    IF player2.effect2 = 0 THEN
                        player2.effect2name = ""
                        player2.effect2data = 0
                        player2.effect2data2 = 0
                        player2.effect2priority = 0
                    END IF

                    IF player2.effect3 > 0 THEN player2.effect3 = player2.effect3 - 1
                    IF player2.effect3 = 0 THEN
                        player2.effect3name = ""
                        player2.effect3data = 0
                        player2.effect3data2 = 0
                        player2.effect3priority = 0
                    END IF



            END SELECT

            turn = turn + 1
            IF turn = 2 THEN turn = 0
            submenu = 0
            opo = 1
            SELECT CASE turn
                CASE 0
                    player1.points = player1.points + player1.points_per_turn
                    player1.magic = player1.magic + player1.magic_per_turn
                CASE 1
                    player2.points = player2.points + player2.points_per_turn
                    player2.magic = player2.magic + player2.magic_per_turn
            END SELECT
            IF player1.health <= 0 THEN PRINT "(placeholder) Player 2 wins!"
            IF player2.health <= 0 THEN PRINT "(placeholder) Player 1 wins!"
            PLAYSOUND turn_change
            IF net.online = 1 THEN
                turn = turn + 1
                IF turn = 2 THEN turn = 0
                turnchange = 1
            END IF
    END SELECT


    COLOR RGB(0, 0, 0)
    IF settings.ldmode = 1 THEN COLOR RGB(255, 255, 255)
    IF norefresh = 0 THEN DISPLAY
    norefresh = 0

    IF settings.fpslock = 1 THEN LIMIT settings.fps
LOOP

sprite:
RETURN

options:
about:


END

errors:
IF error_code = 100 THEN
    CLS
    PRINT "Incorrect CDFCC in " + config_file
    PRINT "Expected: "; cdfcc; " Got: "; config_cdfcc
    PRINT
    PRINT "The configuration file has not loaded properly, is corrupted, or is not"
    PRINT "compatable with this version of " + about.name + "."
    PRINT
    PRINT
    PRINT "It is recommended to reset the file. Hold 'R' to reset configuration file."
    PRINT
    PRINT "You can load the game without reseting the file, however, online multiplayer"
    PRINT "will be disabled. Hold 'C' to load anyway."
    DISPLAY
    DO
        IF KEYHIT = 82 OR KEYHIT = 114 GOTO resetcfg
        IF KEYHIT = 67 OR KEYHIT = 99 THEN corrupt = 1: GOTO continue100
    LOOP

END IF

menu:



i = _KEYHIT
pageturn = 0
IF i = 18432 OR i = 119 THEN opo = opo - 1: PLAYSOUND menu_scroll 'key up
IF i = 97 OR i = 19200 THEN opo = opo - 1: PLAYSOUND menu_scroll 'key up
IF i = 20480 OR i = 115 THEN opo = opo + 1: PLAYSOUND menu_scroll 'key down
IF i = 100 OR i = 19712 THEN opo = opo + 1: PLAYSOUND menu_scroll 'key down
IF i = 32 OR i = 13 THEN choice = 1: PLAYSOUND menu_confirm
'IF i = 27 OR i = 8 THEN choice = 1: opo = 99: playsound menu_confirm
k = i


IF hm = 0 THEN
    IF opo >= no + 1 THEN opo = 1: pageturn = 1
    IF opo <= 0 THEN opo = no: pageturn = -1
    ' FOR i = 1 TO no
    '    IF opo <> i THEN LOCATE i + (vo - sp) + (sp * i), ho: PRINT " "
    ' NEXT
    LOCATE opo + (vo - sp) + (sp * opo), ho: PRINT ""
    RETURN
ELSE
    IF opo >= no + 1 THEN opo = 1: pageturn = 1
    IF opo <= 0 THEN opo = no: pageturn = -1
    ' FOR i = 1 TO no
    '     IF opo <> i THEN LOCATE vo, (ho - sp) + (sp * i): PRINT " "
    ' NEXT
    LOCATE vo, (ho - sp) + (sp * opo): PRINT ""
END IF
RETURN

debug:
GOSUB frame
LOCATE 1, 1: PRINT "Version " + ver + ", ";
IF unstable <> 0 THEN PRINT "Unstable, ";
IF corrupt <> 0 THEN PRINT "Corrupt, ";
PRINT "CDFCC:" + STR$(cdfcc);
IF modloaded = 1 THEN PRINT " Modded: " + modname
LOCATE 2, 1: PRINT "OS: " + hostos; " ";
IF bit32 = 1 THEN PRINT "32-Bit" ELSE PRINT

IF nocost = 1 THEN LOCATE 3, 1: PRINT "No Cost Mode Enabled"

LOCATE 1, 72: PRINT "FPS:" + STR$(frps + 1)
LOCATE 2, 72: PRINT "K:" + STR$(k)
LOCATE 3, 72: PRINT "SUB:" + STR$(submenu)
IF ingame = 1 THEN
    IF k = -15872 AND net.online = 0 THEN nocost = nocost + 1
    LOCATE 4, 2: PRINT "Name: " + player1.name
    LOCATE 5, 2: PRINT "Health:" + STR$(player1.health)
    LOCATE 6, 2: PRINT "Magic:" + STR$(player1.magic)
    LOCATE 7, 2: PRINT "PPT:" + STR$(player1.points_per_turn)
    LOCATE 8, 2: PRINT "MPT:" + STR$(player1.magic_per_turn)
    LOCATE 9, 2: PRINT "ATT:" + STR$(player1.attack_multiplier)
    LOCATE 10, 2: PRINT "DEF:" + STR$(player1.defense_multiplier)
    LOCATE 11, 2: PRINT "MAG:" + STR$(player1.magic_multiplier)
    LOCATE 12, 2: PRINT "SPC: " + player1special.name

    LOCATE 4, 65: PRINT "Name: " + player2.name
    LOCATE 5, 65: PRINT "Health:" + STR$(player2.health)
    LOCATE 6, 65: PRINT "Magic:" + STR$(player2.magic)
    LOCATE 7, 65: PRINT "PPT:" + STR$(player2.points_per_turn)
    LOCATE 8, 65: PRINT "MPT:" + STR$(player2.magic_per_turn)
    LOCATE 9, 65: PRINT "ATT:" + STR$(player2.attack_multiplier)
    LOCATE 10, 65: PRINT "DEF:" + STR$(player2.defense_multiplier)
    LOCATE 11, 65: PRINT "MAG:" + STR$(player2.magic_multiplier)
    LOCATE 12, 65: PRINT "SPC: " + player2special.name
END IF
RETURN


frame:
past_second = current_second
current_second = VAL(MID$(TIME$, 7, 2))
IF current_second = past_second THEN frame = frame + 1 ELSE frps = frame: frame = 0
RETURN

'RETURN



'type assignments

TYPE character
    name AS STRING * 10
    description AS STRING * 71

    health AS UNSIGNED BYTE
    magic AS UNSIGNED BYTE
    points_per_turn AS BYTE
    magic_per_turn AS SINGLE
    attack_multiplier AS SINGLE
    defense_multiplier AS SINGLE
    magic_multiplier AS SINGLE
    sprite_sheet_x AS INTEGER
    sprite_sheet_y AS INTEGER
END TYPE

TYPE bonus
    name AS STRING * 15
    description AS STRING * 71
    type AS BYTE
    attack_boost_multiplier AS SINGLE
    defense_boost_multiplier AS SINGLE
    magic_boost_multiplier AS SINGLE
    points_per_turn AS BYTE
    magic AS BYTE
    magic_per_turn AS SINGLE
    health AS BYTE
END TYPE

TYPE move
    name AS STRING * 10
    type AS BYTE
    description AS STRING * 20
    description2 AS STRING * 20
    accuracy AS BYTE
    cost AS SINGLE
    magic_cost AS SINGLE
    data0 AS SINGLE
    data1 AS SINGLE
    data2 AS SINGLE
    data3 AS SINGLE
    data4 AS SINGLE
    data5 AS SINGLE
END TYPE

TYPE player
    name AS STRING * 10
    health AS INTEGER
    magic AS SINGLE
    points_per_turn AS SINGLE
    magic_per_turn AS SINGLE
    attack_multiplier AS SINGLE
    defense_multiplier AS SINGLE
    magic_multiplier AS SINGLE
    sprite_sheet_x AS INTEGER
    sprite_sheet_y AS INTEGER
    points AS SINGLE
    effect1 AS UNSIGNED BYTE
    effect2 AS UNSIGNED BYTE
    effect3 AS UNSIGNED BYTE
    effect1name AS STRING * 3
    effect2name AS STRING * 3
    effect3name AS STRING * 3
    effect1data AS UNSIGNED BYTE
    effect2data AS UNSIGNED BYTE
    effect3data AS UNSIGNED BYTE
    effect1data2 AS UNSIGNED BYTE
    effect2data2 AS UNSIGNED BYTE
    effect3data2 AS UNSIGNED BYTE

    effect1priority AS BYTE
    effect2priority AS BYTE
    effect3priority AS BYTE

END TYPE


TYPE net
    ip AS STRING
    port AS STRING
    host AS SINGLE
    client AS SINGLE
    connect AS SINGLE
    player AS BYTE
    cdfcc AS INTEGER
    status AS INTEGER
    online AS INTEGER
END TYPE

TYPE about
    name AS STRING * 11
    description AS STRING * 45
END TYPE

TYPE settings
    fpslock AS UNSIGNED BYTE
    fps AS UNSIGNED BYTE
    sounds AS UNSIGNED BYTE
    ldmode AS UNSIGNED BYTE
END TYPE
TYPE modinfo
    name AS STRING * 20
    directory AS STRING * 100
    config_file AS STRING * 100
    mod_info_file AS STRING * 100
    light_theme_file AS STRING * 100
    dark_theme_file AS STRING * 100
    title_song AS STRING * 100

    menu_scroll AS STRING * 100
    menu_confirm AS STRING * 100
    turn_change AS STRING * 100
    error_sound AS STRING * 100
    attack_sound AS STRING * 100
    defend_sound AS STRING * 100
    fire_sound AS STRING * 100
    fire2_sound AS STRING * 100


    game1 AS STRING * 100
    game2 AS STRING * 100
    game3 AS STRING * 100
    game4 AS STRING * 100
    game5 AS STRING * 100

END TYPE


'subroutines

SUB PLAYSOUND (nam$)
    IF sounds = 1 THEN _SNDPLAYFILE nam$, , 1
END SUB
FUNCTION PLAYMUSIC (nam$)
    IF sounds = 1 THEN
        PLAYMUSIC = _SNDOPEN(nam$, "sync")
        _SNDVOL PLAYMUSIC, 0.25
        _SNDLOOP PLAYMUSIC
    END IF
END FUNCTION
SUB BOX (sx, sy, ex, ey)
    REDIM x
    x = sx
    PRINTMODE FILLBACKGROUND
    DO
        DO
            LOCATE sy, sx: PRINT " "
            sx = sx + 1
            LOCATE sy, sx: PRINT " "
        LOOP UNTIL sx = ex
        sy = sy + 1
        sx = x
    LOOP UNTIL sy = ey
    PRINTMODE KEEPBACKGROUND
END SUB

SUB CENTERPRINT (nam$)
    REDIM i
    FOR i = 0 TO INT(40 - (LEN(nam$) / 2) - 1)
        PRINT " ";
    NEXT
    PRINT nam$
END SUB
