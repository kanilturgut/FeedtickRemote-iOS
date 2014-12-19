//
//  Hub.h
//  FeedtickRemote
//
//  Created by Kadir Anil Turgut on 17/12/14.
//  Copyright (c) 2014 Kadir Anil Turğut. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hub : NSObject

@property (nonatomic, retain) NSString *id;
@property (nonatomic, retain) NSString *name;

- (void) getHubList:(void (^) (NSArray *)) completionBlock;

@end
