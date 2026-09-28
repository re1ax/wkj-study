"""
Python 基础练习 08

重点：
1. 高阶函数
2. 闭包
3. *args 和 **kwargs
4. 简单装饰器
5. functools.wraps

完成后运行：
python3 PythonReview/exercises/python_basics_08.py
"""

from functools import wraps


def apply_operation(numbers, operation):
    """对 numbers 中每个元素应用 operation 函数，返回结果列表。

    示例：
    apply_operation([1, 2, 3], lambda x: x * 2) -> [2, 4, 6]
    """
    result = []
    for number in numbers:
        result.append(operation(number))
    return result


def make_multiplier(factor):
    """返回一个乘法函数。

    示例：
    double = make_multiplier(2)
    double(5) -> 10

    这题用于练习闭包：内层函数要记住 factor。
    """
    def multiplier(x):
        return x * factor
    return multiplier


def sum_all(*args):
    """接收任意数量的位置参数，返回它们的和。

    示例：
    sum_all(1, 2, 3) -> 6
    sum_all() -> 0
    """
    total = 0.0
    for arg in args:
        total += arg
    return total


def build_profile(**kwargs):
    """接收任意关键字参数，返回一个新字典。

    要求：
    - 返回 kwargs 的拷贝，不要直接返回 kwargs 本身
    - 如果没有参数，返回空字典

    示例：
    build_profile(name="Alice", city="Shanghai")
    -> {"name": "Alice", "city": "Shanghai"}
    """
    return kwargs.copy()

def require_non_empty(func):
    """装饰器：如果第一个参数为空，直接返回 None。

    示例：
    @require_non_empty
    def first_item(items):
        return items[0]

    first_item([1, 2, 3]) -> 1
    first_item([]) -> None

    提示：
    - 使用 *args, **kwargs 接收原函数参数
    - 使用 wraps(func)
    """
    pass


@require_non_empty
def first_item(items):
    """返回列表第一个元素。"""
    return items[0]


def log_calls(func):
    """装饰器：调用函数前打印函数名，调用后返回原函数结果。

    示例输出：
    Calling greet

    提示：
    print(f"Calling {func.__name__}")
    """
    pass


@log_calls
def greet(name):
    """返回问候语。"""
    return f"Hello, {name}"


if __name__ == "__main__":
    double = make_multiplier(2)
    triple = make_multiplier(3)

    print(apply_operation([1, 2, 3], lambda x: x * 2))
    print(double(5) if double is not None else None)
    print(triple(5) if triple is not None else None)
    print(sum_all(1, 2, 3, 4))
    print(sum_all())
    print(build_profile(name="Alice", city="Shanghai"))
    print(first_item([10, 20, 30]) if callable(first_item) else None)
    print(first_item([]) if callable(first_item) else None)
    print(greet("Python") if callable(greet) else None)
