---
title: 'AWS 여러 프로필에 동시에 접근'
date: 2020-01-09
permalink: /posts/aws/2020-01-09-aws-access-multiple-profile
tags:
  - aws
  - profile
  - multipe
  - access
---

![](/assets/2020-01-09-aws-access-multiple-profile_001139.png)

## 가정

- HoYoung의 계정과 John의 계정은 서로 다른 계정임  
- trust relationship으로 맺어져있어 접근 권한은 획득한 상태

## 방법

1. [CLI에서 접근하는 방법](https://docs.aws.amazon.com/ko_kr/cli/latest/userguide/cli-configure-profiles)
1. [CODE에서 접근하는 방법](https://stackoverflow.com/questions/33378422/how-to-choose-an-aws-profile-when-using-boto3-to-connect-to-cloudfront)

### CLI에서 접근하는 방법

마지막에 `--profile` 을 적어주면된다.

```bash
$ aws rekognition list-collecitons --profile $PROFILENAME
```

혹은 export 를 하여 해당 쉘이 닫히기 전까지는 항상 같은 profile로 작동하도록 할 수 있다.

```bash
$ export AWS_PROFILE=$PROFILENAME
```

### CODE에서 접근하는 방법

boto3에 PROFILENAME을 명시 해주어야한다.

```python
import boto3
rekognition = boto3.client('rekognition') 
```

위 코드를 아래와 같이 바꾸어 주면 원하는 지정한 profile의 [Collection](https://docs.aws.amazon.com/ko_kr/rekognition/latest/dg/collections.html)에 접근 가능하다.

```python
import boto3
session = boto3.Session(profile_name='PROFILENAME')
rekognition = session.client('rekognition')
```

