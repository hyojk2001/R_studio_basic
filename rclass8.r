# install.packages('dplyr')
# install.packages('readxl')
library('dplyr')
library('readxl')

customer_r <- read_xlsx('customer_r.xlsx')
# 파이프 연산자 ctrl + shift + m : %>%
customer_r %>% count()

order_info_r <- read_xlsx('order_info_r.xlsx')
dim(order_info_r)
summarise(order_info_r, avg = mean(SALES))

order_info_r %>% summarise(min_value = min(SALES), max_vale = max(SALES))


#group_by : 행 묶기
reservation_r <- read_xlsx('reservation_r.xlsx')
head(reservation_r)
reservation_r %>% group_by(CUSTOMER_ID) %>% summarise(avg = mean(VISITOR_CNT))

order_info_r %>%  filter(ITEM_ID == 'M0001')
order_info_r %>%  filter(ITEM_ID == 'M0001' & SALES >= 150000)
order_info_r %>% distinct(ITEM_ID)      #distinct : 중복값을 제외하고 고유값만 출력
order_info_r %>% slice(2:4)             #slice(a:b) : a~b번째 행까지만 잘라서 반환
order_info_r %>% slice(c(1,3))          #1행과 3행만 잘라서 출력
order_info_r %>% arrange(SALES)
order_info_r %>% arrange(desc(SALES))
order_info_r %>% arrange(RESERV_NO, ITEM_ID)

table_added_row <- order_info_r %>% add_row(ORDER_NO = '1', ITEM_ID = '1', RESERV_NO = '1')
table_added_row %>% arrange(ORDER_NO)



#sample_frac() : 추츨 샘플 개수를 비율로 지정
#sample_n() : 추출 샘플 개수를 랜덤으로 지정
order_info_r %>% sample_frac(0.1, replace=TRUE)     #전체의 10%를 뽑음. 1이면 100%로 기준.

#select() : 테이블에서 열을 선택(filter : 테이블에서 행을 선택)
order_info_r %>% select(RESERV_NO, SALES)

order_info_r %>% group_by(RESERV_NO) %>% mutate(avg = mean(SALES))  #mutate : 예약변호 별로 묶은 후 평균 매출 확인
order_info_r %>% group_by(RESERV_NO) %>% transmute(avg = mean(SALES))  
order_info_r %>% mutate_all(funs(max))
order_info_r %>% mutate_if(is.numeric, funs(log(.)))    #mutate_if() : 특정 조건을 만족하는 열만 조작해서 새로운 열을 생성

# rename() : 열의 이름을 바꾼다.
order_info_r %>% rename(amt = SALES)

tmp_order_info_r <- order_info_r
bind_cols(order_info_r, tmp_order_info_r)       #똑같은 테이블을 하나 복사한 뒤 두 테이블을 붙이기




