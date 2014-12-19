//
//  Feed.m
//  FeedtickRemote
//
//  Created by Kadir Anil Turgut on 17/12/14.
//  Copyright (c) 2014 Kadir Anil Turğut. All rights reserved.
//

#import "Feed.h"
#import "BaseService.h"

@implementation Feed

- (void) getPostList:(NSDictionary *) params completion:(void (^) (NSArray *)) completionBlock {
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    
    [[BaseService instance] sendAsyncRequestToURL:GET_JOURNAL_POST method:@"POST" data:jsonData completion:^(NSURLResponse *response, NSData *data, NSError *err) {
        
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
