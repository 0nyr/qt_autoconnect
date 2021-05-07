import console

message: str = "hello world"

console.println_fg_color(message, console.ANSIColorCode.TURQUOISE_C)
console.println_ctrl_sequence(message, console.ANSICtrlSequence.FAILED)
console.println_ctrl_sequence(message, "\033[1;4;38;5;76m")
console.println_debug(message)
