---
title: '파이썬으로 보는 solid 원칙'
date: 2020-12-08
permalink: /posts/oop/2020-12-08-oop-design-pattern-02
tags:
  - python
  - oop
  - design pattern
---

# 파이썬으로 보는 solid 원칙

저번 포스팅에서 solid원칙이 이해가 잘 안되서 코드로 직접 준비해봤다.  
~~수학책으로 이해가 안되면 수학 익힘책을 준비하자!!~~

## 단일 책임 원칙(Single Responsibility Principle)


```python
"""
클래스는 하나의 일만 해야한다. 
만약 클래스가 두 개 이상의 책임을 가진다면 
결합(couple)되버린다. 
즉, 하나의 변경이 다른 책임의 변경으로도 이어져버린다.
"""


class Animal:
    def __init__(self, name: str):
        self.name = name
    
    def get_name(self) -> str:
        pass

    def save(self, animal: Animal):
        pass


"""
Animal 클래스는 SRP를 위반했다.

왜??

SRP는 하나의 책임을 가지는 것을 의미한다. 
우리는 위에서 두 개의 책임을 찾을 수 있다.

1. animal database 관리
2. animal properties 관리

constructor와 get_name은 
Animal properties를 관리하는 반면
save함수는 Animal storage database를 관리한다.

이 디자인이 나중에 어떤 결과를 초래할까?

만약 database management function만 변경된다하더라도
Animal properties function만을 사용하는 클래스도 
새로운 변경에 의해 영향을 받는다.

도미노 효과라고도 할 수 있는데, 하나의 카드만 변경했지만, 
다른 모든 카드가 영향을 받아버리는 것을 의미한다.

SRP에 맞게 animal 저장을 하는 다른 클래스를 만들어보자
"""

class Animal:
    def __init__(self, name: str):
        self.name = name
    
    def get_name(self):
        pass

class AnimalDB:
    def get_animal(self, id) -> Animal:
        pass
    
    def save(self, animal: Animal):
        pass

"""
클래스를 디자인할 때, 
'관련된 기능들을 함께 넣는 것'에 초점을 맞춰야한다. 
그래서 변경하려 할 때마다 같은 이유로 변경되어야 한다. 
그리고 다른 이유로 변경되려한다면, 기능을 분리해야한다.
"""

"""
이 솔루션에 단점은 이 코드를 사용하는 쪽에서 
두 개의 클래스를 다뤄야 한다는 것이다. 
이러한 딜레마의 해결책은 Facade pattern을 적용하는 것이다. 

Animal 클래스는 animal database 관리와 
animal properties 관리를 위한 
Facade가 될 것이다.
"""

class Animal:
    def __init__(self, name: str):
        self.name = name
        self.db = AnimalDB()

    def get_name(self):
        return self.name
    
    def get(self, id):
        return self.db.get_animal(id)
    
    def save(self):
        self.db.save(animal=self)
```

### 개방-폐쇄 원칙(The open/Close Principle)

```python
"""
Software Entity(Classes, modules, functions)는 
확장에는 열려있어야하고 변경에는 닫혀있어야한다.
"""

class Animal:
    def __init__(self, name: str):
        self.name = name
    
    def get_name(self) -> str:
        pass

animals = [
    Animal('lion'),
    Animal('mouse')
]

def animal_sound(animals: list):
    for animal in animals:
        if animal.name == 'lion':
            print('roar')
        elif animal.name == 'mouse':
            print('squeak')

animal_sound(animals)

"""
animal_sound 함수는 open-closed 원칙을 위반했다.

왜??

만약 새로운 동물이 추가되면, 
우리는 animal_sound 함수를 변경해야 한다. 
이것은 정말 단순한 예제이지만, 
어플리케이션이 커지고 복잡해진다면?

이런 상태가 계속 계속 반복될 것이고, 
결국 새로운 동물을 추가할 때 
어플리케이션의 많은 요소를 바꿔야 할지도 모른다.
"""

animals = [
    Animal('lion'),
    Animal('mouse'),
    Animal('snake')
]

def animal_sound(animals: list):
    for animal in animals:
        if animal.name == 'lion':
            print('roar')
        elif animal.name == 'mouse':
            print('squake')
        elif animal.name == 'snake':
            print('hiss')

animal_sound(animals)

"""
OCP 를 충족하도록 바꾸어보자
"""

class Animal():
    def __init__(self, name:str):
        self.name = name
    
    def get_name(self) -> str:
        pass
    
    def make_sound(self) -> str:
        pass

class Lion(Animal):
    def make_sound(self):
        return 'roar'

class Mouse(Animal):
    def make_sound(self):
        return 'squeak'

class Snake(Animal):
    def make_sound(self):
        return 'hiss'

def animal_sound(animals: list):
    for animal in animals:
        print(animal.make_sound())

animal_sound(animals)

"""
Animal 클래스는 이제 virtual method 를 가진다. 
각 동물 클래스들은 Animal class 를 상속받고 
virtual method인 make_sound 를 구현하도록 한다.

이제, 새로운 동물을 추가한다고 하더라도 
animal_sound 는 변경되지 않는다. 
새로운 동물을 animals Array에 추가하기만 하면 된다.

이제 animal_sound 는 OCP 원칙을 지킨다고 볼 수 있다.
"""

"""
다른 예시 :

가게를 생각해보자. 
아래 클래스는 고객에게 20% 할인 제공한다.
'더블 할인'을 VIP 고객에게 주고 싶으면
아래처럼 코드를 변경할지도 모른다.
"""

class Discount():
    def __init__(self, customer, price):
        self.customer = customer
        self.price = price
    
    def give_discount(self):
        if self.customer == 'fav':
            return self.price * 0.2
        if self.customer == 'vip':
            return self.price * 0.4

"""
위 코드도 OCP 원칙을 지키지 못한다. 

새로운 할인 퍼센트를 제공하고 싶을 때, 
새로운 고객 유형을 넣고 싶을때, 
새로운 '로직'도 추가되어버린다.

OCP 원칙을 지키도록 만드려면
우리는 Dicount 클래스를 확장한 새로운 클래스를 만들어야 한다.
"""

class Discount:
    def __init__(self, customer, price):
        self.customer = customer
        self.price = price
    
    def get_discount():
        return self.price * 0.2
    
class VIPDiscount(Discount):
    def get_discount():
        return super().get_discount() * 2

"""
만약 super VIP customers에게 80% 할인을 주고 싶으면 
아래처럼 구현하면된다.
'수정 없이 확장'하는 것을 볼 수 있다.
"""

class SuperVIPDiscount(VIPDiscount):
    def get_discount():
        return super().get_discount() * 2
```

### 리스코프 치환 원칙(Liskov Substitution Principle)

```python
"""
자식 클래스는 부모 클래스를 대체 할 수 있어야 한다. 
이 원칙의 핵심은 자식클래스가 부모 클래스를 
에러 없이 대체 할 수 있다는 것을 의미한다.

만약 코드가 클래스의 '타입'을 체크한다면, 
이 원칙을 위반했음에 틀림없다.

Animal 예시를 사용해보자.
"""

def animal_leg_count(animals: list):
    for animal in animals:
        if isinstance(animal, Lion):
            print(lion_leg_count(animal))
        elif isinstance(animal, Mouse):
            print(mouse_leg_count(animal))
        elif isinstance(animal, Pigeon):
            print(pigeon_leg_count(animal))

animal_leg_count(animals)

"""

만약 부모 클래스(Animal)가 
부모 클래스 타입 파라미터를 받는 method를 가지면, 
그것의 자식 클래스(Pigeon)는 
부모 클래스의 타입(Animal type) 혹은 
자식 클래스 타입(Pigeon type)을 argument로 받아야한다.

만약 부모클래스가 부모 클래스의 타입(Animal)을 리턴한다면 
자식 클래스는 부모클래스의 타입(Animal type) 혹은 
자식클래스의 타입(Pigeon)을 리턴해야 한다. 

animal_leg_count 함수를 다시 구현해보자.
"""

def animal_leg_count(animals: list):
    for animal in animals:
        print(animal.leg_count())

animal_leg_count(animals)

"""
animal_leg_count 함수는 
Animal 타입에 신경쓰지 않는다. 
그냥 leg_count method를 호출한다. 

확실한건 인자는
Animal 클래스 혹은 그 자식 클래스라는 것이다. 

이제 Animal 클래스는 leg_count method 를 가져야만 한다. 
그리고 자식 클래스도 leg_count method를 꼭 구현 해야한다.
"""

class Animal:
    def leg_count(self):
        pass

class Lion(animal):
    def leg_count(self):
        return 4

"""
LSP원칙에 대해 다시 생각해보자.
이제 animal_leg_count는 
leg count를 위해 Animal의 타입을 알 필요가 전혀 없다. 

Animal 클래스와 자식 클래스는 
leg_count method를 가지고 있으므로,

animal_leg_count 함수는 
leg_count method를 호출 하기만 하면 된다. 
"""
```

### 인터페이스 분리 원칙(The Interface Segregation Principle)

```python
"""
클라이언트별로 세밀한 인터페이스를 만들 것.
클라이언트는 사용하지 않는 인터페이스에 의존하도록 
강제 되어져서는 안된다.

이 원칙은 커다란 인터페이스를 구현할때의 단점을 다룬다.

아래의 IShape 인터페이스를 보자
"""
class IShape:
    def draw_square(self):
        raise NotImplementedError
    
    def draw_rectangle(self):
        raise NotImplementedError
    
    def draw_circle(self):
        raise NotImplementedError

"""
이 인터페이스는 
squares, circles, rectangles를 구현한다.

IShape 인터페이스를 사용하는 
Circle, Sqaure, Rectangle 클래스는 
반드시 위 메소드들을 구현해야 한다.
"""

class Circle(IShape):
    def draw_square(self):
        pass
    
    def draw_rectangle(self):
        pass
    
    def draw_circle(self):
        pass

class Square(IShape):
    def draw_square(self):
        pass
    
    def draw_rectangle(self):
        pass
    
    def draw_circle(self):
        pass

class Rectangle(IShape):
    def draw_square(self):
        pass
    
    def draw_rectangle(self):
        pass
    
    def draw_circle(self):
        pass

"""
좋지 못한 코드임을 한번에 알 수 있다. 
Rectangle 클래스는 
draw_square, draw_circle 을 구현해야하고 
나머지 클래스도 마찬가지로 
필요하지 않은 메소드까지 구현해야한다.

만약 draw_triangle 이라는 메소드를 추가한다고 생각해보자.
"""

class IShape:
    def draw_square(self):
        raise NotImplementedError
    
    def draw_rectangle(self):
        raise NotImplementedError
    
    def draw_circle(self):
        raise NotImplementedError
    
    def draw_triangle(self):
        raise NotImplementedError

"""
클래스들은 새로운 메소드를 구현하지 않으면 에러가 날 것이다.

클라이언트(Rectangle, Circle, Square)는 
자기가 사용하지 않는 메소드에 의존하도록 강제되어서는 안된다. 
또한 ISP는 하나의 작업만 수행해야 한다.
(SRP 원칙처럼) 다른 종류의 행위는 
다른 인터페이스로 추상화해야한다.

IShape interface가 ISP 원칙을 준수하려면 
액션을 다른 인터페이스로 분리해야한다. 
클래스(Circle, Rectangle, Square, Triangle)은 
IShape 인터페이스를 상속받고, 
각자 고유한 draw 행동을 정의할 수 있다.
"""

class IShape;
    def draw(self):
        raise NotImplementError

class Circle(IShape):
    def draw(self):
        pass

class Square(IShape):
    def draw(self):
        pass

class Rectangle(IShape):
    def draw(self):
        pass

"""
Semi Circle, Right-Angled Triangle, 
Equilateral Triangle, Blunt-Edged Rectangle 
등 새로운 Shape 을 만들때 IShape 사용하기만 하면 된다.
"""
```


### 의존 역전 원칙(Dependency Inversion Principle)

```python
"""
세부 구현이 추상화에 의존해야한다. 
추상화가 세부 사항에 의존하는 상황은 바람직하지 않다.
A. High-level 모듈은 Low-level 모듈에 의존해서는 안된다.
B. 추상화는 세부사항에 의존해서는 안된다. 세부사항이 추상화에 의존해야한다.
"""

class XMLHttpService(XMLHttpRequestService):
    pass

class Http:
    def __init__(self, xml_http_service: XMLHttpService):
        self.xml_http_service = xml_http_service
    
    def get(self, url: str, options: dict):
        self.xml_http_service.request(url, 'GET')
    
    def post(self, url: str, options: dict):
        self.xml_http_service.request(url, 'POST')

"""
여기서, Http는 high-level 컴포넌트이고, 
XMLHttpService는 low-level 컴포넌트이다.
이 디자인은 DIP를 위반한다.
A: High-level module은 low-level 모듈에 의존해서는 안된다.
추상화에 의존해야한다.

Http 클래스는 XMLHttpService 클래스를 의존하고 있다.
만약 우리가 Http connection service를 변경하려고 한다면,
아마도 우리는 Http클래스의 모든 인스턴스를 변경해야만 할 것이고, 
이것은 OCP 원칙을 위반할 것이다.

Http 클래스는 Http 서비스의 타입에 대해서는 
신경쓰지 않도록 구현되어야 한다. 

Connection interface를 만들면 된다.
"""

class Connection:
    def request(self, url: str, options: dict):
        raise NotImplementedError

"""
Connection interface는 request method를 가진다. 
Http 클래스는 Connection 타입을 인자로 받게한다.
"""

class Http:
    def __init__(self, http_connection: Connection):
        self.http_connection = http_connection
    
    def get(self, url: str, options: dict):
        self.http_connection.request(url, 'GET')
    
    def post(self, url, options: dict):
        self.http_connection.request(url, 'POST')

"""
그래서 Http connection service 타입에 상관없이, Http는 네트워크에 쉽게 연결할 수 있다.

이제 다시 인터페이스와 함께 XMLHttpService class를 구현해보자
"""

class XMLHttpService(Connection):
    xhr = XMLHttpRequest()

    def request(self, url: str, options: dict):
        self.xhr.open()
        self.xhr.send()

"""
우리는 많은 Http Connection type을 만들 수 있고, 
아무런 에러와 추가 구현 없이 사용할 수 있다.
"""

class NodeHttpService(Connection):
    def request(self, url: str, options: dict):
        pass

class MockHttpService(Connection):
    def request(self, url: str, options: dict):
        pass

"""
이제 우리는 high-level module과 
low-level module이 추상화에 의존한 것을 볼 수 있다.
Http class(high level 모듈)은 Connection interface(abstraction)에 의존하고 
Http service types(low level modules)도 Connection interface(abstraction)에 의존한다.

또한, DIP는 우리가 Liskov Substitution Principle을 위반하지 않도록 강제한다.
Node-XML-MockHttpService Type 모두 부모인 Connection을 대체할 수 있다.
"""
```

## 마무리

사실 이론만 보면 전혀 와닿지 않았는데 적다보니 이해가 좀 간다. 
그리고 나의 잘못된 코드들이 몇 가지 떠오른다..
아직 몸에 완전히 익지 않았지만, 더 많은 예시를 보고 직접 해보며 몸에 익혀야겠다.

## 참고

[https://github.com/heykarimoff/solid.python](https://github.com/heykarimoff/solid.python)