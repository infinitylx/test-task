#!/usr/bin/python
# -*- coding: utf-8 -*-

dbhost = 'localhost'
dbuser = 'testUser'
dbpass = 'gfhjkm'
dbname = 'mp'

DB_URI = 'postgresql+psycopg2://%s:%s@%s/%s' % (dbuser, dbpass, dbhost, dbname)
