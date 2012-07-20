/* MainViewController
 *
 * @author Ally Ogilvie
 * @copyright WizCorp Inc. [ Incorporated Wizards ] 2012
 * @file MainViewController.h
 *
 */

#ifdef CORDOVA_FRAMEWORK
    #import <Cordova/CDVViewController.h>
#else
    #import "CDVViewController.h"
#endif

@interface MainViewController : CDVViewController
{
    BOOL onReboot;
}

@property (nonatomic) BOOL onReboot; 

@end
