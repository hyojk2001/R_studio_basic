# 데이터 조작하기
x <- c(1,2,3,4,5)
y <- c(6,7,8,9,10)

z <- rbind(x,y)  # x와 y를 행으로 합친다
z

cbind(x,y)       # x와 y를 열로 합친다

df <- data.frame(name = c('a','b'), score = c(80,60))
df

cbind(df,rank = c(1,2)) # df와 rank를 열로 합친다

# split() : 팩터의 열로 나누기
split(iris, iris$Species)       # species(종)에 따라 나누게 된다. 반환값은 리스트 구조가 된다.

# subset() : 조건으로 데이터를 선택한다
subset(iris, Sepal.Length >= 7)
subset(iris, Sepal.Length >= 7 & Sepal.Width >= 3.0)   # 이런 식으로 2개 이상의 조건을 넣어줄 수도 있다(and인 & 혹은 or인 |를 사용)
subset(iris, Sepal.Length >= 7, select = c('Sepal.Length', 'Species'))  # 또한 이런 식으로 출력하고 싶은 열 혹은 행만 따로 출력하는 것도 가능.
subset(iris, Sepal.Length >= 7 & Sepal.Width >= 3.0, select = c('Sepal.Length', 'Species'))

# substr(데이터셋$열이름,a,b) : 데이터 셋 별 a번째 자리부터 b번째 자리까지 출력
substr(iris$Species,1,3)   # 첫번째 자리부터 3번째 자리까지 선택

# merge(데이터셋1, 데이터셋2) : 데이터 합치기. 공통적으로 존재하는 열(예시에서는 name)이 있어야 합칠 수 있다.
x <- data.frame(name = c('a','b','c'), height = c(170,180,160))
y <- data.frame(name = c('c','b','a'), weight = c(50,70,60))
merge(x,y)  # cbind와의 차이 : cbind는 열이 중복되서 합쳐지지만, merge는 공동의 열이 있으면 하나만 쓰게 된다

# sort() : 순서를 정렬해서 데이터 값을 반환
x <- c(20,10,30,50,40)
sort(x)                     # decreasing을 생략하면 기본은 오름차순으로 정렬
sort(x,decreasing = FALSE)  # 오름차순(작은 수부터 큰 수까지 차례대로)
sort(x,decreasing = TRUE)   # 내림차순(큰 수부터 작은 수까지 차례대로)
x                           # sort() 함수를 사용해도 원본이 바뀌지는 않는다

#order() : 순서를 정렬한 뒤, 그 정렬된 행렬의 '인덱스'를 반환한다.
order(x)
order(x,decreasing = FALSE) # 오름차순으로 인덱스 반환
order(x,decreasing = TRUE)  # 내림차순으로 인덱스 반환
x                           # 원본이 바뀌지는 않는다

iris[order(iris$Sepal.Length),]     # Sepal.Length를 따라 오름차순으로 정렬한 뒤, 맨 왼쪽에는 순서대로 변한 인덱스를 나열

# unique(데이터셋) : 유일 값 반환하기
x <- c(1,1,2,2,3,3)
unique(x)   # 즉, 중복을 제거한 x를 배열로 반환

# aggregate(기준열 ~ 그룹화할 열, 데이터셋, 적용할 통계) : 그룹별로 통계 적용.
aggregate(Petal.Length ~ Species, iris, mean)   # 기준열 : Petal.Length, 그룹화할 열 : Species, 데이터셋은 iris, 나오는 통계치는 평균.
aggregate(cbind(Petal.Length, Sepal.Length) ~ Species, iris, mean)      # 여러 열을 선택하려면 cbind로 열을 묶으면 된다.










