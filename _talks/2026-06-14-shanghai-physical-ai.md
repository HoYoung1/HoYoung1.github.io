---
title: "Physical AI in China"
collection: talks
type: "Talk"
permalink: /talks/2026-06-13-shanghai-physical-ai
venue: 上海
date: 2026-06-13
location: "上海世博展览馆 (Shanghai World Expo Exhibition & Convention Center)"
---

Physical AI in China
상하이 박람회에서 본 피지컬 AI

# 상하이 박람회에서 본 피지컬 AI (CSITF)

## 서론

어제 상하이에서 열린 박람회(CSITF, China (Shanghai) International Technology Fair)에 다녀왔다.  
최근에 피지컬 AI쪽에 관심이 생겼는데, 사실 잘은 모른다 ㅠ 그래서 직접 보고 이때의 느낌을 남겨두고자 포스팅

## 본론

### 1. 휴머노이드는 이제 '걷는 것'을 넘었다

작년만 해도 로봇이 걷고 균형 잡는 게 신기했는데, 이번엔 한 단계 더 가있었다.  
가장 인상 깊었던 건 한복입고 북치는 휴머노이드들. LinkerBot 부스였는데, 단체로 악기 연주를 한다.

[https://youtu.be/_t83lZeVpXU?list=TLPQMTQwNjIwMjZtv2nkceIE5g&t=56](https://youtu.be/_t83lZeVpXU?list=TLPQMTQwNjIwMjZtv2nkceIE5g&t=56)

<- ytn 에서도 휴머노이드에 대해 다루면서 해당 회사가 언급되길래 링크 같이.

![](/assets/2026-06-14-shanghai-humanoid.jpg)

이 외에도 Unitree(宇树) G1, magiclab(魔法原子)의 로봇개 + 판다 로봇, 北京人形(天工) 같은 휴머노이드들이 곳곳에 있었다.

![](/assets/2026-06-14-shanghai-unitree.jpg)

Unitree 로봇이 복싱하는 걸 보고 싶었는데, 내가 갔을 땐 그냥 서있는 것만 봤다 ㅋ 춤추는 로봇이 안 끝나서 계속 기다리다가 결국 복싱하는건 못봄..

[https://youtu.be/Xl_ZEwCq59o](https://youtu.be/Xl_ZEwCq59o)

<- 근데 춤추는것도 볼만하긴함. 점프 ㄷㄷ

### 2. 의외로 BCI(Brain-Computer Interface) 관련 부스도 꽤 있었다.

피지컬 AI(휴머노이드) 보러 갔는데 뇌-컴퓨터 인터페이스 부스가 곳곳에 있었다. 교양사아라는 중국드라마에서 해당 연구에 대한 소재가 아주 살짝 나오긴해서 음.. 키워드 정도만 알고있긴했는데 실제로 관련 부스가 꽤 있었음

![](/assets/2026-06-14-shanghai-bci.jpg)

침습형(Invasive) / 반침습형 / 비침습형(EEG)을 나눠서 설명해놓은 게 인상 깊었다. (사실 지인이 설명해줬으나 잘 모르는 분야라 사진만 냅다..)

일론머스크, Neuralink 이런 키워드들도 간혹 들렸다.  

### 3. 완제품만이 아니라 '부품'까지 다 있더라

로봇 본체뿐 아니라 그 안에 들어가는 부품 회사들이 같이 나와있었다.  
- Sinomags(希磁科技) / SENSITEC : 로봇 관절에 들어가는 자기식 엔코더  
- SEAVO(信步科技) : 임바디드(具身) AI 메인보드  
- HYGON(海光) : AI 칩(CPU/GPU)  

생태계가 '센서·칩 → 모터/관절 → 본체 → 응용'까지 수직으로 쫙 깔려있는 게 보였다. 이러니 빠를 수밖에.

### 4. 의료·생활 로봇

- Puncture Robotic : 모발이식 로봇. 와 이게 진짜 되나 싶기도했다..

![](/assets/2026-06-14-shanghai-hairtransplant.jpg)

- SEAVO : 병원 배송 로봇  
- 페이셜 케어 로봇 (AI+생활 존)  
- ULS Robotics(傲鲨)의 VIATRIX : 입는 외골격(exoskeleton)

전시용 컨셉인지는 모르겠으나 아마 결국 프로덕션(실생활)까지 자리잡겠지..

### 5. MiniMax

들어가서 기업 리스트들을 보는데 minimax 가 있어서 깜짝 놀랐다. LLM 회사아닌가? ㅋㅋ 바로 여기로 갔는데, 하필 마지막 날에 가서 이미 철수한 뒤였다 ㅠ 빈 부스만 찍고 옴..

![](/assets/2026-06-14-shanghai-minimax.jpg)

참고로 MiniMax가 뭘로 돈 버나 궁금해서 봤더니, 자체 LLM뿐 아니라 영상·음성 생성 모델, 그리고 해외용 AI 캐릭터 챗앱(Talkie 등) 같은 서비스로 매출을 내는 구조였다. 다음에 또 오면 꼭 봐야지.

### 6. LLM이 피지컬 AI를 키운다

전부터 궁금했던 게 'LLM의 진화가 physical AI를 키웠나?'였다.

예전 로봇은 '이 동작 해' 하고 일일이 프로그래밍해야 했는데, 지금은 LLM/멀티모달 모델이 로봇의 '뇌(인지·계획)' 역할을 하고, 로봇 몸체가 그걸 실행하는 구조다.  
"눈으로 보고(Vision) → 말로 알아듣고(Language) → 몸으로 행동(Action)" 하는 VLA 라는 키워드도 간혹 보였다. LLM이 똑똑해지니까 로봇이 알아서 판단하는 폭이 확 넓어진 것.

## 마무리

피지컬 AI 잘 몰랐는데, 직접 와서 보니 확 와닿았다.  
LLM이 뇌를 맡고, 중국이 부품부터 본체까지 생태계를 깔아놓은듯하다. 게다가 BCI까지 같이 달리고 있는 그림.. 

나도 맡은 자리에서 열심히 일해야지...

아래 참고의 둘러본 회사들과 위에 적혀있는 기업명들은 gemini 가 사진으로 부터 추출한것들이어서 기업명은 살짝 틀릴 수 있다.

## 참고 (둘러본 회사들)

| 회사명 | 중국어 법인명 |
|---|---|
| Galileo | 伽利略（天津）技术有限公司 |
| Huayan Robotics | 广东华沿机器人股份有限公司 |
| SEAVO | 深圳市信步科技有限公司 |
| LinkerBot | 灵心巧手（北京）科技有限公司 |
| Puncture Robotic | 磅客策（上海）智能医疗科技有限公司 |
| MiniMax | 稀宇科技 (MiniMax) |
| HYGON | 海光信息技术股份有限公司 |
| Sinomags | 希磁科技 (安徽龙磁科技股份有限公司) |
| Xiang Nong | 香农科技 (浙江香农科技有限公司) |
| MENGW | 梦舞 (上海梦舞智能科技有限公司) |
| Easephys | 以泽研思 (深圳以泽研思脑电研究中心) |
| BiAi | 必爱智能 (深圳市必爱智能生命科技有限公司) |
| MeHow | 深圳市美好创亿医疗科技股份有限公司 |
