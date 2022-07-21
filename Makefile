TARGET := iphone:clang:latest:13.0
INSTALL_TARGET_PROCESSES = SpringBoard

FINALPACKAGE = 1
DEBUG = 0
THEOS_LEAN_AND_MEAN = 1

# iproxy 2222 22
## ssh-copy-id -p 2222 root@ #127.0.0.1

export THEOS_DEVICE_IP=127.0.0.1
export THEOS_DEVICE_PORT=2222

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = AfterRespring
TWEAKNAME_LIBRARIES = gcuniversal

AfterRespring_FILES = $(shell find Sources/AfterRespring -name '*.swift') $(shell find Sources/AfterRespringC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
AfterRespring_SWIFTFLAGS = -ISources/AfterRespringC/include
AfterRespring_CFLAGS = -fobjc-arc -ISources/AfterRespringC/include

include $(THEOS_MAKE_PATH)/tweak.mk
