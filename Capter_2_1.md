# 2. Pythonic Code

## 2.1 인덱싱과 슬라이스
문자열, 튜플, 리스트와 같은 이터러블이 있는 시퀀스 객체는 데이터를 가져올 때 반복문 보다 슬라이싱을 해주는게 빠르고 효율적이다.

```python
numbers = [0,1,2,3,4,5,6,7,8,9]
print(numbers[-1])  # 9
print(numbers[-2])  # 8
```
배열 복사 시 아래와 같은 방법을 쓰는게 좋다!
```python
a = [1,2,3,4,5]
b = a[::] # 복사
print(b)  # [1,2,3,4,5]

# 메모리 공유하여 서로 영향 주는지 => 안준다.
a[0] = 0 # 원본배열수정
b[0] = 9 # 복사배열수정
print(a)  # [0,2,3,4,5]
print(b)  # [9,2,3,4,5]
```

## 2.2 **Asterisk(*)**
파이썬에서 **Asterisk(*)**는 다음과 같은 상황에서 사용되는데 크게 4가지의 경우가 있다.

1) 곱셈 및 거듭제곱 연산으로 사용할 때
2) 리스트형 컨테이너 타입의 데이터를 반복 확장하고자 할 때
3) 가변인자 (Variadic Arguments)를 사용하고자 할 때
4) 컨테이너 타입의 데이터를 Unpacking 할 때

4. 언패킹
numbers = [1, 2, 3, 4, 5, 6]
```python
# unpacking의 좌변은 리스트 또는 튜플의 형태를 가져야하므로
# 단일 unpacking의 경우 *a가 아닌 *a,를 사용
*a, = numbers
# a = [1, 2, 3, 4, 5, 6]
# *a = 1 2 3 4 5 6

*a, b = numbers
# a = [1, 2, 3, 4, 5]
# b = 6

a, *b, = numbers
# a = 1
# b = [2, 3, 4, 5, 6]

a, *b, c = numbers
# a = 1
# b = [2, 3, 4, 5]
# c = 6
```

product() 함수가 가변인자를 받고 있기 때문에 우리는 리스트의 데이터를 모두 unpacking(*value)하여 함수에 전달해야한다.
이 경우 함수에 값을 전달할 때 *primes와 같이 전달하면 primes 리스트의 모든 값들이 unpacking되어 numbers라는 리스트에 저장된다.

## 2.3 자체 시퀀스 생성
위의 슬라이스 기능은(ex.[:3] or .[slice(None,3)]) 매직매서드 덕분에 동작
### 매직매서드란? 
파이썬이 내부적으로 이미 구현된(빌트인) 메소드, 기능에 따라 호출하여 사용 <br/>
~~~
(ex. __init__,__doc__,__getitem__,__len__)
매직매서드 정리 잘되있음
https://zzsza.github.io/development/2020/07/05/python-magic-method/
~~~
### 시퀀스란? 
각각의 요소들이 연속적으로 이어진 자료형<br/>
(ex. 리스트, 튜플, 문자열 등)
### 시퀀스생성?
기본 자료형 말고도 우리가 필요한 형태의 시퀀스객체를 만들 수 있다.<br/>
학부때 Cat class, Cat instance 만들던 것 처럼..<br/>
아래 예제는 매직매서드를 사용하여 연속적이지 않은 객체의 특정 요소를 가져오는 방법
```python
class items:
  def __init__(self, *value): 
    self._value = list(value)
    print(*value)      # 12345 123 # 언패킹
    print(self._value) # ['12345', '123']
    
  def __len__(self):
    return len(self._value)
    
  def __getitem__(self, item):
    return self._value.__getitem__(item)

# a = items('12345', '123')
li = ['12345', '123']
a = items(*li)

print(a)                 # <__main__.items object at 0x7f8279ab2750>
print(a[0])              # 12345
print(a.__getitem__(1))  # 123
```

## 2.4 컨택스트 관리자(Context manager)
동작하다 예외처리시엔 Try -> <b>Catch</b>, 동작의 전후엔 Try -> <b>finally</b>
<br/>
프론트 개발자가 이해하기엔, .then()=>{}로 이해해도 무방한것같다.
~~~python
fd = open(filename)
try:
  process_file(fd)
finally:
  fd.close()
~~~
해당코드를 이렇게 수정할 수 있다. with 문에 함수를 추가하여 이후 동작을 진행할 수도 있다.
~~~python  
 with open(filename) as fd:
    process_file(fd)
~~~
지금까지 Django api를 개발하면서 주로 DB와 커넥션을 맺을 때 get_connection_db(request)를 호출하여 사용했다.<br/>
with는 매직매서드 __enter__를 사용<br/>
__enter__의 리턴값을 as에 할당, as는 없어도 무방<br/>
with as 스코프(블록)내의 모든 명령어를 실행한 후에는 __exit__가 실행된다.<br/>
__exit__는 __enter__와 마찬가지로 with구문 안에 있다.<br/>
with의 구문이나 스코프(블록)내의 명령어를 수행하다 오류가 발생하면 __exit__를 실행한다.
~~~python
'''
 백업시스템은 데이터베이스 서비스를 종료한 후에만 진행해야한다.
 백업시스템이 동작하면 성공, 실패와 관계없이 데이터베이스 서비스를 재실행해야한다.
'''


class DataBaseHandle:
  def __enter__(self):
    self.stopDB() # 실행1
    return self #__enter__엔 리턴해주는게 좋은습관!
  def __exit__(self, exc_type, ex_value, ex_traceback):
    self.startDB() # 실행3

  def stopDB(self):
    print("stop Database")
  def startDB(self):
    print("start Database")
    
def backup():
  print("backup processing") # 실행2
  
if __name__ == "__main__":
  with DataBaseHandle():
    backup()
    
    
# stop Database
# backup processing
# start Database
~~~
## 2.5 컨택스트 관리자 구현
항상 클래스로 매직매서드를 상속받아 구현해야 하는가? <b/>
-> @contextlib.contextmanager 데코레이터를 사용하면 해결된다
~~~python
import contextlib

# 매직매서드를 구현하지 않는다
@contextlib.contextmanager
def db_handler():
  stopDB() # 1
  yield ## 위에있으면 enter 아래에 있으면 exit
  startDB()# 3
 
 with db_handler():
  backup() # 2
~~~
~~~python
# 매직매서드를 구현하지만 with문이 없다, 믹스인클래스
def db_handler(contextlib.ContextDecorator):  # 데코레이터 상속받음
  def __enter__(self):
    stopDB()
   
  def __exit(self):
    startDB() # 3

@db_handler   # 1
def context_decorator():
  backup().   # 2
~~~
필요한 기능만 추가하여 확장성 좋음, 캡슐화, 재사용성 좋음
단점: 데코레이터로 함수를 호출하기 떄문에 __enter__, __exit__에서 리턴값을 필요로 할 경우 사용 불가
