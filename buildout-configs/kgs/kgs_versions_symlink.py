#!/usr/bin/env python

import os
import sys


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

    versions_link = os.path.join(wd, '../latest_versions.cfg')

    if os.path.exists(versions_link):
        os.unlink(versions_link)

    os.symlink(os.path.join(wd, 'versions.cfg'), versions_link)

if __name__ == "__main__":
    main()

