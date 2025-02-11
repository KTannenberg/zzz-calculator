from dataclasses import field, InitVar
from typing import List, Dict, Optional, Tuple, Union, Callable, Sequence, TypeVar, Generator, OrderedDict as OrderedDictT
from pydantic import Extra, validator, root_validator, conlist
from pydantic.dataclasses import dataclass

from collections import defaultdict, OrderedDict
from collections.abc import Hashable
from enum import Enum, IntEnum, StrEnum

from zenless import Rarity

class Config:
  validate_assignment = True
  validate_all = True
  extra = Extra.forbid

@dataclass(config = Config)
class Agent:
  id: str
  name: str
  rank: Rank
  maxLevel: 60
  stats: List[Stat]

@dataclass(config = Config)
class WEngine:
  id: str
  name: str
  maxLevel: 60


@dataclass(config = Config)
class DriveDisk:
  rank: str
  set: str
  slot: int
  primaryStat: Stat


  # pak: str
  # includes: conlist(str, min_items = 1) = field(default_factory = lambda: ['*'])
  # excludes: List[str] = field(default_factory = list)
  # decodes: List[str] = field(default_factory = lambda: ['**/*.xml', '**/*.html'])
  # patches: Dict[str, List[str]] = field(default_factory = dict)

  # patch: InitVar[Dict[str, str]] = None
  # def __post_init__(self, patch):
  #   merge_to_multidict('patches', self.patches, patch)

  # @post_validator('pak')
  # def check_pak(cls, v):
  #   assert v.endswith('.pak'), 'Should end with .pak extension'
  #   return v

  # def merge_with(self, other: 'Extractor'):
  #   if self.pak != other.pak:
  #     raise ValueError(f'Cannot merge Extractors for different PAK files: self={self.pak}, other={other.pak}')
  #   self.includes += (include for include in other.includes if include not in self.includes)
  #   self.excludes += (exclude for exclude in other.excludes if exclude not in self.excludes)
  #   self.decodes += (decode for decode in other.decodes if decode not in self.decodes)
  #   for file, patches in other.patches.items():
  #     if file in self.patches:
  #       self.patches[file] += patches
  #     else:
  #       self.patches[file] = patches
