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

## **Asterisk(*)**
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
```python
class items:
  def __init__(self, *value):
    self._value = list(value)
    print(*value)      # 12345 123
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
product() 함수가 가변인자를 받고 있기 때문에 우리는 리스트의 데이터를 모두 unpacking(*value)하여 함수에 전달해야한다.
이 경우 함수에 값을 전달할 때 *primes와 같이 전달하면 primes 리스트의 모든 값들이 unpacking되어 numbers라는 리스트에 저장된다. 
만약 이를 primes 그대로 전달한다면 이 자체가 하나의 값으로 쓰여 numbers에는 primes라는 원소가 하나 존재하게 된다.

## 2.2 자체 시퀀스 생성
```python
class items:
  def __init__(self, *value):
    self._value = list(value)
    
  def __len__(self):
    return len(self._values)
    
  def __getitem__self.item):
    return self._values.__getitem__(item)
```
