library(readxl)
library(dplyr)

customer_r <- read_excel("customer_r.xlsx")
reservation_r <- read_excel("reservation_r.xlsx")
order_info_r <- read_excel("order_info_r.xlsx")
item_r <- read_excel("item_r.xlsx")
colnames(customer_r) <- tolower(colnames(customer_r))
colnames(reservation_r) <- tolower(colnames(reservation_r))
colnames(order_info_r) <- tolower(colnames(order_info_r))
colnames(item_r) <- tolower(colnames(item_r))
head(customer_r)

#ggplot
# install.packages('ggplot2')
library(ggplot2)
library(dplyr)

#ggplot의 기본 사용법
ggplot(data = pressure, aes(x = temperature, y = pressure)) + geom_point()  #산점도
ggplot(data = pressure, aes(x = temperature, y = pressure)) + geom_line()   #선 그래프
ggplot(data = pressure, aes(x = temperature, y = pressure)) + geom_col()    #막대 그래프

df_cfm_order <- inner_join(reservation_r, order_info_r, by='reserv_no') %>% 
    select(customer_id, reserv_no, visitor_cnt, cancel, order_no, item_id, sales) %>% 
arrange(customer_id, reserv_no, item_id)

head(df_cfm_order)

df_sct_graph <- df_cfm_order %>% 
    group_by(customer_id) %>% 
    summarise(vst_cnt=sum(visitor_cnt), cust_amt=sum(sales/1000))
head(df_sct_graph)


#산점도 그래프 그리기
ggplot(data = df_sct_graph, aes(x=vst_cnt, y=cust_amt)) + geom_point()     #그래프 틀 그리기 + 산점도 geom_point 추가
ggplot(data = df_sct_graph, aes(x=vst_cnt, y=cust_amt)) + geom_point() + 
xlim(0,50) + ylim(0,500)        #x축과 y축의 범위 정하기

#양(+)의 상관관계 - x가 증가하면 y도 증가
#음(-)의 상관관계 - x가 증가하면 y는 감소, x가 감소하면 y는 증가

#inner_join 함수를 이용해 customer_r의 테이블과 customer_id를 키로 연결
df_sct_graph2 <- inner_join(df_sct_graph, customer_r, by ='customer_id') %>% 
    select(vst_cnt, cust_amt, sex_code)
head(df_sct_graph2)

#성별에 대해 색 적용하기
ggplot(data=df_sct_graph2, aes(x=vst_cnt, y=cust_amt, color=sex_code)) +
    geom_point() + xlim(0,50) + ylim(0,1000)


#막대 그래프 데이터 준비

#예약 완료, 주문 완료 데이터 연결
df_branch_sales_1 <- inner_join(reservation_r, order_info_r, by='reserv_no') %>% 
    select(branch, sales) %>% 
    arrange(branch, sales)

#지점별로 매출 합산
df_branch_sales_2 <- df_branch_sales_1 %>% group_by(branch) %>% 
    summarise(amt=sum(sales)/1000) %>% 
    arrange(desc(amt))
df_branch_sales_2


#identity는 y축 높이를 데이터 값을 기반으로 그리는 옵션이다
ggplot(data=df_branch_sales_2, aes(x=branch, y=amt)) + geom_bar(stat = 'identity') 

# -amt를 통해 내림차순으로 정렬. 마이너스(-) 옵션은 내림차순이라는 의미이다.
ggplot(data=df_branch_sales_2, aes(x=reorder(branch, -amt), y=amt)) + geom_bar(stat = 'identity')   

#자동으로 막대 그래프에 색상 채우기
ggplot(data=df_branch_sales_2, aes(x=reorder(branch, -amt), y=amt, fill=branch)) + geom_bar(stat = 'identity')   

#막대 그래프 중 일부만 선택
ggplot(data=df_branch_sales_2, aes(x=reorder(branch, -amt), y=amt, fill=branch)) + 
geom_bar(stat = 'identity') + xlim(c('강남', '영등포', '중랑', '용산', '서초')) 

#가로 막대그래프 그리기
gg <- ggplot(data=df_branch_sales_2, aes(x=reorder(branch, amt), y=amt, fill=branch)) + 
geom_bar(stat = 'identity') + xlim(c('강남', '영등포', '용산', '서초', '중랑')) 
gg <- gg + coord_flip()     #x축과 y축을 바꾸는 함수
gg
gg <- gg + theme(legend.position = 'bottom')    #범례의 위치 바꾸기(범례: 일러두기. 서초, 강남 등 그래프를 설명하는 표)
gg
gg <- gg + scale_fill_discrete(breaks = c('강남', '영등포', '용산', '서초','중랑')) #그래프의 항목 범례 순서 맞추기
gg

#지점의 예약 건수를 히스토그램으로 그린 예시
gg <- ggplot(data=reservation_r, aes(x=branch)) + geom_bar(stat='count')
gg

#히스토그램 타이틀과 축 제목 변경
gg <- gg + labs(title='지점별 예약 건수', x='지점', y='예약건')
gg

#geom_histogram() 함수로 연속형 데이터의 히스토그램 그리기
ggplot(data=order_info_r, aes(x=sales/1000)) + geom_histogram(binwidth=5)   #bindwidth = 데이터 구간의 너비를 설정

#파이 차트
df_pie_graph <- inner_join(order_info_r, item_r, by='item_id') %>% 
    group_by(item_id, product_name) %>% 
    summarise(amt_item=sum(sales/1000)) %>% 
    select(item_id, amt_item, product_name)
df_pie_graph

ggplot(df_pie_graph, aes(x='', y=amt_item, fill=product_name)) + geom_bar(stat='identity')
ggplot(df_pie_graph, aes(x='', y=amt_item, fill=product_name)) + geom_bar(stat='identity') + 
    coord_polar('y', start=0)

#파이 차트 그리기
gg <- gg + scale_fill_brewer(palette = "Spectral")   
gg <- gg + scale_fill_brewer(palette = "Oranges")   
#팔레트에 무슨 색을 넣는지에 따라 전체적인 색상이 달라진다
#팔레트에 Spectral을 넣으면 다양한 색이 나오게 된다.
gg







