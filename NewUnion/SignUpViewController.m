//
//  SignUpViewController.m
//  NewUnion
//
//  Created by ChjpCoj on 18/03/16.
//  Copyright © 2016 ChjpCoj. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initVariable];
    [self initUI];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self initNotification];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self removeNotification];
}

- (void) initVariable{
    helperIns = [Helper shareInstance];
}

- (void) initUI{
    
    btnLeftButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelCreateAccountViewController:)];
    self.navigationItem.leftBarButtonItem = btnLeftButtonItem;
    
    self.tfFullname.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tfFullname.layer.borderWidth = 0.5f;
    self.tfFullname.layer.cornerRadius = 5.0f;
    [self.tfFullname setDelegate:self];
    
    self.tfEmail.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tfEmail.layer.borderWidth = 0.5f;
    self.tfEmail.layer.cornerRadius = 5.0f;
    [self.tfEmail setDelegate:self];
    
    self.tfPassword.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tfPassword.layer.borderWidth = 0.5f;
    self.tfPassword.layer.cornerRadius = 5.0f;
    [self.tfPassword setDelegate:self];
    
    self.btnCreateAccount.layer.cornerRadius = 5.0f;
    
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

- (void) cancelCreateAccountViewController:(id)sender {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

- (IBAction)btnCreateAccountTouch:(id)sender {
    
    [self.view endEditing:YES];
    
    BOOL isConnected = [helperIns checkConnected];
    if (!isConnected) {
        UIAlertView *_alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"No connection. Please check internet and try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [_alert show];
        return;
    }
    
    if ([self.tfFullname.text isEqualToString:@""]) {
        UIAlertView *_alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Name can't be empty" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [_alert show];
        return;
    }
    
    if ([self.tfEmail.text isEqualToString:@""]) {
        UIAlertView *_alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Email can't be empty" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [_alert show];
        return;
    }
    
    BOOL isValid = [helperIns validateEmail:self.tfEmail.text];
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
    
    [btnLeftButtonItem setEnabled:NO];
    [self.btnCreateAccount setHidden:YES];
    [self.waiting startAnimating];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *parameters = @{@"name" : self.tfFullname.text, @"email" : self.tfEmail.text, @"password" : self.tfPassword.text};
    [manager POST:@"http://54.255.201.10:9000/create" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            
        }];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        UIAlertView *_alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Can't create new user. Please check info and try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [_alert show];
        
        [btnLeftButtonItem setEnabled:YES];
        [self.btnCreateAccount setHidden:NO];
        [self.waiting stopAnimating];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
