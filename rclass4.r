install.packages('readxl')
library(readxl)

x <- read.csv('reservation_r_csv.csv')
y <- read.csv('reservation_r_excel.xlsx')

#write.파일형식(옮길 파일,'옮길 파일의 이름')
write.csv(x,"csv_output.csv")       

#white_excel() 함수로 파일 내보내기
install.packages('writexl')
library(writexl)
write_xlsx(y, 'excel_output.xlsx')

#txt 파일에 데이터를 넣어서 직접 만들기
sink('output.txt')
x <- 1
y <- 2
x
y
x+y
sink()


#R 객체를 저장하는 파일(Rdata 형식) 생성
x <- c(1,2,3)
y <- c(4,5,6)
save(x,y,file = 'save.Rdata')


#메모리의 변수를 모두 삭제. rm()은 변수를 삭제, ls()는 모든 목록 이름을 반환하는 함수
x       
rm(list = ls())


#load() 함수를 사용해 파일로 저장된 변수들을 메모리로 불러오기
# save.Rdata의 파일들을 불러온다
load('save.Rdata') 
x   # [1] 1 2 3
y   # [1] 4 5 6


#사용중인 변수들을 들을 모두 저장
x <- c(1,2,3)
y <- c(4,5,6)
z <- c(7,8,9)
save(list=ls(),file='save2.Rdata')  
#현재 변수들을 저장. list는 ls()를 통해 얻은, 현재 나온 모든 변수(x,y,z)들의 집합체
load('save2.Rdata')
x
y
z


#cat() 함수. sink()와 비슷하다.
connect <- file('result.txt','w')
x <- iris$Sepal.Length
cat(summary(x), file = connect)
close(connect)


#데이터 조회 함수 정리
x <- read.csv('reservation_r_csv.csv')
head(x,2)       #head(x, 처음부터 출력 행의 갯수)
tail(x,2)       #tail(x, 끝에서부터 출력 행의 갯수)
str(x)          #데이터셋의 구조를 출력
summary(x)      #통계량의 요약본을 출력
View(x)         #소스 창으로 데이터, 구조 확인
nrow(x)         #행 개수를 셈
ncol(x)         #열 개수를 셈
dim(x)          #행의 개수와 열의 개수를 출력
length(x)       #벡터 길이를 반환. 실질적으로 행렬 데이터에서는 ncol()과 쓰임이 유사하다
ls(x)           #지정된 전체 변수의 이름들을 목록으로 말해준다. 즉, 행렬에서는 열의 데이터 목록 이름들이다.



library(help = datasets)
head(iris,10)
tail(iris,10)
summary(iris)
View(iris)
str(iris) # obs : 행 갯수, variables : 변수 갯수(열 갯수)
summary(iris$Sepal.Length)  # summary(데이터셋$열이름) - 데이터 셋의 해당 열을 요약 통계해서 표현

#요약 통계량
#Min, Max, Median(50% 중앙의 위치값), Mean(모든 값을 더해서 개수로 나눈 값), 
#1st Qu : 하위 25% 위치값, 3rd Qu : 하위 75%의 위치 값

dim(iris)
nrow(iris)
ncol(iris)
ls()                #현재 있는 모든 리스트를 표현
rm(list = ls())     #현재 있는 모든 리스트를 삭제
ls()



#변수의 '크기'를 확인하기 -> 데이터 크기를 확인하기 위해 필요
x <- c(1,2,3,4,5)
object.size(x)      #96 바이트


#데이터 구조 확인하는 함수
# is.na() : 데이터가 NA(결측치, 관측되지 않은 데이터)인지 확인. TRUE/FALSE를 반환 -> TRUE가 나오면 결측치, FALSE가 나오면 실제
is.na(iris)
# is.null() : 데이터셋이 null인지 확인
# is.numeric() : 데이터셋이 숫자형인지 확인
# is.character() : 데이터셋이 문자형인지 확인
# is.logical() : 데이터셋이 논리형인지 확인
# is.factor() : 데이터 구조가 펙터형인지 확인
# is.data.frame() : 데이터 구조가 데이터 프레임인지 확인

is.data.frame(iris)

library(help = datasets)


Orange
str(Orange)
dim(Orange)
head(Orange,10)
tail(Orange,10)
nrow(Orange)
ncol(Orange)
dim(Orange)
summary(Orange)
ls(Orange)
View(Orange)
is.na(Orange)
is.null(Orange)
is.character(Orange)
is.logical(Orange)
is.factor(Orange)
is.data.frame(Orange)


#Median과 Mean의 차이
x <- c(1,2,3,4,5,11,21,31,41,51)
mean(x)
summary(x)
#이와 같이 Median은 중앙값, 즉 총 10개 중 5번째 값인 5와 6번째 값인 11의 사이인 8.0이 되고
#Mean은 평균값, 즉 전체를 다 더한 후 10으로 나눈 값이다.

x <- c(1,2,4,8)
summary(x)

