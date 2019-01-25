library(dplyr)
library(stringr)
library(rebus)
library(data.table)
library(ggplot2)
library(lubridate)
library(shiny)
library(plotly)
library(markdown)

df <- tbl_df(fread('vgsales.csv', 
                   header=T, 
                   fill=TRUE, 
                   sep=","))

df_filt <- df %>% 
  filter(Year != 'N/A') %>% 
  filter(Publisher != 'N/A')%>% 
  filter(Publisher!= 'Unknown')

rm(df)

df_filt$Year <- as.numeric(df_filt$Year)
df_filt <- df_filt %>% 
  filter(Year <= year(Sys.Date()))

region_sales <- 7:11
names(region_sales) <- names(df_filt[7:11])



seg_9 <- function(x){
  ifelse(grepl('God of War',x) | grepl('God Of War', x), 'God of War',
         ifelse(grepl('Tropico',x),'Tropico', 
                ifelse(grepl('Tony Hawk',x), 'Tony Hawk Game', 
                       ifelse(grepl('Fable',x), 'Fable', 
                              ifelse(grepl('TMNT',x) | grepl('Teenage Mutant', x), "TMNT", 
                                     ifelse(grepl('Def Jam', x), 'Def Jam', 
                                            ifelse(grepl('Hyperdimens', x), 'Hyperdimension Neptunia', 
                                                   ifelse(grepl('PES',x) | grepl('Pro Evolution Soccer', x), 'PES', 
                                                          ifelse(grepl('Ace Combat', x), "Ace Combat", 
                                                                 ifelse(grepl("Army Men", x), "Army Men", 
                                                                        ifelse(grepl('SOCOM', x), 'SOCOM', 
                                                                               ifelse(grepl('KillZone', x), 'Killzone', 
                                                                                      ifelse(grepl('Army of Two', x) | grepl('Army Of Two', x), 'Army of Two', 
                                                                                             ifelse(grepl('Duke N', x), 'Duke Nukem',          ifelse(grepl('NFL Blitz', x), 'NFL Blitz', 
                                                                                                                                                      ifelse(grepl('Miku', x) | grepl('Mirai', x), 'Hatsune Miku', 
                                                                                                                                                             ifelse(grepl('NASCAR',x), 'NASCAR game', ifelse(grepl('DarkStalker', x), 'Darkstalkers', 
                                                                                                                                                                                                             ifelse(grepl('LEGO',x), 'LEGO', 
                                                                                                                                                                                                                    ifelse(grepl('Final Fight',x), 'Final Fight', 
                                                                                                                                                                                                                           ifelse(grepl('Sailor Moon', x), 'Sailor Moon', 
                                                                                                                                                                                                                                  ifelse(grepl('Shrek',x),'Shrek',
                                                                                                                                                                                                                                         ifelse(grepl('Scooby',x),'Scooby-Doo',
                                                                                                                                                                                                                                                ifelse(grepl('Lost Planet',x),'Lost Planet',
                                                                                                                                                                                                                                                       ifelse(grepl('Corpse Party',x),'Corpse Party',
                                                                                                                                                                                                                                                              ifelse(grepl('Backyard',x),'Backyard Sports',
                                                                                                                                                                                                                                                                     ifelse(grepl('Leisure Suit',x),'Leisure Suit Larry',
                                                                                                                                                                                                                                                                            ifelse(grepl('Dragon Warrior',x),'Dragon Warrior',
                                                                                                                                                                                                                                                                                   ifelse(grepl('Monster Jam',x),'Monster Jam',
                                                                                                                                                                                                                                                                                          ifelse(grepl('no Stafi',x),'Stafi',
                                                                                                                                                                                                                                                                                                 ifelse(grepl('Call of Juarez',x),'Call of Juarez',
                                                                                                                                                                                                                                                                                                        ifelse(grepl('Chibi-',x),'Chibi-Robo',
                                                                                                                                                                                                                                                                                                               ifelse(grepl('Transformer',x),'Transformers',
                                                                                                                                                                                                                                                                                                                      ifelse(grepl('NCAA',x),'NCAA',
                                                                                                                                                                                                                                                                                                                             ifelse(grepl('Tetris',x),'Tetris game',
                                                                                                                                                                                                                                                                                                                                    ifelse(grepl('Robotech',x),'Robotech',
                                                                                                                                                                                                                                                                                                                                           ifelse(grepl('Pikmin',x), 'Pikmin', 'other')))))))))))))))))))))))))))))))))))))
}
seg_8 <- function(x){
  ifelse(grepl('Elder Scrolls',x),'Elder Scrolls',
         ifelse(grepl('Idolmaster',x) | grepl('IdolMaster',x) | grepl('Idolm@',x)|grepl('IdolM@',x),'Idolmaster',
                ifelse(grepl('King of Fighters',x) | grepl('King Of Fighter',x),'KoF',
                       ifelse(grepl('Lord of the Rings',x) | grepl('Hobbit',x),'LotR',
                              ifelse(grepl('Simpsons',x),'The Simpsons',
                                     ifelse(grepl('The Sims',x),'The Sims',
                                            ifelse(grepl('Time Crisis',x),'Time Crisis',
                                                   ifelse(grepl('Toukiden',x),'Toukiden',
                                                          ifelse(grepl('Trauma',x),'Trauma Center',
                                                                 ifelse(grepl('Turok',x),'Turok',
                                                                        ifelse(grepl('Twisted Metal',x),'Twisted Metal',
                                                                               ifelse(grepl('Unreal',x),'Unreal Tournament',
                                                                                      ifelse(grepl('Warhammer',x),'Warhammer',
                                                                                             ifelse(grepl('Warriors Orochi',x),'Warriors Orochi',
                                                                                                    ifelse(grepl('Wolfenstein',x),'Wolfenstein',
                                                                                                           ifelse(grepl('Warcraft',x),'WoW',
                                                                                                                  ifelse(grepl('Worms',x),'Worms',
                                                                                                                         ifelse(grepl('X-Men',x),'X-Men',
                                                                                                                                ifelse(grepl('Yakuza',x),'Yakuza',
                                                                                                                                       ifelse(grepl('Yoshi',x),'Yoshi',
                                                                                                                                              ifelse(grepl('Yu-Gi-Oh!',x),'Yu-Gi-Oh!',
                                                                                                                                                     ifelse(grepl('Touhou',x),'Touhou',
                                                                                                                                                            ifelse(grepl('Uncharted',x),'Uncharted',
                                                                                                                                                                   ifelse(grepl('Tom Clancy',x),'Tom Clancy',seg_9(x)
                                                                                                                                                                   ))))))))))))))))))))))))
}
seg_7 <- function(x){
  ifelse(grepl('Romance of the',x),"Romance of the Three Kingdoms",
         ifelse(grepl('Rune Factory',x),'Rune Factory',
                ifelse(grepl('Saints Row',x),'Saints Row',
                       ifelse(grepl('Sakura Wars',x),'Sakura Wars',
                              ifelse(grepl('Samurai Warriors',x),'Samurai Warriors',
                                     ifelse(grepl('Senran Kagura',x),'Senran Kagura',
                                            ifelse(grepl('Serious Sam',x),'Serious Sam',
                                                   ifelse(grepl('Shin Megami', x) | grepl('SMT',x)|grepl('Megami Tensei',x),'SMT',
                                                          ifelse(grepl('Silent Hill',x),'Silent Hill',
                                                                 ifelse(grepl('Skylander',x),'Skylanders',
                                                                        ifelse(grepl('SoulCalibur',x),'Soul Calibur',
                                                                               ifelse(grepl('Spider-',x),'Spider-Man',
                                                                                      ifelse(grepl('SpongeBob',x),'SpongeBob',
                                                                                             ifelse(grepl('Spyro',x),'Spyro',
                                                                                                    ifelse(grepl('SSX',x),'SSX',
                                                                                                           ifelse(grepl('Star Fox',x),'Star Fox',
                                                                                                                  ifelse(grepl('Star Trek',x),'Star Trek',
                                                                                                                         ifelse(grepl('Star Ocean',x),'Star Ocean',
                                                                                                                                ifelse(grepl('Street Fighter',x),'Street Fighter',
                                                                                                                                       ifelse(grepl('Suikoden',x),'Suikoden',
                                                                                                                                              ifelse(grepl('Monkey Ball',x),'Monkey Ball',
                                                                                                                                                     ifelse(grepl('Super Robot',x),'Super Robot',
                                                                                                                                                            ifelse(grepl('Smash Bros',x),'Smash Bros',
                                                                                                                                                                   ifelse(grepl('Tales of',x),'Tales of',
                                                                                                                                                                          ifelse(grepl('Tamagotchi',x),'Tamagotchi',
                                                                                                                                                                                 ifelse(grepl('Tekken',x),'Tekken',seg_8(x)
                                                                                                                                                                                 ))))))))))))))))))))))))))
  
}
seg_6 <- function(x){
  ifelse(grepl('Just Dance',x),'Just Dance',
         ifelse(grepl('Kingdom Hearts',x),'Kingdom Hearts',
                ifelse(grepl('Kirby',x),'Kirby',
                       ifelse(grepl('Tomb Raider',x)|grepl('Lara Croft',x),'Tomb Raider',
                              ifelse(grepl('LittleBigPlanet',x),'LBP',
                                     ifelse(grepl('Madden',x),'Madden',
                                            ifelse(grepl('Sonic',x)|grepl('Knuckles',x)|grepl('Tails',x),'Sonic',
                                                   ifelse(grepl('Mass Effect',x),'Mass Effect',
                                                          ifelse(grepl('Max Payne',x),'Max Payne',
                                                                 ifelse(grepl('Medal of Honor',x),'Medal of Honor',
                                                                        ifelse(grepl('Mega Man',x),'Mega Man',
                                                                               ifelse(grepl('Metal Gear',x),'Metal Gear',
                                                                                      ifelse(grepl('Metal Slug',x),'Metal Slug',
                                                                                             ifelse(grepl('Metroid',x),'Metroid',
                                                                                                    ifelse(grepl('Midnight Club',x),'Midnight Club',
                                                                                                           ifelse(grepl('MonHun',x)|grepl('Monster Hunter',x),'Monster Hunter',
                                                                                                                  ifelse(grepl('Mortal Kombat',x),'Mortal Kombat',
                                                                                                                         ifelse(grepl('Mother ',x)|grepl('EarthBound',x),'Mother',
                                                                                                                                ifelse(grepl('Naruto',x),'Naruto',
                                                                                                                                       ifelse(grepl('Need for Speed',x)|grepl('Need For Speed',x),'NfS',
                                                                                                                                              ifelse(grepl('Ninja Gaiden',x),'Ninja Gaiden',
                                                                                                                                                     ifelse(grepl('PAC-MAN',x)|grepl('Pac-Man',x),'Pac-Man',
                                                                                                                                                            ifelse(grepl('Persona',x) & !grepl('Personal',x),'Persona',
                                                                                                                                                                   ifelse(grepl('Phantasy Star',x),'Phantasy Star',
                                                                                                                                                                          ifelse(grepl('Ace Attorney',x),'Ace Attorney',
                                                                                                                                                                                 ifelse(grepl('Prince of Persia',x),'Prince of Persia',
                                                                                                                                                                                        ifelse(grepl('Layton',x),'Professor Layton',
                                                                                                                                                                                               ifelse(grepl('Quake',x),'Quake',
                                                                                                                                                                                                      ifelse(grepl('Ratchet',x),'Ratchet & Clank',
                                                                                                                                                                                                             ifelse(grepl('Rayman',x),'Rayman',
                                                                                                                                                                                                                    ifelse(grepl('Red Dead',x),'Red Dead Redemption',
                                                                                                                                                                                                                           ifelse(grepl('Red Faction',x),'Red Faction',
                                                                                                                                                                                                                                  ifelse(grepl('Resident Evil',x),'RE',seg_7(x))
                                                                                                                                                                                                                           ))))))))))))))))))))))))))))))))
}
seg_5 <- function(x){
  ifelse(grepl('Ape Escape',x),'Ape Escape',
         ifelse(grepl('Far Cry',x),'Far Cry',
                ifelse(grepl('Farming Simulator',x),'Farming Simulator',
                       ifelse(grepl('Fatal Frame',x),'Fatal Frame',
                              ifelse(grepl('Fire Emblem',x),'Fire Emblem',
                                     ifelse(grepl('Forza',x),'Forza',
                                            ifelse(grepl('Frogger',x),'Frogger',
                                                   ifelse(grepl('Gears of War',x),'Gears of War',
                                                          ifelse(grepl('God Eater',x),'God Eater',
                                                                 ifelse(grepl('Golden Sun',x),'Golden Sun',
                                                                        ifelse(grepl('Rock Band',x),'Rock Band',
                                                                               ifelse(grepl('Guild Wars',x),'Guild Wars',
                                                                                      ifelse(grepl('Guilty Gear',x),'Guilty Gear',
                                                                                             ifelse(grepl('Guitar Hero',x),'Guitar Hero',
                                                                                                    ifelse(grepl('Gundam',x),'Gundam',
                                                                                                           ifelse(grepl('Half-Life',x),'Half-Life',
                                                                                                                  ifelse(grepl('Harvest Moon',x),'Harvest Moon',
                                                                                                                         ifelse(grepl('Hitman',x) & !grepl('Reborn!',x),'Hitman',
                                                                                                                                ifelse(grepl('Indiana Jones',x),'Indiana Jones',
                                                                                                                                       ifelse(grepl('Just Cause',x),'Just Cause',seg_6(x))
                                                                                                                                )))))))))))))))))))
}
seg_4 <- function(x){
  ifelse(grepl('CSI',x),'CSI',
         ifelse(grepl('Custom Robo',x),'Custom Robo',
                ifelse(grepl('Dance Dance Revolution',x),'DDR',
                       ifelse(grepl('Dark Souls', x), 'Dark Souls',
                              ifelse(grepl('Darksiders',x), 'Darksiders',
                                     ifelse(grepl('Dead Island',x),'Dead Island',
                                            ifelse(grepl('Dead or Alive',x),'DoA',
                                                   ifelse(grepl('Dead Rising',x),'Dead Rising',
                                                          ifelse(grepl('Dead Space',x),'Dead Space',
                                                                 ifelse(grepl('Dead to Rights',x),'Dead to Rights',
                                                                        ifelse(grepl('Deus Ex',x),'Deus Ex',
                                                                               ifelse(grepl('Devil May Cry',x),'DMC',
                                                                                      ifelse(grepl('Diablo',x),'Diablo',
                                                                                             ifelse(grepl('Digimon',x),'Digimon',
                                                                                                    ifelse(grepl('Disgaea',x),'Disgaea',
                                                                                                           ifelse(grepl('Doom',x) & !grepl('of Doom',x),'Doom',
                                                                                                                  ifelse(grepl('Dragon Age',x),'Dragon Age',
                                                                                                                         ifelse(grepl('Dragon Ball',x),'Dragon Ball',
                                                                                                                                ifelse(grepl('Dragon Quest',x),'Dragon Quest',
                                                                                                                                       ifelse(grepl('Dynasty Warriors',x),'Dynasty Warriors',
                                                                                                                                              ifelse(grepl('Etrian',x),'Etrian Odyssey',
                                                                                                                                                     ifelse(grepl('F-Zero',x),'F-Zero',
                                                                                                                                                            ifelse(grepl('F.E.A.R',x),'FEAR',
                                                                                                                                                                   ifelse(grepl('Fallout',x),'Fallout',
                                                                                                                                                                          ifelse(grepl("Assassins's",x),"Assassin's Creed",
                                                                                                                                                                                 ifelse(grepl('Armored Core',x),'Armored Core',
                                                                                                                                                                                        ifelse(grepl('Atelier',x),'Atelier',
                                                                                                                                                                                               ifelse(grepl('Batman',x),'Batman',
                                                                                                                                                                                                      ifelse(grepl("Assassin's",x),"Assassin's Creed", seg_5(x)
                                                                                                                                                                                                      )))))))))))))))))))))))))))))
}
seg_3 <- function(x){
  ifelse(grepl('BioShock',x),'BioShock',
         ifelse(grepl('BlazBlue',x) | grepl('Blazblue',x),'BlazBlue',                                                                                       
                ifelse(grepl('Bleach',x),'Bleach',
                       ifelse(grepl('Bloody Roar',x),'Bloody Roar',
                              ifelse(grepl('Bomberman',x),'Bomberman',
                                     ifelse(grepl('Borderlands',x),'Borderlands',
                                            ifelse(grepl('Bratz',x),'Bratz',
                                                   ifelse(grepl('Breath of Fire',x),'Breath of Fire',
                                                          ifelse(grepl('Broken Sword',x),'Broken Sword',
                                                                 ifelse(grepl('Brothers in Arms',x)|grepl('Brothers In Arms',x),'Brothers in Arms',
                                                                        ifelse(grepl('Burnout',x),'Burnout',
                                                                               ifelse(grepl('Buzz!',x),'Buzz!',
                                                                                      ifelse(grepl('Cabela',x),'Cabela',
                                                                                             ifelse(grepl('Carmen Sandiego',x),'Carmen Sandiego',
                                                                                                    ifelse(grepl('Castlevania',x),'Castlevania',
                                                                                                           ifelse(grepl('Donkey Kong',x)|grepl('Diddy Kong',x), 'Donkey Kong',
                                                                                                                  ifelse(grepl('Clock Tower',x),'Clock Tower',
                                                                                                                         ifelse(grepl('Command & Conquer',x),'Command & Conquer',
                                                                                                                                ifelse(grepl('Cooking Mama',x),'Cooking Mama',
                                                                                                                                       ifelse(grepl('Crash',x),'Crash Bandicoot',
                                                                                                                                              ifelse(grepl('Crazy Taxi',x), 'Crazy Taxi',
                                                                                                                                                     ifelse(grepl('Crysis',x),'Crysis', seg_4(x))
                                                                                                                                              )))))))))))))))))))))
}
seg_2 <- function(x){
  ifelse(grepl('Animal Crossing',x), 'Animal Crossing',
         ifelse(grepl('Gran Turismo',x), 'Gran Turismo',
                ifelse(grepl('Star Wars',x), 'Star Wars',
                       ifelse(grepl('FIFA',x), 'FIFA',
                              ifelse(grepl('Battlefield',x),'Battlefield',
                                     ifelse(grepl('.hack',x, fixed = TRUE), '.hack',
                                            ifelse(grepl('Super Robot Wars',x),'Super Robot Wars',
                                                   ifelse(grepl('Battle of Giants',x),'Battle of Giants',
                                                          ifelse(grepl('Battle Spirits',x),'Battle Spirits',
                                                                 ifelse(grepl('Battlestations',x),'Battlestations',
                                                                        ifelse(grepl('Bayonetta',x),'Bayonetta',
                                                                               ifelse(grepl('BeatMania',x),'BeatMania',
                                                                                      ifelse(grepl('Katamari',x),'Katamari',
                                                                                             ifelse(grepl('Ben 10',x),'Ben 10',
                                                                                                    ifelse(grepl('Beyblade',x)|grepl('BeyBlade',x),'Beyblade',
                                                                                                           ifelse(grepl('Banjo',x) & !grepl('Sonic',x) & !grepl('Geass',x),'Banjo Kazooie',seg_3(x))
                                                                                                    )))))))))))))))
}
seg_1 <- function(x){
  ifelse(grepl('Mario Kart', x), 'Mario Kart', 
         ifelse(grepl('Mario Party', x), 'Mario Party', 
                ifelse(grepl('Mario Tennis',x),'Mario Tennis',
                       ifelse(grepl('Mario & Sonic',x),'Mario & Sonic',
                              ifelse(grepl('Zelda',x), 'Zelda', 
                                     ifelse(grepl('Mario', x) | grepl('Luigi', x) | grepl('Captain Toad',x) | grepl('Wario',x) & !grepl('Marionette',x), 'Mario',
                                            ifelse(grepl('Pokemon', x) | grepl('Pokémon',x), 'Pokemon',
                                                   ifelse(grepl('Halo', x), 'Halo', 
                                                          ifelse(grepl('Final Fantasy',x), 'Final Fantasy',
                                                                 ifelse(grepl('Call of Duty',x), 'Call of Duty', 
                                                                        ifelse(grepl('Grand Theft Auto', x),'GTA',seg_2(x))
                                                                 ))))))))))
}


series_seg <- function(x){
  seg_1(x)
}


df_filt$Series <-
  sapply(df_filt$Name, series_seg)


top_sales <- function(vg_sys){
  df_vg <- df_filt %>%
    filter(Platform == vg_sys) %>%
    arrange(Rank)
  return(head(df_vg, n = 10))
}