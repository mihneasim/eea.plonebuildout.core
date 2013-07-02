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

\*  *EEA Profile = EEA Plone Site specific profile for creation of a new
Plone Site to auto install mandatory packages and setup EEA specific defaults*

\*\* *EEA KGS = EEA Known good set (all packages, EEA, Plone and Zope, are pinned to a fixed version)*

System requirements
-------------------
The EEA common Plone buildout is intended to run on Linux/Unix-based operating systems. The
buildout has been used and tested on *Debian*, *Ubuntu* for development and *CentOS 5* and *CentoOS 6* for production.

The bellow libraries and software must be installed on the server before you run the buildout. These must
be globally installed by the server administrator.

For CentOS, the EPEL and RPMForge repositories need to be configured before installing
the packages, since some of them are not included in the base repo.

| Debian/Ubuntu    | CentOS              | dependency for                |
| ---------------- | ------------------- | ----------------------------- |
|python 2.6        | python 2.6          | -                             |
|python-dev        | python-devel        | -                             |
|wget              | wget                | -                             |
|lynx              | lynx                | -                             |
|poppler-utils     | poppler-utils       | pdftotext                     |
|tar               | tar                 | -                             |
|gcc               | gcc                 | -                             |
|git               | git                 | -                             |
|libc6-dev         | glibc-devel         | -                             |
|libxml2-dev       | libxml2-devel       | -                             |
|libxslt-dev       | libxslt-devel       | -                             |
|libsvn-dev        | apr-util-devel      | -                             |
|libaprutil1-dev   | subversion-devel    | -                             |
|wv                | wv                  | http://wvware.sourceforge.net |
|libjpeg-turbo-dev | libjpeg-turbo-devel | -                             |
|libsasl2-dev      | cyrus-sasl-devel    | OpenLDAP                      |



