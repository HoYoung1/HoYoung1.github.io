---
title: 'CloudWatch Agent'
date: 2021-03-14
permalink: /posts/cloudwatch/2021-03-14-cloudwatch-agent
tags:
  - cloudwatch
  - agent
  - high-resolution
---

# CloudWatch Agent

## 서론

`어플리케이션의 버그 -> 갑작스럽게 높아지는 CPU 점유율 -> 서버 다운` 문제를 겪은적이 있는데
Cloudwatch Metric에서는 어느 단서도 얻을 수 없었다. 
그 이유는 CloudWatch Metric 수집이 `기본 Interval(5분)`로 설정되어있었기 때문이다.

옛날에는 [high-resolution-custom-metric](https://aws.amazon.com/about-aws/whats-new/2017/07/amazon-cloudwatch-introduces-high-resolution-custom-metrics-and-alarms/)을 활용해 초단위로 metric data를 수집했다고한다. 하지만 이제는 CloudWatch Agent를 설치하여 쉽게 설정할 수 있다.

## 본론

CloudWatch Metric 수집의 기본 Interval은 *5분*이며,  
Detailed Monitoring 을 활성화하면 Interval은 *1분*이다.  
하지만 초단위로 치는 스파크, 혹은 원인을 알 수 없이 갑작스럽게 죽어버리는 서버 등을 트러블슈팅하려면 초단위의 메트릭이 필요할 때가 있다.

지금부터
- CloudWatch Agent란 무엇인지
- CloudWatch Agent의 설치방법  

에 대해 알아보자

### CloudWatch Agent 란 무엇인가?

[기본적으로 제공되는 Infra metric](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/viewing_metrics_with_cloudwatch.html) 외 [추가적인 system-level metric](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/metrics-collected-by-CloudWatch-agent.html#linux-metrics-enabled-by-CloudWatch-agent)을 수집할 수 있도록 도와주는 도구이다. 또한, 로그를 수집하는데 이용할 수도 있다.

### CloudWatch Agent 의 설치방법

1. [Role 설정](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/create-iam-roles-for-cloudwatch-agent.html)
1. [Agent 설치](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/install-CloudWatch-Agent-on-EC2-Instance.html)
1. [Agent 설정](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/create-cloudwatch-agent-configuration-file.html)
1. [Agent 실행](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/install-CloudWatch-Agent-commandline-fleet.html#start-CloudWatch-Agent-EC2-commands-fleet)

위와 같은 순서대로만 진행하면 된다.  
하나씩 해보자.

#### Role 설정

  - `IAM Role 생성`으로들어와서 EC2 선택 후 `Next Permissions` 클릭 
  - `CloudWatchAgentServerPolicy`, `AmazonSSMFullAccess` 체크 후 Next
  - `CloudWatchAgentServerRole` 입력 후 Role 생성
  - EC2에 방금 만든 Role을 붙여줌
  ![](/assets/2021-03-14-cloudwatch-agent/2021-03-14-cloudwatch-agent_205125.png)

#### Agent 설치

운영체제마다 설치방법이 조금 다르다. 이 글은 Amazon Linux 2를 기준으로 설명하며, [여기](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/download-cloudwatch-agent-commandline.html#download-CloudWatch-Agent-on-EC2-Instance-commandline-first)에서 Platform 별 다운 방법을 알려주니 참고하자.

Amazon Linux 2를 사용하는 경우 EC2에서 아래와 같이 Agent를 설치하면 된다.

```bash
$ sudo yum install amazon-cloudwatch-agent # Agent 설치

$ sudo mkdir -p /usr/share/collectd/
$ sudo touch /usr/share/collectd/types.db
```

#### Agent 설정

자주쓰이는 로그파일을 CloudWatch Log Stream에 보낼 수 있다.

아래 항목을 Log Stream에 보내보자
- /var/log/messages : 시스템의 표준 에러관련 메세지가 기록되는 파일
- /var/log/secure : 접속과 관련하여 언제 어디서 어떤 서비스를 사용했는지 기록되는 파일
- /var/log/cron : cron 데몬이 실행했던 작업을 기록

아래 스크립트에서 이루어지는 내용은 다 default로 설정한다.

```bash
$ sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-config-wizard # 설정 시작

=============================================================
= Welcome to the AWS CloudWatch Agent Configuration Manager =
=============================================================
On which OS are you planning to use the agent?
1. linux
2. windows
default choice: [1]:

Trying to fetch the default region based on ec2 metadata...
Are you using EC2 or On-Premises hosts?
1. EC2
2. On-Premises
default choice: [1]:

Which user are you planning to run the agent?
1. root
2. cwagent
3. others
default choice: [1]:

Do you want to turn on StatsD daemon?
1. yes
2. no
default choice: [1]:

Which port do you want StatsD daemon to listen to?
default choice: [8125]

What is the collect interval for StatsD daemon?
1. 10s
2. 30s
3. 60s
default choice: [1]:

What is the aggregation interval for metrics collected by StatsD daemon?
1. Do not aggregate
2. 10s
3. 30s
4. 60s
default choice: [4]:

Do you want to monitor metrics from CollectD?
1. yes
2. no
default choice: [1]:

Do you want to monitor any host metrics? e.g. CPU, memory, etc.
1. yes
2. no
default choice: [1]:

Do you want to monitor cpu metrics per core? Additional CloudWatch charges may apply.
1. yes
2. no
default choice: [1]:

Do you want to add ec2 dimensions (ImageId, InstanceId, InstanceType, AutoScalingGroupName) into all of your metrics if the info is available?
1. yes
2. no
default choice: [1]:

Would you like to collect your metrics at high resolution (sub-minute resolution)? This enables sub-minute resolution for all metrics, but you can customize for specific metrics in the output json file.
1. 1s
2. 10s
3. 30s
4. 60s
default choice: [4]:

Which default metrics config do you want?
1. Basic
2. Standard
3. Advanced
4. None
default choice: [1]:

Current config as follows:
{
	"agent": {
		"metrics_collection_interval": 60,
		"run_as_user": "root"
	},
	"metrics": {
		"append_dimensions": {
			"AutoScalingGroupName": "${aws:AutoScalingGroupName}",
			"ImageId": "${aws:ImageId}",
			"InstanceId": "${aws:InstanceId}",
			"InstanceType": "${aws:InstanceType}"
		},
		"metrics_collected": {
			"collectd": {
				"metrics_aggregation_interval": 60
			},
			"disk": {
				"measurement": [
					"used_percent"
				],
				"metrics_collection_interval": 60,
				"resources": [
					"*"
				]
			},
			"mem": {
				"measurement": [
					"mem_used_percent"
				],
				"metrics_collection_interval": 60
			},
			"statsd": {
				"metrics_aggregation_interval": 60,
				"metrics_collection_interval": 10,
				"service_address": ":8125"
			}
		}
	}
}
Are you satisfied with the above config? Note: it can be manually customized after the wizard completes to add additional items.
1. yes
2. no
default choice: [1]:

Do you have any existing CloudWatch Log Agent (http://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/AgentReference.html) configuration file to import for migration?
1. yes
2. no
default choice: [2]:

# 여기서부터는 어떤 로그파일을 수집할지 설정
Do you want to monitor any log files?
1. yes
2. no
default choice: [1]:

Log file path:
/var/log/messages
Log group name:
default choice: [messages]

Log stream name:
default choice: [{instance_id}]

Do you want to specify any additional log files to monitor?
1. yes
2. no
default choice: [1]:

Log file path:
/var/log/secure
Log group name:
default choice: [secure]

Log stream name:
default choice: [{instance_id}]

Do you want to specify any additional log files to monitor?
1. yes
2. no
default choice: [1]:

Log file path:
/var/log/cron
Log group name:
default choice: [cron]

Log stream name:
default choice: [{instance_id}]

Do you want to specify any additional log files to monitor?
1. yes
2. no
default choice: [1]:
2
Saved config file to /opt/aws/amazon-cloudwatch-agent/bin/config.json successfully.
Current config as follows:
{
	"agent": {
		"metrics_collection_interval": 60,
		"run_as_user": "root"
	},
	"logs": {
		"logs_collected": {
			"files": {
				"collect_list": [
					{
						"file_path": "/var/log/messages",
						"log_group_name": "messages",
						"log_stream_name": "{instance_id}"
					},
					{
						"file_path": "/var/log/secure",
						"log_group_name": "secure",
						"log_stream_name": "{instance_id}"
					},
					{
						"file_path": "/var/log/cron",
						"log_group_name": "cron",
						"log_stream_name": "{instance_id}"
					}
				]
			}
		}
	},
	"metrics": {
		"append_dimensions": {
			"AutoScalingGroupName": "${aws:AutoScalingGroupName}",
			"ImageId": "${aws:ImageId}",
			"InstanceId": "${aws:InstanceId}",
			"InstanceType": "${aws:InstanceType}"
		},
		"metrics_collected": {
			"collectd": {
				"metrics_aggregation_interval": 60
			},
			"disk": {
				"measurement": [
					"used_percent"
				],
				"metrics_collection_interval": 60,
				"resources": [
					"*"
				]
			},
			"mem": {
				"measurement": [
					"mem_used_percent"
				],
				"metrics_collection_interval": 60
			},
			"statsd": {
				"metrics_aggregation_interval": 60,
				"metrics_collection_interval": 10,
				"service_address": ":8125"
			}
		}
	}
}
Please check the above content of the config.
The config file is also located at /opt/aws/amazon-cloudwatch-agent/bin/config.json.
Edit it manually if needed.
Do you want to store the config in the SSM parameter store?
1. yes
2. no
default choice: [1]:

What parameter store name do you want to use to store your config? (Use 'AmazonCloudWatch-' prefix if you use our managed AWS policy)
default choice: [AmazonCloudWatch-linux]

Trying to fetch the default region based on ec2 metadata...
Which region do you want to store the config in the parameter store?
default choice: [ap-northeast-2]

Which AWS credential should be used to send json config to parameter store?
1. ASIA4V5J5GVGHXRHWYEL(From SDK)
2. Other
default choice: [1]:

Successfully put config to parameter store AmazonCloudWatch-linux.
Program exits now.
```

#### Agent 실행

방금 설정한 config file을 가지고 이제 Agent를 실행해보자

```bash
$ sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json
```

#### 대시보드에서 확인

1. CloudWatch에 CWAgent가 생겼다.
![](/assets/2021-03-14-cloudwatch-agent/2021-03-14-cloudwatch-agent_024834.png)

1. 설정한 3개의 로그파일 확인
![](/assets/2021-03-14-cloudwatch-agent/2021-03-14-cloudwatch-agent_095104.png)

1. 로그파일에서 secure만 잠깐 들어와서보면 /var/log/secure 에 있는 내용이 그대로 들어와있음을 볼 수 있다.
![](/assets/2021-03-14-cloudwatch-agent/2021-03-14-cloudwatch-agent_185153.png)


기본 설정으로 메트릭이 몇 개 안보이는데 [수집할 수 있는 Metric](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/metrics-collected-by-CloudWatch-agent.html#linux-metrics-enabled-by-CloudWatch-agent) 종류를 확인하고 [config 파일을 수정](https://docs.aws.amazon.com/ko_kr/AmazonCloudWatch/latest/monitoring/CloudWatch-Agent-Configuration-File-Details.html)하면 된다.

## 맺으며

- 모니터링 시스템은 효율적으로 쓰면 트러블슈팅에 들이는 시간을 매우 줄일 수 있는 것 같다.

- CloudWatch는 내부적으로 [CollectD](https://github.com/collectd/collectd)와 [StatsD](https://github.com/statsd/statsd)를 사용해 
설정된 시간마다 System Resource로부터 데이터를 수집하고 CloudWatch에 데이터를 보내는 것 같다. 

- 어디선가 들어본 [프로메테우스](https://github.com/prometheus/prometheus), [그라파나](https://github.com/grafana/grafana)도 모니터링 관련 도구라고 하니 나중에 참고해보자.

## 참고 자료

[https://github.com/awslabs/collectd-cloudwatch](https://github.com/awslabs/collectd-cloudwatch)

[https://aws.amazon.com/about-aws/whats-new/2017/07/amazon-cloudwatch-introduces-high-resolution-custom-metrics-and-alarms/](https://aws.amazon.com/about-aws/whats-new/2017/07/amazon-cloudwatch-introduces-high-resolution-custom-metrics-and-alarms/)

[https://github.com/aws/amazon-cloudwatch-agent](https://github.com/aws/amazon-cloudwatch-agent)

[https://geek-university.com/linux/var-log-messages-file/](https://geek-university.com/linux/var-log-messages-file/)