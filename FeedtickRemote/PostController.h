//
//  PostController.h
//  FeedtickRemote
//
//  Created by Kadir Anil Turgut on 18/12/14.
//  Copyright (c) 2014 Kadir Anil Turğut. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) NSString *hubId;
@property (weak, nonatomic) IBOutlet UILabel *lblHeader;
@property (weak, nonatomic) IBOutlet UITableView *PostTable;

@end
