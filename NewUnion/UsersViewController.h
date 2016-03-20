//
//  UsersViewController.h
//  NewUnion
//
//  Created by ChjpCoj on 19/03/16.
//  Copyright © 2016 ChjpCoj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Store.h"
#import "UsersTableView.h"
#import <AFNetworking.h>

@interface UsersViewController : UIViewController
{
    Store                   *storeIns;
    UIBarButtonItem         *btnRightLogout;
}

@property (weak, nonatomic) IBOutlet UsersTableView *tbUsers;


@end
