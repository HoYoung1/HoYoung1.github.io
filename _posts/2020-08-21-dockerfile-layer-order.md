---
title: 'DockerFile layer 순서'
date: 2020-08-21
permalink: /posts/docker/2020-08-21-dockerfile-layer-order
tags:
  - dockerfile
  - layer
  - order
---

# dockerfile layer 순서를 어떻게 해야할까

## 서론 

도커 이미지 빌드할 때 시간을 단축시키고 싶어서 공부를 좀 해봤다.

내 문제는 더 자주 변경되는 레이어가 도커파일의 마지막이 아닌 중간에 있었다는 것!!! 변경되지도 않는 레이어를 계속 만들고 있었다니~~~~
슬프다..

어쨋든 핵심은 다음과 같다.

`dockerfile에서 layer 구성을 할 때 빈번히 변경되는 레이어라면 뒤쪽에, 덜 빈번히 변경되는 레이어일수록 앞쪽에 배치해야한다`

이유는 도커 이미지를 만들때 캐시가 사용되는데, 변경부분부터는 캐시를 사용하지 않게된다.

## 실습

```bash
# Dockerfile
FROM golang:1.11-alpine AS build

RUN apk add --no-cache git
RUN go get github.com/golang/dep/cmd/dep

# 이 레이어는 Gopkg파일이 변경되면 rebuild됨
COPY Gopkg.lock Gopkg.toml /go/src/project/
WORKDIR /go/src/project/

RUN dep ensure -vendor-only

# 이 레이어는 project내 파일이 변경되면 rebuild됨
COPY . /go/src/project/
RUN go build -o /bin/project
```

위와 같은 Dockerfile로 이미지를 만들어보자.
```
$ pwd
/Users/hoyeongkim/go/src/project

$ tree # 현재디렉토리 구조 확인 목적
.
├── Dockerfile
├── Gopkg.lock
├── Gopkg.toml
├── hello_world.go
└── vendor

$ docker build .
```
![](/assets/2020-08-21-dockerfile-layer-order_003902.png)

docker build 를 두 번 연속했더니, 
**아무런 변경사항이 없어** 두번째 build는 전부 캐시를 사용했음을 알 수 있다.

Gopkg.toml 파일에 아무런 의미없는 주석을 추가하고 다시 빌드를 해보자.

![](/assets/2020-08-21-dockerfile-layer-order_005159.png)

3번 레이어까지만 캐시를 사용하였다. 왜 4/8부터는 캐시를 사용하지 않았는가?

![](/assets/  2020-08-21-dockerfile-layer-order_010229.png)

우리는 정확하게 4번째에있는 Gopkg.lock 파일의 내용을 변경하였다. 그리고 도커가 변경내용을 감지하고
4번부터는 캐시를 사용하지 않았다.

## 결론

의존성 및 상황에 따라 다르지만

`가장 변경이 적은 놈부터 가장 변경이 많은 놈 순서`로 캐시를 잘 이용하자~


## 참고

[https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#use-multi-stage-builds](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#use-multi-stage-builds)
