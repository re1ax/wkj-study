"""
Python 基础练习 01

完成方式：
1. 直接在 TODO 位置写代码。
2. 可以运行：python3 exercises/python_basics_01.py
3. 如果卡住，把你的代码和报错发给我，我来帮你一起改。
"""


def count_even_numbers(numbers):
    """返回列表中偶数的个数。"""
    count = 0
    # TODO: 实现这个函数
    for i in range(len(numbers)):
        if(numbers[i] % 2 == 0):
            count += 1
    return count


def reverse_words(sentence):
    """把句子中的单词顺序反转。

    示例：
    "I love Python" -> "Python love I"
    """
    # TODO: 实现这个函数
    result = ""
    words = []
    word = ""
    for i in range(len(sentence)):
        if(sentence[i] == " "):
            words.append(word)
            word = ""
        else:
            word += sentence[i]
    
    words.append(word)

    for i in range(len(words) -1, -1, -1):
        result += words[i]
        if(i != 0):
            result += " "

    return result

def word_frequency(words):
    """统计单词出现次数，返回 dict。"""
    # TODO: 实现这个函数
    result = dict()
    for word in words:
        if(word in result):
            result[word] += 1
        else:
            result[word] = 1
    return result


def filter_students(students, min_score):
    """筛选分数大于等于 min_score 的学生姓名。
    
    students 示例：
    [
        {"name": "Alice", "score": 90},
        {"name": "Bob", "score": 72},
    ]
    """
    
    # TODO: 实现这个函数
    result = []
    for student in students:
        if(student['score'] >= min_score):
            result.append(student["name"])
    return result



def flatten_list(nested):
    """把二维列表拍平成一维列表。

    示例：
    [[1, 2], [3, 4], [5]] -> [1, 2, 3, 4, 5]
    """
    result = []
    # TODO: 实现这个函数
    for i in range(len(nested)):
        for j in range(len(nested[i])):
            result.append(nested[i][j])
    return result


if __name__ == "__main__":
    print(count_even_numbers([1, 2, 3, 4, 6]))
    print(reverse_words("I love Python"))
    print(word_frequency(["python", "c++", "python", "java"]))
    print(filter_students([
        {"name": "Alice", "score": 90},
        {"name": "Bob", "score": 72},
        {"name": "Cindy", "score": 85},
    ], 80))
    print(flatten_list([[1, 2], [3, 4], [5]]))
