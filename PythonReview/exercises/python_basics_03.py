"""
Python 基础练习 03

重点：
1. 函数参数与返回值
2. 嵌套 list / dict
3. try / except 异常处理
4. 简单字符串解析

完成后运行：
python3 PythonReview/exercises/python_basics_03.py
"""


def safe_to_int(value):
    """把 value 转成 int。

    如果转换成功，返回整数。
    如果转换失败，返回 None。

    示例：
    "123" -> 123
    "abc" -> None
    """
    try:
        return int(value)
    except ValueError:
        return None


def calculate_average(numbers):
    """返回数字列表的平均值。

    如果列表为空，返回 0。

    示例：
    [80, 90, 100] -> 90.0
    [] -> 0
    """
    if(len(numbers) == 0):
        return 0.0
    total : float = 0
    for number in numbers:
        total += number
    return total / len(numbers)

def find_student(students, name):
    """按姓名查找学生。

    如果找到，返回整个学生字典。
    如果找不到，返回 None。

    students 示例：
    [
        {"name": "Alice", "score": 90, "city": "Shanghai"},
        {"name": "Bob", "score": 78, "city": "Beijing"},
    ]
    """
    for student in students:
        if(student["name"] == name):
            return student
    return None


def get_city_scores(students):
    """按城市收集学生分数。

    返回值示例：
    {
        "Shanghai": [90, 85],
        "Beijing": [78],
    }
    """
    result = {}
    for student in students:
        if student["city"] in result:
            result[student["city"]].append(student["score"])
        else:
            result[student["city"]] = [student["score"]]
    return result


def parse_query_string(query):
    """解析简单查询字符串，返回字典。

    示例：
    "name=Alice&city=Shanghai&score=90"
    -> {"name": "Alice", "city": "Shanghai", "score": "90"}

    提示：
    先按 "&" 分割，再按 "=" 分割。
    """
    keyAndValues = query.split("&")
    result = {}
    for keyAndValue in keyAndValues:
        parts  =  keyAndValue.split("=")
        result[parts[0]] = parts[1]
    return result


if __name__ == "__main__":
    students_data = [
        {"name": "Alice", "score": 90, "city": "Shanghai"},
        {"name": "Bob", "score": 78, "city": "Beijing"},
        {"name": "Cindy", "score": 85, "city": "Shanghai"},
    ]

    print(safe_to_int("123"))
    print(safe_to_int("abc"))
    print(calculate_average([80, 90, 100]))
    print(calculate_average([]))
    print(find_student(students_data, "Bob"))
    print(find_student(students_data, "Tom"))
    print(get_city_scores(students_data))
    print(parse_query_string("name=Alice&city=Shanghai&score=90"))
