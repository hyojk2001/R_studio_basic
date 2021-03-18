#통계값 출력 함수

x <- c(1,2,3,4,5)/4
x

round(x,0)  #소수점 첫째자리에서 반올림
floor(x)    #소수점 이하를 없앤다(=가우스 숫자)
ceiling(x)  #소수점 이하를 올린다
mean(x)     #평균
median(x)   #중간값
max(x)      #최대값
min(x)      #최소값
trunc(x)    #소수점 둘째 자리에서 반올림
range(x)    #최소값과 최대값 표시
sd(x)       #표준편차( = sqrt(분산))
var(x)      #분산( = 표준편차 ^ 2)

sqrt(var(x))


#그림 / 그래프 그리기

plot(iris$Petal.Length)

plot(iris$Petal.Length, iris$Petal.Width) #plot(x축 데이터셋, y축 데이터셋)

plot(iris$Petal.Length, iris$Petal.Width, main = 'iris data',
 xlab = 'Petal Length', ylab = 'Petal Width', col = iris$Species)       
#plot(x축 데이터셋, y축 데이터셋, xlab = x축 이름, ylab = y축 이름, col = 색을 칠할 기준)

#pairs() : 행렬 산점도 그리기
 pairs(~ Sepal.Width + Sepal.Length + Petal.Width + Petal.Length, data = iris, col = iris$Species)   

#hist() : 히스토그램 그리기. 데이터가 모여있는 정도, 즉 분포를 확인하기 좋다
 hist(iris$Sepal.Width)                 
 hist(iris$Sepal.Width, freq = FALSE)   #freq=FALSE : 확률 밀도로 확인하고자 할때 추가한다

#막대그래프에 이름 붙이기. 집단 간의 차이를 확인하는 데 용이하다.
x <- aggregate(Petal.Length ~ Species, iris, mean)   #aggregate 함수를 사용해 품종별 꽃잎 길이의 평균을 구한다
barplot(x$Petal.Length, names=  x$Species)           #막대 그래프 이름으로 품종을 지정한다

aggregate(iris$Petal.Length~iris$Petal.Width,iris,mean)

#파이 차트 그리기. 데이터 비율을 표현하는 데 용이하다
x <- aggregate(Petal.Length ~ Species, iris, sum)
pie(x$Petal.Length, labels = x$Species)

# 선 그래프 그리기. 시간에 따른 데이터 추이를 확인하는 데 용이하다.
x <- tapply(iris$Petal.Length, iris$Petal.Width, mean)  #iris$Petal.Width를 그룹으로 iris$Petal.Length 평균을 구한다
x


head(swiss)
plot(swiss$Examination)

x <- aggregate(Catholic~Infant.Mortality, swiss, mean)
barplot(x$Catholic, names= x$Infant.Mortality, xlab = 'Catholic', ylab = 'Infant.Mortality')







