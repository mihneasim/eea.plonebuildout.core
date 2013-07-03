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

================  =============  =============
configuration     production     development
================  =============  =============
Apache            configured     not available
Monit             configured     not available
Pound             configured     not available
Zope instances    configured     configured
ZEO               configured     configured
Zope storage      configured     configured
Zope logs         configured     configured
Memcache          configured     configured
Email             configured     disabled
EIONET LDAP       configured     not available
Debugging         not available  configured
EEA Profile [#]_  configured     configured
EEA KGS     [#]_  configured     configured
================  =============  =============

System requirements
-------------------
The EEA common Plone buildout is intended to run on Linux/Unix-based operating systems. The
buildout has been used and tested on *Debian*, *Ubuntu* for development and *CentOS 5* and *CentoOS 6* for production.

The bellow libraries and software must be installed on the server before you run the buildout. These must
be globally installed by the server administrator.

For CentOS, the EPEL and RPMForge repositories need to be configured before installing
the packages, since some of them are not included in the base repo.

=================  ===================  =============================
Debian/Ubuntu      CentOS               dependency for
=================  ===================  =============================
python 2.6         python 2.6           buildout
python-dev         python-devel         buildout
wget               wget                 buildout
lynx               lynx                 buildout
poppler-utils      poppler-utils        pdftotext
tar                tar                  buildout
gcc                gcc                  --
git                git                  buildout
libc6-dev          glibc-devel          --
libxml2-dev        libxml2-devel        --
libxslt-dev        libxslt-devel        --
libsvn-dev         subversion-devel     buildout
libaprutil1-dev    apr-util-devel       --
wv                 wv                   http://wvware.sourceforge.net
libjpeg-turbo-dev  libjpeg-turbo-devel  Pillow
libsasl2-dev       cyrus-sasl-devel     OpenLDAP
=================  ===================  =============================

How to create a new EEA Plone based buildout
--------------------------------------------
Under EEA organisation on GitHub is provided an example of how an EEA Plone buildout should be
made, structured and configured: https://github.com/eea/eea.plonebuildout.example

Steps to create a new EEA Plone based buildout::

$ git clone git@github.com:eea/eea.plonebuildout.example.git
$ rmdir ./eea.plonebuildout.example/.git
$ mv eea.plonebuildout.example eea.plonebuildout.NEW-EEA-PORTAL

Last step should be to add the new buildout under GitHub. To create a new repository under EEA GitHub organisation,
one of the administrators should be contact. To do so, login under `'EEA Taskman'
<http://taskman.eionet.europa.eu>`_ and add a issue with your request under
`'Common infrastructure' project
<http://taskman.eionet.europa.eu/projects/infrastructure>`_.

How to use EEA common Plone buildout for development
----------------------------------------------------
**TODO**

The first time you want to use the  EEA common Plone buildout you first have to get
all software from GitHub and then run a few commands::

$ git clone git@github.com:eea/eea.plonebuildout.example.git
$ cd eea.plonebuildout.example
$ ./install.sh
$ ./bin/buildout -c development.cfg







How to use EEA common Plone buildout for production
---------------------------------------------------
**TODO**
* setup server side permissions and users (groups)
* how to Monit to stop start processes

The first time you want to use the  EEA common Plone buildout you first have to get
all software from GitHub and then run a few commands::

$ git clone git@github.com:eea/eea.plonebuildout.example.git
$ cd eea.plonebuildout.example
$ ./install.sh
$ ./bin/buildout -c deployment.cfg

How to setup the Plone site
---------------------------
eea.plonebuildout.profile
**TODO**

Setup logs on production
------------------------
buildout/var/logs
rotate

GRAYLOG:
For Zope to rich Graylog, rsyslog should be installed and configured
under /etc/rsyslog.conf simmilar as it is under an existing backend.

**TODO** add URL

Setup production monitoring
---------------------------
MUNIN:
Follow: http://taskman.eionet.europa.eu/projects/zope/wiki/HowToUpgradeMunin
Zope and Plone munin plugins should be add to munin node:

 1. $ cd /etc/munin/plugins
 2. create here symlinks from all files found under /var/eea-buildout-plone4/bin/munin-scripts
 3. create /etc/munin/plugin-conf.d/munin.zope.conf
 4. update /etc/munin/plugin-conf.d/munin.zope.conf similar with one from a running backend

**TODO** add URL

Setup testing environment
-------------------------
JENKINS
**TODO**

--------

.. [#] **EEA Profile:** *EEA Plone Site specific profile for creation of a new Plone Site to auto install mandatory packages and setup EEA specific defaults*
.. [#] **EEA KGS:** *EEA Known good set (all packages, EEA, Plone and Zope, are pinned to a fixed version)*