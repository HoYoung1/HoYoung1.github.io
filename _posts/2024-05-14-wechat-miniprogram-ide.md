---
title: 'wechat miniprogram ide'
date: 2024-04-22
permalink: /posts/wechat/wechat_miniprogram_ide
tags:
  - wechat 
  - wechat miniprogram ide
---

# Wechat Miniprogram

위챗 미니프로그램 전용 IDE조작법들 간단히 정리

![](/assets/2024-05-14-23-53-41.png)

> The AppID is used to uniquely identify the Mini Program in the Mini Program platform

최종적으로 EndUser 에게 Release 되려면 AppId 라는 것이 필요하다.
다만 tourist 를 사용해 개발만 해볼 수 있긴한데, 어쨋든 이것저것 헤매다보면 다음과 같은 로그인,회원가입 창을 만난다.

뭔가 가입해야되는 것 같지만, 옆에 '이미 아이디 있음' 클릭 한다음에 wechat 으로 scan하면 바로 로그인 가능! 

![](/assets/2024-05-15-00-31-17.png)



## Compile 방법 

![](/assets/2024-05-15-00-01-04.png)
위챗에서 제공하는 Sample Project Template를 선택하고 넘어왔다. 


compile 누르면 hello world 뜸
![](/assets/2024-04-26-20-19-40.png)

preview 누르면 qr code나오는데, 위챗 킨 다음 스캔하면 내 폰으로 직접 앱 시뮬레이션 가능. ~~옛날에 안드로이드 개발 할 때 생각이 잠깐 났음. 그나저나 뭐든지 다 신기함 ㅋ~~

![](/assets/2024-04-26-20-23-34.png)

## Router 

app.json 파일의 pages 에 모든 page 들의 path를 알 수 있다.

![](/assets/2024-05-15-00-02-22.png)

## Homepage

위 app.json의 pages에 첫번째 page가 home이다. (위 이미지의 pages/index/index)

> The first page specified in the pages field is the homepage of the Mini Program

![](/assets/2024-05-15-00-05-41.png)

Miniprogram이 런치될때 onLaunch 콜백이 가장 먼저 실행되나보다.

> When the Mini Program is launched, the onLaunch callback of the App instance defined in app.js is executed:

![](/assets/2024-05-15-00-10-50.png)

> After the interface is rendered, the page instance receives an onLoad callback, where you can process your logic.

## API Sample

아래와 같은식으로 API도 등등등 지원한다.

To obtain user's geographical location,
```js
wx.getLocation({
  type: 'wgs84',
  success: (res) => {
    var latitude = res.latitude // Latitude
    var longitude = res.longitude // Longitude
  }
})
```

To use the "Scan" feature, 
```js
wx.scanCode({
  success: (res) => {
    console.log(res)
  }
})
```

## Release 과정

![](/assets/2024-05-15-00-20-48.png)

테스트용 프로젝트라서 Upload 버튼이 비활성화 되어있긴하지만, 쨋든 release를 하려면 저 버튼을 통해 코드를 업로드하고, [Mini Program admin console](https://mp.weixin.qq.com/) 에서 `Submit for Review` 버튼을 누르면 심사로 넘어간다고 한다. 

## 맺으며

IOS나 Android 앱 출시랑 비슷하기야 하겠다만, 중국이니까...... 또 좀 다르겠지..

같이 공부하는 친구의 지인의 말에 따르면, 출시하려면 
- 텐센트 인증
- icp 인증
- 공안국 비준 

이런게 필요하다고 한다..



## 참고 자료

Wechat DevTools 
- https://developers.weixin.qq.com/miniprogram/en/dev/devtools/devtools.html

Release
- https://developers.weixin.qq.com/miniprogram/product/record_guidelines.html

- https://developers.weixin.qq.com/miniprogram/en/dev/framework/quickstart/release.html#Release


