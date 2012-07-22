/* WizAssetsPluginExtendsCDVViewController - Extend CDVViewController so we can reach top view
 *
 * @author Ally Ogilvie
 * @copyright WizCorp Inc. [ Incorporated Wizards ] 2011
 * @file WizAssetsPluginExtendCDVViewController.m for PhoneGap
 *
 */ 

#import "WizAssetsPluginExtendCDVViewController.h"
#import "WizActivitySpinnerView.h"
#import "WizDebugLog.h"

#define degreesToRadians(x) (M_PI * x / 180.0)

@implementation CDVViewController (extendViews) 






-(CDVViewController*)addNewView:(UIView*)progressView

{
    
    [[UIApplication sharedApplication].keyWindow addSubview:progressView];
    //[self.imageView addSubview:progressView];
    
    return NULL;
}

-(CDVViewController*)removeView:(UIView*)progressView

{
    
    [progressView removeFromSuperview];
    return NULL;
}



-(CDVViewController*)showPGSplash

{
    
    [self.imageView setHidden:FALSE];
    
    return NULL;
}

-(CDVViewController*)hidePGSplash

{
    
    [self.imageView setHidden:TRUE];
    
    return NULL;
}







/*
 * hideCustomLoader - Hide loader components
 */
-(CDVViewController*)hideCustomLoader:(UIView *)progressView
{
    
    
    
    NSLog(@"****************************************** [hideCustomLoader]");
    
    
    // hide components
    for(UIView* spinnerHolder in [UIApplication sharedApplication].keyWindow.subviews) {
        if(spinnerHolder.tag==44){
            // hide spinner
            for(WizActivitySpinnerView*spinnerView in spinnerHolder.subviews) {
                if(spinnerView.tag==45){
                    [spinnerView setHidden:TRUE];
                    [spinnerView setAlpha:0.0];
                }
            }
            for(UITextView*textView in spinnerHolder.subviews) {
                if(textView.tag==46){
                    [textView setHidden:TRUE];
                }
            }
            for(UIView*screen in spinnerHolder.subviews) {
                if(screen.tag==47){
                    [screen setHidden:TRUE];
                }
            }
            
            [spinnerHolder setHidden:TRUE];
        }
        
        
    }
    

    
    return NULL;
}


/*
 * removeSplashLoader
 */
-(CDVViewController*)removeCustomLoader:(UIView *)progressView
{
    NSLog(@"****************************************** remove spinner");
    // remove view
    for(WizActivitySpinnerView*spinnerView in [UIApplication sharedApplication].keyWindow.subviews) {
        if(spinnerView.tag==45){
            [spinnerView removeFromSuperview];
        }
    }
    for(UITextView*textView in self.view.subviews) {
        if(textView.tag==46){
            [textView removeFromSuperview];
        }
    }
    for(UIView*screen in self.view.subviews) {
        if(screen.tag==47){
            [screen removeFromSuperview];
        }
    }
    
    return NULL;
    
}


-(CDVViewController*)rotateCustomLoader:(int)orientation
{
    
    
    for(UIView*spinnerHolder in [UIApplication sharedApplication].keyWindow.subviews) {
        if(spinnerHolder.tag==44){
            NSLog(@"rotating view.. %@ : orientation... %i", spinnerHolder , orientation);
            
            if (orientation == 1) {
                // portrait normal
                
                [spinnerHolder setAutoresizesSubviews:YES];
                
                spinnerHolder.transform = CGAffineTransformMakeRotation(0.0);
                [spinnerHolder setFrame:CGRectMake([UIApplication sharedApplication].keyWindow.bounds.origin.x, [UIApplication sharedApplication].keyWindow.bounds.origin.y, [UIApplication sharedApplication].keyWindow.bounds.size.width, [UIApplication sharedApplication].keyWindow.bounds.size.height)];
                
                for (UITextView*textView in spinnerHolder.subviews) {
                    if (textView.tag == 46) {
                        [textView setCenter:CGPointMake(spinnerHolder.bounds.size.width/2, spinnerHolder.bounds.size.height/0.95)];
                    }
                }
               
            } else if (orientation == 2) {
                // upside down
                
                [spinnerHolder setAutoresizesSubviews:YES];
                spinnerHolder.transform = CGAffineTransformMakeRotation(degreesToRadians(180)); // 180 degrees
                [spinnerHolder setFrame:CGRectMake([UIApplication sharedApplication].keyWindow.bounds.origin.x, [UIApplication sharedApplication].keyWindow.bounds.origin.y, [UIApplication sharedApplication].keyWindow.bounds.size.width, [UIApplication sharedApplication].keyWindow.bounds.size.height)];

                for (UITextView*textView in spinnerHolder.subviews) {
                    if (textView.tag == 46) {
                        [textView setCenter:CGPointMake(spinnerHolder.bounds.size.width/2, spinnerHolder.bounds.size.height/0.95)];
                    }
                }
                
            } else if (orientation == 3) {
                // landscape to left
                
                [spinnerHolder setAutoresizesSubviews:YES];
                spinnerHolder.transform = CGAffineTransformMakeRotation(degreesToRadians(90)); // 90 degress
                [spinnerHolder setFrame:CGRectMake([UIApplication sharedApplication].keyWindow.bounds.origin.x, [UIApplication sharedApplication].keyWindow.bounds.origin.y, [UIApplication sharedApplication].keyWindow.bounds.size.width, [UIApplication sharedApplication].keyWindow.bounds.size.height)];

                for (UITextView*textView in spinnerHolder.subviews) {
                    if (textView.tag == 46) {                        
                        [textView setCenter:CGPointMake(spinnerHolder.bounds.size.width/2, spinnerHolder.bounds.size.height/0.9)];
                    }
                }
                
            } else if (orientation == 4) {
                // landscape to right
                
                [spinnerHolder setAutoresizesSubviews:YES];
                spinnerHolder.transform = CGAffineTransformMakeRotation(degreesToRadians(-90)); // 270 degrees
                [spinnerHolder setFrame:CGRectMake([UIApplication sharedApplication].keyWindow.bounds.origin.x, [UIApplication sharedApplication].keyWindow.bounds.origin.y, [UIApplication sharedApplication].keyWindow.bounds.size.width, [UIApplication sharedApplication].keyWindow.bounds.size.height)];

                for (UITextView*textView in spinnerHolder.subviews) {
                    if (textView.tag == 46) {
                        [textView setCenter:CGPointMake(spinnerHolder.bounds.size.width/2, spinnerHolder.bounds.size.height/0.9)];
                    }
                }
                
            }    
        }
    }
    

    
    
    return NULL;
}


-(CDVViewController*)showCustomLoader:(NSDictionary *)options
{
    
    NSLog(@"****************************************** [showCustomLoader]");
    
    if (options) 
	{
        // use custom options
        bool showSpinner            = [options objectForKey:@"showSpinner"];
        if (!showSpinner) {
            // default show it
            showSpinner = TRUE;
        } 
        
        NSString *pos            = [options objectForKey:@"position"];
        if (!pos) {
            // default values
            pos       = @"middle";
        }  
        
        NSString *spinnerColour                 = [options objectForKey:@"spinnerColour"];
        if (!spinnerColour) {
            // default values
            spinnerColour       = @"white";
        }

        CGFloat opacity                 = [[options objectForKey:@"opacity"] floatValue];
        if (!opacity) {
            // default values
            opacity       = 0.0;
        } 


        NSString *labelText               = [options objectForKey:@"labelText"];
        if (!labelText) {
            // default values
            labelText                       = @"Loading...";
        }

        NSString *textColour                 = [options objectForKey:@"textColour"];
        if (!textColour) {
            // default values
            textColour       = @"white";
        }
        
        CGFloat width = [[options objectForKey:@"width"] floatValue];
        CGFloat height = [[options objectForKey:@"height"] floatValue];
        

        
        // show components
        for(UIView* spinnerHolder in [UIApplication sharedApplication].keyWindow.subviews) {
            if(spinnerHolder.tag==44){
                
                CGRect screenRect = [spinnerHolder bounds];
                CGFloat screenWidth = screenRect.size.width;
                CGFloat screenHeight = screenRect.size.height;
                
                
                // set WizActivitySpinnerView
                for(WizActivitySpinnerView *spinnerView in spinnerHolder.subviews) {
                    if(spinnerView.tag==45){
                        // TODO: Implement colors
                        if ([spinnerColour isEqualToString:@"white"]) {
                            // TODO: white color
                        } else if ([spinnerColour isEqualToString:@"grey"]) {
                            // TODO: grey color
                        } else {
                            // TODO: default color
                        }

                        if ([pos isEqualToString:@"low"]) {
                            
                            [spinnerView setCenter:CGPointMake(screenWidth/2, screenHeight/1.5)];
                            
                        } else if ([pos isEqualToString:@"middle"]) { 
                            
                            [spinnerView setCenter:CGPointMake(screenWidth/2, screenHeight/2)];
                            
                        } else {
                            
                            // default middle
                            [spinnerView setCenter:CGPointMake(screenWidth/2, screenHeight/2)];
                            
                        }
                        
                        if ( width > 0 && height > 0 ) {
                            [spinnerView setSize:CGSizeMake(width, height)];
                        }

                        if (showSpinner == 1) {
                            [spinnerView setHidden:FALSE];
                            [spinnerView setAlpha:1.0];
                            NSLog(@"showSpinner default %i", showSpinner);
                        } else {
                            [spinnerView setHidden:TRUE];
                            [spinnerView setAlpha:0.0];
                            NSLog(@"showSpinner default %i", showSpinner);
                        }
                    }
                }
                // set UITextView
                for(UITextView*textView in spinnerHolder.subviews) {
                    if(textView.tag==46){
                        
                        
                        [textView setText:labelText];
                        [textView setHidden:FALSE];
                                                
                        // move the centre point down so under the spinner (default is portrait)
                        [textView setCenter:CGPointMake(spinnerHolder.bounds.size.width/2, spinnerHolder.bounds.size.height/0.95)];
        
                        
                        // TODO add more colours?
                        if ([textColour isEqualToString:@"white"]) {
                            [textView setTextColor:[UIColor whiteColor]];
                        } else if ([textColour isEqualToString:@"black"]) {
                            [textView setTextColor:[UIColor blackColor]];
                        } else {
                            [textView setTextColor:[UIColor blackColor]];
                        }
                        
                    }
                }
                
                // set back screen
                for(UIView*screen in spinnerHolder.subviews) {
                    if(screen.tag==47){
                        [screen setAlpha:opacity];
                        [screen setHidden:FALSE];
                    }
                }
            }
        }
                
        
    } else {
        // defaults
        
        
        
        // show components
        for(UIView* spinnerHolder in [UIApplication sharedApplication].keyWindow.subviews) {
            if(spinnerHolder.tag==44){
                // show spinner
                for(WizActivitySpinnerView*spinnerView in spinnerHolder.subviews) {
                    if(spinnerView.tag==45){
                        [spinnerView setHidden:FALSE];
                        [spinnerView setAlpha:1.0];
                    }
                }
                // show text label
                for(UITextView*textView in spinnerHolder.subviews) {
                    if(textView.tag==46){
                        [textView setText:@"Loading..."];
                        [textView setHidden:FALSE];
                    }
                }
                // show black screen
                for(UIView*screen in spinnerHolder.subviews) {
                    if(screen.tag==47){
                        CGFloat opacity = 0.4;
                        [screen setAlpha:opacity];
                        [screen setHidden:FALSE];
                    }
                }
            }
        }



        
        
    } 
    
    
    int orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (orientation != 1) {
        [self rotateCustomLoader:orientation];
    }

    
    for(UIView*spinnerHolder in [UIApplication sharedApplication].keyWindow.subviews) {
        if(spinnerHolder.tag==44){
            [spinnerHolder setHidden:FALSE];
        }
    }
    
    return NULL;
}


/*
 * createSplashLoader - Add loader with spinner using options
 */
-(CDVViewController*)createCustomLoader:(NSDictionary *)options
{
    for(UIView*screen in [UIApplication sharedApplication].keyWindow.subviews) {
        if(screen.tag==44){
            NSLog(@"****************************************** ALREADY CREATED SPLASH LOADER - return.");
            return NULL;
        }
    }
    
    NSLog(@"****************************************** CREATE SPLASH LOADER");
    
    
    // defaults
    NSString *pos           = @"middle";              
    NSString *labelText     = @"Loading..."; 
    NSString *textColour    = @"white"; 
    CGFloat opacity         = 0.0 ;            
    NSString *spinnerColour = @"white";
    CGFloat width           = 0.0;
    CGFloat height          = 0.0;

    if (options) 
	{
        // get loader options
        spinnerColour                 = [options objectForKey:@"spinnerColour"];
        if (!spinnerColour) {
            // default values
            spinnerColour       = @"white";
        }
        
        pos            = [options objectForKey:@"position"];
        if (!pos) {
            // default values
            pos       = @"middle";
        }
        
        
        
        labelText               = [options objectForKey:@"labelText"];
        if (!labelText) {
            // default values
            labelText           = @"Loading...";
        }
        
        
        opacity                 = [[options objectForKey:@"opacity"] floatValue];
        if (!opacity) {
            // default values
            opacity             = 0.0;
        }
        
        
        textColour              = [options objectForKey:@"textColour"];
        if (!textColour) {
            // default values
            textColour          = @"white";
        }
        
        width = [[options objectForKey:@"width"] floatValue];
        height = [[options objectForKey:@"height"] floatValue];

    }

    
    
    

    
    // the holder for everything
    UIView *spinnerHolder = [[UIView alloc] initWithFrame:self.view.bounds];
    spinnerHolder.tag = 44;
    spinnerHolder.hidden = TRUE;
    [spinnerHolder setClipsToBounds:TRUE];
    [spinnerHolder setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [spinnerHolder setContentMode:UIViewContentModeScaleToFill];
    [spinnerHolder setAutoresizesSubviews:YES];

    
    CGRect screenRect = spinnerHolder.bounds;
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    
    // the background screen
    UIView *backgroundScreen = [[UIView alloc] initWithFrame:spinnerHolder.bounds];
    backgroundScreen.backgroundColor = [UIColor blackColor];
    backgroundScreen.tag = 47;
    backgroundScreen.alpha = opacity;
    [backgroundScreen setClipsToBounds:TRUE];
    [backgroundScreen setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [backgroundScreen setContentMode:UIViewContentModeScaleToFill];
    
    
    // create spinner
    // Some URLs for testing local and remote loading of custom animated .gif
    // (Invalid URL or non-existent file will fail silently and not display any image)
    // TODO: Add some reasonable error handling and default image
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"custom" ofType:@"gif" inDirectory:nil]];
    //NSURL *url = [NSURL URLWithString:@"https://github.com/aogilvie/practical-test-01/raw/master/custom.gif"];
    //NSURL *url = [NSURL URLWithString:@"http://images.animationfactory.com/thw/thw14/AF/animations/time/clocks/mr_alarm_dragging_feet/4966736.gif?mr_alarm_dragging_feet_lg_wm"];
    WizActivitySpinnerView *activitySpinner = [[WizActivitySpinnerView alloc] initWithImageURL:url];
    [activitySpinner setCenter:CGPointMake(screenWidth/2, screenHeight/1.5)];
    [activitySpinner setAlpha:1.0];
    [activitySpinner setBackgroundColor:[UIColor clearColor]];
    [activitySpinner startAnimating];
    [activitySpinner setTag:45];
    [activitySpinner setClipsToBounds:TRUE];
    [activitySpinner setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin];
    [activitySpinner setContentMode:UIViewContentModeScaleToFill];
    if ( width > 0 && height > 0 ) {
        [activitySpinner setSize:CGSizeMake(width, height)];
    }
    
        
    if ([pos isEqualToString:@"low"]) {
        
        [activitySpinner setCenter:CGPointMake(screenWidth/2, screenHeight/1.5)];
        
    } else if ([pos isEqualToString:@"middle"]) { 
        
        [activitySpinner setCenter:CGPointMake(screenWidth/2, screenHeight/2)];
        
    } else {
        
        // default middle
        [activitySpinner setCenter:CGPointMake(screenWidth/2, screenHeight/2)];
        
    }
    
    // TODO: Implement color handling
    if ([spinnerColour isEqualToString:@"white"]) {
        // TODO: white color
    } else if ([spinnerColour isEqualToString:@"grey"]) {
        // TODO: grey color
    } else {
        // TODO: default color
    }
    
    
    
    // create text..
    UITextView *loaderStatus = [[UITextView alloc] initWithFrame:spinnerHolder.bounds];
    [loaderStatus setTag:46];
    [loaderStatus setTextAlignment:UITextAlignmentCenter];
    [loaderStatus setFont:[UIFont italicSystemFontOfSize:10.0]];
    [loaderStatus setBackgroundColor:([UIColor clearColor])];
    [loaderStatus setScrollEnabled:FALSE];
    [loaderStatus setUserInteractionEnabled:FALSE];
    [loaderStatus setText:labelText];
    [loaderStatus setClipsToBounds:TRUE];
    
    // move the centre point down so under the spinner (default is portrait)
    [loaderStatus setCenter:CGPointMake(spinnerHolder.bounds.size.width/2, spinnerHolder.bounds.size.height/0.95)];

    [loaderStatus setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];    
    
    
    // TODO more colours?
    if ([textColour isEqualToString:@"white"]) {
        [loaderStatus setTextColor:[UIColor whiteColor]];
    } else if ([textColour isEqualToString:@"black"]) {
        [loaderStatus setTextColor:[UIColor blackColor]];
    }
    

    [activitySpinner setHidden:TRUE];
    [activitySpinner setAlpha:0.0];
    [loaderStatus setHidden:TRUE];
    
    [[UIApplication sharedApplication].keyWindow addSubview:spinnerHolder];
    
    
    // add views to screen
    [spinnerHolder addSubview:backgroundScreen];
    [spinnerHolder addSubview:activitySpinner];
    [spinnerHolder addSubview:loaderStatus];
    
    // Leaking memory is bad Ally. Good test though. :)
    // After these release messages are sent, the objects remain allocated
    // (with a retainCount of 1) for as long as they have a superview.
    // The previous code sent retain messages which incremented the retainCounts
    // without ever decrementing retainCounts (via release messages).  Worse, the
    // original code didn't even hang on to the objects as member variables or
    // properties -- so it was not even possible to send release messages later.
    [backgroundScreen release];
    [activitySpinner release];
    [loaderStatus release];
    
    // And don't forget to send a release to spinnerHolder. :)
    [spinnerHolder release];
    
    return NULL;
    
}

-(CDVViewController*)updateLoaderLabel:(NSString *)loaderText
{
    for (UIView*spinnerHolder in [UIApplication sharedApplication].keyWindow.subviews) {
        if(spinnerHolder.tag==44){
            for(UITextView*loaderLabel in spinnerHolder.subviews) {
                if(loaderLabel.tag==46){
                    [loaderLabel setText:loaderText];
                }
            }
        }
    }

    return NULL;
    
}






@end
