"""
Python 基础练习 07

重点：
1. 列表推导式
2. 字典推导式
3. lambda 与 sorted
4. 生成器 yield
5. enumerate 与 zip

完成后运行：
python3 PythonReview/exercises/python_basics_07.py
"""


def square_even_numbers(numbers):
    """返回偶数的平方列表。

    要求：
    - 只保留偶数
    - 返回这些偶数的平方

    示例：
    [1, 2, 3, 4] -> [4, 16]

    提示：
    可以使用列表推导式。
    """
    result = [number**2 for number in numbers if(number%2) == 0]
    return result


def build_name_score_map(students):
    """把学生列表转换成 name -> score 的字典。

    示例：
    [
        {"name": "Alice", "score": 90},
        {"name": "Bob", "score": 78},
    ]
    -> {"Alice": 90, "Bob": 78}

    提示：
    可以使用字典推导式。
    """
    result = {student["name"]:student["score"] for student in students}
    return result


def sort_words_by_length(words):
    """按单词长度从短到长排序。

    如果长度相同，按字母顺序排序。

    示例：
    ["pear", "apple", "fig", "banana"] -> ["fig", "pear", "apple", "banana"]

    提示：
    sorted(words, key=lambda word: ...)
    """
    return sorted(words, key=lambda word: (len(word), word) )


def running_total(numbers):
    """生成累加和。

    这是一个生成器函数，每次 yield 当前累加结果。

    示例：
    list(running_total([1, 2, 3])) -> [1, 3, 6]
    """
    total = 0
    for number in numbers:
        total += number
        yield total


def index_items(items):
    """给列表元素加上下标，返回元组列表。

    示例：
    ["a", "b", "c"] -> [(0, "a"), (1, "b"), (2, "c")]

    提示：
    使用 enumerate()。
    """
    return list(enumerate(items, start=0))


def pair_names_scores(names, scores):
    """把姓名列表和分数列表配对成字典列表。

    示例：
    ["Alice", "Bob"], [90, 78]
    -> [
        {"name": "Alice", "score": 90},
        {"name": "Bob", "score": 78},
    ]

    提示：
    使用 zip()。
    """
    return [{"name":name, "score": score} for name, score in zip(names, scores)]


if __name__ == "__main__":
    students_data = [
        {"name": "Alice", "score": 90},
        {"name": "Bob", "score": 78},
        {"name": "Cindy", "score": 95},
    ]

    print(square_even_numbers([1, 2, 3, 4, 5, 6]))
    print(build_name_score_map(students_data))
    print(sort_words_by_length(["pear", "apple", "fig", "banana", "kiwi"]))
    totals = running_total([1, 2, 3, 4])
    print(list(totals) if totals is not None else None)
    print(index_items(["a", "b", "c"]))
    print(pair_names_scores(["Alice", "Bob"], [90, 78]))
