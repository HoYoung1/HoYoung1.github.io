---
title: '안드로이드 파이 업데이트 후 request error 문제 해결'
date: 2019-04-20
permalink: /posts/android/2019-04-20-android-pie-request-https
tags:
  - android
  - okhttp
  - pie
  - https
---

okhttp 라이브러리를 사용하고 있었으며 api 호출시 request 하면 에러가 자꾸났음 ㅠ 원래 잘됬는데..
okhttp문제인가 싶어서 여러가지 테스트 하던중 api중 **https**의 경우 정상 호출되는 것을 확인했다.

> 여러가지 open api를 통해서 https 는 되고 http는 안된다는 것을 확인했음.

예전에 있던 핸드폰(갤럭시노트5)으로 통신을 확인했더니... 정상적으로 되더라...  
즉 **android pie**의 경우 **http** request 는 문제가 있다는 것을 확신했다.

구글링하다가 이 내용에 관련해 [포스팅](https://medium.com/mindorks/my-network-requests-are-not-working-in-android-pie-7c7a31e33330)한 블로그를 발견했다.

요약하면 다음과 같다.
- android pie의 경우 default로 https통신을 한다.
- http로 통신 할 경우 셋팅을 해줘야 한다고한다.
- manifest에 android:networkSecurityConfig를 추가해야한다.

```xml
<application
        android:networkSecurityConfig="@xml/network_security_config"
</application>
```

내용은 완전 똑같은데 따라했더니 안되서 스택오버플로우 [다른 글](https://stackoverflow.com/questions/51902629/how-to-allow-all-network-connection-types-http-and-https-in-android-9-pie)도 참고해서 해결했다.

