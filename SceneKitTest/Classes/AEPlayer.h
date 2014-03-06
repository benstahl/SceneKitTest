//
//  AEPlayer.h
//  SceneKitTest
//
//  Created by Ben Stahl on 2/19/14.
//  Copyright (c) 2014 App Easel. All rights reserved.

#import <Foundation/Foundation.h>
#import "AEPlayerPickSet.h"

@interface AEPlayer : NSObject

@property (strong) NSDictionary *data;
@property (copy) NSString *playerID;
@property AEPlayerPickSetStatus pickSetStatus;

- (id)initWithArrayOfPropertyDictionaries:(NSArray*)props;

@end
