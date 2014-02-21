//
//  AETeam.h
//  SceneKitTest
//
//  Created by Ben Stahl on 2/19/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AETeam : NSObject

@property (strong) NSDictionary *data;
@property (copy) NSString *teamID;

- (id)initWithArrayOfPropertyDictionaries:(NSArray*)props;

@end
