//
//  UserTableViewCell.h
//  NewUnion
//
//  Created by ChjpCoj on 19/03/16.
//  Copyright © 2016 ChjpCoj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserTableViewCell : UITableViewCell
{
    
}
@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblFullName;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;


@end
