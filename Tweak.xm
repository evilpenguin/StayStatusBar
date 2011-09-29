/*
 * StayStatusBar
 * Idea: Keep the status bar form hiding
 * Creator: EvilPenguin (James Emrich)
 * 
 * Idea from Hyshai (hyshai29@gmail.com)
 */

#define StayStatusBar_PLIST @"/var/mobile/Library/Preferences/com.understruction.staystatusbar.plist"
#define isAppEnabled(app) ([plistDict objectForKey:app] ? [[plistDict objectForKey:app] boolValue] : NO)
#define listenToNotification$withCallBack(notification, callback); 	\
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), \
        NULL, \
        (CFNotificationCallback)&callback, \
        CFSTR(notification), \
        NULL, \
        CFNotificationSuspensionBehaviorHold);

@interface UIApplication ()
    - (id) displayIdentifier;
@end

static NSMutableDictionary *plistDict = nil;
static BOOL isEnabled;

static void loadSettings() {
    NSLog(@"StayStatusBar: I put you in the corner and make you stay!");
	if (plistDict) {
		[plistDict release];
		plistDict = nil;
	}
	plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:StayStatusBar_PLIST];
    if (plistDict == nil) { plistDict = [[NSMutableDictionary alloc] init]; }
	isEnabled = [plistDict objectForKey:@"enabled"] ? [[plistDict objectForKey:@"enabled"] boolValue] : YES;
}

%hook UIApplication
- (void)setStatusBarHidden:(BOOL)hidden animationParameters:(id)arg2 changeApplicationFlag:(BOOL)arg3 {
	if (isEnabled) {
		if (isAppEnabled([self displayIdentifier])) { 
			hidden = NO;
		}
	}
	%orig(hidden, arg2, arg3);
}
- (void)setStatusBarHidden:(BOOL)hidden animationParameters:(id)arg2{
	if (isEnabled) {
		if (isAppEnabled([self displayIdentifier])) { 
			hidden = NO;
		}
	}
	%orig(hidden, arg2);
}

- (void)setStatusBarHidden:(BOOL)hidden duration:(double)arg2 changeApplicationFlag:(BOOL)arg3 {
	if (isEnabled) {
		if (isAppEnabled([self displayIdentifier])) { 
			hidden = NO;
		}
	}
	%orig(hidden, arg2, arg3);
}

- (void)setStatusBarHidden:(BOOL)hidden duration:(double)arg2 {
	if (isEnabled) {
		if (isAppEnabled([self displayIdentifier])) { 
			hidden = NO;
		}
	}
	%orig(hidden, arg2);
}

- (void)setStatusBarHidden:(BOOL)hidden withAnimation:(int)arg2 {
	if (isEnabled) {
		if (isAppEnabled([self displayIdentifier])) { 
			hidden = NO;
		}
	}
	%orig(hidden, arg2);
}

- (void) setStatusBarHidden:(BOOL)hidden {
	if (isEnabled) {
		if (isAppEnabled([self displayIdentifier])) { 
			hidden = NO;
		}
	}
	%orig(hidden);
}
%end

%ctor {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	%init;
	listenToNotification$withCallBack("com.understruction.staystatusbar.update", loadSettings);
	loadSettings();
	[pool drain];
}