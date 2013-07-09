=========================
EEA common Plone buildout
=========================

.. contents::

Introduction
============
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
===================
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
gcc                gcc                  buildout
git                git                  buildout
libc6-dev          glibc-devel          buildout
libxml2-dev        libxml2-devel        rdflib
libxslt-dev        libxslt-devel        rdflib
libsvn-dev         subversion-devel     buildout
libaprutil1-dev    apr-util-devel       buildout
wv                 wv                   http://wvware.sourceforge.net
libjpeg-turbo-dev  libjpeg-turbo-devel  Pillow
libsasl2-dev       cyrus-sasl-devel     OpenLDAP
=================  ===================  =============================

How to use EEA common Plone buildout
====================================
This section will describe the necessarily steps to create a new EEA Plone based buildout. It will document
the usage of both development and production buildouts and how to setup and configure the environments.

Step 1: create a EEA Plone based buildout
-----------------------------------------
Under EEA organisation on GitHub can be found an example of how a EEA Plone based buildout
should be created, structured and configured, see `eea.plonebuildout.example`_.

Steps to create a new EEA Plone based buildout::

$ git clone git@github.com:eea/eea.plonebuildout.example.git
$ rmdir ./eea.plonebuildout.example/.git
$ mv eea.plonebuildout.example eea.plonebuildout.MY-EEA-PORTAL

Last step should be to add the new buildout sources under GitHub. To create a new repository under EEA GitHub organisation,
one of the administrators should be contact. To do so, login under `'EEA Taskman'`_ and add a issue with your request under
`'Common infrastructure' project`_.

Once the new GitHub repository was created the sources of the new buildout can be pushed there (e.g. https://github.com/eea/eea.plonebuildout.MY-EEA-PORTAL).

Step 2: EEA common Plone buildout for development
-------------------------------------------------
First step on using the EEA common Plone buildout is to setup the specific configuration needed. The list of all configurable
settings (e.g. the number of Zope instances, port numbers, database location on file system etc.) can be found
under *../eea.plonebuildout.MY-EEA-PORTAL/development.cfg*. The *[configuration]* part contains a comprehensive list of configurable options. The values listed here are the buildout defaults. In order to override any of the settings just uncomment it.

Once the buildout settings were set you have to run a few commands using your local user::

$ cd eea.plonebuildout.MY-EEA-PORTAL
$ ./install.sh
$ sudo ./bin/buildout -c development.cfg

To start the application with ZEO support::

$ ./bin/zeoserver start
$ ./bin/www1 start

... and without ZEO support::

$ ./bin/instance start

Now we will have a running Plone buildout. The development buildout by default install ZEO
and two ZEO clients (*./bin/www1* and *./bin/www2*) plus one Zope instance that can be
used without ZEO support (*./bin/instance*).

Step 3: EEA common Plone buildout for production
------------------------------------------------
**TODO**

* how to buildout configs
* AT THE END: setup server side permissions and users (groups),
* [DONE] also update http://taskman.eionet.europa.eu/projects/infrastructure/wiki/Deployment-guide
* [DONE] how to Monit
* how to use KGS
* how to Apache
* how to Pound
* how to LDAP
* how to memcached
* how to email

The first time you want to use the  EEA common Plone buildout you have to run a few commands::

$ cd eea.plonebuildout.MY-EEA-PORTAL
$ ./install.sh
$ ./bin/buildout -c deployment.cfg

Zope/ZEO logs
~~~~~~~~~~~~~
**TODO**

* buildout/var/logs
* rotate
* graylog

GRAYLOG:
For Zope to rich Graylog, rsyslog should be installed and configured
under /etc/rsyslog.conf simmilar as it is under an existing backend.

**TODO** add URL

Monitoring
~~~~~~~~~~
The EEA uses Munin to monitor it's servers. To enable the backend monitoring of your server via Munin follow this `wiki instructions`_.

Complete list of EEA Munin nodes is accessible here: http://unicorn.eea.europa.eu/munin

Testing environment
~~~~~~~~~~~~~~~~~~~
**TODO**

* JENKINS

Deployment guidelines
~~~~~~~~~~~~~~~~~~~~~
To deploy a new buildout on EEA servers and to keep things organised, we provide the `guidelines to follow`_ by the developers, as well as the system administrators. Ideally, the following information should be compiled in a README file, residing in the root directory of the project (e.g. /eea.plonebuildout.MY-EEA-PORTAL/README.txt). Additional resources, such as Taskman projects/wikis may be added to this documentation.

The guideline document provide detailed informations about:

- contact point
- license and other metadata
- necessary hardware resources
- user access policy
- deployment timeline
- backup procedures

Example of deployment guidelines applied to a deployed buildout: `land.copernicus.plonebuildout`_

How to setup the Plone site
===========================
Once we have a running buildout, either for development or production, we need to create a Plone Site. Lets presume
we already have /www1 Zope instance up and running. Now open in any browser the following URL:

* http://localhost:8001

In your browser you should now see the Zope root displaying the message "*Plone is up and running*". Default
administrator credentials are:

* username: *admin*
* password: *admin*

To login under Zope root, click "*Zope Management Interface*" URL and use the above username and password.

To create a new Plone site follow the next steps:

* click on "*Create a new Plone site*" button
* fill in the above mentioned credentials to login as manager
* fill in the desired values for "*Path identifier*", "*Title*" and "*Language*" fields
* under "*Add-ons*", check only "*EEA Plone buildout profile*"
* click "*Create Plone Site*" button found at the bottom of the page

The result of all this steps will be a running Plone site under http://localhost:8001/Plone, with all
mandatory EEA packages installed and LDAP setup for "*Eionet User Directory*".

Source code
===========
Source code can be found under EEA organisation on GitHub and consist in one package for the core buildout, one Plone profile package and one buildout example.

- `eea.plonebuildout.core`_
- `eea.plonebuildout.profile`_
- `eea.plonebuildout.example`_

Copyright and license
=====================
The Initial Owner of the Original Code is European Environment Agency (EEA). All Rights Reserved.

The EEA common Plone buildout (the Original Code) is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

More details under `License.txt`_.

--------

.. [#] **EEA Profile:** *EEA Plone Site specific profile for creation of a new Plone Site to auto install mandatory packages and setup EEA specific defaults*
.. [#] **EEA KGS:** *EEA Known good set (all packages, EEA, Plone and Zope, are pinned to a fixed version)*

.. _`'EEA Taskman'`: http://taskman.eionet.europa.eu
.. _`'Common infrastructure' project`: http://taskman.eionet.europa.eu/projects/infrastructure
.. _`wiki instructions`: http://taskman.eionet.europa.eu/projects/zope/wiki/HowToUpgradeMunin
.. _`guidelines to follow`: http://taskman.eionet.europa.eu/projects/infrastructure/wiki/Deployment-guide
.. _`land.copernicus.plonebuildout`: https://github.com/eea/land.copernicus.plonebuildout/blob/master/README.rst
.. _`eea.plonebuildout.core`: https://github.com/eea/eea.plonebuildout.core
.. _`eea.plonebuildout.profile`: https://github.com/eea/eea.plonebuildout.profile
.. _`eea.plonebuildout.example`: https://github.com/eea/eea.plonebuildout.example
.. _`License.txt`: https://github.com/eea/eea.plonebuildout.core/blob/master/docs/LICENSE.txt
