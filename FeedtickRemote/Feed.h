//
//  Feed.h
//  FeedtickRemote
//
//  Created by Kadir Anil Turgut on 17/12/14.
//  Copyright (c) 2014 Kadir Anil Turğut. All rights reserved.
//

#import <Foundation/Foundation.h>


#define MEDIA_TYPE_TWITTER      1
#define MEDIA_TYPE_INSTAGRAM    2
#define MEDIA_TYPE_FACEBOOK     3
#define MEDIA_TYPE_PINTEREST    4
#define MEDIA_TYPE_RSS          5
#define MEDIA_TYPE_TUMBLR       6
#define MEDIA_TYPE_YOUTUBE      7
#define MEDIA_TYPE_LINKEDIN     8
#define MEDIA_TYPE_GOOGLE_PLUS  9
#define MEDIA_TYPE_VINE         10

#define STATUS_APPROVED         1
#define STATUS_STICKY           2
#define STATUS_WAITING          3
#define STATUS_DENIED           4
#define STATUS_NOT_READY        5


@interface Feed : NSObject

@property (nonatomic, retain) NSString *postId;
@property (nonatomic, retain) NSString *id;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *userFullname;
@property (nonatomic, retain) NSString *userProfileImage;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSString *postImage;
@property (nonatomic, assign) NSInteger *socialMediaType;
@property (nonatomic, assign) NSInteger *postType;
@property (nonatomic, assign) NSInteger *status;

- (void) getPostList:(NSDictionary *) params completion:(void (^) (NSArray *)) completionBlock;
- (void) changePostStatus:(NSDictionary *) params completion:(void(^)(BOOL)) completionBlock;

@end
