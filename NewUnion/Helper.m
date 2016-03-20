//
//  Helper.m
//  NewUnion
//
//  Created by ChjpCoj on 19/03/16.
//  Copyright © 2016 ChjpCoj. All rights reserved.
//

#import "Helper.h"

@implementation Helper

+ (id) shareInstance{
    static Helper        *shareIns = nil;
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        shareIns = [[Helper alloc] init];
    });
    
    return shareIns;
}

- (id) init{
    self = [super init];
    if (self) {
        [self setupVariable];
    }
    
    return self;
}

- (void) setupVariable{
    
    internetManager = [AFNetworkReachabilityManager manager];
    [internetManager startMonitoring];
    
}

- (BOOL) checkConnected {
    
    AFNetworkReachabilityStatus _networkStatus = [internetManager networkReachabilityStatus];
    switch (_networkStatus) {
        case AFNetworkReachabilityStatusNotReachable:
            return NO;
            break;
            
        case AFNetworkReachabilityStatusReachableViaWiFi:
            return YES;
            break;
            
        case AFNetworkReachabilityStatusReachableViaWWAN:
            return YES;
            break;
            
        case AFNetworkReachabilityStatusUnknown:
            return NO;
            break;
            
        default:
            break;
    }
    
}

- (BOOL) validateEmail:(NSString*)_email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailValid = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailValid evaluateWithObject:_email];
    
}

@end
