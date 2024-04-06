def decimal_to_binary(n):
    if n < 0:
        s = '1'
    else:
        s = '0'

    n_abs = abs(n)

    # convert integer part
    n_int = int(n_abs)
    n_bin_int = ""
    if n_int == 0:
        n_bin_int = "0"
    while n_int > 0:
        n_bin_int = n_bin_int + str(n_int % 2)
        n_int //= 2

    n_bin_int = n_bin_int[::-1]

    # convert fractional part
    n_fract = n_abs - int(n_abs)
    n_bin_fract = ""
    if n_fract == 0:
        n_bin_fract = "0"
    for i in range(24):
        n_fract *= 2
        if n_fract >= 1:
            n_bin_fract += '1'
            n_fract -= 1
        else:
            n_bin_fract += '0'

    # unite
    n_bin = n_bin_int + '.' + n_bin_fract
    n_bin = n_bin[:25]

    return n_bin, s


def binary_to_exponential(bin_str):
    int_part, fract_part = bin_str.split('.')
    if '1' in int_part:
        first_one_position = len(int_part) - 1
        shift = first_one_position
        mantissa = '1.' + int_part[1:] + fract_part
    else:
        first_one_position = fract_part.find('1')
        shift = -(first_one_position + 1)
        mantissa = '1.' + fract_part[first_one_position + 1:]

    if len(mantissa) < 25:
        count_of_zeros = 25 - len(mantissa)
        mantissa = mantissa + '0' * count_of_zeros

    return mantissa, shift


def binary_to_hex(binary_str):
    bin_to_hex_map = {
        '0000': '0', '0001': '1', '0010': '2', '0011': '3',
        '0100': '4', '0101': '5', '0110': '6', '0111': '7',
        '1000': '8', '1001': '9', '1010': 'A', '1011': 'B',
        '1100': 'C', '1101': 'D', '1110': 'E', '1111': 'F'
    }

    # Розділення по 4 цифри
    chunks = [binary_str[i:i + 4] for i in range(0, len(binary_str), 4)]
    # Конвертація кожної групи
    hex_str = ''.join(bin_to_hex_map[chunk] for chunk in chunks)

    return hex_str


def convert_to_float(n):
    n_bin, s = decimal_to_binary(n)
    mantissa, shift = binary_to_exponential(n_bin)
    exponent = 127 + shift
    exponent, _ = decimal_to_binary(exponent)
    exponent, _ = exponent.split('.')
    _, mantissa_without_first = mantissa.split('.')
    res = s + exponent + mantissa_without_first
    res = binary_to_hex(res)
    return res


print(convert_to_float(-500.3))
