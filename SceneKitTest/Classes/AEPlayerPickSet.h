//
//  AEPlayerPickSet.h
//  SceneKitTest
//
//  Created by Ben Stahl on 2/24/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum AEPlayerPickSetStatus : NSUInteger {
	kPickSetStatusUnknown,
	kPickSetStatusAccepted,
	kPickSetStatusRejected
} AEPlayerPickSetStatus;

@interface AEPlayerPickSet : NSObject

@property (strong) NSArray *players;
@property (copy) NSString *fantasyTeamOwnerName;
@property (copy) NSString *fantasyTeamOwnerLocation;
@property (copy) NSString *fantasyTeamName;
@property (copy) NSString *playerPosition;
@property NSUInteger cardCount;
@property NSUInteger needCount;
@property NSUInteger remainingCount;

- (NSString*)headerPickString;

@end
