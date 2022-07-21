SYSROOT = $(THEOS)/sdks/iPhoneOS14.4.sdk/
ARCHS = arm64 arm64e
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
$(TWEAK_NAME)_EXTRA_FRAMEWORKS = Cephei
$(TWEAK_NAME)_LIBRARIES = gcuniversal

AfterRespring_FILES = $(shell find Sources/AfterRespring -name '*.swift') $(shell find Sources/AfterRespringC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
AfterRespring_SWIFTFLAGS = -ISources/AfterRespringC/include
AfterRespring_CFLAGS = -fobjc-arc -ISources/AfterRespringC/include

BUNDLE_NAME = AfterRespringPrefs
$(BUNDLE_NAME)_FILES = $(shell find Sources/$(BUNDLE_NAME) -name '*.swift')
$(BUNDLE_NAME)_INSTALL_PATH = /Library/PreferenceBundles
$(BUNDLE_NAME)_CFLAGS = -fobjc-arc
$(BUNDLE_NAME)_FRAMEWORKS = Preferences
$(BUNDLE_NAME)_EXTRA_FRAMEWORKS = Cephei CepheiPrefs
$(BUNDLE_NAME)_LIBRARIES = gcuniversal

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/bundle.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p "$(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences"$(ECHO_END)
	$(ECHO_NOTHING)cp Resources/entry.plist "$(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/$(BUNDLE_NAME).plist"$(ECHO_END)
