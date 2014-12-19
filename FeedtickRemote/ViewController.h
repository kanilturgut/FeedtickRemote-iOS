//
//  ViewController.h
//  FeedtickRemote
//
//  Created by Kadir Anil Turgut on 17/12/14.
//  Copyright (c) 2014 Kadir Anil Turğut. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *lblEmail;
@property (weak, nonatomic) IBOutlet UITextField *lblPassword;
- (IBAction)bLogin:(id)sender;

@end

