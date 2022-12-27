---
title: 'coupang-image-search #2 PoC'
date: 2022-12-27
permalink: /posts/coupang-image-search/poc
tags:
  - coupang image search
  - milvus
---

# coupang image search #2 PoC

## 컨셉검증

우선 딱 5장만 가지고 상품을 찾는지 검증해 보려고 한다.

초코파이, 신라면, 바나나우유, 카누, 키크론키보드
이렇게 5장의 이미지(상품)를 미리 업로드해놓은 다음에, 찾고 싶은 이미지(상품)를 업로드하면 가장 유사한 이미지 순으로 정렬해서 보여주는 시스템. 

사실 '순서'는 관심사 밖이고 내가 찾고자 하는 상품이 첫 번째로 나오면 성공이다. 

![](/assets/2022-12-26-22-50-21.png)

우리 집에 있는 초코파이 중국판의 사진을 찍어 검색했더니 초코파이 상품을 찾아준다. 굿!!

![](/assets/2022-12-26-22-47-05.png)

키크론 키보드를 업로드하니 키크론 키보드 이미지가 가장 첫 번째로 나온다. 굿~~~

어느 정도 되긴하나보다.

그다음에 카누를 업로드해 보았는데ㅜ

![](/assets/2022-12-26-22-48-23.png)

초코파이가 1등, 카누가 2등으로 나온다 ㅜㅜ 스틱과 포장박스는 사실 다르긴 하지만.. 다른 이미지보다는 그래도 충분히 비슷한것 같은데ㅜ 초코파이가 1등으로 나오다니..

이를 어찌할꼬 고민하다가 카누이미지를 하나 더 추가해서 다시 시도해보았다. 

![](/assets/2022-12-26-22-54-08.png)

다행히도 새로 추가한 카누 이미지가 가장 가깝다고 결과가 나왔다.
이정도로 만족하고 넘어가자~

결론 : 대~~충은 돌아갈 것 같기도하다~

## 사용한 기술 스택 간단히 설명

[milvus](https://milvus.io/)와 [Towhee](https://towhee.io/) 를 사용했다.  

milvus란?  
> Vector database built for scalable similarity search  

towhee란?
> Towhee is an open-source machine learning pipeline that helps you encode your unstructured data into embeddings

라고 한다.

처음엔 [엘라스틱서치 similarity search](https://www.elastic.co/kr/what-is/vector-search)로 하려고 했는데 리서치 하다가 milvus라는 걸 발견했다. 문서도 잘되어있고 무엇보다 [bootstrap으로 쉽게 따라 할 수 있는 프로젝트](https://github.com/milvus-io/bootcamp/tree/master/solutions/image/reverse_image_search/quick_deploy)가 있어서(심지어 ui까지 있다) 이것으로 진행하기로 결정.
그리고 scalable 하다고 하니 데이터를 많이 늘려 테스트 해 보고 싶기도 했다.

## 맺으며

어떻게 해야 모델의 성능을 더 높일까? 학습은 어떻게 해야 할까? 등 이런 것들까지 검증해 보긴 어려울 것 같다. 공부도 해야 할 것 같고.. 

그래도 오늘 소개한 이 기술 스택들과 컨셉이 내가 하려고 하는 이미지 검색 프로젝트에 어느 정도 부합할 것 같다는 검증은 된 것 같다.

다음 스텝을 진행해보자.


## 참고 자료

- [https://milvus.io/](https://milvus.io/)
- [https://towhee.io/](https://towhee.io/)
- [https://github.com/milvus-io/milvus](https://github.com/milvus-io/milvus)
- [https://github.com/milvus-io/bootcamp](https://github.com/milvus-io/bootcamp)
- [https://github.com/towhee-io/towhee](https://github.com/towhee-io/towhee)