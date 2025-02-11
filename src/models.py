from dataclasses import field, InitVar
from typing import List, Dict, Optional, Tuple, Union, Callable, Sequence, TypeVar, Generator, OrderedDict as OrderedDictT
from pydantic import Extra, validator, root_validator, conlist
from pydantic.dataclasses import dataclass

from collections import defaultdict, OrderedDict
from collections.abc import Hashable
from enum import Enum

from . import Config

@dataclass(config = Config)
class DriveDisk:
    
class DriveDisk:
  rank: str
  set: str
  slot: int
  primaryStat: Stat
