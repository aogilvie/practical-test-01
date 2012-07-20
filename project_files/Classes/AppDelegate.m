/* AppDelegate
 *
 * @author Ally Ogilvie
 * @copyright WizCorp Inc. [ Incorporated Wizards ] 2012
 * @file AppDelegate.m
 *
 */

#import "AppDelegate.h"
#import "MainViewController.h"

#ifdef CORDOVA_FRAMEWORK
    #import <Cordova/CDVPlugin.h>
#else
    #import "CDVPlugin.h"
#endif

#import "GlobalStore.h"

@implementation AppDelegate

@synthesize window, viewController;
@synthesize gameConfig;

+ (NSMutableDictionary*)getGameConfig
{
    // Path to the plist (in the application bundle)
    NSString *path = [[NSBundle mainBundle] pathForResource:
                      @"gameConfig" ofType:@"plist"];
    
    // Build dictionary from the plist  
    NSMutableDictionary *gameConfig = [[[NSMutableDictionary alloc] initWithContentsOfFile:path] autorelease];
    
    return gameConfig;
}

- (id) init
{	
	/** If you need to do any extra app-specific initialization, you can do it here
	 *  -jm
	 **/
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage]; 
    [cookieStorage setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
        
    // [CDVURLProtocol registerURLProtocol];
    
    return [super init];
}

#pragma UIApplicationDelegate implementation

/**
 * This is main kick off after the app inits, the views and Settings are setup here. (preferred - iOS4 and up)
 */
- (BOOL) application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{    
    NSURL* url = [launchOptions objectForKey:UIApplicationLaunchOptionsURLKey];
    NSString* invokeString = nil;
    
    if (url && [url isKindOfClass:[NSURL class]]) {
        invokeString = [url absoluteString];
		NSLog(@"GGPtest launchOptions = %@", url);
    }    
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    self.window = [[[UIWindow alloc] initWithFrame:screenBounds] autorelease];
    self.window.autoresizesSubviews = YES;
    
    CGRect viewBounds = [[UIScreen mainScreen] applicationFrame];
    
    self.viewController = [[[MainViewController alloc] init] autorelease];
    self.viewController.useSplashScreen = YES;
    
    // set SPLASH on resume
    BOOL enableSplashOnGotoBackground  = [[[AppDelegate getGameConfig] objectForKey:@"enableSplashOnGotoBackground"]boolValue];
    NSLog(@"[SPLASH BACKGROUND] ******* DEFAULT enableSplashOnGotoBackground  %i", enableSplashOnGotoBackground );
    Store* myStore = [Store sharedStore];
    myStore.enableSplashOnGotoBackground = enableSplashOnGotoBackground;
    
    // set HTML file folder
    NSString *wwwFolder = [[AppDelegate getGameConfig] objectForKey:@"wwwPath"];
    if (!wwwFolder){
        NSLog(@"ERROR no www directory string specified in game config");
    } else {
        self.viewController.wwwFolderName = wwwFolder;
    }
    
    
    // set boot FILE
    BOOL testMode  = [[[AppDelegate getGameConfig] objectForKey:@"testMode"]boolValue];
    if (testMode==0) {
        NSString *gameIndex = [[AppDelegate getGameConfig] objectForKey:@"gameIndexPath"];
        
        if (!gameIndex){
            NSLog(@"ERROR no game index html file specified in game config");
        } else {
            NSLog(@"--------- --------- LIVE MODE --------- --------- [%@] " , gameIndex);
            self.viewController.startPage = gameIndex;
        }
        
    } else {
        
        NSString *testIndex = [[AppDelegate getGameConfig] objectForKey:@"testIndexPath"];
        if (!testIndex){
            NSLog(@"ERROR no test index html file specified in game config");
        } else {
            NSLog(@"--------- --------- TEST MODE --------- --------- [%@] ", testIndex);
            self.viewController.startPage = testIndex;
        }
        
    }
    
    
    self.viewController.invokeString = invokeString;
    self.viewController.view.frame = viewBounds;
    
    // check whether the current orientation is supported: if it is, keep it, rather than forcing a rotation
    BOOL forceStartupRotation = YES;
    UIDeviceOrientation curDevOrientation = [[UIDevice currentDevice] orientation];
    
    if (UIDeviceOrientationUnknown == curDevOrientation) {
        // UIDevice isn't firing orientation notifications yet… go look at the status bar
        curDevOrientation = (UIDeviceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    }
    
    if (UIDeviceOrientationIsValidInterfaceOrientation(curDevOrientation)) {
        for (NSNumber *orient in self.viewController.supportedOrientations) {
            if ([orient intValue] == curDevOrientation) {
                forceStartupRotation = NO;
                break;
            }
        }
    } 
    
    if (forceStartupRotation) {
        NSLog(@"supportedOrientations: %@", self.viewController.supportedOrientations);
        // The first item in the supportedOrientations array is the start orientation (guaranteed to be at least Portrait)
        UIInterfaceOrientation newOrient = [[self.viewController.supportedOrientations objectAtIndex:0] intValue];
        NSLog(@"AppDelegate forcing status bar to: %d from: %d", newOrient, curDevOrientation);
        [[UIApplication sharedApplication] setStatusBarOrientation:newOrient];
    }
    
    [self.window setRootViewController:self.viewController];
    [self.window addSubview:self.viewController.view];
    [self.window makeKeyAndVisible];
    
    return YES;
}

// this happens while we are running ( in the background, or from within our own app )
// only valid if GGPtest-Info.plist specifies a protocol to handle
- (BOOL) application:(UIApplication*)application handleOpenURL:(NSURL*)url 
{
    if (!url) { 
        return NO; 
    }
    
	// calls into javascript global function 'handleOpenURL'
    NSString* jsString = [NSString stringWithFormat:@"handleOpenURL(\"%@\");", url];
    [self.viewController.webView stringByEvaluatingJavaScriptFromString:jsString];
    
    // all plugins will get the notification, and their handlers will be called 
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:CDVPluginHandleOpenURLNotification object:url]];
    
    return YES;   
}


- (void)applicationDidTerminate:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}






- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
//    [super applicationDidBecomeActive:application]; 
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    Store* myStore = [Store sharedStore];
    BOOL enable = myStore.enableSplashOnGotoBackground;
    
    NSLog(@"[SPLASH BACKGROUND] ******* enableSplashOnGotoBackground  %i", enable );
    
    if (enable==1) {
        
       // [self showPGSplash];
        
    } else if (enable==0) {
        
        // do nothing enableSplashOnBackground is false
        
    } else {
        // default behaviour
        BOOL enableSplashOnGotoBackground  = [[[AppDelegate getGameConfig] objectForKey:@"enableSplashOnGotoBackground"]boolValue];
        NSLog(@"[SPLASH BACKGROUND] ******* DEFAULT enableSplashOnGotoBackground  %i", enableSplashOnGotoBackground );
        if (enableSplashOnGotoBackground==1) {
            
           // [self showPGSplash]; 
            
        }
    }
    
    
    
}


- (void) dealloc
{
	[super dealloc];
}

@end
