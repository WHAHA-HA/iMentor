#!/usr/bin/env python
from nose.plugins.skip import SkipTest
from functools import wraps
import json

__all__ = ['skipped']

def _to_be_skipped(testfunc):
    skip = False
    testcfg = json.loads(open('test.cfg').read())
    #print(testcfg)
    if testfunc in testcfg.keys() and testcfg[testfunc]:
        skip = testcfg[testfunc]
    return skip


def skipped():
    def wrapper(func):
        @wraps(func)
        def skipped_and_call(*args, **kwargs):
            if _to_be_skipped(str(func.__name__)):
                print("Function " + str(func.__name__) + " is being skipped")
                raise SkipTest("Skipped")
            return func(*args, **kwargs)
        if _to_be_skipped(str(func.__name__)):
            return skipped_and_call
        else:
            return func
    return wrapper

