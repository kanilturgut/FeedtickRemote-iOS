//
//  ViewController.m
//  FeedtickRemote
//
//  Created by Kadir Anil Turgut on 17/12/14.
//  Copyright (c) 2014 Kadir Anil Turğut. All rights reserved.
//

#import "ViewController.h"
#import "User.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {

    // Do any additional setup after loading the view, typically from a nib.
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    if (preferences != nil) {
        NSString *email = [preferences objectForKey:@"email"];
        NSString *password = [preferences objectForKey:@"password"];
    
        if (email != nil && password != nil) {
            NSMutableDictionary *loginDict = [[NSMutableDictionary alloc] init];
            [loginDict setObject:email forKey:@"email"];
            [loginDict setObject:password forKey:@"password"];

            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[User new] login:loginDict completion:^(BOOL isSuccess) {
                    [self.view endEditing:YES];
                    
                    if (isSuccess) {
                        NSLog(@"Login Success");
                        
                        NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
                        [preferences setObject:email forKey:@"email"];
                        [preferences setObject:password forKey:@"password"];
                        [preferences synchronize];
                        
                        
                        [self performSegueWithIdentifier:@"LoginSegue" sender:self];
                    } else {
                        NSLog(@"Login Failed");
                    }
                }];
            });
        }
    }
    
        [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bLogin:(id)sender {
    
    NSString *email = [_lblEmail text];
    NSString *password = [_lblPassword text];
    
    email = @"kanilturgut@gmail.com";
    password = @"123";
    
    NSMutableDictionary *loginDict = [[NSMutableDictionary alloc] init];
    [loginDict setObject:email forKey:@"email"];
    [loginDict setObject:password forKey:@"password"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [[User new] login:loginDict completion:^(BOOL isSuccess) {
            [self.view endEditing:YES];
            
            if (isSuccess) {
                NSLog(@"Login Success");
                
                NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
                [preferences setObject:email forKey:@"email"];
                [preferences setObject:password forKey:@"password"];
                [preferences synchronize];
                
                
                [self performSegueWithIdentifier:@"LoginSegue" sender:self];
            } else {
                NSLog(@"Login Failed");
            }
        }];
    });
}




@end
