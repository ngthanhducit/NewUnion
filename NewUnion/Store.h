//
//  Store.h
//  NewUnion
//
//  Created by ChjpCoj on 19/03/16.
//  Copyright © 2016 ChjpCoj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Store : NSObject
{
    
}

+ (id) shareInstance;

@property (nonatomic, strong) NSMutableArray    *listUsers;

@end
