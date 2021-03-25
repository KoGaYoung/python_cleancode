# python_cleancode
python clean code keyword for organizing

# 작성한 예제
https://colab.research.google.com/drive/1pnsDghe_PSyNUhFQ-RMe0lV3duQTlKqp#scrollTo=Jk6x04bIunri


# 1. docstring
### 주석은 불필요하다. 적절한 변수명, 함수명, 로직만으로 이해할 수 있는 코드가 좋은코드
### 함수, 클래스내부에서 작은따움표''' ''' 나 큰 따움표 """  """로 설명, param, return 을 설명해주는게 좋음


def get_int_format(st):
  '''
  스트링으로 받아온 데이터를 숫자로 리턴해줍니다.
  공백이 들어올 경우 0을 리턴해줍니다.
  :param st: 문자타입의 숫자, 혹은 공백
  :return number
  '''
  if st == '':
    return 0
  else:
    return int(st)

get_int_format.__doc__
    
![image](https://user-images.githubusercontent.com/36693355/112234037-f2128500-8c7e-11eb-8384-e49047b8b822.png)

 
---
### 헝가리안 문법(변수나 함수명에 타입과 기능 설명하는 문법 더이상 사용 X - 수정될 때 마다 변수명 함수명 다 바꿔줘야하는 불편함
### 변수명에 타입명 기재 필요 X ex) 올바른표현 name = [] 올바르지않은표현 name_list = []
---
#2. Annotation
### 타입값과 리턴값의 힌트를 줌.
### docstring과 상호보안적

class annotaion_class_example:
  '''
  Annotaion 예제를 확인하기 위한 class 입니다.
  __annotations__ 속성을 통해 
  class에 할당되는 파라미터의 타입을 확인할 수 있습니다.
  '''
  first_param : str

  def set_first_param(self, value: str) -> None:
    '''
    annotaion_class_example 클래스의
    first_param 값을 바인딩해줍니다.
    함수의 반환값은 없습니다
    '''
    self.first_param = value


def main():
  class_instance1 = annotaion_class_example()
  print(class_instance1.__annotations__)
  print(class_instance1.set_first_param.__annotations__)
  
if __name__ == '__main__':
    main()
    
    
    
![image](https://user-images.githubusercontent.com/36693355/112398480-a7a90b00-8d47-11eb-885f-5e529af5b1a2.png)

