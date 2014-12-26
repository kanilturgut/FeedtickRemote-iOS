//
//  PostController.m
//  FeedtickRemote
//
//  Created by Kadir Anil Turgut on 18/12/14.
//  Copyright (c) 2014 Kadir Anil Turğut. All rights reserved.
//

#import "PostController.h"
#import "Feed.h"
#import "PostCell.h"

#import <AsyncImageView.h>

@interface PostController ()

@end

@implementation PostController

@synthesize hubId;
NSMutableArray *posts;
NSString *journalId;

UIColor *normalColor, *stickyColor, *approveColor, *denyColor, *blackColor, *whiteColor;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    normalColor     = [UIColor colorWithRed:0.996 green:0.996 blue:0.996 alpha:1];
    stickyColor     = [UIColor colorWithRed:0.957 green:0.91 blue:0.353 alpha:1];
    approveColor    = [UIColor colorWithRed:0.651 green:0.835 blue:0.373 alpha:1];
    denyColor       = [UIColor colorWithRed:0.914 green:0.4 blue:0.322 alpha:1];
    
    blackColor      = [UIColor blackColor];
    whiteColor      = [UIColor whiteColor];
    
    _lblHeader.backgroundColor = [UIColor colorWithRed:0.255 green:0.792 blue:0.753 alpha:1];
    
    
    journalId = hubId;
    posts = [NSMutableArray new];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:journalId forKey:@"journalId"];
    
    [[Feed new] getPostList:params completion:^(NSArray *postList) {
        posts = [postList mutableCopy];
        [self.PostTable reloadData];
    }];

    [self.PostTable registerNib:[UINib nibWithNibName:@"PostCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PostCellIdentifier"];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [posts count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *tableIdentifier = @"PostCellIdentifier";
    
    PostCell *cell = (PostCell *)[tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PostCellIdentifier" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSDictionary *feed = [posts objectAtIndex:indexPath.row];
    
    NSString *feedText = [feed objectForKey:@"text"];
    NSString *feedUsername = [feed objectForKey:@"username"];
    NSNumber *status = [feed objectForKey:@"status"];
    NSNumber *socialMediaType = [feed objectForKey:@"socialMediaType"];
    
    NSArray *imageURLs = [feed objectForKey:@"images"];
    NSString *imageURL = [imageURLs objectAtIndex:0];
    
    int statusValue = status.intValue;
    int socialMediaTypeValue = socialMediaType.intValue;
    
    cell.tvPostText.text = feedText;
    cell.tvUsername.text = feedUsername;
    
    UIImage *img = nil;
    if (socialMediaTypeValue == MEDIA_TYPE_TWITTER)
        img = [UIImage imageNamed:@"twitter_icon"];
    else if (socialMediaTypeValue == MEDIA_TYPE_INSTAGRAM)
        img = [UIImage imageNamed:@"instagram_icon"];
    
    cell.ivSocialMedia.image = img;
    [cell.ivPostImage setImageURL:[NSURL URLWithString:imageURL]];
    
    cell.bSticky.layer.borderWidth = 1.0f;
    cell.bSticky.layer.borderColor = [[UIColor grayColor] CGColor];
    [cell.bSticky setTitleEdgeInsets:UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0)];
    cell.bSticky.tag = indexPath.row;
    [cell.bSticky addTarget:self action:@selector(stickyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.bSticky setTitleColor:blackColor forState:UIControlStateNormal];
    [cell.bSticky setTitleColor:whiteColor forState:UIControlStateSelected];

    cell.bAprrove.layer.borderWidth = 1.0f;
    cell.bAprrove.layer.borderColor = [[UIColor grayColor] CGColor];
    [cell.bAprrove setTitleEdgeInsets:UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0)];
    cell.bAprrove.tag = indexPath.row;
    [cell.bAprrove addTarget:self action:@selector(approveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.bAprrove setTitleColor:blackColor forState:UIControlStateNormal];
    [cell.bAprrove setTitleColor:whiteColor forState:UIControlStateSelected];
    
    cell.bDeny.layer.borderWidth = 1.0f;
    cell.bDeny.layer.borderColor = [[UIColor grayColor] CGColor];
    [cell.bDeny setTitleEdgeInsets:UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0)];
    cell.bDeny.tag = indexPath.row;
    [cell.bDeny addTarget:self action:@selector(denyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.bDeny setTitleColor:blackColor forState:UIControlStateNormal];
    [cell.bDeny setTitleColor:whiteColor forState:UIControlStateSelected];

    
    if (statusValue == STATUS_STICKY) {
        cell.bSticky.backgroundColor = stickyColor;
        cell.bAprrove.backgroundColor = normalColor;
        cell.bDeny.backgroundColor = normalColor;
        
        [cell.bSticky setTitleColor:whiteColor forState:UIControlStateNormal];
        [cell.bAprrove setTitleColor:blackColor forState:UIControlStateNormal];
        [cell.bDeny setTitleColor:blackColor forState:UIControlStateNormal];
    } else if (statusValue == STATUS_APPROVED) {
        cell.bSticky.backgroundColor = normalColor;
        cell.bAprrove.backgroundColor = approveColor;
        cell.bDeny.backgroundColor = normalColor;
        
        [cell.bSticky setTitleColor:blackColor forState:UIControlStateNormal];
        [cell.bAprrove setTitleColor:whiteColor forState:UIControlStateNormal];
        [cell.bDeny setTitleColor:blackColor forState:UIControlStateNormal];
    } else if (statusValue == STATUS_DENIED) {
        cell.bSticky.backgroundColor = normalColor;
        cell.bAprrove.backgroundColor = normalColor;
        cell.bDeny.backgroundColor = denyColor;
        
        [cell.bSticky setTitleColor:blackColor forState:UIControlStateNormal];
        [cell.bAprrove setTitleColor:blackColor forState:UIControlStateNormal];
        [cell.bDeny setTitleColor:whiteColor forState:UIControlStateNormal];
    } else {
        cell.bSticky.backgroundColor = normalColor;
        cell.bAprrove.backgroundColor = normalColor;
        cell.bDeny.backgroundColor = normalColor;
        
        [cell.bSticky setTitleColor:blackColor forState:UIControlStateNormal];
        [cell.bAprrove setTitleColor:blackColor forState:UIControlStateNormal];
        [cell.bDeny setTitleColor:blackColor forState:UIControlStateNormal];
    }
    
    return cell;
    
}

-(void)stickyButtonClicked:(UIButton*)sender {
    long rowNumber = sender.tag;
    
    NSDictionary *feed = [posts objectAtIndex:rowNumber];
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:journalId forKey:@"journalId"];
    [dic setObject:[feed objectForKey:@"_id"] forKey:@"postId"];
    [dic setObject:[NSNumber numberWithInt:STATUS_STICKY] forKey:@"status"];
    
    [[Feed new] changePostStatus:dic completion:^(BOOL isSuccess) {
        if (isSuccess) {
            NSLog(@"Success");
        } else {
            NSLog(@"Fail");
        }
    }];
}

-(void)approveButtonClicked:(UIButton*)sender {
    long rowNumber = sender.tag;

    NSDictionary *feed = [posts objectAtIndex:rowNumber];
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:journalId forKey:@"journalId"];
    [dic setObject:[feed objectForKey:@"_id"] forKey:@"postId"];
    [dic setObject:[NSNumber numberWithInt:STATUS_APPROVED] forKey:@"status"];
    
    [[Feed new] changePostStatus:dic completion:^(BOOL isSuccess) {
        if (isSuccess) {
            NSLog(@"Success");
        } else {
            NSLog(@"Fail");
        }
    }];
}

-(void)denyButtonClicked:(UIButton*)sender {
    long rowNumber = sender.tag;

    NSDictionary *feed = [posts objectAtIndex:rowNumber];
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:journalId forKey:@"journalId"];
    [dic setObject:[feed objectForKey:@"_id"] forKey:@"postId"];
    [dic setObject:[NSNumber numberWithInt:STATUS_DENIED] forKey:@"status"];
    
    [[Feed new] changePostStatus:dic completion:^(BOOL isSuccess) {
        if (isSuccess) {
            NSLog(@"Success");
        } else {
            NSLog(@"Fail");
        }
    }];
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
