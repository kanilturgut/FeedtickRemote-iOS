//
//  PostCell.h
//  FeedtickRemote
//
//  Created by Kadir Anil Turgut on 18/12/14.
//  Copyright (c) 2014 Kadir Anil Turğut. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AsyncImageView.h>

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet AsyncImageView *ivPostImage;
@property (weak, nonatomic) IBOutlet UIImageView *ivSocialMedia;
@property (weak, nonatomic) IBOutlet UILabel *tvUsername;
@property (weak, nonatomic) IBOutlet UILabel *tvPostText;

@property (weak, nonatomic) IBOutlet UIButton *bSticky;
@property (weak, nonatomic) IBOutlet UIButton *bAprrove;
@property (weak, nonatomic) IBOutlet UIButton *bDeny;


@end
