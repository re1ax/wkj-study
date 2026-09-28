"""
Python 基础练习 05

重点：
1. pathlib 路径处理
2. with open 文件读写
3. JSON 数据
4. 文件相关异常处理
5. 数据汇总

完成后运行：
python3 PythonReview/exercises/python_basics_05.py
"""

import json
from pathlib import Path


def read_nonempty_lines(file_path):
    """读取文本文件，返回去除空白后的非空行列表。

    如果文件不存在，返回空列表。

    示例文件内容：
    Python

    NumPy

    返回：
    ["Python", "NumPy"]
    """
    try:
        
        result = []
        with open(file_path, "r", encoding="utf-8") as file:
            for line in file:
                line = line.strip()
                if line:
                    result.append(line)
        return result
    except FileNotFoundError:
        return []



def load_json_records(file_path):
    """读取 JSON 文件并返回其中的数据。

    如果文件不存在或 JSON 格式错误，返回空列表。

    提示：
    - json.load(file_object)
    - FileNotFoundError
    - json.JSONDecodeError
    """
    try:
        with open(file_path, "r", encoding="utf-8") as file:
            return json.load(file)
    except (FileNotFoundError, json.JSONDecodeError):
        return []


def build_score_summary(students):
    """根据学生列表生成成绩汇总字典。

    非空列表返回：
    {
        "count": 学生人数,
        "average": 平均分,
        "top_student": 最高分学生姓名,
        "top_score": 最高分,
    }

    平均分保留两位小数，可以使用 round(value, 2)。

    如果 students 为空，返回：
    {
        "count": 0,
        "average": 0,
        "top_student": None,
        "top_score": None,
    }
    """
    
    
    result = {
        "count": 0,
        "average": 0,
        "top_student": None,
        "top_score": None,
    }
    if not students:
        return result
    sum_score = 0
    for student in students:
        result["count"] += 1
        sum_score += int(student["score"])
        if(result["top_score"] is None or student["score"] > result["top_score"]) :
            result["top_score"] = student["score"]
            result["top_student"] = student["name"]
    result["average"] = round(sum_score / result["count"],2)
    return result


def save_json(data, file_path):
    """把 data 保存到 JSON 文件。

    要求：
    - 如果父目录不存在，先创建父目录
    - 使用 UTF-8 编码
    - JSON 使用 2 个空格缩进
    - 保存成功后返回 True

    提示：
    - Path(file_path).parent.mkdir(parents=True, exist_ok=True)
    - json.dump(...)
    """
    path = Path(file_path)
    path.parent.mkdir(parents=True, exist_ok=True)

    with open(path, "w", encoding="utf-8") as file:
        json.dump(data, file, ensure_ascii=False, indent=2)

    return True


def find_files_by_suffix(folder_path, suffix):
    """查找目录中指定后缀的文件，返回文件名列表。

    只查找当前目录，不递归进入子目录。
    返回结果按文件名升序排列。

    示例：
    find_files_by_suffix("datasets", ".json")
    -> ["students.json"]

    如果目录不存在，返回空列表。
    """
    folder = Path(folder_path)
    if not folder.exists() or not folder.is_dir():
        return []

    result = []
    for path in folder.iterdir():
        if path.is_file() and path.name.endswith(suffix):
            result.append(path.name)

    return sorted(result)


if __name__ == "__main__":
    project_dir = Path(__file__).resolve().parents[1]
    datasets_dir = project_dir / "datasets"

    topics_path = datasets_dir / "review_topics.txt"
    students_path = datasets_dir / "students.json"
    output_path = datasets_dir / "score_summary_output.json"

    topics = read_nonempty_lines(topics_path)
    students = load_json_records(students_path)
    summary = build_score_summary(students)

    print(topics)
    print(students)
    print(summary)
    print(save_json(summary, output_path))
    print(find_files_by_suffix(datasets_dir, ".json"))
