library(seqinr)
source("MyFunctions.R")
original = read.fasta("SARS_COV_2_WUHAN.txt")
mexican = read.fasta("SARS_COV_1.txt")
#str(original)
#str(mexican)

df = data.frame(
  SNP = character(),
  Position = numeric(),
  Amino = character(),
  Gen = character()
)

for(i in seq_along(mexican)){ #indices en toda la secuncia original
  genOri = toupper(original[[i]])
  genMex = toupper(mexican[[i]])
  genOri[genOri=="T"] = "U"
  genMex[genMex=="T"] = "U"
  #print(attr(genOri,"Annot"))
  
  #print(length(genOri))
  #print(length(genMex))
  
  diferentes = which(genOri != genMex);# print(diferentes)
  if(length(genOri) == length(genMex) & length(diferentes)> 0){
    attr1 = attr(genOri,"Annot") 
    print(attr1)
    sep = unlist(strsplit(attr1, "\\[|\\]|:|="));
    #print(sep)
    gen = sep[which(sep=="gene")+1]
    
    for(k in diferentes){
      SNP = paste(genOri[k],"to",genMex[k])
      print(paste(k,SNP))
      
      #       C  U  G U  A  G
      #k      1  2  3 4  5  6
      #ajuste 0 -1 -2 0 -1 -2
      ajuste =(k-1) %% 3
      codonOri = paste(genOri[k-ajuste],genOri[k+1-ajuste],genOri[k+2-ajuste],sep="")
      codonMex = paste(genMex[k-ajuste],genMex[k+1-ajuste],genMex[k+2-ajuste],sep="")
      aminoChange = paste(trad[codonOri],"to",trad[codonMex],sep="")
      
      newRow = list(SNP,k,aminoChange,gen)
      df[nrow(df)+1,]=newRow #AGREGAR FILA A UN DATA FRAME
      
    }
  }
}

str(df)
df

library("ggplot2")
p = ggplot(df)
p = p + aes(x=Amino, fill=Amino)
p = p + ggtitle("Frecuencia de SNP") + labs(x="Amino",y="Frecuencia", fill="Amino")
p = p + geom_bar(stat="count")
p = p + facet_grid(~Gen)
p = p + theme_bw()
p
