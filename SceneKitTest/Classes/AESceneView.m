//
//  AESceneView.m
//  SceneKitTest
//
//  Created by Ben Stahl on 2/11/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "AESceneView.h"
#import "AEPlayer.h"
#import "AETeam.h"
#import "AEPlayerCard.h"
#import "AEUtility.h"
#import "CHCSVParser.h"

#define kMasterKey	@"ID"

@implementation AESceneView

-(void)awakeFromNib {
    self.backgroundColor = [NSColor darkGrayColor];

//	NSURL *url = [[NSBundle mainBundle] URLForResource:@"ex_player_card_v0001_0016" withExtension:@"dae"];
//
//	NSError * __autoreleasing error;
//	SCNScene *scene = [SCNScene sceneWithURL:url options:nil error:&error];

	_playerCards = [NSMutableArray arrayWithCapacity:5];
	_players = [NSMutableDictionary dictionary];
	_teams = [NSMutableDictionary dictionary];
	_currentParserLine = 0;

	[self initPlayersFromCSVFileWithBaseFilenames:@[@"ffl_2009_players"]];
	[self initTeamsFromCSVFileWithBaseFilenames:@[@"ffl_2009_teams", @"ffl_2009_teams_supplemental"]];

	_playerIDPool = @[@"nfl.p.2914", @"nfl.p.3116", @"nfl.p.3664", @"nfl.p.4262", @"nfl.p.5036", @"nfl.p.5452", @"nfl.p.5474", @"nfl.p.5900", @"nfl.p.6353", @"nfl.p.6427", @"nfl.p.6492", @"nfl.p.6994", @"nfl.p.7073", @"nfl.p.7809", @"nfl.p.7868", @"nfl.p.7904", @"nfl.p.8261", @"nfl.p.8286", @"nfl.p.8298", @"nfl.p.8306", @"nfl.p.8327", @"nfl.p.8330", @"nfl.p.8821", @"nfl.p.9295", @"nfl.p.9497"];
//	NSInteger randomPlayerIndex =  AERandInt(0, _playerIDPool.count - 1);

	// Create an empty scene
	SCNScene *scene = [SCNScene scene];

	if (scene) {
		self.scene = scene;
	} else {
		NSLog(@"Error creating scene.");
	}

//	scene.view.backgroundColor = [NSColor blackColor];

	SCNNode *root = scene.rootNode;
//	self.allowsCameraControl = YES;
//	self.showsStatistics = YES;

	// Main camera
	SCNCamera *camera = [SCNCamera camera];
	camera.xFov = 45;   // Degrees, not radians
	camera.yFov = 45;
	SCNNode *cameraNode = [SCNNode node];
	cameraNode.camera = camera;
	cameraNode.position = SCNVector3Make(0, .5, 17);
	[scene.rootNode addChildNode:cameraNode];

	// main light
	SCNLight *light = [SCNLight light];
    light.type = SCNLightTypeDirectional;
//	SCNNode *lightNode = [SCNNode node];
//	lightNode.light = light;
//	lightNode.position = SCNVector3Make(-200, 200, -200);
//	[root addChildNode:lightNode];
    root.light = light;

	// floor geometry
	SCNFloor *floor = [SCNFloor floor];
	floor.reflectivity = 0.20;
	SCNNode *floorNode = [SCNNode nodeWithGeometry:floor];
	[root addChildNode:floorNode];

	// debug info
////	self.layer = [CALayer layer];
////    self.wantsLayer = YES;
//
//	CATextLayer *infoLayer = [CATextLayer layer];
//	infoLayer.font = CGFontCreateWithFontName((CFStringRef)@"DIN-Regular");
//	infoLayer.fontSize = 48.0;
//	infoLayer.backgroundColor = [[NSColor blueColor] CGColor];
//	infoLayer.string = [NSString stringWithFormat:@"%@ players\n%@ teams", @(_players.count), @(_teams.count)];
////	[self.layer addSublayer:infoLayer];

//	SCNPlane *infoPlane = [SCNPlane planeWithWidth:4.0 height:5.6];
//	SCNNode *infoNode = [SCNNode nodeWithGeometry:infoPlane];
//	SCNMaterial *infoMat = [SCNMaterial material];
//	infoNode.position = SCNVector3Make(0.0, 2.8 + .1, 0.0);
//	[AEUtility configureMaterial:infoMat];
//	[root addChildNode:infoNode];

//	SCNNode *playerCardNode = [SCNNode node];
//	SCNSceneSource *playerCardSource = [SCNSceneSource sceneSourceWithURL:url options:nil];
//	SCNGeometry *playerCardGeometry = [playerCardSource entryWithIdentifier:@"player_card_test" withClass:[SCNGeometry class]];
//	playerCardNode.geometry = playerCardGeometry;
//	[root addChildNode:playerCardNode];

//	SCNText *text = [SCNText textWithString:@"QB RANK" extrusionDepth:0.0f];
//	text.alignmentMode = kCAAlignmentCenter;
//
//////	text.materials[1] = [SCNMaterial material];
//	text.font = [NSFont fontWithName:@"DIN-Regular" size:200];
//	SCNNode *textNode = [SCNNode nodeWithGeometry:text];
//////	textNode.scale = SCNVector3Make(0.2, 0.2, 0.2);
//	textNode.position = SCNVector3Make(0, 1, 0);
//	textNode.transform = CATransform3DScale(textNode.transform, .01f, .01f, .01f);
//	[root addChildNode:textNode];

	NSUInteger playerCardCount = 5;
	for (int i = 0; i < playerCardCount; i++) {
		CGFloat cardSpacingX = 4.5;
		NSInteger randomPlayerIndex =  AERandInt(0, _playerIDPool.count - 1);
		AEPlayer *player = [self playerWithID:_playerIDPool[randomPlayerIndex]];
		//		NSLog(@"Showing player card for player with id %@, data = %@", _playerIDPool[randomPlayerIndex], player.data);
		AEPlayerCard *card = [[AEPlayerCard alloc] init];
		[card configureWithPlayer:player];
		[_playerCards addObject:card];
		[root addChildNode:card];
		//	NSLog(@"card size = %fx%f", playerCard.cardSize.x, playerCard.cardSize.y);
		CGFloat totalWidth = (playerCardCount - 1) * cardSpacingX;
//		NSLog(@"total width = %f", @(totalWidth));
		card.position = SCNVector3Make(-(totalWidth / 2.0) + cardSpacingX * i, (card.cardSize.y / 2.0) + .025, 0.0);
//		card.rotation = SCNVector4Make(1.0, 1.0, 0.0, -card.position.x / 20.0);
//		NSLog(@"x pos of card %@ = %f", @(i), card.position.x);
	}

//	//	AEPlayer *player = [[AEPlayer alloc] initWithArrayOfPropertyDictionaries:@[@{kMasterKey : @"nfl.p.7755"}]];
//	AEPlayer *player = [self playerWithID:_playerIDPool[randomPlayerIndex]];
//	NSLog(@"Showing player card for player with id %@, data = %@", _playerIDPool[randomPlayerIndex], player.data);
////	NSLog(@"Loading player %@ | name = %@ | id = %@ | bg tint color = %@", player, player.data[@"DISPLAY_NAME"], player.data[@"ID"], player.data[@"COLOR_BG_TINT"]);
//	_playerCard = [[AEPlayerCard alloc] init];
//	[_playerCard configureWithPlayer:player];
////	NSLog(@"Player card has %@ child nodes.", @(playerCard.childNodes.count));
////	NSLog(@"%@", [playerCard description]);
//	[root addChildNode:_playerCard];
////	NSLog(@"card size = %fx%f", playerCard.cardSize.x, playerCard.cardSize.y);
//	_playerCard.position = SCNVector3Make(0.0, (_playerCard.cardSize.y / 2.0) + .025, 0.0);
}

/* ========================================================================== */
- (void)mouseDown:(NSEvent *)theEvent {
//	CGFloat cardSpacingX = 10.0;
	for (int i = 0; i < _playerCards.count; i++) {
		NSInteger randomPlayerIndex =  AERandInt(0, _playerIDPool.count - 1);
		AEPlayer *player = [self playerWithID:_playerIDPool[randomPlayerIndex]];
//		NSLog(@"Showing player card for player with id %@, data = %@", _playerIDPool[randomPlayerIndex], player.data);
		[_playerCards[i] configureWithPlayer:player];
	}
}

#pragma mark - convenience

/* ========================================================================== */
- (AEPlayer*)playerWithID:(NSString*)playerID {
	return _players[playerID];
}

/* ========================================================================== */
- (AETeam*)teamWithID:(NSString*)teamID {
	return _teams[teamID];
}

#pragma mark - data files

/* ========================================================================== */
- (void)initPlayersFromCSVFileWithBaseFilenames:(NSArray*)filenames {
	for (NSString *filename in filenames) {
		NSString *filePath = [[[NSBundle mainBundle] URLForResource:filename withExtension:@"csv"] path];
//		NSLog(@"File path = %@", filePath);
		CHCSVParser *parser = [[CHCSVParser alloc] initWithContentsOfCSVFile:filePath];
		_playerParser = parser;
		parser.sanitizesFields = YES;
		parser.stripsLeadingAndTrailingWhitespace = YES;
		parser.delegate = self;
		[parser parse];
	}

	NSLog(@"%@ players found.", @(_players.allKeys.count));

	for (NSString *key in [_players allKeys]) {
		AEPlayer *p = _players[key];
//		NSLog(@"Player with key %@ = %@", key, p.data);
		NSString *headshotFilePath = [[[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"PC Headshots/%@", p.data[@"ID"]] withExtension:@"png"] path];
		//	NSLog(@"Attempting to load image %@", filePath);
//		NSImage *headshotImage = [[NSImage alloc] initWithContentsOfFile:headshotFilePath];
		if (![[NSFileManager defaultManager] fileExistsAtPath:headshotFilePath]) {
			NSLog(@"*** Player headshot image for %@ not found.", p.data[@"ID"]);
		}
	}
}

/* ========================================================================== */
- (void)initTeamsFromCSVFileWithBaseFilenames:(NSArray*)filenames {
	for (NSString *filename in filenames) {
		NSString *filePath = [[[NSBundle mainBundle] URLForResource:filename withExtension:@"csv"] path];
//		NSLog(@"File path = %@", filePath);
		CHCSVParser *parser = [[CHCSVParser alloc] initWithContentsOfCSVFile:filePath];
		_teamParser = parser;
		parser.sanitizesFields = YES;
		parser.stripsLeadingAndTrailingWhitespace = YES;
		parser.delegate = self;
		[parser parse];
	}

	NSLog(@"%@ teams found.", @(_teams.allKeys.count));

	for (NSString *key in [_teams allKeys]) {
		AEPlayer *t = _teams[key];
		NSLog(@"%@", t.data);
	}
}

#pragma mark- CHCSVParserDelegate

/* ========================================================================== */
- (void)parser:(CHCSVParser *)parser didBeginLine:(NSUInteger)recordNumber {
//	NSLog(@"parser:DidBeginLine: %@", @(recordNumber));
	if (parser == _playerParser) {
		_currentParsingPlayerData = [NSMutableDictionary dictionary];
	} else if (parser == _teamParser) {
		_currentParsingTeamData = [NSMutableDictionary dictionary];
	}
	_currentParserLine = recordNumber;
}

/* ========================================================================== */
- (void)parser:(CHCSVParser *)parser didEndLine:(NSUInteger)recordNumber {
//	NSLog(@"parser:DidEndLine: %@", @(recordNumber));

	if (_currentParserLine == 1) {
//		NSLog(@"Player keys = %@", _playerKeys);
		return;
	}

	if (parser == _playerParser) {
		NSString *playerID = _currentParsingPlayerData[kMasterKey];
		AEPlayer *player = _players[playerID];
		if (player) {
			NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:player.data];
			[d addEntriesFromDictionary:_currentParsingPlayerData];
			player.data = [NSDictionary dictionaryWithDictionary:d];
		} else {
			player = [[AEPlayer alloc] init];
			player.data = [NSDictionary dictionaryWithDictionary:_currentParsingPlayerData];
//			NSLog(@"Set player data %@", player.data);
			[_players setObject:player forKey:playerID];
		}
		_currentParsingPlayerData = nil;
	} else if (parser == _teamParser) {
		NSString *teamID = _currentParsingTeamData[kMasterKey];
		AETeam *team = _teams[teamID];
		if (team) {
			NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:team.data];
			[d addEntriesFromDictionary:_currentParsingTeamData];
			team.data = [NSDictionary dictionaryWithDictionary:d];
		} else {
			team = [[AETeam alloc] init];
			team.data = [NSDictionary dictionaryWithDictionary:_currentParsingTeamData];
//			NSLog(@"Set team data %@", team.data);
			[_teams setObject:team forKey:teamID];
		}
		_currentParsingTeamData = nil;
	}
}

/* ========================================================================== */
- (void)parserDidBeginDocument:(CHCSVParser *)parser {
	NSLog(@"parserDidBeginDocument:");
	_currentParserLine = 0;
	if (parser == _playerParser) {
		_playerKeys = [NSMutableArray array];
	} else if (parser == _teamParser) {
		_teamKeys = [NSMutableArray array];
	}
}

/* ========================================================================== */
- (void)parserDidEndDocument:(CHCSVParser *)parser {
	NSLog(@"parserDidEndDocument:");
	if (parser == _playerParser) {
		_playerKeys = nil;
	} else if (parser == _teamParser) {
		_teamKeys = nil;
	}
}

/* ========================================================================== */
- (void)parser:(CHCSVParser *)parser didReadField:(NSString *)field atIndex:(NSInteger)fieldIndex {
//	NSLog(@"parser:didReadField: %@ atIndex: %@", field, @(fieldIndex));
	// Skip over header (CHCSVParser line numbers are 1-based).
	if (_currentParserLine == 1) {
		if (parser == _playerParser) {
			[_playerKeys addObject:field];
		} else if (parser == _teamParser) {
			[_teamKeys addObject:field];
		}
//		NSLog(@"Adding field %@, %@ player keys found.", field, @(_playerKeys.count));
		return;
	}

	if (parser == _playerParser) {
		[_currentParsingPlayerData setValue:field forKey:_playerKeys[fieldIndex]];
	} else if (parser == _teamParser) {
		[_currentParsingTeamData setValue:field forKey:_teamKeys[fieldIndex]];
	}
}

/* ========================================================================== */
- (void)parser:(CHCSVParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	NSLog(@"parser:didStartElement: %@ namespaceURI: %@ qualifiedName: %@ attributes: %@", elementName, namespaceURI, qName, attributeDict);
}

/* ========================================================================== */
- (void)parser:(CHCSVParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	NSLog(@"parser:didEndElement: %@ namespaceURI: %@ qualifiedName: %@", elementName, namespaceURI, qName);
}

@end
