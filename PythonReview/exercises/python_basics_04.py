"""
Python 基础练习 04

重点：
1. 字符串清洗
2. set 集合操作
3. 按字典字段排序
4. 默认参数
5. 解析 CSV 风格文本

完成后运行：
python3 PythonReview/exercises/python_basics_04.py
"""


def clean_names(names):
    """清洗姓名列表。

    要求：
    - 去掉每个姓名前后的空白字符
    - 跳过清洗后为空字符串的元素
    - 返回清洗后的列表

    示例：
    [" Alice ", "", " Bob", "   "] -> ["Alice", "Bob"]
    """
    result = []
    for name in names:
        clean_name = name.strip()
        if(clean_name != ""):
            result.append(clean_name)
    return result


def find_common_items(list_a, list_b):
    """返回两个列表中的共同元素，结果不要求保持原顺序。

    示例：
    [1, 2, 3], [2, 3, 4] -> [2, 3]

    提示：
    可以使用 set。
    """
    common = set(list_a) & set(list_b)
    return list(common)


def get_top_students(students, limit=3):
    """按分数从高到低返回前 limit 个学生姓名。

    students 示例：
    [
        {"name": "Alice", "score": 90},
        {"name": "Bob", "score": 78},
    ]

    示例：
    get_top_students(students, 2) -> ["Alice", "Cindy"]
    """
    limit = min(limit, len(students))
    result = []
    sorted_student = sorted(students, key = lambda student : student["score"], reverse = True)
    for i in range(limit):
        result.append(sorted_student[i]["name"])
    return result

def count_by_field(records, field):
    """统计字典列表中某个字段的出现次数。

    records 示例：
    [
        {"name": "Alice", "city": "Shanghai"},
        {"name": "Bob", "city": "Beijing"},
        {"name": "Cindy", "city": "Shanghai"},
    ]

    示例：
    count_by_field(records, "city") -> {"Shanghai": 2, "Beijing": 1}
    """
    result = dict()
    for record in records:
        if(record[field] in result):
            result[record[field]] += 1
        else:
            result[record[field]] = 1
    return result



def parse_csv_lines(text):
    """解析简单 CSV 文本，返回字典列表。

    假设：
    - 第一行是表头
    - 每行字段用英文逗号分隔
    - 不需要处理字段中包含逗号的复杂情况

    示例：
    "name,city,score\\nAlice,Shanghai,90\\nBob,Beijing,78"
    -> [
        {"name": "Alice", "city": "Shanghai", "score": "90"},
        {"name": "Bob", "city": "Beijing", "score": "78"},
    ]
    """
    lines = text.splitlines()
    headers = lines[0].split(",")
    result = []
    for line in lines[1:]:
        values = line.split(",")
        record = {}
        for i in range(len(values)):
            record[headers[i]] = values[i]
        result.append(record)
    return result


if __name__ == "__main__":
    students_data = [
        {"name": "Alice", "score": 90, "city": "Shanghai"},
        {"name": "Bob", "score": 78, "city": "Beijing"},
        {"name": "Cindy", "score": 95, "city": "Shanghai"},
        {"name": "Tom", "score": 60, "city": "Shenzhen"},
    ]

    csv_text = "name,city,score\nAlice,Shanghai,90\nBob,Beijing,78"

    print(clean_names([" Alice ", "", " Bob", "   ", "Cindy"]))
    print(find_common_items([1, 2, 3], [2, 3, 4]))
    print(get_top_students(students_data, 2))
    print(count_by_field(students_data, "city"))
    print(parse_csv_lines(csv_text))
