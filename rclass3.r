#벡터끼리 연산하는 사례

x <- c(1,2,3,4)
y <- c(1,2)

z <- x+y
z

z <- x*y
z

x < 10 

#길이가 다르면 길이가 모자란 만큼 반복 사용한다.

y <- c(1,2)
10-y   #길이가 다르면 반복해서 돈다



#연산자

5 %% 2  #5를 2로 나눈 나머지
5 %/% 2 #5를 2로 나눈 몫

# & : and. 벡터 개별 값끼리의 비교
# $$ : and. 벡터의 '첫번째 값끼리만'의 비교
# | : or. 벡터 개별 값끼리의 비교
# || : or. 벡터의 '첫번째 값끼리만'의 비교

c(TRUE,TRUE,FALSE) | c(TRUE,FALSE,FALSE)    # and
c(TRUE,TRUE,FALSE) || c(TRUE,FALSE,FALSE)   # and. 앞에 하나만 따짐
c(TRUE,TRUE,FALSE) & c(TRUE,FALSE,FALSE)    # or
c(TRUE,TRUE,FALSE) && c(TRUE,FALSE,FALSE)   # or. 앞에 하나만 따짐

x <- c('a','b')
'a' %in% x      # 특정 조건이 그룹 안에 있는지 확인

x <- c('hi','hello')
'hi' %in% x

x <- read.csv('reservation_r_csv.csv')
head(x)