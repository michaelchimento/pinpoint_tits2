library(tidyverse)
library(lubridate)
setwd("/home/michael/pinpoint_exp2")


file_names <- dir("coallated_data") #where you have your files
df <- do.call(rbind,lapply(paste("coallated_data/",file_names, sep=""),read.csv))

df = df %>% mutate(date = date(ymd_hms(time)))

df_sum = df %>% filter(!(population=="P1" & id==48),
                       !(population=="P10" & id==145),
                       !(population=="P2" & id==47),
                       !(population=="P3" & id==154),
                       !(population=="P3" & id==64),
                       !(population=="P4" & id==61),
                       !(population=="P5" & id==51),
                       !(population=="P6" & id==63),
                       !(population=="P7" & id==20),
                       !(population=="P7" & id==67),
                       !(population=="P7" & id==2),
                       !(population=="P8" & id==65),
                       !(population=="P9" & id==52),) %>%
                        mutate(id = as.factor(id),population=factor(population, c("P1","P2","P3","P4","P5","P6","P7","P8","P9","P10"))) %>% 
                        group_by(population,date,id) %>% summarize(sum = n())
mean(df_sum$sum)



p1 = ggplot(data=df_sum, aes(x=date,y=id))+
  facet_wrap(~population,scales="free")+
  geom_tile(aes(fill=log(sum,10)))+
  scale_fill_distiller(palette = "Spectral", name="log10(detects)")+
  geom_text(aes(label=sum),color="black")+
  scale_x_date(date_labels = "%b %d")+
  labs(y="ID",x="Day",title="Pinpoint detections")
ggsave(p1,file="daily_pinpoint_detections.pdf",width=12,height=8, units="in")
