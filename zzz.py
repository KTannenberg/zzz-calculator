#!/usr/bin/env python3
import sys
__required_version__ = (3, 6, 1)
if sys.version_info < __required_version__:
  sys.exit('[ERROR] This script requires at least Python ' + '.'.join(map(str, __required_version__))
        + ' to execute, but detected version is: ' + '.'.join(map(str, sys.version_info)))

# import arguments and mix
import argparse
import yaml
import glob
import re
import textwrap

# os and shell utils
import os
from os import path
from pathlib import Path
import shutil

# logging
import logging
log = logging.getLogger(__name__)
verbose = False

from typing import List, Dict, Set
from src.shell import shell
from src.mapping import Generator, Mapping, Source, Target
