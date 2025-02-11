#!/usr/bin/env python3
import sys
__required_version__ = (3, 6, 1)
if sys.version_info < __required_version__:
  sys.exit('[ERROR] This script requires at least Python ' + '.'.join(map(str, __required_version__))
        + ' to execute, but detected version is: ' + '.'.join(map(str, sys.version_info)))

from pydantic import BaseModel
class Config:
  validate_assignment = True
  validate_all = True
