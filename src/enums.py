from enum import Enum
from typing import Literal

#type DiskSlot = Literal[1, 2, 3, 4, 5, 6]

class DiskSlot(Enum):
    X = 0, "Unknown"
    S1 = 1, "[1]"
    S2 = 2, "[2]"
    S3 = 3, "[3]"
    S4 = 4, "[4]"
    S5 = 5, "[5]"
    S6 = 6, "[6]"
    
    def __new__(cls, value, label):
        self = object.__new__(cls)
        self._value_ = value
        self.label = label
        # self._add_value_alias_(v)
        return self
    
    @classmethod
    def _missing_(cls, value):
        for k, v in cls.__members__.items():
            if value.lower() in (k, k.lower(), v.value, v.label.lower()):
                return v
        return cls.X


class Rarity(Enum):
    X = 0, "Unknown"
    B = 1, "B-rank"
    A = 2, "A-rank"
    S = 3, "S-rank"
    
    def __new__(cls, value, label):
        self = object.__new__(cls)
        self._value_ = value
        self.label = label
        # self._add_value_alias_(v)
        return self
    
    @classmethod
    def _missing_(cls, value):
        for k, v in cls.__members__.items():
            if value.lower() in (k, k.lower(), v.value, v.label.lower()):
                return v
        return cls.X
