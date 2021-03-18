library(readxl)
library(dplyr)
library('ggplot2')

customer_r <- read_excel("customer_r.xlsx")
reservation_r <- read_excel("reservation_r.xlsx")
order_info_r <- read_excel("order_info_r.xlsx")
item_r <- read_excel("item_r.xlsx")
colnames(customer_r) <- tolower(colnames(customer_r))
colnames(reservation_r) <- tolower(colnames(reservation_r))
colnames(order_info_r) <- tolower(colnames(order_info_r))
colnames(item_r) <- tolower(colnames(item_r))

#월별 매출 선 그래프
# 예약 번호 1~6번째 자리를 선택해서(월단위로 만듬) 그룹화
total_amt <- order_info_r %>% 
    mutate(month = substr(reserv_no, 1, 6)) %>%    #mutate : 열을 하나 새로 생성한다. 여기서는 month라는 열을 새로 생성
                                                    #substr : 열을 특정 범위에서 자른다
    group_by(month) %>% 
    summarise(amt_monthly=sum(sales/1000))
total_amt

ggplot(total_amt, aes(x=month, y=amt_monthly, group=1)) + geom_line()  #선을 그릴때는 group=1을 항상 넣는다
# 선 그래프의 각 월 매출에 점 그리기
ggplot(total_amt, aes(x=month, y=amt_monthly, group=1)) + geom_line() + geom_point()
ggplot(total_amt, aes(x=month, y=amt_monthly, group=1, label=amt_monthly)) + 
    geom_line(color="red", size=1) + geom_point(color="darkred", size=3) + 
    geom_text(vjust=1.7, hjust=0.5) +  #vjust : 수직 위치, hjust : 수평 위치
    ylim(0,12000)

#상자 그림 : 데이터 분포 확인
df_boxplot_graph <- inner_join(order_info_r, item_r, by="item_id")
head(df_boxplot_graph)




#####수업과 별개#####
head(ToothGrowth)
tail(ToothGrowth)

#VC와 OJ 2개의 그래프 그려보기
a <- ToothGrowth %>% group_by(supp='VC') %>% arrange(len)
b <- ToothGrowth %>% group_by(supp='OJ') %>% arrange(len)
head(a)
head(b)


df <- ToothGrowth %>% 
    group_by(dose) %>%    # 투여량 별로 그룹화
    summarise(sd=sd(len), len=mean(len))    #sd : 표준편차, mean: 평균
df


ggplot(df, aes(dose,len)) + 
    geom_line(aes(group=1)) + geom_point(size=3)
# geom_line 그래프를 그릴 때는 반드시 group을 지정해야 한다


df2 <- ToothGrowth %>% 
    group_by(dose, supp) %>% 
    summarise(sd=sd(len), len=mean(len))
df2


ggplot(df2, aes(dose, len)) + 
    geom_line(aes(group=supp, linetype=supp, color=supp)) +     #선의 색깔을 다르게 하려면 group 선정된 것을 color에 넣어주면 된다
    geom_point(size=3) +
    theme_classic()