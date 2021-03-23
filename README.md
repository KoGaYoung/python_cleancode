# python_cleancode
python clean code keyword for organizing


# 1. docstring
### 주석은 불필요하다. 적절한 변수명, 함수명, 로직으로 이해할 수 있는 코드가 좋은코드
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
