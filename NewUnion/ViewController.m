//
//  ViewController.m
//  NewUnion
//
//  Created by ChjpCoj on 18/03/16.
//  Copyright © 2016 ChjpCoj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initVariable];
    [self initUI];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self initNotification];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self removeNotification];
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void) initVariable{
    storeIns = [Store shareInstance];
    helperIns = [Helper shareInstance];
}

- (void) initUI{
    
    self.tfUserName.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tfUserName.layer.borderWidth = 0.5f;
    self.tfUserName.layer.cornerRadius = 5.0f;
    [self.tfUserName setDelegate:self];
    
    self.tfPassword.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tfPassword.layer.borderWidth = 0.5f;
    self.tfPassword.layer.cornerRadius = 5.0f;
    [self.tfPassword setDelegate:self];
    
    self.btnLogin.layer.cornerRadius = 5.0f;
    self.btnSignUp.layer.cornerRadius = 5.0f;
}

- (void) initNotification{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void) removeNotification{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    
}

#pragma -mark KEYBOARD DELEGATE
- (void)keyboardDidShow:(NSNotification *)notification {
    
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height + 150, 0.0);
    self.mainScroll.contentInset = contentInsets;
    self.mainScroll.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbRect.size.height;
    if (self.activeField) {
        if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
            [self.mainScroll scrollRectToVisible:self.activeField.frame animated:YES];
        }
    }
    
}

- (void)keyboardWillBeHidden:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.mainScroll.contentInset = contentInsets;
    self.mainScroll.scrollIndicatorInsets = contentInsets;
    [self.mainScroll setScrollEnabled:NO];
}

#pragma -mark UITextField Delegate
- (void) textFieldDidBeginEditing:(UITextField *)textField{
    [self.mainScroll setScrollEnabled:YES];
    self.activeField = textField;
}

- (void) textFieldDidEndEditing:(UITextField *)textField{
    self.activeField = nil;
}

- (IBAction)btnLoginTouch:(id)sender {
    
    [self.view endEditing:YES];
    
    BOOL isConnected = [helperIns checkConnected];
    if (!isConnected) {
        UIAlertView *_alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"No connection. Please check internet and try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [_alert show];
        return;
    }
    
    if ([self.tfUserName.text isEqualToString:@""]) {
        UIAlertView *_alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Email can't be empty" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [_alert show];
        return;
    }
    
    BOOL isValid = [helperIns validateEmail:self.tfUserName.text];
    if (!isValid) {
        UIAlertView *_alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Format email invalid" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [_alert show];
        return;
    }
    
    if ([self.tfPassword.text isEqualToString:@""]) {
        UIAlertView *_alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please enter your password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [_alert show];
        return;
    }
    
    [self.btnLogin setHidden:YES];
    [self.btnSignUp setEnabled:NO];
    
    [self.waiting startAnimating];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *parameters = @{@"email" : self.tfUserName.text, @"password" : self.tfPassword.text};
    [manager POST:@"http://54.255.201.10:9000/auth/signin" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [manager.requestSerializer setValue:@"m eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJwcm92aWRlciI6ImxvY2FsIiwibmFtZSI6ImRlbW8iLCJlbWFpbCI6ImRlbW9AeWFob28uY29tIiwiX2lkIjoiNTZlZDcyYjQzODEzODQ0MjE1MjZiYzBiIiwiX192IjowLCJjcmVhdGVkIjoiMjAxNi0wMy0xOVQxNTozOTozMi4xODBaIiwiYXZhdGFyIjoiaHR0cHM6Ly9jZG40Lmljb25maW5kZXIuY29tL2RhdGEvaWNvbnMvdXNlci1hdmF0YXItZmxhdC1pY29ucy81MTIvVXNlcl9BdmF0YXItMzMtNTEyLnBuZyJ9.W6N37c6Kg7cwsrJ18krSGhTUr0RlLBRMGVAUPDIy5RU" forHTTPHeaderField:@"authorization"];
        
        [manager GET:@"http://54.255.201.10:9000/users" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSMutableArray *_results = responseObject;
            if (_results && _results.count > 0) {
                NSInteger count = _results.count;
                for (NSInteger i = 0; i < count; i++) {
                    NSDictionary *_user = _results[i];
                    User *_userIns = [User new];
                    [_userIns setUser_id:[_user valueForKey:@"_id"]];
                    [_userIns setAvatar:[_user valueForKey:@"avatar"]];
                    [_userIns setCreated:[_user valueForKey:@"created"]];
                    [_userIns setEmail:[_user valueForKey:@"email"]];
                    [_userIns setName:[_user valueForKey:@"name"]];
                    
                    [storeIns.listUsers addObject:_userIns];
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIWindow *window = [[UIApplication sharedApplication] keyWindow];
                UIStoryboard *_storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UINavigationController *_post = [_storyBoard instantiateViewControllerWithIdentifier:@"list_user_storyboard"];
                window.rootViewController = _post;
            });

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [self.btnSignUp setEnabled:YES];
            [self.waiting stopAnimating];
            [self.btnLogin setHidden:NO];
            UIAlertView *_alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Get users failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [_alert show];
            
        }];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        [self.btnSignUp setEnabled:YES];
        [self.waiting stopAnimating];
        [self.btnLogin setHidden:NO];
        UIAlertView *_alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Login failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [_alert show];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
