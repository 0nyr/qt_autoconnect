from typing import Union

from console.ansicolorcode import ANSIColorCode
from console.ansistring import ANSIString
from console.ansictrlsequence import ANSICtrlSequence

# python enum : https://docs.python.org/3/library/enum.html 
# python typing : https://docs.python.org/3/library/typing.html 

def println_fg_color(message: str, colorCode: ANSIColorCode):
    ctrlSequence: str = "%s%s%sm" % (
        ANSIString.ESC.value,
        ANSIString.FG_256.value,
        colorCode.value
    )
    print("%s%s%s" % (
        ctrlSequence,
        message,
        ANSICtrlSequence.RESET.value
    ))

def println_debug(message: str):
    println_fg_color(message, ANSIColorCode.DEBUG_C)

def println_ctrl_sequence(message: str, ctrlSequence: Union[ANSICtrlSequence, str]):
    #print("type ctrlSequence = ", type(ctrlSequence))
    if type(ctrlSequence) == ANSICtrlSequence:
        ctrlSequenceStr = ctrlSequence.value
    else:
        ctrlSequenceStr = ctrlSequence
    
    print("%s%s%s" % (
        ctrlSequenceStr,
        message,
        ANSICtrlSequence.RESET.value
    ))
