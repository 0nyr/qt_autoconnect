# python enum : https://docs.python.org/3/library/enum.html 
from enum import Enum

class ANSIString(Enum):

    # Example : Using the strings to form 256 color control sequences
    #    "\033[1;4;38;5;76m"
    #    "\033[ 1; 4; 38;5; 76m" 
    #    "ESC BOLD; UNDERLINED; FG_256; PASSED_Cm"

    #    WARN : don't forget the "m" at the end of the sequence !

    ESC = "\033["  # escape character
    END = "m"  # end character

    # set 
    BOLD = "1"
    DIM = "2" 
    UNDERLINED = "4" 
    BLINK = "5" 
    REVERSE = "7" 
    HIDDEN = "8" 

    # reset
    R_ALL = "0" 
    R_BOLD = "21" 
    R_DIM = "22" 
    R_UNDERLINED = "24" 
    R_BLINK = "25" 
    R_REVERSE = "27" 
    R_HIDDEN = "28" 

    # foreground or background (before color code)
    FG_256 = "38;5;"  # foreground 256 
    BG_256 = "48;5;" # background 256