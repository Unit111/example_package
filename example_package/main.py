import random
import string


def random_string(length: int) -> str:
    return ''.join(random.choice(string.ascii_letters) for _ in range(length))


def random_number(max_number: int) -> int:
    return random.randint(0, max_number)