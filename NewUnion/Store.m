//
//  Store.m
//  NewUnion
//
//  Created by ChjpCoj on 19/03/16.
//  Copyright © 2016 ChjpCoj. All rights reserved.
//

#import "Store.h"

@implementation Store

+ (id) shareInstance{
    static Store        *shareIns = nil;
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        shareIns = [[Store alloc] init];
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

- (void) setupVariable {
    
    self.listUsers = [NSMutableArray new];
    
}

@end
