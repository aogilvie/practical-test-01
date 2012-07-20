#import "GlobalStore.h"

@implementation Store

@synthesize deviceTokenStr;  
@synthesize enableSplashOnGotoBackground;

static Store *sharedStore = nil;

+ (Store *) sharedStore {
    @synchronized(self){
        if (sharedStore == nil){
            sharedStore = [[self alloc] init];
        }
    }
    
    return sharedStore;
}

// your init method if you need one

@end
