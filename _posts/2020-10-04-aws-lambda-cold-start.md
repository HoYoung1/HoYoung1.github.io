---
title: 'AWS lambda cold start는 도대체 왜 있는 것일까'
date: 2020-10-06
permalink: /posts/aws/2020-10-04-aws-lambda-cold-start
tags:
  - why
  - cold start
  - aws lambda
---

# AWS lambda cold start는 도대체 왜 있는 것일까

## 서론

AWS lambda를 사용하다 보면 `도대체 왜 처음에는 느릴까?` 라는 문제에 직면한다.
심지어 두 번째부터는 언제 그랬냐는 듯이 아주 빠른 속도로 실행되기 때문에, 이게 참.. 빠른거야 느린거야 싶을 때가 있다. 맨 처음에만 느린 그 희한한 현상을 `cold start` 라고 한다. 
그리고 일반적인 경우에 문제가 되지 않으나, real-time을 요구하는 상황에서 아주 골칫거리이다.

아래는 lambda cold start를 해결하기 위한 방법이다.
1. 주기적으로 lambda를 실행시켜 warm 상태를 유지한다.
1. Provisioned Concurrency를 사용한다.

2019년 12월에 발표된 [Provisioned Concurrency를 사용하면 앞으로 cold start로 인해 골치를 썩을 필요는 없다. (또한 앞으로 warm 상태를 위해 주기적으로 lambda를 실행할 필요도 없다)

그럼 도대체 왜 
- cold start 라는 게 있는거고 
- AWS는 이제서야 Provisioned Concurrency를 만들었으며
- 처음부터 cold start라는 정책을 안 만들었으면 되는 거 아니야?? 
- ~~아니 이거 처음에 불편하게 해놓고 편한 기능 만든 척하며 돈 벌어가려는 수법 아니야!? 읭!?~~  

의문을 해결해보자.

결론부터 말하자면 이 모든 것은 [서버리스](https://ko.wikipedia.org/wiki/%EC%84%9C%EB%B2%84%EB%A6%AC%EC%8A%A4_%EC%BB%B4%ED%93%A8%ED%8C%85)로부터 시작되며, 이러한 원리는 AWS lambda, Azure Function, OpenFass 등 모든 serverless compute architecture에 적용되어 있다. 

## 본론

cold? warm?

> 서버리스 기능은 하나 또는 여러 개의 컨테이너에서 제공된다. 요청이 들어오면 함수는 호출을 처리하기 위해 이미 실행 중인 컨테이너가 있는지 확인하고. 쉬고 있는 컨테이너가 있는 경우 이를 warm 컨테이너라고 한다. 즉시 사용할 수 있는 컨테이너가 없는 경우 함수는 새 컨테이너를 띄우며 이를 **cold start** 라고 한다.

cold start가 있는 이유에 대한 납득이 간다. 그렇다면 활성 상태를 좀 길게 잡아서 cold start를 느끼는 빈도를 줄여주면 안되는가? 

> warm 상태라는 것은 컴퓨팅 자원을 잡고 있다고 봐야 한다. 즉, 활성 상태를 길게 잡을수록 자원을 제공하고 있는 시간이 길어진다고 보면 될 듯하다.

컨테이너가 cold start를 할 때 순서는 다음과 같다.
1. 스토리지에서 코드와 패키지를 가져온다.
2. 컨테이너를 띄운다.
3. 메모리에 패키지와 코드를 올린다.
4. function handler를 작동시킨다.

**warm start**는 놀고있는 컨테이너를 잡아 바로 4번을 수행하는 것을 의미하며, 1번~3번까지 걸리는 시간이 **cold start**라고 보면 된다.

## 마무리

사용자 입장에서 이러한 내용을 알 필요는 없다. 주어진 옵션들을 상황에 맞게 잘 사용하며 된다. 단, 도대체 왜 cold start가 있는 걸까라는 의문 해소에 도움이 되었으면 한다. 아래 링크를 참고하였으며, 더 자세한 내용은 링크에서 직접 보면 도움이 될 듯 하다.

## 참고

[https://dashbird.io/blog/can-we-solve-serverless-cold-starts/](https://dashbird.io/blog/can-we-solve-serverless-cold-starts/)
[https://aws.amazon.com/ko/blogs/korea/new-provisioned-concurrency-for-lambda-functions/](https://aws.amazon.com/ko/blogs/korea/new-provisioned-concurrency-for-lambda-functions/)
