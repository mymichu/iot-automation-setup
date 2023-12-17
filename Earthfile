VERSION 0.7

FROM alpine:3.19

all:
    BUILD +buildarm 
    BUILD +buildhost
 
builder:
    RUN apk add --no-cache \
        cmake \
        make \
        git

builderhost:
    FROM +builder
    RUN apk add --no-cache \
        clang \
        linux-headers 

builderarm:
    FROM +builder
    RUN apk add --no-cache \
        gcc-arm-none-eabi \
        g++-arm-none-eabi \
        binutils-arm-none-eabi \
        newlib-arm-none-eabi 

buildarm:
    FROM +builderarm 
    COPY --dir devices /devices
    COPY --dir application /application
    COPY CMakeLists.txt /CMakeLists.txt
    COPY toolchainBSPIotNode.cmake /toolchainBSPIotNode.cmake
    RUN mkdir -p /build
    WORKDIR /build
    RUN --mount=type=cache,target=3rdparty,sharing=shared cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=../toolchainBSPIotNode.cmake  ..
    RUN --mount=type=cache,target=/build/CMakeFiles,sharing=private make
    SAVE ARTIFACT bin/blinky_app AS LOCAL "output-arm/blinky"
    SAVE ARTIFACT bin/blinky_app.bin AS LOCAL "output-arm/blinky.bin"
    SAVE ARTIFACT bin/blinky_app.hex AS LOCAL "output-arm/blinky.hex"
    SAVE ARTIFACT bin/blinky_app.map AS LOCAL "output-arm/blinky.map"
    SAVE ARTIFACT bin/flash.jLink AS LOCAL "output-arm/blinky.jLink"

buildhost:
    FROM +builderhost 
    COPY --dir application /application
    COPY CMakeLists.txt /CMakeLists.txt
    RUN mkdir -p /build
    WORKDIR /build
    RUN --mount=type=cache,target=3rdparty,sharing=shared cmake -DCMAKE_BUILD_TYPE=Release  ..
    RUN --mount=type=cache,target=/build/CMakeFiles,sharing=private make
    RUN ctest