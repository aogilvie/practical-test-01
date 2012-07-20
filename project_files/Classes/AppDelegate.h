/* AppDelegate
 *
 * @author Ally Ogilvie
 * @copyright WizCorp Inc. [ Incorporated Wizards ] 2012
 * @file AppDelegate.h
 *
 */

#import <UIKit/UIKit.h>

#ifdef CORDOVA_FRAMEWORK
    #import <Cordova/CDVViewController.h>
#else
    #import "CDVViewController.h"
#endif


@interface AppDelegate : NSObject < UIApplicationDelegate > {
    NSMutableDictionary* gameConfig;
}

// invoke string is passed to your app on launch, this is only valid if you 
// edit GGPtest-Info.plist to add a protocol
// a simple tutorial can be found here : 
// http://iphonedevelopertips.com/cocoa/launching-your-own-application-via-a-custom-url-scheme.html

@property (nonatomic, retain) IBOutlet UIWindow* window;
@property (nonatomic, retain) IBOutlet CDVViewController* viewController;
@property (nonatomic, retain) NSMutableDictionary* gameConfig;


+getGameConfig;

@end

