//
//  SFSafariViewController+My.m
//  Demo
//
//  Created by smart on 2023/6/4.
//

#import "SFSafariViewController+My.h"
#import <objc/runtime.h>

@implementation SFSafariViewController (My)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];

        // Hook init 方法进行代理
        SEL originalSelector = @selector(initWithURL:configuration:);
        SEL swizzledSelector = @selector(my_initWithURL:configuration:);

        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

        BOOL didAddMethod =
            class_addMethod(class,
                            originalSelector,
                            method_getImplementation(swizzledMethod),
                            method_getTypeEncoding(swizzledMethod));

        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (instancetype)my_initWithURL:(NSURL *)URL
                 configuration:(SFSafariViewControllerConfiguration *)configuration {
    
    if ([URL.host isEqualToString:@"auth.particle.network"]) {
        NSURLComponents *comps = [NSURLComponents componentsWithURL:URL resolvingAgainstBaseURL:YES];
        comps.scheme = @"http";
        comps.host = @"127.0.0.1";
        comps.port = @3000;
        URL = comps.URL;
        
        NSLog(@"[My] - HOOK URL : %@", URL);
    } else {
        NSLog(@"[My] - ORIG URL : %@", URL);
    }
    
    SFSafariViewController *vc = [self my_initWithURL:URL configuration:configuration];
    return vc;
}

@end
