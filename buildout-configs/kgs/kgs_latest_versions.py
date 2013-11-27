#!/usr/bin/env python

import os
import sys
import shutil


def main():
    if 'versions.cfg' not in os.listdir('.'):
        if len(sys.argv) == 1:
            print "Please run this command in the kgs folder. "
            print "Alternatively, give the path as an argument to this script"
            sys.exit(1)
        wd = sys.argv[1].strip()
        os.chdir(wd)
    else:
        wd = os.getcwd()

    latest_kgs = os.path.join(wd, '../latest_kgs')

    if os.path.exists(latest_kgs):
        shutil.rmtree(latest_kgs)

    shutil.copytree(wd, latest_kgs)

if __name__ == "__main__":
    main()

