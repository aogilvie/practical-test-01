/* AppDelegate
 *
 * @author Ally Ogilvie 
 * @copyright WizCorp Inc. [ Incorporated Wizards ] 2012
 * @file AppDelegate.m
 *
 */

#import "MainViewController.h"
#import "AppDelegate.h"

#import "GlobalStore.h"
#import "WizAssetsPluginExtendCDVViewController.h"


@implementation MainViewController
@synthesize onReboot;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        onReboot = FALSE;
    }
    return self;
}

- (void) didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void) viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

/* Comment out the block below to over-ride */
/*
- (CDVCordovaView*) newCordovaViewWithFrame:(CGRect)bounds
{
    return[super newCordovaViewWithFrame:bounds];
}
*/

/* Comment out the block below to over-ride */
/*
#pragma CDVCommandDelegate implementation

- (id) getCommandInstance:(NSString*)className
{
	return [super getCommandInstance:className];
}

- (BOOL) execute:(CDVInvokedUrlCommand*)command
{
	return [super execute:command];
}

- (NSString*) pathForResource:(NSString*)resourcepath;
{
	return [super pathForResource:resourcepath];
}
 
- (void) registerPlugin:(CDVPlugin*)plugin withClassName:(NSString*)className
{
    return [super registerPlugin:plugin withClassName:className];
}
*/

#pragma UIWebDelegate implementation

- (void) webViewDidFinishLoad:(UIWebView*) theWebView 
{
     // only valid if ___PROJECTNAME__-Info.plist specifies a protocol to handle
     if (self.invokeString)
     {
        // this is passed before the deviceready event is fired, so you can access it in js when you receive deviceready
        NSString* jsString = [NSString stringWithFormat:@"var invokeString = \"%@\";", self.invokeString];
        [theWebView stringByEvaluatingJavaScriptFromString:jsString];
     }
     
     // Black base color for background matches the native apps
     theWebView.backgroundColor = [UIColor blackColor];

	return [super webViewDidFinishLoad:theWebView];
}

/* Comment out the block below to over-ride */


- (void) webViewDidStartLoad:(UIWebView*)theWebView 
{
    // Create the native splash / game loader (ALL options optional / no options pass NULL)
    // Create MUST be called so that it can be used from Javascript
    
    NSLog(@"[MainViewController] ---------- onReboot %i", onReboot);
    if (!onReboot) {
        
        [self createCustomLoader:NULL];
        NSLog(@"[MainViewController] ---------- Created Spinner");
        
        
        BOOL enableCustomLoaderAtSplash  = [[[AppDelegate getGameConfig] objectForKey:@"enableCustomLoaderAtSplash"]boolValue];
        if (enableCustomLoaderAtSplash==1) {
            NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"middle",                     @"position",
                                     @"0.7",                        @"opacity",
                                     @"white",                      @"spinnerColour",
                                     @"white",                      @"textColour",
                                     @"Initializing Game Engine..", @"labelText",
                                     nil];
            [self showCustomLoader:options];
            
        }
        
    }
    
    
	return [super webViewDidStartLoad:theWebView];
}

 /*
- (void) webView:(UIWebView*)theWebView didFailLoadWithError:(NSError*)error 
{
	return [super webView:theWebView didFailLoadWithError:error];
}
*/

- (BOOL) webView:(UIWebView*)theWebView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
   
    
    return [super webView:theWebView shouldStartLoadWithRequest:request navigationType:navigationType];
}

-(void) timedRestart:(NSTimer*)theTimer
{
    // gives time for our JS method to execute splash
    [[theTimer userInfo] reload];
}

@end
