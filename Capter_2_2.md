# 2.6 프로퍼티, 속성과 객체의 매서드 다른 타입들

다른언어들은 public, private, protected가 있지만 파이썬은 전부 public
밑줄을 사용함으로써 private표현 가능. 이왕이면 적재적소에 밑줄을 잘 써주자!

public method : 모든 class에서 해당 method로 접근이 가능하다.<br/>
private method : 자신이 포함된 class에서만 해당 method로 접근이 가능하다.<br/>
protected class : 상속 받은 class와 자신이 속한 class에서만 접근이 가능하다.<br/>

## 밑줄 한 개는 priavte 표시
## 밑줄 두 개는 여러 번 확장되는 클래스의 매서드를 매끄럽게 오버라이드 하기 위함
### 남용시 _<class-name>__<attribute>인 경우 Name Mangling 발생

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
