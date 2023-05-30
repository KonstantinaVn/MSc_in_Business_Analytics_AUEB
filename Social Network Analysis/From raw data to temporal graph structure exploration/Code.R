#Athens University of Economics and Business
#M.Sc. Program in Business Analytics
#Course: Social Network Analysis - Spring 2022
#Student_id:p2822107
#Name: Vioni Konstantina
#Instructor: Katia Papakonstantinopoulou


#Project 2: From raw data to temporal graph structure exploration



########################### Task 1: DBLP co-authorship graph ###################
## Having created the .csv files, we used them to create the respective igraph##
## graphs. #####################################################################


#Importing the created csv files:

final_auth16 <- read.csv("C:/Users/konst/Desktop/Social Network/project2/p2822107/final csv files/data16.csv", header = T, sep = ",")
final_auth17 <- read.csv("C:/Users/konst/Desktop/Social Network/project2/p2822107/final csv files/data17.csv", header = T, sep = ",")
final_auth18 <- read.csv("C:/Users/konst/Desktop/Social Network/project2/p2822107/final csv files/data18.csv", header = T, sep = ",")
final_auth19 <- read.csv("C:/Users/konst/Desktop/Social Network/project2/p2822107/final csv files/data19.csv", header = T, sep = ",")
final_auth20 <- read.csv("C:/Users/konst/Desktop/Social Network/project2/p2822107/final csv files/data20.csv", header = T, sep = ",")

#Load package:
library(igraph)

#Creating the graphs for each year:
g16<-graph_from_data_frame(final_auth16, directed=FALSE)
g16<-set.edge.attribute(g16, "weight", index=E(g16),final_auth16[1:nrow(final_auth16),]$Weight)

g17<-graph_from_data_frame(final_auth17, directed=FALSE)
g17<-set.edge.attribute(g17, "weight", index=E(g17),final_auth17[1:nrow(final_auth17),]$Weight)

g18<-graph_from_data_frame(final_auth18, directed=FALSE)
g18<-set.edge.attribute(g18, "weight", index=E(g18),final_auth18[1:nrow(final_auth18),]$Weight)

g19<-graph_from_data_frame(final_auth19, directed=FALSE)
g19<-set.edge.attribute(g19, "weight", index=E(g19),final_auth19[1:nrow(final_auth19),]$Weight)


g20<-graph_from_data_frame(final_auth20, directed=FALSE)
g20<-set.edge.attribute(g20, "weight", index=E(g20),final_auth20[1:nrow(final_auth20),]$Weight)



#Checking if the graphs are weighted
is.weighted(g16)
is.weighted(g17)
is.weighted(g18)
is.weighted(g19)
is.weighted(g20)



#Printing the graphs:
print(g16,e=TRUE, v=TRUE)
print(g17,e=TRUE, v=TRUE)
print(g18,e=TRUE, v=TRUE)
print(g19,e=TRUE, v=TRUE)
print(g20,e=TRUE, v=TRUE)


#Plotting the graphs:
plot(g16,vertex.label= NA,edge.arrow.width= 0.8,edge.arrow.size= 0.2, vertex.size= 3,vertex.color="blue", sub="Graph of 2016")
plot(g17,vertex.label= NA,edge.arrow.width= 0.8,edge.arrow.size= 0.2, vertex.size= 3,vertex.color="blue", sub="Graph of 2017")
plot(g18,vertex.label= NA,edge.arrow.width= 0.8,edge.arrow.size= 0.2, vertex.size= 3,vertex.color="blue", sub="Graph of 2018")
plot(g19,vertex.label= NA,edge.arrow.width= 0.8,edge.arrow.size= 0.2, vertex.size= 3,vertex.color="blue", sub="Graph of 2019")
plot(g20,vertex.label= NA,edge.arrow.width= 0.8,edge.arrow.size= 0.2, vertex.size= 3,vertex.color="blue", sub="Graph of 2020")





######################### Task2:Average degree over time #######################
## The next task was to create plots that visualize the 5-year evolution of  ###
## different metrics for the graph. More specifically, we created plots for: ###


#   Number of vertices #

library(ggplot2)

#calculation of the number of vertices for each graph:
n_vertices_16<-vcount(g16)
n_vertices_17<-vcount(g17)
n_vertices_18<-vcount(g18)
n_vertices_19<-vcount(g19)
n_vertices_20<-vcount(g20)

#creating the dataframe that will be used in the ggplot
n_vertices_total<-c(n_vertices_16,n_vertices_17,n_vertices_18,n_vertices_19,n_vertices_20)

years<-c(2016,2017,2018,2019,2020)

dNumber_of_vertices <- data.frame(Year = years,Number_of_vertices = n_vertices_total)

#plotting the 5-year evolution of number of vertices
ggplot(dNumber_of_vertices, aes(Year, Number_of_vertices)) + geom_path()  

#As it can be observed, through the years,the number of vertices increased.
#As a matter of fact, we came to the conclusion that in the last 5 years there 
#were more authors that wrote papers since each vertex represented  an author.


#   Number of edges #

#calculation of the number of edges for each graph:
n_edges_16<-ecount(g16)
n_edges_17<-ecount(g17)
n_edges_18<-ecount(g18)
n_edges_19<-ecount(g19)
n_edges_20<-ecount(g20)

#creating the dataframe that will be used in the ggplot
n_edges_total<-c(n_edges_16,n_edges_17,n_edges_18,n_edges_19,n_edges_20)

dNumber_of_edges <- data.frame(Year = years,Number_of_edges =n_edges_total)

#plotting the 5-year evolution of number of edges
ggplot(dNumber_of_edges, aes(Year, Number_of_edges)) + geom_path()  

#As it can be observed, through the years,the number of edges increased in a 
#nearly same way as the number of vertices did.This could be considered as 
#reasonable due to the fact that the number of authors increased and consequently 
#the cooperation between them  would increase.



# Diameter of the graph #

#calculation of the diameter for each graph:
diameter_16<-diameter(g16)
diameter_17<-diameter(g17)
diameter_18<-diameter(g18)
diameter_19<-diameter(g19)
diameter_20<-diameter(g20)

#creating the dataframe that will be used in the ggplot
diameter_total<-c(diameter_16,diameter_17,diameter_18,diameter_19,diameter_20)

ddiameter<- data.frame(Year = years,Diameter =diameter_total)

#plotting the 5-year evolution of diameter
ggplot(ddiameter, aes(Year, Diameter)) + geom_path()  

#From this plot, we understood that the distance between the two most distanced nodes in the graph was the highest in 2018.
# High values were in 2016 and 2020 but not such high as in 2018.
# The lowest distance was observed in 2017.




# Average degree (simple, not weighted) #

#The average degree of an undirected graph is used to measure the number of edges
#compared to the number of nodes.To do this we simply divide the summation of all 
#nodes' degree by the total number of nodes.

#calculation of the average degree for each graph:
avg_degree_16<-mean(degree(g16,mode="all"))
avg_degree_17<-mean(degree(g17,mode="all"))
avg_degree_18<-mean(degree(g18,mode="all"))
avg_degree_19<-mean(degree(g19,mode="all"))
avg_degree_20<-mean(degree(g20,mode="all"))

#creating the dataframe that will be used in the ggplot
avg_degree_total<-c(avg_degree_16,avg_degree_17,avg_degree_18,avg_degree_19,avg_degree_20)

davg_degree<- data.frame(Year = years,Average_degree = avg_degree_total)

#plotting the 5-year evolution of the average degree 
ggplot(davg_degree, aes(Year, Average_degree)) + geom_path()  

#This plot illustrated the fluctuation of the average degree in the last 5 years.
# The peak in this plot is observed in 2020 and the minimum in 2017.



######################### Task3:  Important nodes ##############################
## We wrote code to create and print data frames for the 5-year revolution of ##
## the top-10 authors with regard to:###########################################



# Degree (simple, not weighted) #

#calculation of the degree of each year
degree_16<-degree(g16,mode='total')
degree_17<-degree(g17,mode='total')
degree_18<-degree(g18,mode='total')
degree_19<-degree(g19,mode='total')
degree_20<-degree(g20,mode='total')


#sorting the result and displaying the top 10 authors of each year
degree_16_top<-head(sort(degree_16,decreasing =TRUE),10)
degree_17_top<-head(sort(degree_17,decreasing =TRUE),10)
degree_18_top<-head(sort(degree_18,decreasing =TRUE),10)
degree_19_top<-head(sort(degree_19,decreasing =TRUE),10)
degree_20_top<-head(sort(degree_20,decreasing =TRUE),10)


#creating a list with the degrees and top 10 authors for each year
d_total<-c(degree_16_top,degree_17_top,degree_18_top,degree_19_top,degree_20_top)

#extracting the unique names of top 10 authors
authors_names<-unique(names(d_total))


# we created dataframes that contained each year degree
#(which contained the name of all authors of each year and their degree)
dfdegree_16<-data.frame(Names=names(degree_16),"Year_2016"=degree_16)
dfdegree_17<-data.frame(Names=names(degree_17),"Year_2017"=degree_17)
dfdegree_18<-data.frame(Names=names(degree_18),"Year_2018"=degree_18)
dfdegree_19<-data.frame(Names=names(degree_19),"Year_2019"=degree_19)
dfdegree_20<-data.frame(Names=names(degree_20),"Year_2020"=degree_20)

#In order to illustrate the the 5-year evolution of the top-10 authors, we decided 
#to create a new dataframe that would contain the unique  top 10 authors 
#and their degree  for each year.As a matter of fact, we merged the dataframes named 
#'dfdegree_16','dfdegree_17''dfdegree_18','dfdegree_19' and 'dfdegree_20' which contained 
#the degrees of all authors in each year.Then, we specified the names of authors that we 
#wanted to keep so as to take only the results from the top-10 authors.
#The process that we followed is the below:


#merging the dataframes to illustrate the 5-year evolution of the top-10 authors 
df_merge<-Reduce(function(x, y) merge(x, y, all=TRUE), list(dfdegree_16,dfdegree_17,dfdegree_18,dfdegree_19,dfdegree_20))                  

#To filter out only the top 10 authors in the new dataframe, 
#we followed the below process:
df_merge<-df_merge[is.element(df_merge$Names, authors_names),]

#As it can be observed some NAs were created  due to the fact that there were years that 
#did not have some authors and their degree could not be calculated.

###### Filling NAs in the dataframe 'df_merge':
df_merge[is.na(df_merge)] <- 0

#Changing the row name of the dataframe df_merge for a more aesthetically output
rownames(df_merge) <- df_merge$Names




# PageRank #

#calculation of the pagerank of each year
pg_rank_16<-page_rank(g16)$vector
pg_rank_17<-page_rank(g17)$vector
pg_rank_18<-page_rank(g18)$vector
pg_rank_19<-page_rank(g19)$vector
pg_rank_20<-page_rank(g20)$vector
  
#sorting the result and displaying the top 10 authors of each year
pg_rank_16_top<-head(sort(pg_rank_16,decreasing =TRUE),10)
pg_rank_17_top<-head(sort(pg_rank_17,decreasing =TRUE),10)
pg_rank_18_top<-head(sort(pg_rank_18,decreasing =TRUE),10)
pg_rank_19_top<-head(sort(pg_rank_19,decreasing =TRUE),10)
pg_rank_20_top<-head(sort(pg_rank_20,decreasing =TRUE),10)

#creating a list with the pagerank and top 10 authors for each year
pg_total<-c(pg_rank_16_top,pg_rank_17_top,pg_rank_18_top,pg_rank_19_top,pg_rank_20_top)

#extracting the unique names of top 10 authors
authors_names_pg<-unique(names(pg_total))


# we created dataframes that contained each year pagerank
#(which contained the name of all authors of each year and their pagerank)
dfpg_rank_16<-data.frame(Names=names(pg_rank_16),"Year_2016"=round(pg_rank_16,5))
dfpg_rank_17<-data.frame(Names=names(pg_rank_17),"Year_2017"=round(pg_rank_17,5))
dfpg_rank_18<-data.frame(Names=names(pg_rank_18),"Year_2018"=round(pg_rank_18,5))
dfpg_rank_19<-data.frame(Names=names(pg_rank_19),"Year_2019"=round(pg_rank_19,5))
dfpg_rank_20<-data.frame(Names=names(pg_rank_20),"Year_2020"=round(pg_rank_20,5))

#In order to illustrate the the 5-year evolution of the top-10 authors, we decided 
#to create a new dataframe that would contain the unique  top 10 authors 
#and their pagerank for each year.As a matter of fact, we merged the dataframes named 
#'dfpg_rank_16','dfpg_rank_17''dfpg_rank_18','dfpg_rank19' and 'dfpg_rank_20' which contained 
#the pagerank of all authors in each year.Then, we specified the names of authors that we 
#wanted to keep so as to take only the results from the top-10 authors.
#The process that we followed is the below:


#merging the dataframes to illustrate the 5-year evolution of the top-10 authors 
df_pgmerge<-Reduce(function(x, y) merge(x, y, all=TRUE), list(dfpg_rank_16,dfpg_rank_17,dfpg_rank_18,dfpg_rank_19,dfpg_rank_20))                  

#To filter out only the top 10 authors in the new dataframe, 
df_pgmerge<-df_pgmerge[is.element(df_pgmerge$Names, authors_names_pg),]

#As it can be observed some NAs were created  due to the fact that there were years that 
#did not have some authors and their pagerank could not be calculated.

###### Filling NAs in the dataframe 'df_pgmerge':
df_pgmerge[is.na(df_pgmerge)] <- 0

#Changing the row name of the dataframe df_merge for a more aesthetically output
rownames(df_pgmerge) <- df_pgmerge$Names






######################### Task4:  Communities  #################################
## 4.1: Our final task was to perform community detection on the mention graphs#
## We tried applying fast greedy clustering, infomap clustering, and louvain ###
## clustering on the 5 undirected co-authorship graphs.


start.time <- Sys.time()
#fast greedy clustering for each graph:
fg_clustering16<-cluster_fast_greedy(g16)
fg_clustering17<-cluster_fast_greedy(g17)
fg_clustering18<-cluster_fast_greedy(g18)
fg_clustering19<-cluster_fast_greedy(g19)
fg_clustering20<-cluster_fast_greedy(g20)

end.time <- Sys.time()
time_diff <- round(end.time - start.time, 2)
time_diff


#infomap clustering for each graph:

#function to calculate the needed time of execution
start.time <- Sys.time()

inf_clustering16<-cluster_infomap(g16)
inf_clustering17<-cluster_infomap(g17)
inf_clustering18<-cluster_infomap(g18)
inf_clustering19<-cluster_infomap(g19)
inf_clustering20<-cluster_infomap(g20)

communities_infomap<-list(inf_clustering16,inf_clustering17,inf_clustering18,inf_clustering19,inf_clustering20)

end.time <- Sys.time()
time_diff <- round(end.time - start.time, 2)
time_diff


#louvain clustering for each graph:

start.time <- Sys.time()

louv_clustering16<-cluster_louvain(g16)
louv_clustering17<-cluster_louvain(g17)
louv_clustering18<-cluster_louvain(g18)
louv_clustering19<-cluster_louvain(g19)
louv_clustering20<-cluster_louvain(g20)

communities_louvain<-list(louv_clustering16,louv_clustering17,louv_clustering18,louv_clustering19,louv_clustering20)

end.time <- Sys.time()
time_diff <- round(end.time - start.time, 2)
time_diff



#Commenting the performance of the 3 algorithms

# Modularity #

#modularity for fast greedy clustering 
round(modularity(fg_clustering16),2)
round(modularity(fg_clustering17),2)
round(modularity(fg_clustering18),2)
round(modularity(fg_clustering19),2)
round(modularity(fg_clustering20),2)

#modularity for infomap clustering
round(modularity(inf_clustering16),2)
round(modularity(inf_clustering17),2)
round(modularity(inf_clustering18),2)
round(modularity(inf_clustering19),2)
round(modularity(inf_clustering20),2)


#modularity for louvain clustering
round(modularity(louv_clustering16),2)
round(modularity(louv_clustering17),2)
round(modularity(louv_clustering18),2)
round(modularity(louv_clustering19),2)
round(modularity(louv_clustering20),2)


# Number of communities #

# for fast greedy clustering 
length(fg_clustering16)
length(fg_clustering17)
length(fg_clustering18)
length(fg_clustering19)
length(fg_clustering20)

# for infomap clustering 

length(inf_clustering16)
length(inf_clustering17)
length(inf_clustering18)
length(inf_clustering19)
length(inf_clustering20)

# for louvain clustering 

length(louv_clustering16)
length(louv_clustering17)
length(louv_clustering18)
length(louv_clustering19)
length(louv_clustering20)


#Compare the Detected Communities for each year 

#2016:
round(compare(inf_clustering16,louv_clustering16),2)
#2017:
round(compare(inf_clustering17,louv_clustering17),2)
#2018:
round(compare(inf_clustering18,louv_clustering18),2)
#2019:
round(compare(inf_clustering19,louv_clustering19),2)
#2020:
round(compare(inf_clustering20,louv_clustering20),2)



## 4.2: We picked one of the three methods as well as a random author that appeared
## in all 5 graphs and wrote code to detect the evolution of the communities this
## user belonged to.

# We selected the louvain clustering because the performance results were 
# better than on other algorithms.


# Determine which individuals belong to which community
m16<-membership(louv_clustering16)
m17<-membership(louv_clustering17)
m18<-membership(louv_clustering18)
m19<-membership(louv_clustering19)
m20<-membership(louv_clustering20)

#To pick a random author that appeared in all 5 graphs we followed the below procedure:
#We created variable 'alldegrees' which was a list that contained the degrees of each year
#Then we created a table that illustrated the frequency of appearance of each author in the 5 years


alldegrees<-c(degree_16,degree_17,degree_18,degree_19,degree_20)

#creation of the table 
allauthors <- table(names(alldegrees))
#keeping only the authors that appeared in all the 5 years that we were interested in.
allauthors<- allauthors[allauthors == 5]

# we used the seed to have the same author as an output every time
set.seed(10)
random_author <- names(sample(allauthors, 1))

# The random selected author was "Meng Jiang 0001"


#################### Do you spot similarities in the communities? ##############

#finding the community that "Meng Jiang 0001" belonged to each year
com16<-m16[random_author]#21
com17<-m17[random_author]#7
com18<-m18[random_author]#92
com19<-m19[random_author]#5
com20<-m20[random_author]#9


#selecting the authors that were at the same community with  "Meng Jiang 0001"
auth16<-louv_clustering16[membership(louv_clustering16)[random_author]]
auth17<-louv_clustering17[membership(louv_clustering17)[random_author]]
auth18<-louv_clustering18[membership(louv_clustering18)[random_author]]
auth19<-louv_clustering19[membership(louv_clustering19)[random_author]]
auth20<-louv_clustering20[membership(louv_clustering20)[random_author]]

#creating dataframes for each year and community 
dauth16<-as.data.frame(auth16)
dauth17<-as.data.frame(auth17)
dauth18<-as.data.frame(auth18) 
dauth19<-as.data.frame(auth19) 
dauth20<-as.data.frame(auth20)

#setting the column name for each dataframe as 'Authors'
colnames(dauth16) <- "Authors"
colnames(dauth17) <- "Authors"
colnames(dauth18) <- "Authors"
colnames(dauth19) <- "Authors"
colnames(dauth20) <- "Authors"

#We observed that each dataframe contained the name of our random author, so we decided to remove it so as to 
#find later the similarities between the dataframes
dauth16<-subset(dauth16, Authors != random_author)
dauth17<-subset(dauth17, Authors != random_author)
dauth18<-subset(dauth18, Authors != random_author)
dauth19<-subset(dauth19, Authors != random_author)
dauth20<-subset(dauth20, Authors != random_author)


#Searching for common authors between each community and each year 

#for 2016-2017:
#finding the common authors between these two dataframes (communities that the random author belong)
com_auth1617<-intersect(dauth16$Authors,dauth17$Authors)
#calculating the number of common authors
num1617<-length(com_auth1617)#8

#for 2016-2018:
com_auth1618<-intersect(dauth16$Authors,dauth18$Authors)
num1618<-length(com_auth1618)#0

#for 2016-2019:
com_auth1619<-intersect(dauth16$Authors,dauth19$Authors)
num1619<-length(com_auth1619)#0


#for 2016-2020:
com_auth1620<-intersect(dauth16$Authors,dauth20$Authors)
num1620<-length(com_auth1620)#0

#for 2017-2018:
com_auth1718<-intersect(dauth17$Authors,dauth18$Authors)
num1718<-length(com_auth1718)#14

#for 2017-2019:
com_auth1719<-intersect(dauth17$Authors,dauth19$Authors)
num1719<-length(com_auth1719)#0

#for 2017-2020:
com_auth1720<-intersect(dauth17$Authors,dauth20$Authors)
num1720<-length(com_auth1720)#4

#for 2018-2019:
com_auth1819<-intersect(dauth18$Authors,dauth19$Authors)
num1819<-length(com_auth1819)#2

#for 2018-2020:
com_auth1820<-intersect(dauth18$Authors,dauth20$Authors)
num1820<-length(com_auth1820)#2

#for 2019-2020:
com_auth1920<-intersect(dauth19$Authors,dauth20$Authors)
num1920<-length(com_auth1920)#10



## 4.3:Finally, we created a visualization of the graph using a different color for
## each community. We made sure to have a look at the sizes of the communities and
## filter out all nodes that belonged to very small or very large communities, in order
## to create a meaningful and aesthetically pleasing visualization.



allgraphs<-list(g16,g17,g18,g19,g20)
years<-c(2016,2017,2018,2019,2020)

# Visualization of the 5 graphs using a different color for each community
for (i in 1:5) {
  n <- allgraphs[[i]]
  m <- communities_louvain[[i]]
  V(n)$color <- factor(membership(m))
  is_crossing <- crossing(n, communities = m)
  E(n)$lty <- ifelse(is_crossing, "solid", "dotted")
  community_size <- sizes(m)
  # we created this sub-graph in order not to keep those communities that are either very small or very large
  in_mid_community <- unlist(m[community_size > 40 & community_size < 90])
  sub <- induced.subgraph(n, in_mid_community)
  plot(sub, vertex.label = NA, edge.arrow.width = 0.8, edge.arrow.size = 0.2,
       coords = layout_with_fr(sub), margin = 0, vertex.size = 4, sub = paste("Communities of: ", years[i], sep = ""))  
}

#I executed the below command because during the execution of the above for loop occurred an error "Error in .Call.graphics(C_palette, value) : invalid graphics state"
dev.off()

