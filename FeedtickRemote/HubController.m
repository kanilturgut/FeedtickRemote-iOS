//
//  HubController.m
//  FeedtickRemote
//
//  Created by Kadir Anil Turgut on 17/12/14.
//  Copyright (c) 2014 Kadir Anil Turğut. All rights reserved.
//

#import "HubController.h"
#import "Hub.h"
#import "PostController.h"

@interface HubController ()

@end

@implementation HubController

NSMutableArray *hubs;
NSIndexPath *selectedHubIndex;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _lblHeader.backgroundColor = [UIColor colorWithRed:0.255 green:0.792 blue:0.753 alpha:1];
    
    hubs = [NSMutableArray new];
    [[Hub new] getHubList:^(NSArray *hubList) {
        
        hubs = [hubList mutableCopy];
        [self.hubTable reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [hubs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *tableIdentifier = @"HubTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    NSDictionary *hub = [hubs objectAtIndex:indexPath.row];
    NSString *hubName = [hub objectForKey:@"name"];
    
    cell.textLabel.text = hubName;
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"ShowJournalPostsSegue" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowJournalPostsSegue"]) {
        NSIndexPath *indexPath = [self.hubTable indexPathForSelectedRow];
        PostController *destViewController = segue.destinationViewController;
        
        NSDictionary *tmp = [hubs objectAtIndex:indexPath.row];
        
        
        destViewController.hubId = [tmp objectForKey:@"_id"];
    }
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
