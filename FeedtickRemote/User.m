//
//  User.m
//  FeedtickRemote
//
//  Created by Kadir Anil Turgut on 17/12/14.
//  Copyright (c) 2014 Kadir Anil Turğut. All rights reserved.
//

#import "User.h"
#import "BaseService.h"

@implementation User

- (id) init {
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}


- (void) login:(NSDictionary *) loginParams completion:(void(^)(BOOL)) completionBlock {
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:loginParams options:NSJSONWritingPrettyPrinted error:nil];
    
    [[BaseService instance] sendAsyncRequestToURL:LOGIN method:@"POST" data:jsonData completion:^(NSURLResponse *response, NSData *data, NSError *err) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        long responseCode = [httpResponse statusCode];
        
        NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        if (completionBlock) {
            if (responseCode == 200) {
                
                User *user = [[User alloc] init];
                
                user.id         = [responseData objectForKey:@"id"];
                user.email      = [responseData objectForKey:@"email"];
                user.firstName  = [responseData objectForKey:@"firstName"];
                user.lastName   = [responseData objectForKey:@"lastName"];
                
                completionBlock(YES);
            } else {
                completionBlock(NO);
            }
        }
        
    }];
}

@end
