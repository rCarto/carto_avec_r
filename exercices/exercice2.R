################################################################################
##                                                                            ##
##                                  EXERCICE 2                                ##
##                                                                            ##
##                           CARTOGRAPHIE THEMATIQUE                          ##
##                                                                            ##
################################################################################



################################################################################
## 1) CHARGER COUCHE GEOGRAPHIQUE & DONNEES ALPHANUMERIQUES SOUS R
################################################################################

# a) Charger la couche géographique des communes françaises métroplitaines sous R
# En utilisant la library(sf) et la fonction st_read()
# b) Vérifiez le système de projection avec st_crs() 
# C) Charger les fichier de données base_cc_comparateur.xls fournie par l'insee 
# Utilisez la library(readxl) et la fonction read_excel() pour 
# ouvrir la table de données correctement...


################################################################################
## 2) CREATION D'UNE NOUVELLE COUCHE - SELECTION PAR ATTRIBUTS
################################################################################

# Créez un nouvel objet sf à partir d'une séléction par attribut
# a) Séléctionnez toutes les communes d'une seule région
# b) Enregistrez votre séléction dans un nouvel objet
# c) Afficher la nouvelle couche (st_geometry())

# Pour connaitre la liste de tous les noms ou code de région --> unique()


################################################################################
## 3) REALISER UNE JOINTURE - COUCHE GEO ET TABLE DE DONNEES
################################################################################

# a) Joingnez la table de données insee avec la couche gégographique des communes 
# de votre région séléctionnée. Utilisez la fonction merge()




################################################################################
## 4) REALISATION DE CARTE THEMATIQUES 
################################################################################

# REALISEZ SEPT CARTES THEMATIQUES, avec au moins :

# 3 échelles différentes (échelle du pays, de la région, du département, de l'EPCI...)
# 3 découpages territoriaux différents (les communes, les EPCI, les départements...)
# Exemple : 
# - Une carte à des départements à l'échelle d'une région, 
# - Une carte des EPCI à l'échelle de la France, 
# - Unne carte des communes à l'échelle d'un département...

# 1 carte de localisation (avec carton de localisation, label, legende...)
# 1 carte quantitative de stock
# 1 carte quantitative de ratio
# 1 carte quantitative combinant stock et ratio
# 1 carte qualitative
# 1 Anamorphose/cartogram
# 1 carte avec des discontinuités représentées


# Nous vous conseillons d'utiliser le package 'cartography' pour l'ensemble de 
# vos réalisations. 
# Néanmoins l'utilisation d'autres libraries sera une valeur ajoutée (ggplot2...)

# A RENDRE POUR LE ? :
# - 1 pgm R
# - 1 document avec les 7 cartes produites

#####
# Exemple : Carte du taux de chômage et discontinuité par EPCI en Île de France
# (échelle = une région, territoire = EPCI)

