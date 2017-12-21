//
//  NSBundle+TEGestrueLock.m
//  Pods
//
//  Created by kingdomrain on 2017/5/10.
//
//

#import "NSBundle+TERatior.h"
#import "TERatior.h"

@implementation NSBundle (TEGestrueLock)
+ (NSBundle *)TERatiorLockBundle {
    return [self bundleWithURL:[self TERatiorLockBundleURL]];
}
+ (NSURL *)TERatiorLockBundleURL {
    NSBundle *bundle = [NSBundle bundleForClass:[TERatior class]];
    return [bundle URLForResource:@"TERatior" withExtension:@"bundle"];
}

@end
