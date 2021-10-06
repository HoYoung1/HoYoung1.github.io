---
title: 'How To Debug Scrapy'
date: 2021-10-06
permalink: /posts/scrapy/2021-10-06-how-to-debug-scrapy
tags:
  - scrapy
  - how to debug scrapy
---

# How To Debug Scrapy

## 서론

scrapy 같은 커맨드 라인으로 실행시키는 툴도 pyCharm에서 디버깅을 할 수 있다.
이참에 정리 해보려 한다.

## 본론

```bash
$ scrapy --help
Scrapy 2.5.1 - project: hyScrapy

Usage:
  scrapy <command> [options] [args]

Available commands:
  bench         Run quick benchmark test
  check         Check spider contracts
  commands
  crawl         Run a spider
  edit          Edit spider
  fetch         Fetch a URL using the Scrapy downloader
  genspider     Generate new spider using pre-defined templates
  list          List available spiders
  parse         Parse URL (using its spider) and print the results
  runspider     Run a self-contained spider (without creating a project)
  settings      Get settings values
  shell         Interactive scraping console
  startproject  Create new project
  version       Print Scrapy version
  view          Open URL in browser, as seen by Scrapy
```

```bash
$ scrapy crawl [SPIDER_NAME]
```

이런식으로 spider를 실행시킨다.  
디버그하는 방법은 생각보다 간단하다.

```bash
$ which scrapy
/Users/hoyeongkim/src/virtual/environment/bin/scrapy
```

`which` command를 통해 scrapy 커맨드의 경로를 알 수 있다.

```bash
$ cat /Users/hoyeongkim/src/virtual/environment/bin/scrapy
```

![](/assets/2021-10-06-21-38-10.png)

scrapy command를 열어보면 결국 python script라는 것을 알 수 있다.


![](/assets/2021-10-06-21-31-18.png)


1. Script Path: `which scrapy` 의 결과를 넣어준다.
1. Parameters: scrapy crawl [SPIDER_NAME] 에서 parameter 내용들을 넣어준다.
1. Working directory: scrapy crawl 커맨드를 실행시키는 directory를 지정해준다.

디버깅 포인트 찍고 실행하면 끝

## 맺으며

이런식으로 커맨드로 실행시키는 툴들도 커맨드의 경로와 parameter의 경로를 입력해주면 디버깅이 가능하다.

## 참고 자료

[https://stackoverflow.com/questions/21788939/how-to-use-pycharm-to-debug-scrapy-projects]([https://stackoverflow.com/questions/21788939/how-to-use-pycharm-to-debug-scrapy-projects)