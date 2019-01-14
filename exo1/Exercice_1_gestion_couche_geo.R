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


################################################################################
## 3) CREATION D'UNE NOUVELLE COUCHE - SELECTION PAR ATTRIBUTS
################################################################################

# Créez un nouvel objet sf à partir d'une séléction par attribut
# a) Séléctionnez toutes les communes d'une seule région
# b) Enregistrez votre séléction dans un nouvel objet
# c) Afficher la nouvelle couche (st_geometry())

# Pour connaitre la liste de tous les noms ou code de région --> unique()


################################################################################
## 4) CREATION D'UNE NOUVELLE COUCHE - PAR FUSION D'ENTITES GEOGRAPHIQUES
################################################################################

# a) Fusionnez les communes de votre région en un polygone = votre région
# Utilisez la fonction st_union ()

# b) Créez la couche géograpique des départements de votre région
# Utilisez la library(dplyr) pour regrouper les polygones par attribut
# Il s'agit de la même écriture que pour le regroupement d'un dataframe


# c) Affichez les résultats




################################################################################
## 5) CREATION D'UNE NOUVELLE COUCHE - ZONE TAMPON
################################################################################

# Créez une zone tampon d'une distance de 15km autour des limites d'une commune
# de votre choix avec st_buffer()
# a) Commencez par séléctionner une commune, puis appliquer lui un buffer


################################################################################
# 6) CREATION D'UNE NOUVELLE COUCHE - SELECTION PAR LOCALISATION
################################################################################

# Déterminez quelles communes de votre région intersectent le buffer crée
# Utilisez la fonction st_intersects() de la library(sf)
# Inserez directement le resultat comme variable du shape des communes



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



################################################################################
# 8) CREATION D'UNE COUCHE DE POINT - A PARTIR DE LONG ET LAT
################################################################################

# Créer un objet sf (points) contenant la localisation de la préfécture de région
# Vous pouvez récupérer la longitude et la latitude sur Google Map ou OSM
# Créer un point avec st_points(), puis l'objet sf avec st_sfc() et st_sf()




################################################################################
# 9) CALCUL D'UNE MATRICE DE DISTANCE - distance entre des points
################################################################################

# Calculez une matrice de distance entre la préfecteure et les centroïdes des
# communes de votre région. Pour cela, utiliser la fonct st_distance()
# N'oubliez pas de vérifier les projections utilisées avec st_transform()

################################################################################
# 10) CARTOGRAPHIE D'UNE VARIABLE D'UN OBJET SF
################################################################################

# Essayer de cartographier (uniquement) la distance de chaque commune à la 
# préfecture de la  région avec la fonction plot...
