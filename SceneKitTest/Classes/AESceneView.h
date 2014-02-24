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
@class AEPlayerPickSet;
@class AEHeaderView;

@interface AESceneView : SCNView <CHCSVParserDelegate> {
	SCNNode *_worldPivotNode;
	SCNNode *_cameraNode;
	SCNNode *_displayedCardsNode;
	SCNNode *_sponsorLogoNode;

	CHCSVParser *_playerParser;
	CHCSVParser *_teamParser;
	NSUInteger _currentParserLine;
	NSMutableDictionary *_currentParsingPlayerData;
	NSMutableDictionary *_currentParsingTeamData;
	NSMutableArray *_playerKeys;
	NSMutableArray *_teamKeys;
	
	NSArray *_playerIDPool;
	NSMutableArray *_displayedCards;
	NSUInteger _displayedCardCount;
	NSDictionary *_cameraPositions;
	NSDictionary *_sponsorLogoPositions;
	NSDictionary *_cardPositions;
	NSArray *_validPlayerPositions;
//	AEPlayerCard *_playerCard;
	BOOL _cardsAnimating;

	NSMutableArray *_playerPickSets;
	AEPlayerPickSet *_currentPickSet;
}

@property (strong) NSMutableDictionary *players;
@property (strong) NSMutableDictionary *teams;

@property (strong) IBOutlet AEHeaderView *headerView;

- (AEPlayer*)playerWithID:(NSString*)playerID;
- (AETeam*)teamWithID:(NSString*)teamID;

- (IBAction)newPickSetButtonClicked:(id)sender;

@end
