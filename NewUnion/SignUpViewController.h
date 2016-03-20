//
//  SignUpViewController.h
//  NewUnion
//
//  Created by ChjpCoj on 18/03/16.
//  Copyright © 2016 ChjpCoj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "Helper.h"

@interface SignUpViewController : UIViewController <UITextFieldDelegate>
{
    Helper                              *helperIns;
    UIBarButtonItem                     *btnLeftButtonItem;
}

@property (nonatomic, strong) UITextField           *activeField;

@property (strong, nonatomic) IBOutlet UIScrollView *mainScroll;
@property (strong, nonatomic) IBOutlet UITextField *tfFullname;
@property (strong, nonatomic) IBOutlet UITextField *tfEmail;
@property (strong, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *waiting;
@property (strong, nonatomic) IBOutlet UIButton *btnCreateAccount;

@end
