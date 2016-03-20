//
//  Helper.h
//  NewUnion
//
//  Created by ChjpCoj on 19/03/16.
//  Copyright © 2016 ChjpCoj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworkReachabilityManager.h>

@interface Helper : NSObject
{
    AFNetworkReachabilityManager            *internetManager;
}

+ (id) shareInstance;

- (BOOL) checkConnected;
- (BOOL) validateEmail:(NSString*)_email;
@end
