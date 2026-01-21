FROM amazonlinux:2

# Instalar dependencias básicas + librerías que wkhtmltopdf necesita
RUN yum -y update && \
    yum -y install \
        zip \
        unzip \
        tree \
        nano \
        fontconfig \
        fontconfig-devel \
        freetype \
        libX11 \
        libXext \
        libXrender \
        xorg-x11-fonts-100dpi \
        xorg-x11-fonts-75dpi \
        xorg-x11-utils \
        tar \
        gzip \
        rpm2cpio \
        cpio \
        wget \
        which \
        libjpeg-turbo \
        libpng \
        libXinerama \
        libXrandr \
        libXtst \
        libXv \
        libXxf86dga \
        libXxf86misc \
        libXxf86vm \
        libdmx \
        libXau \
        libXi \
        pkgconfig \
        xorg-x11-font-utils \
        dejavu-sans-fonts \
        dejavu-fonts-common \
    && yum clean all

# Copiar RPM dentro del contenedor
COPY wkhtmltox-0.12.6-1.amazonlinux2.x86_64.rpm /tmp/

# Extraer RPM a /opt
RUN cd /opt && \
    rpm2cpio /tmp/wkhtmltox-0.12.6-1.amazonlinux2.x86_64.rpm | cpio -idmv

# Configurar rutas
ENV PATH="/opt/usr/local/bin:${PATH}"
ENV LD_LIBRARY_PATH="/opt/usr/local/lib"
ENV FONTCONFIG_PATH="/opt/usr/local/share/fonts"

WORKDIR /opt

CMD ["/bin/bash"]

