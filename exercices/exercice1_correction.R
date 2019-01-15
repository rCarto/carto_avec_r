################################################################################
##                                                                            ##
##                                EXERCICE 1                                  ##
##                                                                            ##
##                      Gestion de couches géographiques                      ##
##                                                                            ##
################################################################################


################################################################################
## CREER UN PROJET R 
################################################################################

# Créez un projet avant de démarrer l'exercice. 
# Il s'agit d'une bonne pratique qui vous facilitera la tâche.
# Cela améliore l'organisation et la portabilité de votre travail


################################################################################
## 1) TELECHARGER LA COUCHE GEO DES COMMUNNES FRANCAISES METROPOLITAINES
################################################################################

# Une couche géographique des communes françaises métropolitaines en format shp
# est disponible ici : 
# 
# http://www.gis-cist.fr/Cours/data.zip
# 
# Source : 
# BD ADMIN EXPRESS (IGN) & Base comparateur de territoires (INSEE), 2018


# Téléchargez et décompressez la dans votre dossier projet



################################################################################
## 2) CHARGER LA COUCHE GEOGRAPHIQUE SOUS R
################################################################################

# a) Charger la couche géographique des communes françaises métroplitaines sous R
# En utilisant la library(sf) et la fonction st_read()
# b) Vérifiez le système de projection avec st_crs() / modifer = st_transform()

#####
library(sf)
Shp_commune <- read_sf("data/shape/COMMUNE_CARTO.shp", quiet=TRUE)

# Vérifier le système de projection
st_crs(Shp_commune) 
# Compléter les informations sur le système de projection
st_crs(Shp_commune) <- 2154

#####

################################################################################
## 3) CREATION D'UNE NOUVELLE COUCHE - SELECTION PAR ATTRIBUTS
################################################################################

# Créez un nouvel objet sf à partir d'une séléction par attribut
# a) Séléctionnez toutes les communes d'une seule région
# b) Enregistrez votre séléction dans un nouvel objet
# c) Afficher la nouvelle couche (st_geometry())

# Pour connaitre la liste de tous les noms ou code de région --> unique()

#####
# Afficher la liste des noms des différentes régions françaises
unique(Shp_commune$NOM_REG)

# Séléctionner une région (ex: "CORSE") 
Shp_commune_corse <- Shp_commune[Shp_commune$NOM_REG %in% "CORSE",]
# OU avec la library dplyr
library(dplyr)
Shp_commune_corse <- Shp_commune %>% filter(NOM_REG=="CORSE")

# Afficher la couche géographique créee
plot(Shp_commune_corse)
plot(st_geometry(Shp_commune_corse))
#####



################################################################################
## 4) CREATION D'UNE NOUVELLE COUCHE - PAR FUSION D'ENTITES GEOGRAPHIQUES
################################################################################

# a) Fusionnez les communes de votre région en un polygone = votre région
# Utilisez la fonction st_union ()

#####
# Union de toutes les entités d'un objet sf
Shp_region_corse <- st_union(Shp_commune_corse)
#####

# b) Créez la couche géograpique des départements de votre région
# Utilisez la library(dplyr) pour regrouper les polygones par attribut
# Il s'agit de la même écriture que pour le regroupement d'un dataframe

#####
library(dplyr)
Shp_departement_corse <- Shp_commune_corse %>%  
  group_by(INSEE_DEP, NOM_DEP) %>% 
  summarize(nb=n())
#####

# c) Affichez les résultats

#####
plot(Shp_region_corse)
plot(Shp_departement_corse)
#####



################################################################################
## 5) CREATION D'UNE NOUVELLE COUCHE - ZONE TAMPON
################################################################################

# Créez une zone tampon d'une distance de 15km autour des limites d'une commune
# de votre choix avec st_buffer()
# a) Commencez par séléctionner une commune, puis appliquer lui un buffer

#####
# Séléctionner une commune au hasard avec st_sample()
# choisir une commune au hasard
Shp_sel_commune_corse <- Shp_commune_corse[sample(1:nrow(Shp_commune_corse), size = 1), ]

# OU réaliser une séléction selon une valeur
Shp_sel_commune_corse  <- Shp_commune_corse[Shp_commune_corse$INSEE_COM %in% "2A070", ]

# Calculer un buffer de 15 km autour de cette commune
Buff_sel_commune_corse <- st_buffer(x = Shp_sel_commune_corse,
                                    dist = 15000)
#####


plot(st_geometry(Shp_commune_corse))
plot(st_geometry(Shp_sel_commune_corse), col = "red", add=TRUE)
plot(st_geometry(Buff_sel_commune_corse), col = NA, border = "blue", lwd = 2, add=TRUE)


################################################################################
# 6) CREATION D'UNE NOUVELLE COUCHE - SELECTION PAR LOCALISATION
################################################################################

# Déterminez quelles communes de votre région intersectent le buffer crée
# Utilisez la fonction st_intersects() de la library(sf)
# Inserez directement le resultat comme variable du shape des communes

#####
Shp_commune_corse$buff <- st_intersects(x = st_geometry(Shp_commune_corse), 
                                        y = st_geometry(Buff_sel_commune_corse), 
                                        sparse = FALSE)
#####



################################################################################
# 7) AFFICHAGE DE COUCHE GEOGRAPHIQUE
################################################################################

# Affichez/superposez toutes les couches géographiques créees :
# Couche des communes de votre région
# Couche des communes intersectées par le buffer
# Couche de votre commune séléctionnée
# Couche du buffer 
# Couche des départements de votre région
# Couche des limites de votre région

# Jouez sur les styles pour les différencier... 

#####
# Gestion des marges
par(mar = c(0.5,0.5,1.5,0.5)) 
# Affichage de la première couche
plot(st_geometry(Shp_commune_corse), col="#aec8f2", border="darkblue", lwd=1)
# Ajout de couches supplémentaires
plot(st_geometry(Shp_commune_corse[Shp_commune_corse$buff ==TRUE,]), 
     col="pink", lwd=1, border="red", add=T)
plot(st_geometry(Shp_sel_commune_corse), col="green", border="black", 
     lwd=1, add=T)
plot(st_geometry(Buff_sel_commune_corse), col=NA, border="black",
     lwd=2, lty=2,add=T)
#####



################################################################################
# 8) CREATION D'UNE COUCHE DE POINT - A PARTIR DE LONG ET LAT
################################################################################

# Créer un objet sf (points) contenant la localisation de la préfécture de région
# Vous pouvez récupérer la longitude et la latitude sur Google Map ou OSM
# Créer un point avec st_points(), puis l'objet sf avec st_sfc() et st_sf()

#####
# Création d'un point à partir d'une longitude et latitude)
pts_prefecture <- st_point(c(8.736599, 41.919576))

# Création de la géométrie (objet sfc)
Geom_prefecture <- st_sfc(pts_prefecture, crs = (4326))

# Création d'un data frame (attributs sémantiques) pour construire objet sf
df_prefecture <- data.frame(id = 1, type = "PREFECTURE")

# Création objet sf
sf_prefecture <- st_sf(df_prefecture, geometry = Geom_prefecture)

class(sf_prefecture)
#####



################################################################################
# 9) CALCUL D'UNE MATRICE DE DISTANCE - distance entre des points
################################################################################

# Calculez une matrice de distance entre la préfecteure et les centroïdes des
# communes de votre région. Pour cela, utiliser la fonct st_distance()
# N'oubliez pas de vérifier les projections utilisées avec st_transform()

#####
# Modifier la projection
sf_prefecture <- st_transform(sf_prefecture, crs=2154)
# Extraire les centroïdes des communes de votre région
st_geometry(Pts_commune_corse) <- st_centroid(st_geometry(Shp_commune_corse))

# Calculer les distances entre préfecture et centroïdes de communes
Shp_commune_corse$dist_pref <- as.numeric(st_distance(x=st_geometry(sf_prefecture),
                                                      y=st_geometry(Pts_commune_corse),
                                                      by_element = TRUE))
#####



################################################################################
# 10) CARTOGRAPHIE D'UNE VARIABLE D'UN OBJET SF
################################################################################

# Essayer de cartographier (uniquement) la distance de chaque commune à la 
# préfecture de la  région avec la fonction plot...

#####
# Indiquer la variable à cartographier entre[""]
plot(Shp_commune_corse["dist_pref"])
plot(st_geometry(sf_prefecture), pch="x", cex = 2, col = "red", add=T)

#####






