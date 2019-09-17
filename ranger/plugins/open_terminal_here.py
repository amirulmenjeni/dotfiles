from __future__ import (absolute_import, division, print_function)

import ranger.api
import os

HOOK_READY_OLD = ranger.api.hook_ready

def hook_ready(fm):
    pass

