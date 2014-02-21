//
//  AESceneView.h
//  SceneKitTest
//
//  Created by Ben Stahl on 2/11/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import <SceneKit/SceneKit.h>
#import "CHCSVParser.h"

@class CHCSVParser;
@class AEPlayer;
@class AEPlayerCard;
@class AETeam;

@interface AESceneView : SCNView <CHCSVParserDelegate> {
	CHCSVParser *_playerParser;
	CHCSVParser *_teamParser;
	NSUInteger _currentParserLine;
	NSMutableDictionary *_currentParsingPlayerData;
	NSMutableDictionary *_currentParsingTeamData;
	NSMutableArray *_playerKeys;
	NSMutableArray *_teamKeys;
	NSArray *_playerIDPool;
	NSMutableArray *_playerCards;
//	AEPlayerCard *_playerCard;
}

@property (strong) NSMutableDictionary *players;
@property (strong) NSMutableDictionary *teams;

- (AEPlayer*)playerWithID:(NSString*)playerID;
- (AETeam*)teamWithID:(NSString*)teamID;

@end
