"""
Python 基础练习 02

重点：
1. 字符串 split / join
2. list / dict 的遍历
3. 按题目要求返回精确的数据结构
"""


def get_long_words(sentence, min_length):
    """返回句子中长度大于等于 min_length 的单词列表。

    示例：
    "I enjoy learning Python", 6 -> ["learning", "Python"]
    """
    #TODO: implement this function
    words = sentence.split()
    result = []
    for word in words:
        if(len(word) >= min_length):
            result.append(word)
    return result




def group_by_score_level(students):
    """按成绩分组，返回包含 high / mid / low 三个 key 的 dict。

    规则：
    - score >= 85: high
    - 60 <= score < 85: mid
    - score < 60: low

    返回值示例：
    {
        "high": ["Alice"],
        "mid": ["Bob"],
        "low": ["Tom"],
    }
    """
    high = []
    mid = []
    low = []
    for student in students:
        if(student["score"] >= 85):
            high.append(student["name"])
        elif(student["score"] >= 60):
            mid.append(student["name"])
        else:
            low.append(student["name"])
        result = {}
    result["high"] = high
    result["mid"] = mid
    result["low"] = low
    return result

def remove_duplicates(items):
    """去重并保持原顺序。

    示例：
    [3, 1, 3, 2, 1] -> [3, 1, 2]
    """
    hash = {}
    result = []
    for item in items:
        if(item not in hash):
            result.append(item)
            hash[item] = True
    return result


def merge_counts(dict_a, dict_b):
    """合并两个计数字典。

    示例：
    {"python": 2, "java": 1}, {"python": 3, "c++": 1}
    -> {"python": 5, "java": 1, "c++": 1}
    """
    for key in dict_b.keys():
        if(key in dict_a.keys()):
            dict_a[key] += dict_b[key]
        else:
            dict_a[key] = dict_b[key]
    return dict_a


def title_case(sentence):
    """把每个单词的首字母变大写，其余字母变小写。

    示例：
    "hELLO pyTHON" -> "Hello Python"
    """
    sentence = sentence.lower()
    isUp = True
    result = ""
    for ch in sentence:
        if(isUp):
            result += ch.upper()
            isUp = False
        else:
            result += ch
        if(ch == " "):
            isUp = True
            
        
    return result


if __name__ == "__main__":
    students_data = [
        {"name": "Alice", "score": 91},
        {"name": "Bob", "score": 78},
        {"name": "Cindy", "score": 85},
        {"name": "Tom", "score": 52},
    ]

    print(get_long_words("I enjoy learning Python", 6))
    print(group_by_score_level(students_data))
    print(remove_duplicates([3, 1, 3, 2, 1]))
    print(merge_counts({"python": 2, "java": 1}, {"python": 3, "c++": 1}))
    print(title_case("hELLO pyTHON"))

