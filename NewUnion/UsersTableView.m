//
//  UsersTableView.m
//  NewUnion
//
//  Created by ChjpCoj on 19/03/16.
//  Copyright © 2016 ChjpCoj. All rights reserved.
//

#import "UsersTableView.h"

#define USER_CELL_IDENTIFY @"user_identify_cell"

@implementation UsersTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) awakeFromNib{
    [self initVariable];
}

- (void) initVariable{
    itemsSource = [NSMutableArray new];
    storeIns = [Store shareInstance];
    
    [self setDelegate:self];
    [self setDataSource:self];
    [self setShowsHorizontalScrollIndicator:NO];
    [self setShowsVerticalScrollIndicator:NO];
    
    self.estimatedRowHeight = UITableViewAutomaticDimension;
    self.rowHeight = 80.0f;
    
    self.bounces = YES;
    self.alwaysBounceVertical = YES;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getLatestUsers) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.refreshControl];
}

- (void) getLatestUsers{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"m eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJwcm92aWRlciI6ImxvY2FsIiwibmFtZSI6ImRlbW8iLCJlbWFpbCI6ImRlbW9AeWFob28uY29tIiwiX2lkIjoiNTZlZDcyYjQzODEzODQ0MjE1MjZiYzBiIiwiX192IjowLCJjcmVhdGVkIjoiMjAxNi0wMy0xOVQxNTozOTozMi4xODBaIiwiYXZhdGFyIjoiaHR0cHM6Ly9jZG40Lmljb25maW5kZXIuY29tL2RhdGEvaWNvbnMvdXNlci1hdmF0YXItZmxhdC1pY29ucy81MTIvVXNlcl9BdmF0YXItMzMtNTEyLnBuZyJ9.W6N37c6Kg7cwsrJ18krSGhTUr0RlLBRMGVAUPDIy5RU" forHTTPHeaderField:@"authorization"];
    
    [manager GET:@"http://54.255.201.10:9000/users" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray *_results = responseObject;
        if (_results && _results.count > 0) {
            storeIns.listUsers = [NSMutableArray new];
            
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
            
            [self initData:storeIns.listUsers];
        }
        
        [self.refreshControl endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.refreshControl endRefreshing];
        
    }];
}

- (void) initData:(NSMutableArray*)_items{
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"created" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *_sortResults = [_items sortedArrayUsingDescriptors:sortDescriptors];
    itemsSource = [[NSMutableArray alloc] initWithArray:_sortResults];
    [self reloadData];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return itemsSource.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0f;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UserTableViewCell *nuCell = nil;
    nuCell = (UserTableViewCell*)[tableView dequeueReusableCellWithIdentifier:USER_CELL_IDENTIFY];
    if (nuCell == nil) {
        nuCell = [[UserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:USER_CELL_IDENTIFY];
    }
    
    return nuCell;
    
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell isKindOfClass:[UserTableViewCell class]]) {
        UserTableViewCell *nuCell = (UserTableViewCell*)cell;
        User *_user = itemsSource[indexPath.row];
        
        [nuCell.lblFullName setText:_user.name];
        [nuCell.lblEmail setText:_user.email];
        [nuCell.imgAvatar setImageWithURL:[NSURL URLWithString:_user.avatar] placeholderImage:[UIImage imageNamed:@"empty_avatar"]];
    }
}

@end
