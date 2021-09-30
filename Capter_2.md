# 2. Pythonic Code

## 2.1 인덱싱과 슬라이스
배열 복사 시 아래와 같은 방법을 쓰는게 좋다!

![image](https://user-images.githubusercontent.com/36693355/115388213-905e2000-a216-11eb-84d0-c5f5cdb09324.png)

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
