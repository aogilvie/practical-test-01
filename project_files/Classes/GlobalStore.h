@interface Store : NSObject {
    NSString* deviceTokenStr;
    bool enableSplashOnGotoBackground;
}

@property (nonatomic, retain) NSString* deviceTokenStr;
@property (nonatomic) bool enableSplashOnGotoBackground;

+ (Store *) sharedStore;

@end
