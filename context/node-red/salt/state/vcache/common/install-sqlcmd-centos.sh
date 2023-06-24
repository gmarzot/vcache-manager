#!/bin/bash

curl https://packages.microsoft.com/config/rhel/7/prod.repo > /etc/yum.repos.d/mssql-release.repo

yum remove unixODBC-utf16 unixODBC-utf16-devel #to avoid conflicts
ACCEPT_EULA=Y yum install -y msodbcsql17
# optional: for bcp and sqlcmd
ACCEPT_EULA=Y yum install -y mssql-tools
# optional: for unixODBC development headers
yum install -y unixODBC-devel
