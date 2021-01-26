setwd("~/Box/WILD 2050 (Janna Willoughby)/2021_spring/packback/") #home
setwd("~/Box Sync/WILD 2050/2021_spring/packback/") #work

#import week's data
week   = 3
grades = read.table(paste("packback", week, ".csv", sep=""), header=T, sep=",") #note: if adding multiple weeks at a time remove row 1

#fix grade input file
if(grades[1,1]=="custom_id"){
  colnames(grades) = as.character(unlist(grades[1,]))
  grades = grades[2:nrow(grades),]
}

#add roster information
#note: must add quotes in case student names contain non alphanumeric characters (replace , with "," and replace \n with "\n"; then add fist and last " in doc)
names = read.table("names_ids.csv", header=T, sep=",") 
#names = names[-1,1:5]

#week 2+ (week 1 did not count towards semester totals)
to.add = data.frame(SIS.User.ID = grades$custom_id, wkpk = grades$Score) #check score column name
names   = merge(x=names, y=to.add, by="SIS.User.ID", all.y=T, all.x=T)

#set NA to 0
names$wkpk[is.na(names$wkpk)] = 0

#put columns in correct order
names.out = data.frame(names = names$Student, Sid = names$ID, SISID = names$SIS.User.ID, SISlogin = names$SIS.Login.ID, section = names$Section, wkpk = names$wkpk)

#export data file
####spring 2021 edit note: week numbers are corrected by 1! #####
write.table(names.out, paste("import_wk", week, ".csv", sep=""), sep=",", row.names=F, col.names=c("Student Name", "Student ID", "SIS User ID", "SIS Login ID", "Section", paste("Week ", (week-1), " Packback", sep="")))

