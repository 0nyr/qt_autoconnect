# python enum : https://docs.python.org/3/library/enum.html 
from enum import Enum

class ANSICtrlSequence(Enum):
    # basic control sequences
    RESET = "\033[m" 

    # full control sequences
    PASSED = "\033[1;4;38;5;76m" 
    FAILED = "\033[1;5;38;5;197m" 

    # substitution control sequences
    FG_CRTL_S = "\033[38;5;%sm" 
    BG_CRTL_S = "\033[48;5;%sm"