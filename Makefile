TWEAK_NAME = StayStatusBar
StayStatusBar_FILES = Tweak.xm

BUNDLE_NAME = StayStatusBaPreferences
StayStatusBaPreferences_OBJC_FILES = StayStatusBaPreferences.m
StayStatusBaPreferences_FRAMEWORKS = UIKit Foundation CoreFoundation CoreGraphics GraphicsServices
StayStatusBaPreferences_PRIVATE_FRAMEWORKS = SpringBoardServices Preferences
StayStatusBaPreferences_INSTALL_PATH = /System/Library/PreferenceBundles

include theos/makefiles/common.mk
include theos/makefiles//tweak.mk
include theos/makefiles//bundle.mk