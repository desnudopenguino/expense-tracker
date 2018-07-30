# Desnudopenguino's Expense Tracker

This is a simple CRUD web application to collect receipt info for tracking expenses.

### Dependencies:
- sqlite
- ruby 2.4.1
- rails 5.2.0
- node
- yarn
	- coffee-loader
        - coffeescript
        - element-ui
	- vue-turbolinks
- (more to come as I complete this README)

### NGINX Config:
Here are some notes on configuring NGINX to run with the app

Set up the upstream app in nginx.conf:
```
    upstream app {
        server unix:///usr/home/bucky/receipts/shared/sockets/puma.sock;
    }
```

Add the rest of the app configuration inside the `server {` block in nginx.conf
```
        root /path/to/app/public;

        location @app {
            proxy_pass http://app;
            proxy_redirect off;

            proxy_set_header HOST $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded_Proto $scheme;
        }

        location / {
            try_files $uri @app;
        }

        location ^~ /assets/ {
            gzip_static on;
            expires max;
        }

        location ^~ /packs/ {
            gzip_static on;
            expires max;
        }
```

### Notes
So This is just one part of two for the tool. The second part is [MetaBase](https://github.com/metabase/metabase). MetaBase is a tool that allows you to build a collection of queries to view your data in nice formatted ways. I figured there is no point in reinventing the wheel of viewing and analyzing the data if I didn't have to. To handle running both a rails instance and a MetaBase instance, the rails instance is set up to run on port 3001. MetaBase runs on port 3000. 

This instance was meant to be run on a local/home machine, thus the use of sqlite and no user authentication and authorization. 
