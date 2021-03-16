library('readxl')
library('dplyr')

order_info_r <- read_xlsx('order_info_r.xlsx')
tmp_order_info_r <- order_info_r

#동일한 테이블 2개를 옆으로, 밑으로 붙이기
# cbind(tmp_order_info_r, order_info_r)
# bind_cols(tmp_order_info_r, order_info_r)       # bind_cols를 쓰려면 dplyr 을 선언해야 한다
# bind_rows(tmp_order_info_r, order_info_r)        


reservation_r <- read_xlsx('reservation_r_excel.xlsx')

inner_join(reservation_r, order_info_r, by='RESERV_NO') %>% 
arrange(RESERV_NO, ITEM_ID) %>% 
select(RESERV_NO, CUSTOMER_ID, VISITOR_CNT, CANCEL, ORDER_NO, ITEM_ID, SALES)


left_join(reservation_r, order_info_r, by = 'RESERV_NO') %>%    #RESERV_NO를 기준으로 왼쪽으로 붙인다
arrange(RESERV_NO, ITEM_ID) %>%
select(RESERV_NO, CUSTOMER_ID, VISITOR_CNT, CANCEL, ORDER_NO, ITEM_ID, SALES) 


table_added_row <- order_info_r %>% 
    add_row(ORDER_NO = '1', ITEM_ID = '1', RESERV_NO = '1', SALES = 1)
full_join(reservation_r, table_added_row, by='RESERV_NO') %>% 
    arrange(RESERV_NO, ITEM_ID) %>% 
    select(RESERV_NO, CUSTOMER_ID, VISITOR_CNT, CANCEL, ORDER_NO, ITEM_ID, SALES)


reservation_r_rsv_no <- select(reservation_r, RESERV_NO)
head(reservation_r_rsv_no)
order_info_r_rsv_no <- select(reservation_r, RESERV_NO)
intersect(reservation_r_rsv_no, order_info_r_rsv_no)    #양쪽 데이터셋에 존재하는 RESERV_NO

setdiff(reservation_r_rsv_no, order_info_r_rsv_no)      #두 데이터셋의 차이

union(reservation_r_rsv_no, order_info_r_rsv_no)        #중복을 제거한 합집합 데이터

reservation_r %>%                               # reservation_r 테이블을 선택해서 데이터를 전달
    group_by(CUSTOMER_ID) %>%                   # 고객 번호로 그룹화하고
    summarise(avg = mean(VISITOR_CNT)) %>%      # 이 데이터셋을 '방문 고객수 평균' 이라는 열로 요약.
    filter(avg >= 3) %>%                        # 요약된 값(=방문 고객수 평균)이 3 이상인 행만 선택
    arrange(desc(avg))                          # 그 평균을 내림차순으로 정렬


my_first_cook <- order_info_r %>%                           # order_info_r을 선택해서 데이터 전달
    mutate(RESERV_MONTH = substr(RESERV_NO, 1, 6)) %>%      # reserv_no 값을 첫번째부터 6번째까지 선택해서 reserv_month라는 열 생성
    group_by(ITEM_ID, RESERV_MONTH) %>%                     # 메뉴 아이템, reserv_month로 그룹화해서
    summarise(AVG_SALES = mean(SALES)) %>%                  # 매출 평균을 요약해서 avg_sales라는 열에 담고
    arrange(ITEM_ID, RESERV_MONTH)                          # item_id과 reserv_month를 기준으로 오름차순 정렬

my_first_cook



mpg <- as.data.frame(ggplot2::mpg)
#1. 
# 자동차 배기량에 따라 고속도로 연비가 다른지 알아보려고 한다.
# displ(배기량)이 4 이하인 자동차와 5 이상인 자동차 중 어떤 자동차의 hwy(고속도로 연비)가 평균적으로 더 높은지 확인하기
mpg_a <- mpg %>% 
    group_by(displ) %>% 
    summarise(avg = mean(hvy)) %>% 
    filter(displ <= 4) %>% 
    arrange(desc(avg))
tail(mpg_a)

#풀이
mpg_a <- mpg %>% filter(displ <= 4)
mpg_b <- mpg %>% filter(displ >= 5)
mean(mpg_a$hwy) #mpg_a의 hvy의 평균
mean(mpg_b$hwy) #mpg_b의 hvy 평균


#2.
# 자동차 제조 회사에 따라 도시 연비가 다른지 알아보려 합니다. 'audi'와 'toyota' 중 어느
# manufactor(자동차 제조회사)의 cty(도시 연비)가 평균적으로 더 높은지 알아보세요.
mpg_audi <- mpg %>% filter(manufacturer == 'audi')
mpg_toyota <- mpg %>% filter(manufacturer == 'toyota')
mean(mpg_audi$cty)
mean(mpg_toyota$cty)


#3.
# 'chervolet','ford','honda' 자동차의 고속도로 연비 평균을 알아보려 합니다. 이 회사들의
# 자동차를 추출한 뒤, hwy 전체 평균을 구해보세요.