//
//  AEModuleFFLViewController.h
//  SceneKitTest
//
//  Created by Ben Stahl on 2/24/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CHCSVParser.h"

@class AEFFLSceneView;
@class AEHeaderView;
@class CHCSVParser;
@class AEPlayer;
@class AETeam;

@interface AEModuleFFLViewController : NSViewController <CHCSVParserDelegate> {
	CHCSVParser *_playerParser;
	CHCSVParser *_teamParser;
	NSUInteger _currentParserLine;
	NSMutableDictionary *_currentParsingPlayerData;
	NSMutableDictionary *_currentParsingTeamData;
	NSMutableArray *_playerKeys;
	NSMutableArray *_teamKeys;
}

@property (assign) IBOutlet NSView *menuView;
@property (assign) IBOutlet AEFFLSceneView *sceneView;
@property (assign) IBOutlet AEHeaderView *headerView;

@property (strong) NSMutableDictionary *players;
@property (strong) NSMutableDictionary *teams;
@property (strong) NSArray *playerIDPool;
@property (strong) NSArray *validPlayerPositions;

- (AEPlayer*)playerWithID:(NSString*)playerID;
- (AETeam*)teamWithID:(NSString*)teamID;

- (IBAction)showCardsButtonClicked:(id)sender;

@end
