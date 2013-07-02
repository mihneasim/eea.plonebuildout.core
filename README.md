=========================
EEA common Plone buildout
=========================
Buildout is a tool for easily creating identical development or production
environments. This tool gives you the right versions of Zope, Plone products
and Python libraries to ensure that every installation gets exactly the same
configuration.

Everything is installed in a local folder. This prevents conflicts with
already existing Python and Zope packages. Nothing other than this folder
is touched, so the user doesn't need any special privileges.

There are two configurations available for running EEA common Plone buildout:

1. one for developers
2. one for production (deployment)

EEA common Plone buildout ships with various default configurations for
the development and production installations:

| configuration | production    | development   |
| ------------- | ------------- | ------------- |
|Apache         | configured    | not available |
|Monit          | configured    | not available |
|Pound          | configured    | not available |
|Zope instances | configured    | configured    |
|ZEO            | configured    | configured    |
|Zope storage   | configured    | configured    |
|Zope logs      | configured    | configured    |
|Memcache       | configured    | configured    |
|Email          | configured    | disabled      |
|EIONET LDAP    | configured    | not available |
|Debugging      | not available | configured    |
|EEA Profile*   | configured    | configured    |
|EEA KGS**      | configured    | configured    |

\*  EEA Profile = EEA Plone Site specific profile for creation of a new
Plone Site to auto install mandatory packages and setup EEA specific defaults

\*\* EEA KGS = EEA Known good set (all packages, EEA, Plone and Zope, are pinned to a fixed version)

System requirements
-------------------
The EEA common Plone buildout is intended to run on Linux/Unix-based operating systems. The
buildout has been used and tested on Fedora, Debian, Ubuntu and Mac OS X.

Be sure that you have this software and libraries installed on the server
before you run buildout. These must be globally installed by the server
administrator.

For CentOS, the EPEL and RPMForge repositories need to be configured before installing
the packages, since some of them are not included in the base repo.

  * python 2.6
  * python-dev (for python 2.6) (Debian/Ubuntu) / python-devel (for python 2.6) (CentOS)
  * wget
  * lynx
  * poppler-utils
     * for pdftotext etc
  * tar
  * gcc
  * libc6-dev (Debian/Ubuntu) / glibc-devel (CentOS)
  * libxml2-dev (Debian/Ubuntu) / libxml2-devel (CentOS)
  * libxslt-dev (Debian/Ubuntu) / libxslt-devel (CentOS)
  * libsvn-dev and libaprutil1-dev (Debian/Ubuntu) / apr-util-devel and subversion-devel (CentOS)
  * libsasl2-dev (Debian/Ubuntu) / cyrus-sasl-devel (CentOS)
     * OpenLDAP dependency
  * wv
     * used to index Word documents
     * http://wvware.sourceforge.net
     * may be installed after Plone install
  * graphviz, graphviz-gd and graphviz-dev (Debian/Ubuntu) / graphviz-devel (CentOS)
     * dependency for eea.relations
  * xpdf
     * read more under eea.reports
  * pdftk and ImageMagick ver 6.3.7+
     * read more under eea.reports
  * git
  * python-docutils
     * used for <buildout_dir>/tools/unifyChangelogs.py
  * python-ordereddict
     * used for <buildout_dir>/tools/unifyChangelogs.py
  * libcurl3-dev (Debian/Ubuntu) / curl-devel (CentOS)
     * dependency for sparql-client and pycurl2
  * libjpeg-turbo-dev (Debian/Ubuntu) / libjpeg-turbo-devel (CentOS)



