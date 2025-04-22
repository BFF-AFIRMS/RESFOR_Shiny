### Setup DuckDB
library(duckdb)

drv <- duckdb::duckdb(dbdir = 'data.duckdb')
con <- duckdb::dbConnect(drv)

### Spruce
spruce<-readRDS('../data/spruce.final.RDS')

spruce$HbBV_C13_gain<-spruce$HbBV_C13_gain*-1
spruce$AbBV_C13_gain<-spruce$AbBV_C13_gain*-1

spruce$Site<-factor(spruce$Site)
spruce$ID<-as.character(spruce$ID)
spruce$Family<-as.character(spruce$Family)

spruce.bv.index<-c(29,31,33,35,37)
spruce.bv.nice.names<-c("DBH30","HT30","WD","RES2015","C13")
spruce.bv.names<-colnames(spruce)[spruce.bv.index]

spruce.A.bv.index<-spruce.bv.index+10
spruce.A.bv.names<-colnames(spruce)[spruce.A.bv.index]

spruce.phen.index<-c(15,18,21,23,25)
spruce.phen.names<-colnames(spruce)[spruce.phen.index]

spruce.gen.gain.index<-c(49:53)
spruce.ped.gain.index<-c(54:58)

spruce.bv.names
spruce.A.bv.names
spruce.phen.names
spruce.bv.nice.names
colnames(spruce[spruce.gen.gain.index])
colnames(spruce[spruce.ped.gain.index])

duckdb::dbWriteTable(con, "spruce", spruce)
###

### Pine
pine<-readRDS('../data/pine.final.RDS')

pine$BV_G.C13b.s_gain<-pine$BV_G.C13b.s_gain*-1
pine$BV_A.C13b.s_gain<-pine$BV_A.C13b.s_gain*-1
#pine$Hs8.BV_HT30_gain<-pine$Hs8.BV_HT30_gain+1
#pine$Hs8.BV_DBH30_gain<-pine$Hs8.BV_DBH30_gain+1

pine$Site<-factor(pine$Site)
pine$ID<-as.character(pine$ID)
pine$Family<-as.character(pine$Family)

duckdb::dbWriteTable(con, "pine", pine)
### 

### Soil GRIDS

soilGRIDS <- readRDS('../data/soilGRIDS.data.RDS')
duckdb::dbWriteTable(con, "soilGRIDS", soilGRIDS)

### Climate

climate <- readRDS('../data/clim.data.long.RDS')
duckdb::dbWriteTable(con, "climate", climate)

### Legacy

pine.msmt <- as.data.frame(readRDS('../data/pine.MSMT.wide.bvs.RDS'))
duckdb::dbWriteTable(con, "pine_msmt", pine.msmt)
