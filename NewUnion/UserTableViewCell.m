//
//  UserTableViewCell.m
//  NewUnion
//
//  Created by ChjpCoj on 19/03/16.
//  Copyright © 2016 ChjpCoj. All rights reserved.
//

#import "UserTableViewCell.h"

@implementation UserTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.contentView.autoresizesSubviews = NO;
    self.contentView.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
