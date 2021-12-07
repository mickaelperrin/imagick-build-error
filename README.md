# Imagick build error

## How to reproduce

1. clone the repository
2. launch `build.sh`

## Errors displayed

```
#8 3.852 /usr/src/php/ext/imagick/php_imagick_defs.h:25:12: fatal error: MagickWand/MagickWand.h: No such file or directory
#8 3.852    25 | #  include <MagickWand/MagickWand.h>
#8 3.852       |            ^~~~~~~~~~~~~~~~~~~~~~~~~
```

## Interesting logs

```
#8 2.581 checking ImageMagick MagickWand API configuration program... checking Testing /usr/local/bin/MagickWand-config... It exists
#8 2.581 found in /usr/local/bin/MagickWand-config
#8 2.584 checking if ImageMagick version is at least 6.2.4... found version 7.1.0-17 Q16 HDRI
#8 2.584 checking for MagickWand.h or magick-wand.h header... user location /usr/local/include/ImageMagick-7/MagickWand/MagickWand.h
#8 2.587 /usr/local/bin/MagickWand-config: line 53: --libs: not found
#8 2.588 /usr/local/bin/MagickWand-config: line 41: --cflags: not found
```
