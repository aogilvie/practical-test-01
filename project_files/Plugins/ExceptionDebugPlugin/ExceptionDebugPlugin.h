#import <Foundation/Foundation.h>

#ifdef CORDOVA_FRAMEWORK
#import <Cordova/CDVPlugin.h>
#import <Cordova/CDVCordovaView.h>
#else
#import "CDVPlugin.h"
#import "CDVCordovaView.h"
#endif

@interface CDVCordovaView(ExceptionDebug)
@end

@interface ExceptionDebugPlugin : CDVPlugin
+ (ExceptionDebugPlugin*) sharedInstance;
- (CDVPlugin*)initWithWebView:(UIWebView*)webView;
- (void)ready:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;
@end
