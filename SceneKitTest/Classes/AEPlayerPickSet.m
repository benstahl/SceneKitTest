//
//  AEPlayerPickSet.m
//  SceneKitTest
//
//  Created by Ben Stahl on 2/24/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import "AEPlayerPickSet.h"

@implementation AEPlayerPickSet

/* ========================================================================== */
- (id)init {
	if (self = [super init]) {
		_players = nil;
	}
	return self;
}

/* ========================================================================== */
- (NSString*)headerPickString {
	return [NSString stringWithFormat:@"%@ from %@ needs %@ of %@", _fantasyTeamOwnerName, _fantasyTeamOwnerLocation, @(_needCount), @(_cardCount)];
}

/* ========================================================================== */
- (NSString*)description {
	NSMutableString *s = [NSMutableString string];
	[s appendString:_fantasyTeamOwnerName];
	[s appendString:[NSString stringWithFormat:@"\n%@", [self headerPickString]]];
	return [NSString stringWithString:s];
}

@end
