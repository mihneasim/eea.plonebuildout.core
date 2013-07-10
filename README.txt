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

The bellow system libraries must be installed on the server before you run the buildout. These must be globally
installed by the server administrator.

For CentOS, the EPEL and RPMForge repositories need to be configured before installing
the packages, since some of them are not included in the base repo.

All installs will require the basic GNU build and archive tools: gcc, g++, gmake, gnu tar, gunzip, bunzip2 and patch.

On Debian/Ubuntu systems, this requirement will be taken care of by installing build-essential. On RPM systems (RedHat, Fedora, CentOS), you'll need the gcc-c++ (installs most everything needed as a dependency) and patch RPMs.

=================  ===================  =============================
Debian/Ubuntu      CentOS               dependency for
=================  ===================  =============================
python 2.6         python 2.6           buildout
python-dev         python-devel         buildout
wget               wget                 buildout
lynx               lynx                 buildout
tar                tar                  buildout
gcc                gcc                  buildout
git                git                  buildout
libc6-dev          glibc-devel          buildout
libxml2-dev        libxml2-devel        buildout
libxslt-dev        libxslt-devel        buildout
libsvn-dev         subversion-devel     buildout
libaprutil1-dev    apr-util-devel       buildout
wv                 wv                   http://wvware.sourceforge.net
poppler-utils      poppler-utils        pdftotext
libjpeg-dev        libjpeg-devel        Pillow
libsasl2-dev       cyrus-sasl-devel     OpenLDAP
readline-dev       readline-devel       buildout
build-essential    make                 buildout
libz-dev           which                buildout
--                 patch                buildout
--                 gcc-c++              buildout
=================  ===================  =============================

Here you can read on how to prepare a server for an out-of-the-box Plone installation: `Preparing to install Plone`_.

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
under *../eea.plonebuildout.MY-EEA-PORTAL/development.cfg*. The *[configuration]* part contains a comprehensive list of configurable options. The values listed here are the buildout defaults. In order to override any of the settings
just uncomment them.

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
Similar, as explained in the previous chapter, the first step on using the EEA common Plone buildout is to setup
the specific configuration needed. The list of all configurable settings (e.g. the number of Zope instances,
port numbers, database location on file system etc.) can be found under *../eea.plonebuildout.MY-EEA-PORTAL/deployment.cfg*.
The *[configuration]* part contains a comprehensive list of configurable options. The values listed here are the buildout defaults. In order to override any of the settings just uncomment them.

The first time you want to use the  EEA common Plone buildout you have to run a few commands::

$ cd eea.plonebuildout.MY-EEA-PORTAL
$ ./install.sh
$ sudo ./bin/buildout -c deployment.cfg

The above installation process will install and configure, in addition to Zope and ZEO, the following:

* *Apache* basic configuration
* *Pound* for load balancing ZEO clients
* *Monit* for managing and monitoring processes
* *Memcache*
* Daemon for sending *emails*
* *ZEO clients* - 8 instances
* *ZEO*

Install Monit as system service::

$ cd eea.plonebuildout.MY-EEA-PORTAL/etc/rc.d
$ ln -s `pwd`/monit /etc/init.d/monit
$ chkconfig --add monit

Monit, when started, will automatically start Pound, Zeo clients, ZEO and ZopeSendmail daemon. Pound will load balance them and Apache will serve the website::

$ service monit start

Apache configuration file should be symlinked from /eea.plonebuildout.MY-EEA-PORTAL/etc/apache-vh.conf under /etc/httpd/conf.d, this operation should be done by system administrators.

Database packing
~~~~~~~~~~~~~~~~
Packing is a vital regular maintenance procedure The Plone database does not automatically prune deleted content. You must periodically pack the database to reclaim space.

Data.fs should be packed daily via a cron job::

 01 2 * * * /eea.plonebuildout.MY-EEA-PORTAL/bin/zeopack

Backup policy
~~~~~~~~~~~~~
The backup policy should be established with sistem administrators. Locations to be backuped, backup frequency and backup retention should be decided.

Logs
~~~~
EEA common Plone buildout for deployment will generate logs from ZEO, Zope, Pound and Apache. All this logs have
a default location and a default size on disk allocated for each of them.

A ZEO server only maintains one log file, which records starts, stops and client connections. Unless you are
having difficulties with ZEO client connections, this file is uninformative. It also typically grows very
slowly — so slowly that you may never need to rotate it. In respect of this ZEO log files will not be rotated and
the default location on disk will be:

* /eea.plonebuildout.MY-EEA-PORTAL/var/log/zeoserver.log

Zope client logs are of much more interest and grow more rapidly. There are two kinds of client logs, and each of your clients will maintain both, access logs and event logs. By default the logs will be rotated once they rich 100Mb in size and 3 old log files will be kept. Zope clients will write the logs on disk under /eea.plonebuildout.MY-EEA-PORTAL/var/log/, e.g.:

* /eea.plonebuildout.MY-EEA-PORTAL/var/log/www1-Z2.log
* /eea.plonebuildout.MY-EEA-PORTAL/var/log/www1.log

Logs generated by Pound will be created under /eea.plonebuildout.MY-EEA-PORTAL/var/log/pound.log. This logs
must be rotated using logrotate. System administrators should configure logrotate for example like this::

    # rotate Pound logs for MY-EEA-PORTAL
    /var/eea.plonebuildout.MY-EEA-PORTAL/var/log/pound.log {
    weekly
    missingok
    rotate 5
    dateext
    compress
    notifempty
    postrotate
      /bin/kill -HUP `cat /var/run/syslogd.pid 2> /dev/null` 2> /dev/null || true
      /bin/kill -HUP `cat /var/run/rsyslogd.pid 2> /dev/null` 2> /dev/null || true
    endscript
    }

Logs generated by Apache will be created under /var/log/httpd/\*.log. This logs must be rotated using logrotate.
Logrotate comes with suitable default configurations for apache/httpd. However, for extra log locations, such as
specific access logs kept under /var/local/www-logs, system administrators should provide additional configuration file(s)
for logrotate; for example, in /etc/logrotate.d/eea we might have something like this::

    # rotate Apache logs for MY-EEA-PORTAL and MY-OTHER-EEA-PORTAL
    /var/local/www-logs/MY-EEA-PORTAL/*.access /var/local/www-logs/MY-OTHER-EEA-PORTAL/access {
    missingok
    notifempty
    sharedscripts
    postrotate
        /sbin/service httpd reload > /dev/null 2>/dev/null || true
    endscript
    }

Logs via Graylog2
~~~~~~~~~~~~~~~~~
For Zope logs to rich Graylog2, rsyslog should be installed and configured under /etc/rsyslog.conf similar as it is
under an existing backend (e.g. redsquirrel). Zope clients should send the logs to rsyslog on certain interfaces and
should be configured like bellow::

    event-log-custom =
        <syslog>
            address /dev/log
            facility local4
            format ${:_buildout_section_name_}: %(message)s
            level info
        </syslog>
    access-log-custom =
        <syslog>
            address /dev/log
            facility local1
            format ${:_buildout_section_name_}-Z2: %(message)s
            level info
        </syslog>

In order to have access on `EEA Graylog2`_, an administrator should be asked to give you permissions.

Monitoring
~~~~~~~~~~
The EEA uses Munin to monitor it's servers. To enable the backend monitoring of your server via Munin follow this `wiki instructions`_.

Complete list of EEA Munin nodes is accessible here: http://unicorn.eea.europa.eu/munin

Continuous Integration
~~~~~~~~~~~~~~~~~~~~~~
Read more under: `How to use EEA Continuous Integration Testing server`_

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
mandatory EEA packages installed and an instance of LDAPUserFolder mapped on "*Eionet User Directory*".

The list of EEA Plone packages installed:

* eea.cache
* eea.depiction
* eea.facetednavigation
* eea.faceted.vocabularies
* eea.faceted.inheritance
* eea.geotags
* eea.rdfmarshaller
* eea.relations
* eea.socialmedia
* eea.tags
* eea.translations

New EEA KGS available
=====================
Whenever a new EEA KGS (EEA Known Good Set) is released, a portal message will appear for the managers,
indicating the new EEA KGS version available for upgrade.

To upgrade to the new EEA KGS, change in your versions.cfg file (inside the root of the buildout under /eea.plonebuildout.MY-EEA-PORTAL/versions.cfg), to point to the new KGS versions.cfg file.

For example, to upgrade to EEA KGS version 1.1, /eea.plonebuildout.MY-EEA-PORTAL/versions.cfg must contain::

    [buildout]
    extends =
        https://raw.github.com/eea/eea.plonebuildout.core/master/buildout-configs/kgs/1.1/versions.cfg

Once the modification has been made, re-run buildout, restart Zope instances and then follow
normal Plone upgrade procedures: first run upgrade migration of Plone (if case), then upgrade the
EEA and thirdparty packages.

Source code
===========
Source code can be found under EEA organisation on GitHub and consist in one package for the core buildout, one Plone profile package and one buildout example.

- `eea.plonebuildout.core`_
- `eea.plonebuildout.profile`_
- `eea.plonebuildout.example`_

To add a new package within EEA organization GitHub space, follow the instructions from this wiki: `How to add EEA packages on GitHub`_.


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
.. _`Preparing to install Plone`: http://developer.plone.org/reference_manuals/active/deployment/preparing.html
.. _`How to add EEA packages on GitHub`: http://taskman.eionet.europa.eu/projects/zope/wiki/HowToAddPackagesOnGithub
.. _`EEA Graylog2`: http://logs.eea.europa.eu
.. _`How to use EEA Continuous Integration Testing server`: http://taskman.eionet.europa.eu/projects/zope/wiki/HowToJenkins
