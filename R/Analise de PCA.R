

# Setup -------------------------------------------------------------------

rm(list = ls())

library(readxl)
library(dplyr)
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


fviz_eig(res.pca)

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
