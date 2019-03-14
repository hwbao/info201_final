library(dplyr)

get_desc <- function(name) {
  result <- temp %>% 
    filter(x == name) %>% 
    select(y) %>% 
    pull()
}

y <- c(
"the sub category installation has highest amount of average goal, and the sub category digital art has lowest amount of average goal.",
"the sub category comics has highest amount of average goal, and the sub category comic book has lowest amount of average goal",
"the sub category weaving has highest amount of average goal, and the sub category crochet has lowest amount of average goal",
"the sub category spaces has highest amount of average goal, and the sub category dance has lowest amount of average goal",
"the sub category architecture has highest amount of average goal, and the sub category graphical design has lowest amount of average goal",
 "the sub category couture has highest amount of average goal, and the sub category pet fashion has lowest amount of average goal",
"the sub category movie theater has highest amount of average goal, and the sub category music videos has lowest amount of average goal",
"the sub category farms has highest amount of average goal, and the sub category small batches has lowest amount of average goal",
"the sub category live games has highest amount of average goal, and the sub category playing car games has lowest amount of average goal",
"the sub category video has highest amount of average goal, and the sub category photo has lowest amount of average goal",
"the sub category comedy has highest amount of average goal, and the sub category indie rock has lowest amount of average goal",
 "the sub category nature has highest amount of average goal, and the sub category places has lowest amount of average goal",
 "the sub category translation has highest amount of average goal, and the sub category poetry has lowest amount of average goal",
 "the sub category space exploration has highest amount of average goal, and the sub category DIY electronics has lowest amount of average goal",
"the sub category space has highest amount of average goal, and the sub category comedy has lowest amount of average goal"
)



x <- c("Art", "Comics", "Crafts", "Dance", "Design", "Fashion", 'Film & Video', "Food", "Game", "Journalism", "Music", 
       "Photography", "Publishing", "Technology", "Theater")
temp <- data.frame(x, y, stringsAsFactors = F)
