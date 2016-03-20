//
//  User.h
//  NewUnion
//
//  Created by ChjpCoj on 3/19/16.
//  Copyright © 2016 ChjpCoj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
{
    
}

@property (nonatomic, copy) NSString            *user_id;
@property (nonatomic, copy) NSString            *avatar;
@property (nonatomic, copy) NSString            *email;
@property (nonatomic, copy) NSString            *name;
@property (nonatomic, copy) NSString            *created;

@end
