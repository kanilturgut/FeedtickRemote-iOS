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


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _lblHeader.backgroundColor = [UIColor colorWithRed:0.255 green:0.792 blue:0.753 alpha:1];
    
    NSString *journalId = hubId;
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
    
    NSArray *imageURLs = [feed objectForKey:@"images"];
    NSString *imageURL = [imageURLs objectAtIndex:0];
    
    cell.tvPostText.text = feedText;
    cell.tvUsername.text = feedUsername;
    
    int statusValue = status.intValue;
    UIImage *img = nil;
    if (statusValue == MEDIA_TYPE_TWITTER)
        img = [UIImage imageNamed:@"twitter_icon"];
    else if (statusValue == MEDIA_TYPE_INSTAGRAM)
        img = [UIImage imageNamed:@"instagram_icon"];
    
    cell.ivSocialMedia.image = img;
    [cell.ivPostImage setImageURL:[NSURL URLWithString:imageURL]];
    
    return cell;
    
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
