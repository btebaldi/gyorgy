

# Setup -------------------------------------------------------------------

rm(list = ls())

library(readxl)
library(dplyr)
library(ggplot2)
library(factoextra)


db <- read_excel("../Simulacao GYORGY.xlsx", 
                 col_types = c("date", "numeric", "numeric", 
                               "numeric", "numeric", "numeric", 
                               "numeric", "numeric", "numeric", 
                               "numeric", "numeric", "numeric", 
                               "numeric", "numeric", "numeric", 
                               "numeric", "numeric", "numeric"), 
                 skip = 1)

db$Data <- as.Date(db$Data)

pca.data <- db %>%
  select(Alternativo, 
         Inflacao, 
         Internacional,
         Multimercados,
         Pos_fixado,
         Pre_fixado,
         Renda_Variavel,
         Sem_Classificacao) %>% 
  filter(row_number() > 1)


res.pca <- prcomp(pca.data, scale = TRUE)


fviz_eig(res.pca)


fviz_pca_ind(res.pca,
             col.ind = "cos2", # Color by the quality of representation
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"))



fviz_pca_var(res.pca,
             col.var = "contrib", # Color by contributions to the PC
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"))



fviz_pca_biplot(res.pca, repel = TRUE,
                col.var = "#2E9FDF", # Variables color
                col.ind = "#696969")  # Individuals color


res.pca$rotation
res.pca$center
res.pca$scale
res.pca$x



