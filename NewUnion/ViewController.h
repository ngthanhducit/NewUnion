//
//  ViewController.h
//  NewUnion
//
//  Created by ChjpCoj on 18/03/16.
//  Copyright © 2016 ChjpCoj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import "Store.h"   
#import "UsersViewController.h"
#import "User.h"
#import "Helper.h"

@interface ViewController : UIViewController <UITextFieldDelegate>
{
    Store                       *storeIns;
    Helper                      *helperIns;
}

@property (nonatomic, strong) UITextField           *activeField;

@property (strong, nonatomic) IBOutlet UIScrollView *mainScroll;
@property (strong, nonatomic) IBOutlet UITextField *tfUserName;
@property (strong, nonatomic) IBOutlet UITextField *tfPassword;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *waiting;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) IBOutlet UIButton *btnSignUp;

@end

