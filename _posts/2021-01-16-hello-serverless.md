---
title: 'Hello Serverless'
date: 2021-01-16
permalink: /posts/serverless/2021-01-16-hello-serverless
tags:
  - serverless
---

# serverless

Serverless.com Hello World

[serverless.com](https://www.serverless.com/) 뭐하는 곳일까?


![](/assets/2021-01-16-hello-serverless/2021-01-16-hello-serverless_234357.png)

구글에 serverless를 검색하면 가장 먼저 나오는 serverless.com

유명 클라우드 회사인 AWS, Azure, GCP에서 제공하는 서버리스는 알겠는데, 이건 도대체 뭘까 궁금해서 헬로월드 수준으로 가볍게 도전해봤다.

`Deploy AWS DynamoDB` 버튼을 눌러시작해보자.

![](/assets/2021-01-16-hello-serverless/2021-01-16-hello-serverless_234710.png)
여러가지를 deploy 할 수 있는 것처럼 보인다.

Serverless.com 의 콘솔에 들어왔고 아래와 같은 화면을 볼 수 있다. 또 deploy 버튼을 눌러보자.

![](/assets/2021-01-16-hello-serverless/2021-01-16-hello-serverless_234943.png)

하라는대로 해보자.
setup 버튼을 눌러준다.

![](/assets/2021-01-16-hello-serverless/2021-01-16-hello-serverless_235553.png)

role을 만들어야 하나보네
눌러본다.

![](/assets/2021-01-16-hello-serverless/2021-01-16-hello-serverless_235643.png)

동의 후 cloudformation 스택이 배포된다.

![](/assets/2021-01-16-hello-serverless/2021-01-16-hello-serverless_235746.png)

스택 템플릿을 보면 어떤 리소스를 만드는지 확인할 수 있다.
![](/assets/2021-01-16-hello-serverless/2021-01-16-hello-serverless_000236.png)

Resources 부분만 보면 무엇을 만드는지 알 수 있다.
```yaml
Resources:
  SFRole:
    Type: AWS::IAM::Role
    Properties:
      AssumeRolePolicyDocument:
        Version: '2012-10-17'
        Statement:
          - Effect: Allow
            Principal:
              AWS: arn:aws:iam::486128539022:root
            Action:
              - sts:AssumeRole
            Condition:
              StringEquals:
                sts:ExternalId: !Sub 'ServerlessFramework-${OrgUid}'
      Path: /
      RoleName: !Ref RoleName
      ManagedPolicyArns:
        - arn:aws:iam::aws:policy/AdministratorAccess
  ReporterFunction:
    Type: Custom::ServerlessFrameworkReporter
    Properties:
      ServiceToken: 'arn:aws:lambda:us-east-1:486128539022:function:sp-providers-stack-reporter-custom-resource-prod-tmen2ec'
      OrgUid: !Ref OrgUid
      RoleArn: !GetAtt SFRole.Arn
      Alias: !Ref Alias
```
1. AdministratorAccess 권한을 가진 `AWS::IAM::Role`
1. 486128539022 계정의 람다인 `Custom::ServerlessFrameworkReporter` 

를 만드는 것 같다. 

486128539022 계정에 임시자격증명을 주기도 하고 ~~게다가 Admin권한~~  
`Custom Resource`는 잘 모르는데.. 

슬슬 무지에서 오는 두려움이 몸을 지배한다..   
뭔가 바로 지우고 싶지만 조금만 더 해보자.

그리고 Dynamodb 관련된 내용은 없다. 아마 저 `Custom Resource`에 뭔가가 있는 것 같다.

IAM에 Role에서 방금 생성된 Role을 볼 수 있다. 

![](/assets/2021-01-16-hello-serverless/2021-01-16-hello-serverless_001723.png)

그리고 Serverless 콘솔에 들어가보면 나의 배포를 기다리고 있다. 하라는대로 해보자.

![](/assets/2021-01-16-hello-serverless/2021-01-16-hello-serverless_002414.png)

성공! Full detail은 콘솔에서 볼 수 있다고 적혀있다. 

![](/assets/2021-01-16-hello-serverless/2021-01-16-hello-serverless_003239.png)

콘솔에서는 이런 정보들을 볼 수 있다.

![](/assets/2021-01-16-hello-serverless/2021-01-16-hello-serverless_003457.png)

AWS 콘솔에 들어가면 DDB Table도 확인해 볼 수 있다.

![](/assets/2021-01-16-hello-serverless/2021-01-16-hello-serverless_003644.png)

생각보다 어렵지 않았고 위 흐름을 정리해보면 다음과 같다.

1. Role 생성
1. CLI로 Serverless Deploy 
1. 리소스 생성됨 ~~(내 권한을 가지고 Serverless.com에서 정의해놓은 Lambda를 호출시켜서)~~

## 마무리

[serverless github](https://github.com/serverless/serverless)에 들어가보면 
`the easy & open way to build serverless applications`
이라고 적혀있다.

한마디로 Serverless Framework는  서버리스 어플리케이션을 위한 인프라와 코드를 쉽게 배포하는 도구이다. 

실제로 서버리스로 개발하다보면 이 인프라와 코드를 어떻게 관리해야 하는가? 라는 과제에 직면하는데, 배포 프레임워크 혹은 오픈소스를 통해 관리할 수 있다.

배포 프레임워크 혹은 오픈소스의 종류는 [이 블로그](https://www.megazone.com/techblog_20200424_opensource-24-open-source-tools-for-the-serverless-developer-part-1/)에 설명이 잘 되어있다.

AWS CDK를 통한 배포만 해왔는데, 나중에 Azure 혹은 GCP를 같이 사용할 때를 대비하여 multi-cloud IaC들도 관심을 가져야 할 것 같다.

끝


아 마지막으로.. 제일 중요한건 Cloudformation delete 스택 버튼을 눌러 생성된 롤을 꼭 지워준다!

## 참고

- [serverless](https://www.serverless.com/)
- [serverless github](https://github.com/serverless/serverless)