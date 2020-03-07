---
title: 'Next Permutation 다음 순열'
date: 2020-03-07  
permalink: /posts/algorithm/2020-03-07-algorithm-next-permutation
tags:
  - algorithm
  - next_permutation 
---

# Next Permutation 알고리즘

DFS로만 순열을 구해왔는데, 특정 순열이 있을 때 딱 그 순열의 다음 순열만을 구해오는
**next_permutation**을 알게되어, 간단히만 기록해보자.

엄청 잘 나와있는 블로그가 있다. 자세한 설명은 [여기](https://jins-dev.tistory.com/entry/%EB%8B%A4%EC%9D%8C-%EC%88%9C%EC%97%B4-%EC%B0%BE%EA%B8%B0-%EC%A0%84%EC%B2%B4-%EC%88%9C%EC%97%B4-%ED%83%90%EC%83%89-%EC%95%8C%EA%B3%A0%EB%A6%AC%EC%A6%98-Next-Permutation)로

## Flow

1. 먼저, 순열의 전체를 순회하면서(O(n)) N[i] < N[i+1] 인 가장 마지막 i 를 구해낸다
(이때 i가 존재하지 않는다면, 해당 순열이 가장 마지막 순열이 된다.)

2. 배열의 끝부터 좀전에 구해낸 i 까지 오면서 N[j] > N[i] 인 위치, 즉 N[i] 보다 큰 가장 마지막 Element 를 찾아내고, 이 위치를 J 라고 정한다.
(N[i] < N[i+1] 인 위치를 찾고 i라고 정했기 때문에, J는 무조건 존재한다.)

3. i+1부터 수열의 마지막까지 Reverse 해주면 된다.
