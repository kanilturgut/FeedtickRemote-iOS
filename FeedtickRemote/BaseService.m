//
//  BaseService.m
//  FeedtickRemote
//
//  Created by Kadir Anil Turgut on 17/12/14.
//  Copyright (c) 2014 Kadir Anil Turğut. All rights reserved.
//

#import "BaseService.h"

@implementation BaseService

- (id) init {
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

+ (BaseService *) instance {
    static BaseService *instance = nil;
    
    @synchronized(self) {
        if (instance == nil) {
            instance = [[BaseService alloc] init];
        }
    }
    
    return instance;
}

-(void) sendAsyncRequestToURL:(NSString *) urlString
                       method:(NSString *) httpMethod
                         data:(NSData *) data
                   completion:(void (^) (NSURLResponse *, NSData *, NSError *)) completionBlock {
    
    NSURL *url                  = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BASE_DOMAIN, urlString]];
    NSMutableURLRequest *req    = [NSMutableURLRequest requestWithURL:url];
    
    if (data) {
        [req setHTTPBody:data];
        
        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"\n\n[INFO] - SENT JSON:\n\n%@", jsonString);
        
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)data.length];
        [req setValue:postLength forHTTPHeaderField:@"Content-Length"];
    }
    
    [req setHTTPMethod:httpMethod];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setTimeoutInterval:120];
    
    [NSURLConnection sendAsynchronousRequest:req
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *responseData, NSError *connectionError) {
                               if (completionBlock) {
                                   completionBlock(response, responseData, connectionError);
                               }
                           }];
    
}

-(void) sendSynchRequestToURL:(NSString *)urlString
                       method:(NSString *)httpMethod
                         data:(NSData *)data
                   completion:(void (^)(NSURLResponse *, NSData *, NSError *)) completionBlock {
    
}


@end
