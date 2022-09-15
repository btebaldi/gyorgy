

# Setup -------------------------------------------------------------------

rm(list = ls())

library(readxl)
library(dplyr)
<<<<<<< HEAD
library(ggplot2)
=======
>>>>>>> 93f29d6032740002d40df253b4252697f6fd12d9
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
<<<<<<< HEAD

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
=======
db

res.pca <- db %>% 
  select(Alternativo, Inflacao, Internacional, 
         Multimercados, Pos_fixado, Pre_fixado,
         Renda_Variavel, Sem_Classificacao) %>%
  filter(row_number()>1) %>% 
  prcomp( scale = TRUE, center = TRUE, rank =9)

data1 <- res.pca$x %*% t(res.pca$rotation)

data1[, 1] <- (data1[, 1] * res.pca$scale[1]) + res.pca$center[1]
head(data1) 

db %>% 
  select(Alternativo, Inflacao, Internacional, 
         Multimercados, Pos_fixado, Pre_fixado,
         Renda_Variavel, Sem_Classificacao) %>%
  filter(row_number()>1) %>% 
  data.matrix() %>% 
  apply(2, sd)

res.pca$scale
>>>>>>> 93f29d6032740002d40df253b4252697f6fd12d9


fviz_eig(res.pca)

<<<<<<< HEAD

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



=======
# Graph of individuals. Individuals with a similar profile are grouped together.
fviz_pca_ind(res.pca,
             col.ind = "cos2", # Color by the quality of representation
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE     # Avoid text overlapping
)


# Graph of variables. Positive correlated variables point to the same side of the plot. Negative correlated variables point to opposite sides of the graph.
fviz_pca_var(res.pca,
             col.var = "contrib", # Color by contributions to the PC
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE     # Avoid text overlapping
)


# Biplot of individuals and variables
fviz_pca_biplot(res.pca, repel = TRUE,
                col.var = "#2E9FDF", # Variables color
                col.ind = "#696969"  # Individuals color
)
>>>>>>> 93f29d6032740002d40df253b4252697f6fd12d9
