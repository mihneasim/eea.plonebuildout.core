<VirtualHost *:80>
    ServerAdmin ${conf:server-admin}
    ServerName ${conf:www-domain}
    ServerAlias ${conf:www-domain}

    RewriteEngine On

    RewriteRule ^/(.*) http://localhost:${conf:pound-port}/VirtualHostBase/http/${conf:www-domain}:80/${conf:plone-site}/VirtualHostRoot/$1 [P,L]

</VirtualHost>
