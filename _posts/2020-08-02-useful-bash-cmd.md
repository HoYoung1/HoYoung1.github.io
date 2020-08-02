---
title: '유용한 bash cmd 기록'
date: 2020-08-02
permalink: /posts/shell/2020-08-02-useful-bash-cmd
tags:
  - bash
  - $
  - shell
---

유용한 bash cmd 기록

유튜브에서 bash shell을 가지고 50분을 설명하는 [영상](https://www.youtube.com/watch?v=kgII-YWo3Zw)이있다. 
내 지식으로는 10분이면 바닥을 칠텐데 50분 설명할 내공을 가지다니.... ~~부럽다~~~

**'아니.. 이런게 있었어?'**
라는 생각이 들었던 커맨드 두 개만 정리해보자.

# 1. 인자 재활용 : '$_'

예시 그림 : 
![](/assets/2020-08-02-useful-bash-cmd_210503.png)

```bash
$ mkdir test
$ cd $_
```

인자를 반복하고 싶지 않을 때 '$_' 를 입력하면 된다.  
위 예시에서는 'test' 인자를 반복하지 않아도 된다.

![](/assets/2020-08-02-useful-bash-cmd_211233.png)

크롬 개발자도구에서도 비슷한 용도로 사용된다.

# 2. 마지막 커맨드 재활용 : '!!'

예시 그림 : 
![](/assets/2020-08-02-useful-bash-cmd_211741.png)

```bash
$ mkdir /mnt/new
$ sudo !!
```

!! 를 쓰면 위에 커맨드가 그대로 들어온다. 

## 참고

[https://www.youtube.com/watch?v=kgII-YWo3Zw](https://www.youtube.com/watch?v=kgII-YWo3Zw)
