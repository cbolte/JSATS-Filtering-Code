library(dplyr)


det <- select(hills_det, dtf = X5, Hex = X7)

min(det$dtf)
max(det$dtf)






#Get detections on receivers from specified tags.


get_tag_detections <- function(df_det, df_taglist) {
  taglist_det <- NULL
  det <- df_det
  all_tags <- unique(df_taglist$TagID_Hex) #Hex should be substituted for whatever column name has the tag_list.
  for (tag in all_tags) {
    ind_tag <- subset(det, Hex == tag) #optional Hex substitute
    if (nrow(ind_tag) > 0) {
      taglist_det <- rbind(taglist_det, ind_tag)
    }
  }
  tag_summary <- NULL
  all_tags <- unique(taglist_det$Hex)
  for (tag in all_tags) {
    ind_tag <- subset(taglist_det, Hex == tag)
    n_det <- nrow(ind_tag)
    tag_summary <- rbind(tag_summary, data.frame(tag, n_det))
  }
  return(tag_summary)
}

#This will give you only detections from tags in our list. Different code will be required to glean additional information about each tag.

detected_tags <- get_tag_detections(det, taglist)
