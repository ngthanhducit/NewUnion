//
//  NUTextField.m
//  NewUnion
//
//  Created by ChjpCoj on 19/03/16.
//  Copyright © 2016 ChjpCoj. All rights reserved.
//

#import "NUTextField.h"

@implementation NUTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void) layoutSubviews{
    [super layoutSubviews];
}

- (void) setup{
    
    [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    
    self.leftViewMode = UITextFieldViewModeAlways;
    
    [self setDelegate:self];
}

- (CGRect) textRectForBounds:(CGRect)bounds{
    return CGRectInset(bounds, 20, 20);
}

- (CGRect)editingRectForBounds:(CGRect)bounds{
    return CGRectInset(bounds, 20, 20);
}

@end
