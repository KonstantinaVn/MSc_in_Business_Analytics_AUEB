#Athens University of Economics and Business
#M.Sc. Program in Business Analytics
#Course: Social Network Analysis - Spring 2022
#Student_i:p2822107
#Name: Vioni Konstantina
#Instructor: Katia Papakonstantinopoulou


## Project 1:Network Analysis and Visualization with R and igraph ##


####### Task 1: 'A Song of Ice and Fire' network ###############################

## Creation of igraph graph1 using the network of the characters of 'A Song of Ice and Fire' 
## by George R. R. Martin 
## columns Source, Target, and Weight were used to create an undirected weighted graph

#installation of igraph package
install.packages("igraph")

#Load package
library(igraph)

#reading the data
dataset <- read.csv("C:/Users/konst/Desktop/Social Network/1st Assignment/asoiaf-all-edges.csv")
View(dataset)

#gaining information about our dataset
str(dataset)
#It consisted of 2.823 observations and 5 variables ('Source','Target','Type','id','Weight')

#checking for null values
table(is.na(dataset))
#there were no missing  values

#keeping only columns Source, Target, and Weight to create an undirected weighted graph
dataset_=dataset[c('Source','Target','weight')]

#creation of graph 'g'
g<- graph_from_data_frame(dataset_, directed=FALSE)
print(g,e=TRUE, v=TRUE) 

#viewing the attributes of edge
edge_attr(g)       

##################### Task 2: Network Properties ###############################
## Having created an igraph graph, we explored its basic properties and #######
## wrote code to print:#######################################################

##Number of vertices
vcount(g)
#the number of vertices was 796

##Number of edges
ecount(g)
#the number of edges was 2823

##Diameter of the graph
diameter(g)
# the diameter of the graph was 53

##Number of triangles
sum(count_triangles(g, vids = V(g)))
#The number of triangles was 16965


##The top-10 characters of the network as far as their degree is concerned

 #For this question, I used function degree() to calculate the degree centrality
 #Then, i sorted the result by decreasing order and displayed the 10 first characters of the network
top_10_degree<-head(sort(degree(g,mode='total'),decreasing = TRUE),10)
print(top_10_degree)

 #The top-10 characters of the network were the below:

 # Tyrion-Lannister   Jon-Snow   Jaime-Lannister  Cersei-Lannister Stannis-Baratheon 
 #   122               114               101                97                89 

 # Arya-Stark     Catelyn-Stark       Sansa-Stark      Eddard-Stark        Robb-Stark 
 #    84                75                75                74                74 


##The top-10 characters of the network as far as their weighted degree is concerned

 #For this question i used function strength to sum up the edge weights of the adjacent 
 #edges for each vertex.Then, i sorted the result by decreasing order and displayed the 
 #first 10 by the use of head() function.

top_10_weighted_degree<-head(sort(strength(g,vids = V(g),mode ="total",loops = TRUE),decreasing =TRUE),10)
print(top_10_weighted_degree)

 #Result:
 #  Tyrion-Lannister     Jon-Snow   Cersei-Lannister  Joffrey-Baratheon 
 #    2873               2757               2232               1762 
 # Eddard-Stark Daenerys-Targaryen    Jaime-Lannister        Sansa-Stark 
 #   1649               1608               1569               1547 
 # Bran-Stark   Robert-Baratheon 
 #   1508               1488 


##################### Task 3: Subgraph #########################################
##3.1)Plot the entire network.##################################################
##3.2)Create a subgraph of the network, by discarding all vertices that ########
##have less than 10 connections in the network, and plot the subgraph.##########
##3.3)Write code that calculates the edge density of the entire graph, as well##
##as the aforementioned subgraph,and provide an explanation on the obtained ####
##results (a few sentences in your report)######################################


#3.1:Plot of the entire network:

plot(g,vertex.label= NA,edge.arrow.width= 0.8,edge.arrow.size= 0.2, vertex.size= 3,vertex.color="blue") 


#3.2:Create a subgraph of the network, by discarding all vertices that have less 
# than 10 connections in the network, and plot the subgraph.

important <- degree(g,mode='total') >= 10
imp_prod <- V(g) [important]
plot(induced_subgraph(g,vids=imp_prod),vertex.label= NA,edge.arrow.width= 0.8,edge.arrow.size= 0.2, vertex.size= 3,vertex.color="orange")


#3.3:Write code that calculates the edge density of the entire graph, as well
# as the aforementioned subgraph,and provide an explanation on the obtained 
# results (a few sentences in your report)

# We used the edge_density function that is the number of edges divided by maximal number of edges.
#calculation of the edge density of the whole graph
edge_density(g, loops = FALSE)
#Result:0.008921968

#calculation of the edge density of the subgraph
edge_density(induced_subgraph(g,vids=imp_prod), loops = FALSE)
#Result:0.117003

# The edge density of the subgraph was higher than that of the entire graph.This 
# result was reasonable due to the fact that the density of a graph is the ratio 
# of the number of edges and the number of possible edges.The subgraph of the 
# network contained all vertices that had less than 10 connections in the network.
# As a matter of fact the number of edges was lower and the result of the ratio
# higher.


##################### Task 4:Centrality ########################################
## 4.1)Write code to calculate and print the top-15 nodes according to #########
###### the:  . closeness centrality ############################################
############ . betweenness centrality ##########################################
## 4.2)Find out where the character Jon Snow is ranked according to the above #
## two measures and provide an explanation (a few sentences) of the observations
## you make after examining your results. ######################################
  



#4.1:Write code to calculate and print the top-15 nodes according to the: 


# closeness centrality :
c_c_top_15<-head(sort(closeness(g,vids = V(g),normalized = FALSE),decreasing=TRUE),15)
print(c_c_top_15)

#Result:
#Jaime-Lannister  Robert-Baratheon Stannis-Baratheon     Theon-Greyjoy       Jory-Cassel 
#0.0001205982      0.0001162791      0.0001146921      0.0001146132      0.0001141553 
#Tywin-Lannister  Tyrion-Lannister  Cersei-Lannister  Brienne-of-Tarth    Jon-Snow 
#0.0001137656      0.0001130071      0.0001129688      0.0001124480      0.0001118944 
#Joffrey-Baratheon     Rodrik-Cassel      Eddard-Stark     Doran-Martell   Robb-Stark 
#0.0001105094      0.0001103631      0.0001092180      0.0001088613      0.0001088495 

# betweenness centrality :
b_c_top_15<-head(sort(betweenness(g,v = V(g),directed = FALSE,normalized = FALSE),decreasing=TRUE),15)
print(b_c_top_15)

#Result:
#Jon-Snow      Theon-Greyjoy    Jaime-Lannister Daenerys-Targaryen 
#41698.94           38904.51           36856.35           29728.50 
#Stannis-Baratheon   Robert-Baratheon   Tyrion-Lannister   Cersei-Lannister 
#29325.18           29201.60           28917.83           24409.67 
#Tywin-Lannister     Robb-Stark         Arya-Stark    Barristan-Selmy 
#20067.94           19870.45           19354.54           17769.29 
#Eddard-Stark        Sansa-Stark   Brienne-of-Tarth 
#17555.36           15913.44           15614.41 


#4.2)Find out where the character Jon Snow is ranked according to the above
# two measures and provide an explanation (a few sentences) of the observations
# you make after examining your results.

#As it can be observed, 'Jon Snow' was ranked in 10th place 
#considering the closeness centrality and in 1st regarding the betweenness centrality.




##################### Task 5: Ranking and Visualization ######################## 
## Write code to calculate the PageRank values, and create a plot of the #######
## graph that uses these values to appropriately set the nodes' size so that the
## nodes that are ranked higher are more evident.###############################

library(magrittr)
pg_rank<-page_rank(g,vids = V(g),directed = FALSE,weights = NULL)%>% #calculation of page rank 
  use_series("vector") %>% #extracting column as vector
  sort(decreasing = TRUE) %>% #sorting values in decreasing order
  as.matrix %>% #converting in a matrix format
  set_colnames("page.rank") # setting column name

#converting page rank to a dataframe
pg_rank<- as.data.frame(pg_rank)
#to have an aesthetically pleasing result, we resized the page rank
resized_page_rank<- as.numeric(pg_rank[,1] * 1000)
#creation of the plot
plot(g,vertex.color="orange", vertex.label = NA, edge.arrow.width=10, vertex.size=resized_page_rank)
