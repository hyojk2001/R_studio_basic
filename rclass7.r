# install.packages('ggplot2')

x <- c(1,2,3,4,5)

# ifelse(조건, 결과1, 결과2) -> 조건이 맞으면 결과1을, 틀리면 결과2를 반환
# 다수의 데이터에 대해 참과 거짓을 판별할 때 사용된다
ifelse(x == 2, TRUE, FALSE) 

# for 반복문
for (i in 1:5){
    print(i)
}

# for문의 또다른 활용
sum <- 0
for (i in seq(1,5,by = 1)){     # seq : 순차 값을 생성하는 함수
    sum <- sum + i
}
sum

# while 반복문
i <- 1
while(i <= 5){
    print(i)
    i <- i + 1
}

# while문과 if문을 섞어서
i <- 1
while(i <= 5){
    i <- i + 1
    if(i == 2){
        next    # i가 2이면 while문 처음으로 돌아간다
    }
    print(i)
}

# repeat문
i <- 1
repeat{
    print(i)
    if(i >= 5){
        break
    }
    i <- i + 1
}






