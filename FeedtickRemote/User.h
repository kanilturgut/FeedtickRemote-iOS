//
//  User.h
//  FeedtickRemote
//
//  Created by Kadir Anil Turgut on 17/12/14.
//  Copyright (c) 2014 Kadir Anil Turğut. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, retain) NSString *id;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;

- (void) login:(NSDictionary *) loginParams completion:(void(^)(BOOL)) completionBlock;

@end
