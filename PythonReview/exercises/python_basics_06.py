"""
Python 基础练习 06

重点：
1. class 类
2. __init__ 初始化
3. self 实例方法
4. 在对象中维护数据
5. 简单增删查改

完成后运行：
python3 PythonReview/exercises/python_basics_06.py
"""


class StudentGradeBook:
    """一个简单的学生成绩册。"""

    def __init__(self):
        """初始化成绩册。

        要求：
        - 创建一个实例属性 self.students
        - self.students 用列表保存学生字典
        """
        self.students = []

    def add_student(self, name, score):
        """添加学生。

        要求：
        - 如果学生已存在，返回 False
        - 如果添加成功，返回 True

        学生字典格式：
        {"name": name, "score": score}
        """
        student = {"name": name, "score": score}
        for stu in self.students:
            if stu["name"] == name:
                return False
        self.students.append(student)
        return True

    def find_student(self, name):
        """按姓名查找学生。

        找到返回学生字典，找不到返回 None。
        """
        for student in self.students:
            if student["name"] == name:
                return student
        return None

    def update_score(self, name, new_score):
        """更新学生成绩。

        如果学生存在，更新成绩并返回 True。
        如果学生不存在，返回 False。
        """
        for student in self.students:
            if student["name"] == name:
                student["score"] = new_score
                return True
        return False

    def average_score(self):
        """返回所有学生的平均分。

        如果没有学生，返回 0。
        平均分保留两位小数。
        """
        if len(self.students) == 0:
            return 0
        total : float = 0.0
        for student in self.students:
            total += student["score"]
        return round(total/len(self.students), 2)

    def top_students(self, limit=3):
        """按成绩从高到低返回前 limit 个学生姓名列表。

        如果 limit 超过学生人数，返回所有学生。
        """
        sorted_students = sorted(self.students, key = lambda x : x["score"], reverse=True)
        
        result = []
        for student in sorted_students[:limit]:
            result.append(student["name"])

        return result

    def remove_student(self, name):
        """删除学生。

        如果学生存在，删除并返回 True。
        如果学生不存在，返回 False。
        """
        for student in self.students:
            if name == student["name"]:
                self.students.remove(student)
                return True
        return False


if __name__ == "__main__":
    gradebook = StudentGradeBook()

    print(gradebook.add_student("Alice", 90))
    print(gradebook.add_student("Bob", 78))
    print(gradebook.add_student("Cindy", 95))
    print(gradebook.add_student("Alice", 88))

    print(gradebook.find_student("Bob"))
    print(gradebook.find_student("Tom"))

    print(gradebook.update_score("Bob", 82))
    print(gradebook.update_score("Tom", 70))

    print(gradebook.average_score())
    print(gradebook.top_students(2))

    print(gradebook.remove_student("Alice"))
    print(gradebook.remove_student("Tom"))
    print(gradebook.top_students(10))
