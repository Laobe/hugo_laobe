## - python 的copy方法
编程语言都存在变量的copy，包括shallow copy 和 deep copy

### copy方法
举两个例子：

例子一

```python
# 第一种类型 直接赋值
list_a = [1, 2, 3]
dict_a = {'a': 1, 'b': 2, 'c': 3}

list_b = list_a
dict_b = dict_a

id(list_b) == id(list_a)            # True
id(list_b[1]) == id(list_a[1])      # True
id(dict_b) == id(dict_a)            # True
id(dict_b['a']) == id(dict_a['a'])  # True

# 修改list_b 看看list_a 的变化
list_b.append(4)
list_a       # [1, 2, 3, 4]
list_b       # [1, 2, 3, 4]
list_b[0] = 5
list_a       # [5, 2, 3, 4]
list_b       # [5, 2, 3, 4]

# 修改dict_b看看dict_a 的变化
dict_b['d'] = 4
dict_b       # {'a': 1, 'c': 3, 'b': 2, 'd': 4}
dict_a       # {'a': 1, 'c': 3, 'b': 2, 'd': 4}
dict_b['a'] = 5
dict_b       # {'a': 5, 'c': 3, 'b': 2, 'd': 4}
dict_a       # {'a': 5, 'c': 3, 'b': 2, 'd': 4}
""" 总结：
  这个的结果根据上面的id对比应该可以直接理解把
“”“


# 第二种类型 (shallow copy 浅copy)
import copy
list_a = [1, 2, 3]
dict_a = {'a': 1, 'b': 2, 'c': 3}

list_c = copy.copy(list_a)
dict_c = copy.copy(dict_a)

id(list_c) == id(list_a)            # False
id(list_c[1]) == id(list_a[1])      # True
id(dict_c) == id(dict_a)            # False
id(dict_c['a']) == id(dict_a['a'])  # True

# 修改list_c 看看list_a 的变化
list_c.append(4)
list_c       # [1, 2, 3, 4]
list_a       # [1, 2, 3]
list_c[0] = 5
list_c       # [5, 2, 3, 4]
list_a       # [1, 2, 3]

# 修改dict_c 看看dict_a 的变化
dict_c['d'] = 4
dict_c       # {'a': 1, 'c': 3, 'b': 2, 'd': 4}
dict_a       # {'a': 1, 'c': 3, 'b': 2}
dict_c['a'] = 5
dict_c       # {'a': 5, 'c': 3, 'b': 2, 'd': 4}
dict_a       # {'a': 1, 'c': 3, 'b': 2}
""" 总结：
  这个看出来了吧，list和dict的元素指的id不同，
  修改了元素对原来的list和dict不会做任何改变。
“”“

# 第三种类型 (shallow copy 深copy)
import copy
list_a = [1, 2, 3]
dict_a = {'a': 1, 'b': 2, 'c': 3}

list_d = copy.deepcopy(list_a)
dict_d = copy.deepcopy(dict_a)

id(list_d) == id(list_a)            # False
id(list_d[1]) == id(list_a[1])      # True
id(dict_d) == id(dict_a)            # False
id(dict_d['a']) == id(dict_a['a'])  # True

# 修改list_d 看看list_a 的变化
list_d.append(4)
list_d       # [1, 2, 3, 4]
list_a       # [1, 2, 3]
list_d[0] = 5
list_d       # [5, 2, 3, 4]
list_a       # [1, 2, 3]

# 修改dict_d 看看dict_a 的变化
dict_d['d'] = 4
dict_d       # {'a': 1, 'c': 3, 'b': 2, 'd': 4}
dict_a       # {'a': 1, 'c': 3, 'b': 2}
dict_d['a'] = 5
dict_d       # {'a': 5, 'c': 3, 'b': 2, 'd': 4}
dict_a       # {'a': 1, 'c': 3, 'b': 2}
""" 总结：
  这个的结果看起来跟上浅copy的效果相同。
“”“
```
*上面的例子看出来浅copy跟深copy效果相同，那它们还有区别吗？*
那我们再来看第二个例子吧

例子二
```python
a = [1,2,3]
b = [4,5,6]
list_a = [a, b]
dict_a = {'a': a, 'b': b}

# 第一种类型 直接赋值
list_b = list_a
dict_b = dict_a

id(list_b) == id(list_a)            # True
id(list_b[1]) == id(list_a[1])      # True
id(dict_b) == id(dict_a)            # True
id(dict_b['a']) == id(dict_a['a'])  # True

# 修改list_b 看看list_a 的变化
list_b.append(4)
list_a      # [[1, 2, 3], [4, 5, 6], 4]
list_b      # [[1, 2, 3], [4, 5, 6], 4]
a           # [1, 2, 3]
b           # [4, 5, 6]
list_b[0].append(4)
list_a      # [[1, 2, 3, 4], [4, 5, 6], 4]
list_b      # [[1, 2, 3, 4], [4, 5, 6], 4]
a           # [1, 2, 3, 4]
b           # [4, 5, 6]
list_b[1] = 5
list_a      # [[1, 2, 3, 4], 5, 4]
list_b      # [[1, 2, 3, 4], 5, 4]
a           # [1, 2, 3, 4]
b           # [4, 5, 6]

# 修改dict_b看看dict_a 的变化
dict_b['d'] = 4
dict_b      # {'a': [1, 2, 3, 4], 'b': [4, 5, 6], 'd': 4}
dict_a      # {'a': [1, 2, 3, 4], 'b': [4, 5, 6], 'd': 4}
a           # [1, 2, 3, 4]
b           # [4, 5, 6]
dict_b['a'].append(10)
dict_b      # {'a': [1, 2, 3, 4, 10], 'b': [4, 5, 6], 'd': 4}
dict_a      # {'a': [1, 2, 3, 4, 10], 'b': [4, 5, 6], 'd': 4}
a           # [1, 2, 3, 4, 10]
b           # [4, 5, 6]
dict_b['b'] = 10
dict_b      # {'a': [1, 2, 3, 4, 10], 'b': 10, 'd': 4}
dict_a      # {'a': [1, 2, 3, 4, 10], 'b': 10, 'd': 4}
a           # [1, 2, 3, 4, 10]
b           # [4, 5, 6]
""" 总结：
  这个的结果根据上面的id对比应该可以直接理解把
“”“


# 第二种类型 (shallow copy 浅copy)
import copy
a = [1,2,3]
b = [4,5,6]
list_a = [a, b]
dict_a = {'a': a, 'b': b}
list_c = copy.copy(list_a)
dict_c = copy.copy(dict_a)

id(list_c) == id(list_a)            # False
id(list_c[1]) == id(list_a[1])      # True
id(dict_c) == id(dict_a)            # False
id(dict_c['a']) == id(dict_a['a'])  # True

# 修改list_c 看看list_a 的变化
list_c.append(4)
list_a      # [[1, 2, 3], [4, 5, 6]]
list_c      # [[1, 2, 3], [4, 5, 6], 4]
a           # [1, 2, 3]
b           # [4, 5, 6]
list_c[0].append(4)
list_a      # [[1, 2, 3, 4], [4, 5, 6], 4]
list_c      # [[1, 2, 3, 4], [4, 5, 6], 4]
a           # [1, 2, 3, 4]
b           # [4, 5, 6]
list_c[1] = 5
list_a      # [[1, 2, 3, 4], [4, 5, 6]]
list_c      # [[1, 2, 3, 4], 5, 4]
a           # [1, 2, 3, 4]
b           # [4, 5, 6]

# 修改dict_c看看dict_a 的变化
dict_c['d'] = 4
dict_c      # {'a': [1, 2, 3, 4], 'b': [4, 5, 6], 'd': 4}
dict_a      # {'a': [1, 2, 3, 4], 'b': [4, 5, 6]}
a           # [1, 2, 3, 4]
b           # [4, 5, 6]
dict_c['a'].append(10)
dict_c      # {'a': [1, 2, 3, 4, 10], 'b': [4, 5, 6], 'd': 4}
dict_a      # {'a': [1, 2, 3, 4, 10], 'b': [4, 5, 6]}
a           # [1, 2, 3, 4, 10]
b           # [4, 5, 6]
dict_c['b'] = 10
dict_c      # {'a': [1, 2, 3, 4, 10], 'b': 10, 'd': 4}
dict_a      # {'a': [1, 2, 3, 4, 10], 'b': [4, 5, 6]}
a           # [1, 2, 3, 4, 10]
b           # [4, 5, 6]
""" 总结：
  这个看出来了吧，list和dict的元素指的id不同，
  修改了元素对原来的list和dict不会做任何改变。
“”“


# 第三种类型 (deep copy 深copy)
import copy
a = [1,2,3]
b = [4,5,6]
list_a = [a, b]
dict_a = {'a': a, 'b': b}
list_d = copy.deepcopy(list_a)
dict_d = copy.deepcopy(dict_a)

id(list_d) == id(list_a)            # False
id(list_d[1]) == id(list_a[1])      # False (这里有不同点啦)
id(dict_d) == id(dict_a)            # False
id(dict_d['a']) == id(dict_a['a'])  # False (这里有不同点啦)

# 修改list_d 看看list_a 的变化
list_d.append(4)
list_a      # [[1, 2, 3], [4, 5, 6]]
list_d      # [[1, 2, 3], [4, 5, 6], 4]
a           # [1, 2, 3]
b           # [4, 5, 6]
list_d[0].append(4)
list_a      # [[1, 2, 3], [4, 5, 6]]       (这里也有不同点啦)
list_d      # [[1, 2, 3, 4], [4, 5, 6], 4]
a           # [1, 2, 3]
b           # [4, 5, 6]
list_d[1] = 5
list_a      # [[1, 2, 3], [4, 5, 6]]
list_d      # [[1, 2, 3, 4], 5, 4]
a           # [1, 2, 3]
b           # [4, 5, 6]

# 修改dict_d看看dict_a 的变化
dict_d['d'] = 4
dict_d      # {'a': [1, 2, 3], 'b': [4, 5, 6], 'd': 4}
dict_a      # {'a': [1, 2, 3], 'b': [4, 5, 6]}
a           # [1, 2, 3]
b           # [4, 5, 6]
dict_d['a'].append(10)
dict_d      # {'a': [1, 2, 3, 10], 'b': [4, 5, 6], 'd': 4
dict_a      # {'a': [1, 2, 3], 'b': [4, 5, 6]}  (这里也有不同点啦)
a           # [1, 2, 3]
b           # [4, 5, 6]
dict_d['b'] = 10
dict_d      # {'a': [1, 2, 3, 10], 'b': 10, 'd': 4}
dict_a      # {'a': [1, 2, 3], 'b': [4, 5, 6]}
a           # [1, 2, 3]
b           # [4, 5, 6]
""" 总结：
  这里的结果看起来，deepcopy和shallow copy的结果有点不一样啦。
  原理在那个id判断的不同点上就看出来啦。
“”“
```

### 总结
---
python 的赋值，浅copy，深copy是对对象一层一层的深入copy。赋值只做了对象引用，没任何copy，浅copy只是对对象本身进行了copy，如果对象里面包含其他对象是引用，深copy是对对象的每一层都做了copy

注意： 我们平时使用的list2 = list1[:], dict2 = dict(dict1)。 用这种pythonic的方法来对对象进行copy 达到的效果时什么呢。
从字面意思就能看出来，就是表层做了copy，深层还都是引用。

所以我们在确认对象里面没有再包含list，dict的时候，我们尽量使用list2=list1[:],dict2=dict(dict1) 这种方法，这种方式最pythonic，而且也避免了导入copy包。如果有包含list,dict的时候，就要注意啦。视情况进行copy。


