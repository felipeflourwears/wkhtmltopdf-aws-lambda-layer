# WKHTMLTOPDF 
To build a binary file

First, you need to install docker and build the image with the Dockerfile
```bash
docker build -t wkhtmltopdf-layer
```
Then, you need to enter to bash:
```bash
docker run --rm -it wkhtmltopdf-layer
```

Verify the binary
```bash
wkhtmltopdf --version
```
## Package 
In the root folder you need to build the package, but first verify the binary path

```bash
which wkhtmltopdf
```
To see libraries
```bash
bash-4.2# ldd /opt/usr/local/bin/wkhtmltopdf
	linux-vdso.so.1 (0x000077ed1b37e000)
	libjpeg.so.62 => /lib64/libjpeg.so.62 (0x000077ed1ad7a000)
	libpng15.so.15 => /lib64/libpng15.so.15 (0x000077ed1ab51000)
	libXrender.so.1 => /lib64/libXrender.so.1 (0x000077ed1a947000)
	libfontconfig.so.1 => /lib64/libfontconfig.so.1 (0x000077ed1a706000)
	libfreetype.so.6 => /lib64/libfreetype.so.6 (0x000077ed1a450000)
	libXext.so.6 => /lib64/libXext.so.6 (0x000077ed1a23e000)
	libX11.so.6 => /lib64/libX11.so.6 (0x000077ed19f06000)
	libssl.so.10 => /lib64/libssl.so.10 (0x000077ed19c97000)
	libcrypto.so.10 => /lib64/libcrypto.so.10 (0x000077ed19840000)
	libz.so.1 => /lib64/libz.so.1 (0x000077ed1962b000)
	libdl.so.2 => /lib64/libdl.so.2 (0x000077ed19427000)
	librt.so.1 => /lib64/librt.so.1 (0x000077ed1921f000)
	libpthread.so.0 => /lib64/libpthread.so.0 (0x000077ed19001000)
	libstdc++.so.6 => /lib64/libstdc++.so.6 (0x000077ed18c7f000)
	libm.so.6 => /lib64/libm.so.6 (0x000077ed1893f000)
	libgcc_s.so.1 => /lib64/libgcc_s.so.1 (0x000077ed18729000)
	libc.so.6 => /lib64/libc.so.6 (0x000077ed1837c000)
	/lib64/ld-linux-x86-64.so.2 (0x000077ed1b000000)
	libexpat.so.1 => /lib64/libexpat.so.1 (0x000077ed1814b000)
	libuuid.so.1 => /lib64/libuuid.so.1 (0x000077ed17f46000)
	libbz2.so.1 => /lib64/libbz2.so.1 (0x000077ed17d36000)
	libxcb.so.1 => /lib64/libxcb.so.1 (0x000077ed17b0e000)
	libgssapi_krb5.so.2 => /lib64/libgssapi_krb5.so.2 (0x000077ed178c2000)
	libkrb5.so.3 => /lib64/libkrb5.so.3 (0x000077ed175de000)
	libcom_err.so.2 => /lib64/libcom_err.so.2 (0x000077ed173da000)
	libk5crypto.so.3 => /lib64/libk5crypto.so.3 (0x000077ed171a9000)
	libXau.so.6 => /lib64/libXau.so.6 (0x000077ed16fa5000)
	libkrb5support.so.0 => /lib64/libkrb5support.so.0 (0x000077ed16d96000)
	libkeyutils.so.1 => /lib64/libkeyutils.so.1 (0x000077ed16b92000)
	libresolv.so.2 => /lib64/libresolv.so.2 (0x000077ed1697c000)
	libselinux.so.1 => /lib64/libselinux.so.1 (0x000077ed16755000)
	libpcre.so.1 => /lib64/libpcre.so.1 (0x000077ed164f3000)
```

### Create package
Main binary file:
```bash
mkdir -p package/bin package/lib package/fonts
cp /opt/usr/local/bin/wkhtmltopdf package/bin/
chmod +x package/bin/wkhtmltopdf
cp -r /usr/share/fonts package/
```
Libraries:
```bash
cp /lib64/libjpeg.so.62 package/lib/
cp /lib64/libpng15.so.15 package/lib/
cp /lib64/libXrender.so.1 package/lib/
cp /lib64/libfontconfig.so.1 package/lib/
cp /lib64/libfreetype.so.6 package/lib/
cp /lib64/libXext.so.6 package/lib/
cp /lib64/libX11.so.6 package/lib/
cp /lib64/libexpat.so.1 package/lib/
cp /lib64/libuuid.so.1 package/lib/
cp /lib64/libbz2.so.1 package/lib/
cp /lib64/libxcb.so.1 package/lib/
cp /lib64/libXau.so.6 package/lib/
cp /lib64/libssl.so.10 package/lib/
cp /lib64/libcrypto.so.10 package/lib/
cp /usr/bin/fc-match bin/
cp /usr/bin/fc-list bin/
```

fonts.conf
Create file in this path
```bash
bash-4.2# ls
bin  fonts  lib
bash-4.2# cd fonts/
bash-4.2# ls
dejavu	fonts.conf
bash-4.2# 
```
Add content:
```bash
cat > fonts.conf <<'EOF'
<?xml version="1.0"?>
<fontconfig>
  <dir>/opt/fonts/dejavu</dir>
  <cachedir>/tmp/fontconfig</cachedir>
</fontconfig>
EOF

```

### Zip Package
```bash
cd package
zip -r ../wkhtmltopdf-lambda.zip .
```




## Documentation Download
```bash
https://wkhtmltopdf.org/downloads.html#how-do-i-use-it-in-aws-lambda
```