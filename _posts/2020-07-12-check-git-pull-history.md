---
title: 'git pull history 조회'
date: 2020-07-12
permalink: /posts/git/2020-07-12-check-git-pull-history
tags:
  - git
  - log
  - pull
  - history
---

git pull history 조회

```bash
$ git reflog --date=iso | grep pull 
```

찍어보면 아래 그림처럼 pull history 를 볼 수 있다.

![](/assets/2020-07-12-check-git-pull-history_210924.png)


내가 pull을 언제받았었지? 긴가민가 하다면,  
내 동료가 중요한 내용을 pull 안받고 배포를 한 것 같다면,  
내가 이 ~~망할~~ 프로젝트에 pull을 몇 번이나 했는지 궁금하다면  

지금 당장 
```bash
$ git reflog --date=iso | grep pull 
```
를 입력해보자.

## 참고

[https://stackoverflow.com/questions/47321486/how-to-retrieve-git-pull-history](https://stackoverflow.com/questions/47321486/how-to-retrieve-git-pull-history)
