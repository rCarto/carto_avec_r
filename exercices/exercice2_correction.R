library(sf)
library(readxl)
library(dplyr)
library(cartography)

# import des communes
com.sf <- st_read("data/shape/COMMUNE_CARTO.shp", quiet=TRUE)

# import des données
com.df <- read_excel(path = "data/insee/base_cc_comparateur.xls",
                          sheet = 1, skip = 5) 

# sélection des communes d'IDF
comidf <- com.sf[com.sf$INSEE_REG == 11,]

# création des départements
dep <- com.sf %>%
  group_by(INSEE_DEP) %>%
  summarize(n=n()) %>%
  st_cast()

# afficher la couche géographique créee
par(mar = c(0,0,0,0))
plot(st_geometry(comidf))

# joindre les données
comidf <- merge(x = comidf, 
                y = com.df, 
                by.x="INSEE_COM", 
                by.y="CODGEO", 
                all.x = TRUE )

# créez la couche des EPCI en Île de france (en agrégeant des indicateurs)
epciidf <- comidf %>%  
  group_by(CODE_EPCI) %>% 
  summarize(P15_CHOM1564=sum(P15_CHOM1564),
            P15_ACT1564=sum(P15_ACT1564)) %>%
  st_cast()

# calcul du taux de chômage par EPCI, en Ile de france
epciidf$tx_unemp <- round(epciidf$P15_CHOM1564 / epciidf$P15_ACT1564 * 100, 1)

# Affichage de la carte
# Définition des marges
par(mar = c(0.2,0.2,1.4,0.2))
# Centrer la carte sur l'IDF
plot(st_geometry(epciidf), border = NA, col=NA)
# Affichage des départements
plot(st_geometry(dep), border = "white", col="grey", add=T, lwd = 1)
# Affichage d'un ombrage
plot(st_geometry(epciidf) + c(2000,-2000),
     col = "grey20", border = NA, add=T )
# Affichage du taux de chômage, discrétisé par la méthode des quantiles
choroLayer(x = epciidf, 
           var = "tx_unemp", 
           method = "quantile",
           nclass = 6, 
           border = "white", 
           lwd = 0.5, 
           col = carto.pal(pal1 = "wine.pal", n1 = 6), 
           legend.pos = "left", 
           legend.title.txt = "Taux de\nchômage\n(en %)", 
           legend.title.cex = 0.9,
           legend.values.cex = 0.7,
           legend.frame = TRUE,
           add=TRUE)
# habillage
layoutLayer(title ="Le chômage dans les EPCI d'Ile de France", 
            coltitle = "white",
            tabtitle = TRUE,
            frame = FALSE,
            sources = "", 
            author = "",
            scale = 20)
north(pos = "topleft", col = "black")


# Carte qualitative du taux de chômage de l'APCI par rapport au taux national
# taux national (https://www.insee.fr/fr/statistiques/2851776)

# construction d'une variable qualitative en 2 modalités
txfr <- 9.6
epciidf[epciidf$tx_unemp>=txfr,"chom"] <- "Plus élevé"
epciidf[epciidf$tx_unemp<txfr,"chom"] <- "Moins élevé"

# Première carte avec 2 modalité
typoLayer(x = epciidf, var = "chom", 
          col = c("firebrick", "darkslategray"),
          legend.title.txt = "Taux de chômage\nde l'EPCI\npar rapport\nau taux national\n(9.6%)" )

# Construction d'une variable qualitative en 3 modalités
epciidf$chom2 <- "Proche"
epciidf[epciidf$tx_unemp>=txfr+1,"chom2"] <- "Plus élevé"
epciidf[epciidf$tx_unemp<txfr-1,"chom2"] <- "Moins élevé"

# Affichage de la carte
# Définition des marges
par(mar = c(0.2,0.2,1.4,0.2))
# Centrer la carte sur l'IDF
plot(st_geometry(epciidf), border = NA, col=NA)
# Affichage des départements
plot(st_geometry(dep), border = "white", col="grey", add=T, lwd = 1)
# Affichage d'un ombrage
plot(st_geometry(epciidf) + c(2000,-2000),
     col = "grey20", border = NA, add=T )
# Affichage de la ccarte qualitative
typoLayer(x = epciidf, var = "chom2", 
          col = c("firebrick","gold", "darkslategray"),
          legend.title.txt = "Taux de chômage\nde l'EPCI\npar rapport\nau taux national\n(9.6%)", 
          legend.values.order = c("Plus élevé", "Proche", "Moins élevé"), 
          legend.pos = "left", add=T)
# Affichage de l'habillage
layoutLayer(title ="Le chômage dans les EPCI d'Ile de France", 
            coltitle = "white",
            tabtitle = TRUE,
            frame = TRUE,
            author = "Données : Insee, 2018; Fond de carte : IGN - Admin Express 2019", 
            sources = "",
            scale = 20)
# Placer interactivement un texte avec locator()
# locator(1)
text(x = 743420.4, y = 6787277,
     labels = "T. Giraud & H. Pécout, 2019",
     srt = 90, adj = c(0,1), cex = 0.7)
