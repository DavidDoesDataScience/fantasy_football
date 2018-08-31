### Load libraries
install.packages(c('ggplot2', 'ggthemes', 'tidyr', 'viridis', 'shiny', 'devtools', 'MASS', 'RColorBrewer'),
                 repos = 'http://cran.us.r-project.org')
require(ggplot2)
require(ggthemes)
require(tidyr)
require(viridis)
require(shiny)
require(devtools)
require(MASS)
require(RColorBrewer)


### create my pallete
# Qualitative color schemes by Paul Tol
tol1qualitative=c("#4477AA")
tol2qualitative=c("#4477AA", "#CC6677")
tol3qualitative=c("#4477AA", "#DDCC77", "#CC6677")
tol4qualitative=c("#4477AA", "#117733", "#DDCC77", "#CC6677")
tol5qualitative=c("#332288", "#88CCEE", "#117733", "#DDCC77", "#CC6677")
tol6qualitative=c("#332288", "#88CCEE", "#117733", "#DDCC77", "#CC6677","#AA4499")
tol7qualitative=c("#332288", "#88CCEE", "#44AA99", "#117733", "#DDCC77", "#CC6677","#AA4499")
tol8qualitative=c("#332288", "#88CCEE", "#44AA99", "#117733", "#999933", "#DDCC77", "#CC6677","#AA4499")
tol9qualitative=c("#332288", "#88CCEE", "#44AA99", "#117733", "#999933", "#DDCC77", "#CC6677", "#882255", "#AA4499")
tol10qualitative=c("#332288", "#88CCEE", "#44AA99", "#117733", "#999933", "#DDCC77", "#661100", "#CC6677", "#882255", "#AA4499")
tol11qualitative=c("#332288", "#6699CC", "#88CCEE", "#44AA99", "#117733", "#999933", "#DDCC77", "#661100", "#CC6677", "#882255", "#AA4499")
tol12qualitative=c("#332288", "#6699CC", "#88CCEE", "#44AA99", "#117733", "#999933", "#DDCC77", "#661100", "#CC6677", "#AA4466", "#882255", "#AA4499")

tol_pal <- list(tol1qualitative,
                tol2qualitative,
                tol3qualitative,
                tol4qualitative,
                tol5qualitative,
                tol6qualitative,
                tol7qualitative,
                tol8qualitative,
                tol9qualitative,
                tol10qualitative,
                tol11qualitative,
                tol12qualitative
                )

### Load Data into Workspace

ov <- read.csv('~/dev/fantasy_football/data/TierSummary - OverallTiers.csv', header = T)
ov$Tier <- as.factor(as.character(ov$Tier))

qb <- read.csv('~/dev/fantasy_football/data/TierSummary - QBTiers.csv', header = T)
qb$Tier <- as.factor(qb$Tier)

wr <- read.csv('~/dev/fantasy_football/data/TierSummary - WRTiers.csv', header = T)
wr$Tier <- as.factor(wr$Tier)

rb <- read.csv('~/dev/fantasy_football/data/TierSummary - RBTiers.csv', header = T)
rb$Tier <- as.factor(rb$Tier)

te <- read.csv('~/dev/fantasy_football/data/TierSummary - TETiers.csv', header = T)
te$Tier <- as.factor(te$Tier)

kc <- read.csv('~/dev/fantasy_football/data/TierSummary - KTiers.csv', header = T)
kc$Tier <- as.factor(kc$Tier)

dst <- read.csv('~/dev/fantasy_football/data/TierSummary - DSTTiers.csv', header = T)
dst$Tier <- as.factor(dst$Tier)






