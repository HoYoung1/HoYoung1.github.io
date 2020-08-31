---
title: 'Flask에서 npm 라이브러리 사용'
date: 2020-08-31
permalink: /posts/flask/2020-08-31-using-npm-in-flask
tags:
  - 플라스크
  - flask
  - npm
  - npm in flask
---

# Flask 에서 npm 라이브러리 사용하는 방법

## 서론

npm으로 라이브러리 설치해서 써야하는데 플라스크에서는 이걸 어떻게 쓸까 찾아봤다  
바코드 리드 기능을 추가해야해서 [QuaggaJS](https://github.com/serratus/quaggaJS) 이 라이브러리를 사용했다.

## 실습

Flask 구조
```bash
.
├── app.py
├── static
│   └── main.css
└── templates
    └── index.html
```
Flask에서 css, js파일은 보통 static directory 밑에서 관리함

```bash
$ cd static
$ npm init
$ npm install <PACKAGE NAME>
```

바코드 라이브러리가 필요해서 QuaggaJS 를 설치했음. 다른 패키지도 상관없음

![](/assets/2020-08-31-using-npm-in-flask_164009.png)

설치 후 node_modules 아래경로를 찾아준다.

![](/assets/2020-08-31-using-npm-in-flask_165828.png)

Flask html에서 원래 static 파일 불러오듯이

```html
{% raw %}<script type="text/javascript" src="{{ url_for('static', filename='node_modules/quagga/dist/quagga.js') }}"></script>{% endraw %}
```
이렇게 가져오면 된다. 끝

## 참고

[https://somjang.tistory.com/entry/Python-Flask%EC%97%90%EC%84%9C-npm-%EB%9D%BC%EC%9D%B4%EB%B8%8C%EB%9F%AC%EB%A6%AC-%EC%82%AC%EC%9A%A9%ED%95%98%EB%8A%94-%EB%B0%A9%EB%B2%95?category=345065](https://somjang.tistory.com/entry/Python-Flask%EC%97%90%EC%84%9C-npm-%EB%9D%BC%EC%9D%B4%EB%B8%8C%EB%9F%AC%EB%A6%AC-%EC%82%AC%EC%9A%A9%ED%95%98%EB%8A%94-%EB%B0%A9%EB%B2%95?category=345065)

