# 2.6 파이썬에서의 밑줄

다른언어들은 public, private, protected가 있지만 파이썬은 전부 public
밑줄을 사용함으로써 private표현 가능. 이왕이면 적재적소에 밑줄을 잘 써주자!

public method : 모든 class에서 해당 method로 접근이 가능하다.<br/>
private method : 자신이 포함된 class에서만 해당 method로 접근이 가능하다.<br/>
protected class : 상속 받은 class와 자신이 속한 class에서만 접근이 가능하다.<br/>


밑줄 한 개는 priavte 표시<br/>
밑줄 두 개는 여러 번 확장되는 클래스의 매서드를 매끄럽게 오버라이드 하기 위함<br/>
남용시 _[class-name]__[attribute]인 경우 Name Mangling 발생

~~~ python
class Connector:
  def __init__(self, source):
    self.source = source   # public
    self._timeout = 60     # correct private
    self.__timeout = 30    # wrong private
    
    def connect(self):
      print("connecting with {0}".format(self._timeout))
      
>>> conn = Connector("www.wehago.com")
>>> conn.connect    # 이런식으로 private요소는 클래스 내부에서만 호출
connectig with 60
>>> conn.__timeout  # 이름 맹글링
attributeError: 'Connector' object has no attribute '__timeout'
~~~

# 2.7 프로퍼티
객체의 속성에 대한 접근을 제어하는 경우 사용한다.<br/>
자바같은 객체지향언어는 접근제어로 게터(getter) 세터(setter)를 사용하는것처럼 파이썬에선 프로퍼티사용
~~~ python
# 이렇게 쓰면 외부에서 자유롭게 접근가능
class Person:
    def __init__(self, first_name, last_name, age):
        self.first_name = first_name
        self.last_name = last_name
        self.age = age 
~~~
~~~python
# getter/setter 메서드를 통해서 객체의 내부 데이터에 대한 접근을 좀 더 통제할 수 있게되었지만,
# 기존에 필드명을 바로 사용할 때 보다는 코드가 조금 지저분해졌습니다. 
# 뿐만 아니라, Person 클래스의 프로그래밍 인터페이스가 변경됨에 따라 하위 호환성도 깨지게 된다는 큰 단점이 있음

class Person:
    def __init__(self, first_name, last_name, age):
        self.first_name = first_name
        self.last_name = last_name
        self.set_age(age)

    def get_age(self):
        return self._age

    def set_age(self, age):
        if age < 0:
            raise ValueError("Invalid age")
        self._age = age
        
person = Person("John", "Doe", 20)
person.get_age()  # 20

person.set_age(person.get_age() + 1)
person.get_age()  # 21
~~~

~~~ python
# 파이썬의 내장 함수인 property()로 필드명을 사용하는 것처럼 깔끔하게 getter/setter 메서드가 호출되게 할 수 있음

class Person:
    def __init__(self, first_name, last_name, age):
        self.first_name = first_name
        self.last_name = last_name
        self.age = age

    def get_age(self):
        return self._age

    def set_age(self, age):
        if age < 0:
            raise ValueError("Invalid age")
        self._age = age

age = property(get_age, set_age)

person = Person("John", "Doe", 20)
person.age  # 20  # 내부적으로 get_age
person.age = person.age + 1  # 내부적으로 set_age
person.age  # 21
~~~

~~~python
# @property 데코레이터 더 간단하게 
class Person:
    def __init__(self, first_name, last_name, age):
        self.first_name = first_name
        self.last_name = last_name
        self.age = age

    @property
    def age(self):
        return self._age

    @age.setter
    def age(self, age):
        if age < 0:
            raise ValueError("Invalid age")
        self._age = age
~~~
모든속성에 get,set(명령-분리원칙)을 활용하는 프로퍼티를 사용할 필요는 없다.<br/>
속성값을 가져오거나 수정할 때 필요한 경우에만 사용하자

# 2.8 이터러블 객체
리스트,
