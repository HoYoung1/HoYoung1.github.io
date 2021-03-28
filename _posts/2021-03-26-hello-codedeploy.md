---
title: 'Hello CodeDeploy'
date: 2021-03-26
permalink: /posts/aws/2021-03-26-hello-codedeploy
tags:
  - codedeploy
---

# CodeDeploy

[CodeDeploy Sample](https://github.com/aws-samples/aws-codedeploy-samples/tree/master/applications/SampleApp_Linux)을 조금 더 쉽게 돌려보기 위해 'CodeDeploy를 포함한 여러 AWS Resource들을 한번에 배포'하는 
CDK를 만들어보았고 그 내용을 정리해보자.


## 서론

EC2, S3 같은 서비스는 그 서비스 자체만으로 실행가능하므로 비교적 쉽게 익힐 수 있다고 생각한다. 
하지만 CodeDeploy 같은 서비스는 여러가지 서비스를 동시에 써야 CodeDeploy를 활용해 볼 수 있다.

[CodeDeploy Sample](https://github.com/aws-samples/aws-codedeploy-samples/tree/master/applications/SampleApp_Linux) 은 CodeDeploy를 위한 간단한 Script와 Appspec File을 제공한다. 하지만 실제로 이 Sample을 돌려보려면 'Trigger가 되는 CodeCommit', '배포 Target이 되는 ASG', '전체 파이프라인을 돌려주는 CodePipeline' 등이 설정되어 있어야 한다. 

설정을 콘솔에서 수동으로 할 수도 있으나,
- `ASG` 만들어줘야하고.. 
- `Repository` 만들어줘야하고.. 
- `CodeDeploy` 설정해줘야하고.. 
- `CodePipeline` 설정해줘야하고..  
그 이후에 실행해보면 또 안된다...왜? 
- EC2에 [CodeDeploy Agent 설치](https://docs.aws.amazon.com/ko_kr/codedeploy/latest/userguide/codedeploy-agent-operations-install.html) 해야 돌릴 수 있다드라..

이래서 IaC 하는구나 싶다.



CDK로 후딱 돌려보자. 소스코드는 [여기]()에 있다.

## 본론

목표는 CodeDeploy 돌려보기!

### AWS 리소스 생성

```bash
$ git clone https://github.com/HoYoung1/HelloCodedeploy.git

# lib/config.ts 파일 본인 계정에 맞춰 수정 (아이디넣기, 리전넣기)
$ cdk bootstrap
$ cdk list
$ cdk deploy 
```

Deploy 되는 내용 간단히 설명
1. ASG, CodeDeploy, CodeCommit Repo, CodePipeline 리소스가 새로 생성된다.  
주의 : VPC를 새로 생성하지 않고 Default VPC를 사용한다. 

1. CodeDeploy는 autoScalingGroup을 타겟으로 설정

1. CodeCommit 소스푸시 -> CodeDeploy Action 되도록 Pipeline 설정


### CodeDeploy 돌려보기

```bash
$ git submodule init && git submodule update # CodeDeploy Sample 이용하기
$ cd ./aws-codedeploy-samples/applications/SampleApp_Linux
$ ls -l 
-rwxr-xr-x  1 hoyeongkim  staff  10884 Mar 22 17:08 LICENSE.txt
-rwxr-xr-x  1 hoyeongkim  staff    359 Mar 22 17:08 appspec.yml
-rwxr-xr-x  1 hoyeongkim  staff    717 Mar 22 17:08 index.html
drwxr-xr-x  5 hoyeongkim  staff    160 Mar 22 17:08 scripts

```

```bash
$ pwd
~/hello-codedeploy/aws-codedeploy-samples/applications/SampleApp_Linux
$ git init 
$ git commit -am "First Commit"
$ git remote add suborigin [Repo Url] # AWS CodeCommit에 들어가서 생성된 Repo URL copy
$ git push suborigin master # codecommit helper 설정되어있어야함
```

push 하면 pipeline이 돌기 시작한다.
![](/assets/2021-03-23-codedeploy/2021-03-23-codedeploy_223948.png)

CodeDeploy에 들어가면 순서대로 잘 배포되었다.
![](/assets/2021-03-23-codedeploy/2021-03-23-codedeploy_224541.png)

뭔지는 잘 모르겠지만, 어쨋든 푸시하면 잘 작동되는것 같다!!!

### CodeDeploy 살짝 살펴보기

돌리기만 하면 내용 이해는 쉽다. 제일 중요한 내용 2개만 살펴보자

- LifeCycle Event Hook
- AppSpec.yml

#### LifeCycle Event Hook

![](/assets/2021-03-23-codedeploy/2021-03-23-codedeploy_232835.png)

위 순서대로 Event들이 실행됬다. 
이것은 CodeDeploy에서 이미 정해놓은 순서이며, 각각을 Event Hook이라고 한다.  
일부 Hook은 스크립트에서 사용할 수 있으며, 일부는 이미 예약되어있는 Event여서 직접 사용이 불가능하다.  
각 Hook의 의미와 배포 별 LifeCycle은 [여기](https://docs.aws.amazon.com/codedeploy/latest/userguide/reference-appspec-file-structure-hooks.html)를 참조하면 된다.(참고로 이 글에서 한 배포는 EC2 In-place deployment 이다.)

#### AppSpec.yml

사실 CodeDeploy라는 서비스는 AppSpec.yml 파일을 읽어서 그대로 실행하는 것이라고 생각하면된다. 우리가 아까 푸시했던 곳에 Appspec.yml 파일이 있었다.

![](/assets/2021-03-23-codedeploy/2021-03-23-codedeploy_233855.png)

AppSpec.yml은 [정해진 구조](https://docs.aws.amazon.com/codedeploy/latest/userguide/reference-appspec-file.html)를 맞춰서 작성하면 된다.

```yaml
version: 0.0
os: linux
files:
  - source: /index.html
    destination: /var/www/html/
hooks:
  BeforeInstall:
    - location: scripts/install_dependencies
      timeout: 300
      runas: root
    - location: scripts/start_server
      timeout: 300
      runas: root
  ApplicationStop:
    - location: scripts/stop_server
      timeout: 300
      runas: root
```

위 yaml은 현재 우리 프로젝트의 appspec.yml파일이다.  
부분부분 살펴보자.

```yaml
files:
  - source: /index.html
    destination: /var/www/html/
```
서버의 /var/www/html/ 경로에 index.html 파일만 배포한다.  
디렉토리 전부 다 서버에 올리고 싶으면 

```yaml
files:
  - source: /
    destination: /var/www/html/
```
이렇게 하면 된다.

hooks 부분을 보자.

```yaml
hooks:
  BeforeInstall:
    - location: scripts/install_dependencies
      timeout: 300
      runas: root
    - location: scripts/start_server
      timeout: 300
      runas: root
  ApplicationStop:
    - location: scripts/stop_server
      timeout: 300
      runas: root
```

아까 그림에서 보았던 그 Hook이다!

![](/assets/2021-03-23-codedeploy/2021-03-23-codedeploy_234614.png)

- BeforeInstall -> scripts/start_server
- ApplicationStop -> scripts/stop_server

각 훅은 해당 스크립트를 실행시키는데 스크립트 내용은 scripts/ 디렉토리에서 확인할 수 있다.

## 맺으며

CodeDeploy 서비스에 대한 이해 끝!

다음포스팅은 [CodeDeploy Sample](https://github.com/aws-samples/aws-codedeploy-samples/tree/master/applications/SampleApp_Linux) 의도에 맞게 조금 더 배포 셋팅을 해보자.