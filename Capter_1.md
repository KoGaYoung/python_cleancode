# 1.1 docstring
### 주석은 불필요하다(최소한으로). 적절한 변수명, 함수명, 로직만으로 이해할 수 있는 코드가 좋은코드
### 함수, 클래스내부에서 작은따움표''' ''' 나 큰 따움표 """  """로 설명, param, return 을 설명해주는게 좋음

```python
def get_int_format(st):
  '''
  스트링으로 숫자 변환하여 리턴해줍니다.
  공백은 0을 리턴해줍니다.
  
  :param 
          st: 문자타입의 숫자, 혹은 공백
  :return 
          number
  '''
  if st == '':
    return 0
  else:
    return int(st)

get_int_format.__doc__  # 함수의 독스트링 가져오는 방법
```
 
---
### 더이상 헝가리안 문법사용 X - 
#### - 헝가리안 문법이란? 변수나 함수명에 타입과 기능 설명 
#### - 수정될 때 마다 변수명 함수명 다 바꿔줘야하는 불편함
### 변수명에 타입명 기재 필요 X 
#### ex) 올바른표현 name = [] 올바르지않은표현 name_list = []
---
# 1.2 Annotation
### 타입값과 리턴값의 힌트를 줌.
### docstring과 상호보안적
### 예제1)
```python
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
  print(class_instance1.__annotations__)                  # {'first_param': <class 'str'>}
  print(class_instance1.set_first_param.__annotations__)  # {'value': <class 'str'>, 'return': None}
  
if __name__ == '__main__':
    main()
```

### 예제2 - 실무에서 적용해본 view
#### request, Response의 타입값은 ? 디버거 찍어서 
```python
def misuimcheo_monthchange(request: json) -> Response: 
    '''
    초기이월 적용월을 선택합니다. 왼쪽 그리드 수임처들을 갱신하여 리턴합니다.
    1. A 테이블의 미수날짜 update
    2. 미수 테이블의 세무대리인 회사번호, 선택년월~종료년월
    3. 합계 재계산된 왼쪽 그리드 리턴

    :param request:
            cno         : 세무대리인 cno
            da_ym       : 현재 화면상의 초기이월 적용월
            da_accend : 세무대리인 회계종료년월일
    :return:
    '''
    dic = request.data.copy()
    query = misuimcheo_month_change() + misuimcheo_left_select()
    state = status.HTTP_200_OK

    with get_service_connection(request) as cursor:
        cursor.execute(query, dic)
        rows = name_to_json(cursor)

        return Response(status=state, data=rows)
```

