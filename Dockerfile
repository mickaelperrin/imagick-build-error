FROM php:7.4-fpm-alpine
ARG LIB_WEBP_VESRION=1.2.1
ARG IMAGE_MAGICK_VERSION=7.1.0-17

# Compile webp from source
RUN apk --no-cache upgrade \
 && apk --update add gcc make g++ \
 && mkdir -p /usr/src/libwebp \
 && apk add --no-cache \
      libjpeg \
      libpng \
 && curl -fsSL https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-${LIB_WEBP_VESRION}.tar.gz | tar xvz -C "/usr/src/libwebp" --strip 1 \
 && cd /usr/src/libwebp \
 && ./configure \
 && make -j$(nproc) \
 && make install \
 && rm -vrf /usr/src/webp;

# Compile imagemagick from source
RUN  mkdir -p /usr/src/imagemagick \
 && curl -fsSL https://imagemagick.org/download/releases/ImageMagick-${IMAGE_MAGICK_VERSION}.tar.gz | tar xvz -C "/usr/src/imagemagick" --strip 1 \
 && cd /usr/src/imagemagick \
 && ./configure \
      --with-magick-plus-plus=no \
      --without-perl \
      --disable-docs \
      --with-fontconfig=yes \
      --with-fftw \
      --with-heic=yes \
      --with-jpeg=yes \
      --with-png=yes \
      --with-tiff=yes \
      --with-webp=yes \
 && ldconfig /usr/local/lib \
 && make -j$(nproc) \
 && make install \
 && identify -version \
 && identify -list format

# Imagick
ENV MAGICK_HOME=/usr/src/imagemagick
ARG IMAGICK_VERSION=3.6.0RC1
RUN mkdir -p /usr/src/php/ext/imagick \
 && curl -fsSL https://github.com/Imagick/imagick/archive/refs/tags/${IMAGICK_VERSION}.tar.gz | tar xvz -C "/usr/src/php/ext/imagick" --strip 1

RUN  cd /usr/src/php/ext/imagick \
 && apk add --no-cache autoconf pkgconfig \
 && phpize \
 &&  ./configure \
 && make -j$(nproc) \
 && make install \
 && docker-php-ext-enable imagick
