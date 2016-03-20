//
//  UsersViewController.m
//  NewUnion
//
//  Created by ChjpCoj on 19/03/16.
//  Copyright © 2016 ChjpCoj. All rights reserved.
//

#import "UsersViewController.h"

@interface UsersViewController ()

@end

@implementation UsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initVariable];
    [self initUI];
}

- (void) initVariable{
    storeIns = [Store shareInstance];
}

- (void) initUI{
    self.title = @"Users";
    [self.tbUsers initData:storeIns.listUsers];
    
    btnRightLogout = [[UIBarButtonItem alloc] initWithTitle:@"LOGOUT" style:UIBarButtonItemStylePlain target:self action:@selector(btnLogoutTouch:)];
    self.navigationItem.leftBarButtonItem = btnRightLogout;
}

- (void) btnLogoutTouch:(id)sender{
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIStoryboard *_storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *_post = [_storyBoard instantiateViewControllerWithIdentifier:@"login_storyboard"];
    window.rootViewController = _post;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
