 lqw <- read.csv("~/Desktop/kasparov/white_queen_win_matrix.csv")
 rownames(lqw)<-lqw[,1]
 lqw[,1]<-NULL
 lqw<-as.matrix(lqw)
 lqw.plot<-corrplot(lqw,is.corr=F,method="shade",tl.srt=0,tl.col="black",addgrid.col="grey")
 
 lrw <- read.csv("~/Desktop/kasparov/white_rook_win_matrix.csv")
 rownames(lrw)<-lrw[,1]
 lrw[,1]<-NULL
 lrw<-as.matrix(lrw)
 lrw.plot<-corrplot(lrw,is.corr=F,method="shade",tl.srt=0,tl.col="black",addgrid.col="grey")
 
 lbw <- read.csv("~/Desktop/kasparov/white_bishop_win_matrix.csv")
 rownames(lbw)<-lbw[,1]
 lbw[,1]<-NULL
 lbw<-as.matrix(lbw)
 lbw.plot<-corrplot(lbw,is.corr=F,method="shade",tl.srt=0,tl.col="black",addgrid.col="grey")
 
 lnw <- read.csv("~/Desktop/kasparov/white_knight_win_matrix.csv")
 rownames(lnw)<-lnw[,1]
 lnw[,1]<-NULL
 lnw<-as.matrix(lnw)
 lnw.plot<-corrplot(lnw,is.corr=F,method="shade",tl.srt=0,tl.col="black",addgrid.col="grey")
 
 lqb <- read.csv("~/Desktop/kasparov/black_queen_win_matrix.csv")
 rownames(lqb)<-lqb[,1]
 lqb[,1]<-NULL
 lqb<-as.matrix(lqb)
 lqb.plot<-corrplot(lqb,is.corr=F,method="shade",tl.srt=0,tl.col="black",addgrid.col="grey")
 
 lrb <- read.csv("~/Desktop/kasparov/black_rook_win_matrix.csv")
 rownames(lrb)<-lrb[,1]
 lrb[,1]<-NULL
 lrb<-as.matrix(lrb)
 lrb.plot<-corrplot(lrb,is.corr=F,method="shade",tl.srt=0,tl.col="black",addgrid.col="grey")
 
 lbb <- read.csv("~/Desktop/kasparov/black_bishop_win_matrix.csv")
 rownames(lbb)<-lbb[,1]
 lbb[,1]<-NULL
 lbb<-as.matrix(lbb)
 lbb.plot<-corrplot(lbb,is.corr=F,method="shade",tl.srt=0,tl.col="black",addgrid.col="grey")
 
 lnb <- read.csv("~/Desktop/kasparov/black_knight_win_matrix.csv")
 rownames(lnb)<-lnb[,1]
 lnb[,1]<-NULL
 lnb<-as.matrix(lnb)
 lnb.plot<-corrplot(lnb,is.corr=F,method="shade",tl.srt=0,tl.col="black",addgrid.col="grey")