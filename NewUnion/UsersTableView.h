//
//  UsersTableView.h
//  NewUnion
//
//  Created by ChjpCoj on 19/03/16.
//  Copyright © 2016 ChjpCoj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserTableViewCell.h"
#import "User.h"
#import <AFNetworking.h>
#import "Store.h"   
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface UsersTableView : UITableView <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray              *itemsSource;
    Store                       *storeIns;
}

@property (nonatomic, strong) UIRefreshControl          *refreshControl;

- (void) initData:(NSMutableArray*)_items;
@end
