//
//  BaseService.h
//  FeedtickRemote
//
//  Created by Kadir Anil Turgut on 17/12/14.
//  Copyright (c) 2014 Kadir Anil Turğut. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BASE_DOMAIN                 @"http://journifyapp.herokuapp.com"
#define LOGIN                       @"/auth"
#define JOURNAL_LIST                @"/journal/listJournals"
#define GET_JOURNAL_POST            @"/journal/getJournalPosts"
#define CHANGE_JOURNAL_POST_STATUS  @"/journal/changeJournalPostStatus"

@interface BaseService : NSObject

+(BaseService *) instance;

-(void) sendAsyncRequestToURL:(NSString *) urlString
                       method:(NSString *) httpMethod
                         data:(NSData *) data
                   completion:(void (^) (NSURLResponse *, NSData *, NSError *)) completionBlock;

-(void) sendSynchRequestToURL:(NSString *)urlString
                       method:(NSString *)httpMethod
                         data:(NSData *)data
                   completion:(void (^)(NSURLResponse *, NSData *, NSError *)) completionBlock;

@end
