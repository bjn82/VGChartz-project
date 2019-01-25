# Readme

A look into video game sales in different regions and several other facets.

by Brennan James Donnell

[BitBucket](https://bitbucket.org/bjn82/video_game_sales_vgchartz/src/master/)


---

## Intro:
Video games have been a part of my life. Old video came consoles are of particular interest to me. Both from a technical perspective and from a historical perspective. What made one console successful and another a failure? Was it the games? The company? The competition? The hardware? Or a combination of factors? Though I don't have as much time to play games as I used to, I still find it fascinating to look at how games consoles have changed over time.

---
## Data Dictionary:
* **Rank**: Position in the VGChartz GameDB, based on global sales.
* **Name**: Name of the game.
* **Platform**: System on which the game was released.
* **Year**: Year in which the game was first released.
* **Genre**: Genre in which the game was primarily placed.
* **Publisher**: Company that *published* the game.
* **NA_Sales**: Sales in North America in millions of units.
* **EU_Sales**: Sales in Europe in millions of units.
* **JP_Sales**: Sales in Japan in millions of units.
* **Other_Sales**: Sales in other parts of the world in millions.
* **Global_Sales**: Overall sales in millions of units.
* **Series**: What main series was the game a part of.

---

## Packages used:
* data.table
* dplyr
* ggplot2
* lubridate
* markdown
* plotly
* rebus
* shiny
* stringr

---

## Goals
* To highlight regional sales by series to see where a series performs best.
* To Visualize top-selling games in the lifespan of a system when compared to other systems
* To explore how what kinds of games publishers trend towards, as well as the sales of the games on different platforms.
* To discover more about video game consoles, both in terms of hardware, software, games, and the reasons why a console succeeded or why others failed.

---

## Known issues:
* Series recognition and sorting is not perfect.
 + It's entirely based on manually going through the list.
 + Someday I would like to algorithmically go through and put similar titles together. For now though, it does okay because I told it to.
* I didn't have the time to modify the scraper to get the game developer information, which I really would have liked to have.
* The information I have is incredibly basic and nearly all of it can be found by reading through Wikipedia.

---

## Future steps:
* Scrape developer and rating information
* Create a more algorithmic way to define a series
* Pull in more data from different sources, such as *IGN* on games not present in the chart to work towards a more complete setup of a console's library.
* Port the versioning from *BitBucket* to *GitHub*.
* Fork it on the Kaggle data page.
* Create a more robust *Genre* tag for cross-genre info.
* Continue to update the *Console Information* tab.
 + Include information about consoles not present: CD-i, Virtual Boy
 + Include info about add-ons and system variants: Sega 32x, Nintendo 64DD, etc.
* Look into having more historical information
 + Console war between Sega and Nintendo
 + Video Game Crash in North America.

---

## Sources:
* Images: Wikipedia
* Basic platform info: Wikipedia
* Dataset: [Kaggle](https://www.kaggle.com/gregorut/videogamesales) & [VGChartz](http://www.vgchartz.com/gamedb/)
* Series info: Personal information

---

## Further information:
* AVGN: YouTuber.
 + Talks about a lot of old video games and lesser known systems, particularly ones that are bad.
* *Console War*: Novel.
 + Written about the console war between Sega and Nintendo during the era of the SNES and the Genesis. I haven't finished it yet.
* DF Retro (Digital Foundry): Website & YouTuber.
 + Good info about different versions of games that appear on different platforms, as well as game console architecture.

---

## Contact me:
* [LinkedIn](https://www.linkedin.com/in/brennan-donnell-112066165/)
* [GitHub](https://github.com/bjn82)
* Email: bjn82@wildcats.unh.edu
