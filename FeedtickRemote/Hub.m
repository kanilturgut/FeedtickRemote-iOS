//
//  Hub.m
//  FeedtickRemote
//
//  Created by Kadir Anil Turgut on 17/12/14.
//  Copyright (c) 2014 Kadir Anil Turğut. All rights reserved.
//

#import "Hub.h"
#import "BaseService.h"

@implementation Hub

- (void) getHubList:(void (^) (NSArray *)) completionBlock {
    
    [[BaseService instance] sendAsyncRequestToURL:JOURNAL_LIST method:@"GET" data:nil completion:^(NSURLResponse *response, NSData *data, NSError *err) {

        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        long responseCode = [httpResponse statusCode];
        
        NSArray *responseArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        if (completionBlock) {
            if (responseCode == 200) {
                completionBlock(responseArray);
                NSLog(@"Hub list fetch success");
            } else {
                NSLog(@"Hub list fetch fail");
            }
        }
    }];
    
}

@end
