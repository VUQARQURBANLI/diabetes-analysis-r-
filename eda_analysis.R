library(tidyverse)
library(ggplot2)

newdata <- diabetes
newdata %>% str()
newdata %>% glimpse()
newdata %>% summary()

# Glucose NA cleaninig prosesi
newdata %>% filter(Glucose==0) %>% view()  
newdata <- newdata %>% filter(!Glucose==0)  #bu mƏnim variantimdi

clean_data <- newdata %>% mutate(Glucose =na_if(Glucose,0))
clean_data <- clean_data %>% filter(!is.na(Glucose))
clean_data <- clean_data[!is.na(clean_data$Glucose),]

#BloodPresure NA cleaning prosesi
clean_data %>% filter(is.na(BloodPressure)) %>% view()

clean_data <- clean_data %>% mutate(BloodPressure = na_if(BloodPressure,0))

count_n <- clean_data %>% summarise(count_n =sum(BloodPressure)) %>% pull()
count_n <- sum(is.na(clean_data$BloodPressure))
count_total <-nrow(clean_data)
percent <- paste0(round(count_n*100/count_total,2),'%')

bp_median <- median(clean_data$BloodPressure,na.rm = TRUE)
clean_data <- clean_data %>% mutate(BloodPressure = ifelse(is.na(BloodPressure),bp_median,BloodPressure))

clean_data %>% filter(SkinThickness == 0)
clean_data <- clean_data %>% mutate(SkinThickness = na_if(SkinThickness,0))
clean_data %>% filter(is.na(SkinThickness))

mdeian_skn <- median(clean_data$SkinThickness,na.rm = TRUE)
clean_data <- clean_data %>% mutate(SkinThickness = ifelse(is.na(SkinThickness),mdeian_skn,SkinThickness))

clean_data %>% filter(Insulin == 0 )

clean_data <- clean_data %>% mutate(Insulin= ifelse(Insulin == 0,NA,Insulin))
clean_data <- clean_data %>% mutate(Insulin = na_if(Insulin,0))

median_ins <- median(clean_data$Insulin,na.rm = TRUE)
#median_ins <- clean_data %>% median(Insulin,na.rm = TRUE) #  bu sehv olacaq cunki bu vektor kimi olmur amma yuxardki vektordu

clean_data <- clean_data %>% mutate(Insulin = ifelse(is.na(Insulin),median_ins, Insulin))

clean_data %>% filter(is.na(Insulin))
clean_data %>% filter(Insulin == 0)

clean_data <- clean_data %>% select(-`ifelse(Insulin == 0, NA, Insulin)`)
clean_data %>% view()



clean_data %>% summary(Insulin)
sd(clean_data$Insulin)
p1 <- clean_data %>% ggplot(aes(Insulin))+geom_histogram(bins = 30,fill= "steelblue")+
  labs(title = 'Insulin Paylanmasi before')

clean_data <- clean_data %>% mutate(log_insulin = log1p(Insulin))
p2 <- clean_data %>% ggplot(aes(log_insulin))+geom_histogram(bins = 30,fill='steelblue')+
  labs(title = 'After trs Insulin')
library(patchwork)
p1+p2+plot_annotation(title = 'Transfomasiya arasındakı fərq')

summary(clean_data$Glucose)
hist(clean_data$Glucose)

clean_data %>% ggplot(aes(Glucose))+geom_histogram(fill='steelblue')+
  labs(title = 'Glucose paylanması before')

clean_data <- clean_data %>%
  mutate(log_Glucose = log1p(Glucose))
clean_data %>% ggplot(aes(log_Glucose))+geom_histogram(fill='steelblue')+
  labs(title = 'Glucose paylanması after')

summary(clean_data$BloodPressure)
sd(clean_data$BloodPressure)
clean_data %>% ggplot(aes(BloodPressure))+geom_histogram(fill='steelblue')

summary(clean_data$BMI)
sd(clean_data$BMI)
clean_data %>% ggplot(aes(BMI))+geom_histogram(fill = 'steelblue')
clean_data <-  clean_data %>% mutate(BMI = na_if(BMI,0))
clean_data %>% drop_na(BMI)

summary(clean_data$SkinThickness)
sd(clean_data$SkinThickness)

clean_data %>% ggplot(aes(SkinThickness))+geom_histogram(fill='steelblue')

summary(clean_data$DiabetesPedigreeFunction)
sd(clean_data$DiabetesPedigreeFunction)
n1 <- clean_data %>% ggplot(aes(DiabetesPedigreeFunction))+geom_histogram(fill = 'steelblue')
clean_data <- clean_data %>% mutate(log_DFuncPed = log1p(DiabetesPedigreeFunction))
n2 <- clean_data %>% ggplot(aes(log_DFuncPed))+geom_histogram(fill = 'steelblue')+labs(title = 'log')
clean_data <- clean_data %>% mutate(sqrt_DFuncPed = sqrt(DiabetesPedigreeFunction))
n3 <- clean_data %>% ggplot(aes(sqrt_DFuncPed))+geom_histogram(fill = 'steelblue')+labs(title = 'sqrt')
n1+n2+n3

summary(clean_data$Pregnancies)
sd(clean_data$Pregnancies)
clean_data %>% ggplot(aes(Pregnancies))+geom_histogram(binwidth = 1,fill = 'steelblue')
shapiro.test(clean_data$Pregnancies)
boxplot(clean_data$Pregnancies,horizontal = TRUE)
clean_data <- clean_data %>% mutate(log_Pregnancies = log1p(Pregnancies))
clean_data %>% ggplot(aes(log_Pregnancies))+geom_histogram(bins=7,fill = 'steelblue')+labs(title = 'log')
shapiro.test(clean_data$log_Pregnancies)





#Keçdik EDA hisəssinə 

clean_data %>% summary()
clean_data %>% group_by(Outcome) %>% summarise(mean_glcs = mean(Glucose))
clean_data %>% group_by(Outcome) %>% summarise(mean_Preg = mean(Pregnancies))
clean_data %>% group_by(Outcome) %>% summarise(mean_Bld = mean(BloodPressure))
clean_data %>% group_by(Outcome) %>% summarise(mean_SK = mean(SkinThickness))
clean_data %>% group_by(Outcome) %>% summarise(mean_İns = mean(Insulin))
clean_data %>% group_by(Outcome) %>% summarise(mean_BMİ = mean(BMI))
clean_data %>% group_by(Outcome) %>% summarise(mean_DbPdgFunc = mean(DiabetesPedigreeFunction))
clean_data %>% group_by(Outcome) %>% summarise(mean_Age = mean(Age))

# 1.Burdan bu nəticəyə gəldiki Diabeti olan xəstələrin Glucose dəyərləri yüksəkdi
# 2.Burdada göstərirki Hamiləlik sayı çoxdursa təsir edə bilər analizdən belə çıxdı
#   düşünmürəəm bunun digerləri kimi önəmi var 
# 3.Burdada görsənir ki qan təzyqi çoxdursa Diabet ola bilər 
# 4. Burdada eyni dəri qalınılğıda təsir edir 
# 5 Bu analizdəndə görsənir ki İnsuliin ciddi təsiri var 
# 6. Burdanda yenə təsiri olduğu görsənir kutle indeksinin 
# 7. Burdada eynni qaydada
# 8. Yaşda eyni Diabeti olanın Yaş ortalamsı çoxdu olmayanın yaş ortalamsına 
# BU analizlərə görə bütun sütunların əlaəqəsi olduğu görsənir Outcome ilə



clean_data %>% ggplot(aes(Glucose,factor(Outcome)))+geom_boxplot(fill='tomato')

# Burdan bu nəticəyə çıxmaq olarki diabet olanların medianı daha çoxdur yəni Glucosu təsiri var 

clean_data %>% ggplot(aes(Glucose,fill=factor(Outcome)))+geom_density()

# Burdanda belə nəticəyə gəlmək olarki yenə təsiri var qrafikə nəzər salsaq burda görsənəcəyki 1 tərfdə sıxlıq var
clean_data %>% ggplot(aes(BMI,factor(Outcome)))+geom_boxplot(fill='tomato') # Bununda təsiri var# storng
clean_data %>% ggplot(aes(BloodPressure,factor(Outcome)))+geom_boxplot(fill='tomato')# weak
clean_data %>% ggplot(aes(Age,factor(Outcome)))+geom_boxplot(fill='tomato')# strong
clean_data %>% ggplot(aes(SkinThickness,factor(Outcome)))+geom_boxplot(fill='tomato')# weak
clean_data %>% ggplot(aes(DiabetesPedigreeFunction,factor(Outcome)))+geom_boxplot(fill='tomato')# stromg
clean_data %>% ggplot(aes(Pregnancies,factor(Outcome)))+geom_boxplot(fill='tomato')# strong


clean_data %>% ggplot(aes(Insulin,fill=factor(Outcome)))+geom_density()
clean_data %>% ggplot(aes(SkinThickness,fill=factor(Outcome)))+geom_density()
clean_data %>% ggplot(aes(BloodPressure,fill=factor(Outcome)))+geom_density()
clean_data %>% ggplot(aes(BMI,fill=factor(Outcome)))+geom_density()
clean_data %>% ggplot(aes(DiabetesPedigreeFunction,fill=factor(Outcome)))+geom_density()

install.packages("corrplot")   
library(corrplot)
cor_matrix <- clean_data %>% 
  select(-Outcome) %>%
  cor(use = "complete.obs") %>%
  round(2)

corrplot(cor_matrix, method = "color", type = "upper", 
         tl.col = "black", tl.srt = 45, addCoef.col = "black")

