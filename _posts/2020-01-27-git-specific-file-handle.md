---
title: 'git 특정파일만 되돌리기, 특정파일만 add 취소하기'
date: 2020-01-27
permalink: /posts/git/2020-01-27-git-reset-HEAD-file
tags:
  - git
  - reset
  - head
  - file
---

# 특정파일의 작업 취소 그리고 특정파일의 add 취소에 대해 알아보자

종종 사용되나, 잘 안외워진다. 한 파일만 다루는 경우를 정리해보자. 

1. [특정파일의 작업 취소(변경사항버리기)](#1-특정파일의-작업-취소)
1. [특정파일의 add 취소(unstaged로 변경)](#2-특정파일-add-취소)

## 1. 특정파일의 작업 취소

작업 내용이 마음에 들지 않을때, 최근 커밋으로 모든 내용을 강제로 돌리고싶을때

```bash
$ git reset --hard # 모든 파일의 작업 내용을 버림
```
를 종종 하는편이다. 

하지만 가끔 `특정 파일`만 `'git reset --hard'` 를 시키고 싶을때가있다.

```bash
$ git checkout -- [Filename] # 특정 파일의 작업 내용을 버림
```

## 2. 특정파일 add 취소

- 실수로 커밋하지 않을 파일까지 add 한 경우, 즉 commit 대상에서 빼고 싶을때, 
- 혹은 `'git add .'` 을 하고 그 중에 특정 파일 add 취소하고 싶을 때

```bash
$ git reset HEAD [Filename] # 특정 파일을 Unstage 상태로 변경 
```


