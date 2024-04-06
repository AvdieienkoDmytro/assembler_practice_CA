def hex_to_binary(hex_str):
    hex_to_bin_map = {
        '0': '0000', '1': '0001', '2': '0010', '3': '0011',
        '4': '0100', '5': '0101', '6': '0110', '7': '0111',
        '8': '1000', '9': '1001', 'A': '1010', 'B': '1011',
        'C': '1100', 'D': '1101', 'E': '1110', 'F': '1111'
    }
    return ''.join(hex_to_bin_map[digit] for digit in hex_str)


def bin_to_decimal_integer_part(bin_str):
    decimal = 0
    power = len(bin_str) - 1
    for digit in bin_str:
        if digit == '1':
            decimal += 2 ** power
        power -= 1
    return decimal


def bin_to_decimal_fract_part(binary_str):
    decimal = 0
    for i, digit in enumerate(binary_str):
        decimal += int(digit) * (2 ** -(i + 1))
    return decimal


def shift_for_mantissa(bin_mantissa, shift):
    if shift >= 0:
        return '1' + bin_mantissa[:shift] + '.' + bin_mantissa[shift:]
    else:
        return '0.' + '0'*(abs(shift) - 1) + bin_mantissa[:shift]


def float_to_decimal(float_str):
    float_str = hex_to_binary(float_str)
    s, e, m = float_str[0], float_str[1:9], float_str[9:]
    shift = bin_to_decimal_integer_part(e) - 127
    m = shift_for_mantissa(m, shift)
    int_m, frac_m = m.split('.')
    res = bin_to_decimal_integer_part(int_m) + bin_to_decimal_fract_part(frac_m)
    if s == '1':
        return -res
    else:
        return res


print(float_to_decimal('C9064750'))
