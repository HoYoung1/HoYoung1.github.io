---
title: '가용성이란?'
date: 2020-05-03  
permalink: /posts/wiki/2020-05-03-what-is-availability
tags:
  - availability
---

# 가용성이란?

AWS 서비스를 사용하다보면 가용성이란 말을 정말 자주 듣는다.
- 고가용성(High Availability)
- 가용성 향상  
등등..

위키피디아에 [가용성](https://ko.wikipedia.org/wiki/%EA%B0%80%EC%9A%A9%EC%84%B1)을 검색해보자.
> 가용성 : 서버와 네트워크, 프로그램 등의 정보 `시스템이 정상적으로 사용 가능한 정도`

가용성이 높으면 좋은건 알겠는데, 아직 가용성이 뭔지 정확하게 모르겠다.

수식을 통해 살펴보자

![](./assets/2020-05-03-what-is-availability/2020-05-03-what-is-availability_175911.png)

가용성(Availability)이란 정상적인 사용 시간(Uptime)을 전체 사용 시간(Uptime+Downtime)으로 나눈 값을 말한다

즉 365일(24시간 X 365일) 가동했는데, 한번도 안죽었으면 99.999999999% 의 가용성을 보여준다고 할 수 있다.