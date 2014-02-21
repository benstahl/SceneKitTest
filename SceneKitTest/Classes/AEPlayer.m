//
//  AEPlayer.m
//  SceneKitTest
//
//  Created by Ben Stahl on 2/19/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import "AEPlayer.h"

@implementation AEPlayer

/* ========================================================================== */
- (id)init {
	if (self = [super init]) {
		_data = [NSDictionary dictionary];
		_playerID = nil;
	}
	return self;
}

/* ========================================================================== */
- (id)initWithArrayOfPropertyDictionaries:(NSArray*)props {
	if (self = [super init]) {
		NSMutableDictionary *temp = [NSMutableDictionary dictionary];
		for (NSDictionary *d in props) {
			NSArray *keys = [d allKeys];
			if ([keys containsObject:@"ID"]) {
				_playerID = [props valueForKey:@"ID"];
				[temp addEntriesFromDictionary:d];
			}
		}
	}
	return self;
}

@end
