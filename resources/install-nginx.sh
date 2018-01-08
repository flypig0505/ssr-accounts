#!/bin/bash

NGINX_VERSION=1.13.3 
PCRE_VERSION=8.41 
ZLIB_VERSION=1.2.11

#git clone https://github.com/gfw-breaker/ngx_http_substitutions_filter_module.git
#git clone https://github.com/gfw-breaker/ngx_http_google_filter_module.git

tar xzf nginx-${NGINX_VERSION}.tar.gz && \
tar xzf pcre-${PCRE_VERSION}.tar.gz && \
tar xzf zlib-${ZLIB_VERSION}.tar.gz

cd nginx-${NGINX_VERSION} && \
./configure \
	--with-http_sub_module  \
	--with-http_ssl_module  \
	--with-http_realip_module  \
        --with-http_addition_module  \
              --with-http_sub_module  \
              --with-http_dav_module  \
              --with-http_flv_module  \
              --with-http_mp4_module \
              --with-http_gunzip_module  \
              --with-http_gzip_static_module \
              --with-http_random_index_module \
              --with-http_secure_link_module  \
              --with-http_stub_status_module  \
              --with-http_auth_request_module  \
              --with-threads  \
              --with-stream  \
              --with-stream_ssl_module  \
              --with-http_slice_module  \
              --with-mail  \
              --with-mail_ssl_module  \
              --with-file-aio  \
              --with-http_v2_module  \
	--with-pcre=../pcre-${PCRE_VERSION} \
 	--with-zlib=../zlib-${ZLIB_VERSION} && \
  make -j4 && \
  make install 

cd ..
cp nginx.conf /usr/local/nginx/conf/


