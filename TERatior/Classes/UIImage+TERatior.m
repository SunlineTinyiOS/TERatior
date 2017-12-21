//
//  UIImage+TERatior.m
//  Pods
//
//  Created by kingdomrain on 2017/12/21.
//
//

#import "UIImage+TERatior.h"
#import "NSBundle+TERatior.h"

@implementation UIImage (TEGestrueLock)

+ (UIImage *)TERatiorImageNamed:(NSString *)name {
    return [self my_imageNamed:name inBundle:[NSBundle TERatiorLockBundle]];
}
+ (UIImage *)my_imageNamed:(NSString *)name inBundle:(NSBundle *)bundle {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    return [UIImage imageNamed:name inBundle:bundle compatibleWithTraitCollection:nil];
#elif __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_8_0
    return [UIImage imageWithContentsOfFile:[bundle pathForResource:name ofType:@"png"]];
#else
    if ([UIImage respondsToSelector:@selector(imageNamed:inBundle:compatibleWithTraitCollection:)]) {
        return [UIImage imageNamed:name inBundle:bundle compatibleWithTraitCollection:nil];
    } else {
        return [UIImage imageWithContentsOfFile:[bundle pathForResource:name ofType:@"png"]];
    }
#endif
}

@end
