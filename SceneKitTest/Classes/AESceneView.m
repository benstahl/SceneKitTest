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

	_displayedCards = [NSMutableArray arrayWithCapacity:5];
	_players = [NSMutableDictionary dictionary];
	_teams = [NSMutableDictionary dictionary];
	_currentParserLine = 0;

	[self initPlayersFromCSVFileWithBaseFilenames:@[@"ffl_2009_players"]];
	[self initTeamsFromCSVFileWithBaseFilenames:@[@"ffl_2009_teams", @"ffl_2009_teams_supplemental"]];

	_playerIDPool = @[@"nfl.p.2914", @"nfl.p.3116", @"nfl.p.3664", @"nfl.p.4262", @"nfl.p.4659", @"nfl.p.5036", @"nfl.p.5228", @"nfl.p.5474", @"nfl.p.5652", @"nfl.p.5900", @"nfl.p.6353", @"nfl.p.6427", @"nfl.p.6492", @"nfl.p.6802", @"nfl.p.6994", @"nfl.p.7073", @"nfl.p.7200", @"nfl.p.7203", @"nfl.p.7241", @"nfl.p.7247", @"nfl.p.7406", @"nfl.p.7434", @"nfl.p.7809", @"nfl.p.7860", @"nfl.p.7868", @"nfl.p.7904", @"nfl.p.8255", @"nfl.p.8261", @"nfl.p.8263", @"nfl.p.8286", @"nfl.p.8298", @"nfl.p.8306", @"nfl.p.8327", @"nfl.p.8330", @"nfl.p.8346", @"nfl.p.8391", @"nfl.p.8416", @"nfl.p.8432", @"nfl.p.8815", @"nfl.p.8821", @"nfl.p.8850", @"nfl.p.8872", @"nfl.p.8902", @"nfl.p.8926", @"nfl.p.9030", @"nfl.p.9037", @"nfl.p.9039", @"nfl.p.9265", @"nfl.p.9271", @"nfl.p.9274", @"nfl.p.9293", @"nfl.p.9295", @"nfl.p.9314", @"nfl.p.9496", @"nfl.p.9497"];
//	NSInteger randomPlayerIndex =  AERandInt(0, _playerIDPool.count - 1);

//	for (NSString *s in _playerIDPool) {
//		NSString *headshotFilePath = [[[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"PC Headshots/%@", s] withExtension:@"png"] path];
//		if (![[NSFileManager defaultManager] fileExistsAtPath:headshotFilePath]) {
//			NSLog(@"*** Player headshot image for %@ not found.", s);
//		}
//	}

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
	cameraNode.position = SCNVector3Make(0, .5, 18);
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

	_displayedCardsNode = [SCNNode node];
	[root addChildNode:_displayedCardsNode];

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

//	NSInteger randomPlayerCount = AERandInt(2, 5);
//	NSArray *randomPlayers = [self randomUniquePlayersWithCount:randomPlayerCount];
//	[self animateCardsInForPlayers:randomPlayers];

//	NSUInteger playerCardCount = 5;
//	for (int i = 0; i < playerCardCount; i++) {
//		CGFloat cardSpacingX = 4.5;
//		NSInteger randomPlayerIndex =  AERandInt(0, _playerIDPool.count - 1);
//		AEPlayer *player = [self playerWithID:_playerIDPool[randomPlayerIndex]];
//		NSLog(@"Showing player card for player with id %@, data = %@", _playerIDPool[randomPlayerIndex], player.data);
//		AEPlayerCard *card = [[AEPlayerCard alloc] init];
//		[card configureWithPlayer:player];
//		[_displayedCards addObject:card];
//		[root addChildNode:card];
//		//	NSLog(@"card size = %fx%f", playerCard.cardSize.x, playerCard.cardSize.y);
//		CGFloat totalWidth = (playerCardCount - 1) * cardSpacingX;
////		NSLog(@"total width = %f", @(totalWidth));
//		card.position = SCNVector3Make(-(totalWidth / 2.0) + cardSpacingX * i, (card.cardSize.y / 2.0) + .025, 0.0);
////		card.rotation = SCNVector4Make(1.0, 1.0, 0.0, -card.position.x / 20.0);
////		NSLog(@"x pos of card %@ = %f", @(i), card.position.x);
//	}
}

/* ========================================================================== */
- (void)mouseDown:(NSEvent *)theEvent {
//	CGFloat cardSpacingX = 10.0;
//	for (int i = 0; i < _displayedCards.count; i++) {
//		NSInteger randomPlayerIndex =  AERandInt(0, _playerIDPool.count - 1);
//		AEPlayer *player = [self playerWithID:_playerIDPool[randomPlayerIndex]];
//		NSLog(@"Showing player card for player with id %@, data = %@", _playerIDPool[randomPlayerIndex], player.data);
//		[_displayedCards[i] configureWithPlayer:player];
//	}

	if (_displayedCardCount == 0) {
		NSInteger randomPlayerCount = AERandInt(2, 5);
		NSArray *randomPlayers = [self randomUniquePlayersWithCount:randomPlayerCount];
		[self animateCardsInForPlayers:randomPlayers];
	} else {
		[self animateCardsOut];
	}
}

/* ========================================================================== */
- (void)animateCardsInForPlayers:(NSArray*)players {
	_displayedCardCount = players.count;
	CGFloat cardSpacingStartX = 6.0;
	CGFloat cardSpacingEndX = 4.5;
	CGFloat totalWidthStart = (_displayedCardCount - 1) * cardSpacingStartX;
	CGFloat totalWidthEnd = (_displayedCardCount - 1) * cardSpacingEndX;

	// First create cards and place them in their starting positions.
	for (int i = 0; i < _displayedCardCount; i++) {
		AEPlayerCard *card = [[AEPlayerCard alloc] init];
		[card configureWithPlayer:players[i]];
		card.position = SCNVector3Make(-(totalWidthStart / 2.0) + cardSpacingStartX * i, 2.0, 18.0);
//		card.position = SCNVector3Make(-(totalWidthEnd / 2.0) + cardSpacingEndX * i, (card.cardSize.y / 2.0) + .025, 0.0);
		card.rotation = SCNVector4Make(1.0, 0.0, 0.0, AEDegToRad(-75.0));
		[_displayedCards addObject:card];
		[_displayedCardsNode addChildNode:card];
	}

	// Now animate to their ending positions.
//	[SCNTransaction begin];
//	[SCNTransaction setAnimationDuration:3.0];
//	[SCNTransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
//	[SCNTransaction setCompletionBlock:^{
//		NSLog(@"Cards finished in animation.");
//	}];

//	NSMutableArray *cardAnimations = [NSMutableArray arrayWithCapacity:_displayedCardCount];
	for (int i = 0; i < _displayedCardCount; i++) {

//		[SCNTransaction commit];

//		AEPlayerCard *card = _displayedCards[i];
//		CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//		animation.values = @[[NSValue valueWithSCNVector3:card.position],
//							[NSValue valueWithSCNVector3:SCNVector3Make(-(totalWidthEnd / 2.0) + cardSpacingEndX * i, (card.cardSize.y / 2.0) + .025, 0.0)]];
////		animation.values = @[
////							[NSValue valueWithSCNVector3:SCNVector3Make(card.position.x, 0.0, 0.0)],
////							[NSValue valueWithSCNVector3:SCNVector3Make(card.position.x, 1.5, 0.0)],
////							[NSValue valueWithSCNVector3:SCNVector3Make(card.position.x, 0.0, 0.0)]
////							];
//
////		animation.keyTimes = @[@0.0, @1.0];
//		animation.duration = 3.0;
////		animation.beginTime = 0.65 * i;
////		[cardAnimations addObject:animation];
////		NSLog(@"Animating card %@", @(i));

		double delayInSeconds = 0.25 * i;
		dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
		dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
			[SCNTransaction begin];
			[SCNTransaction setAnimationDuration:1.0];
			[SCNTransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];

			AEPlayerCard *card = _displayedCards[i];
			card.position = SCNVector3Make(-(totalWidthEnd / 2.0) + cardSpacingEndX * i, (card.cardSize.y / 2.0) + .025, 0.0);
			card.rotation = SCNVector4Make(0.0, 0.0, 0.0, 0.0);
			[SCNTransaction commit];
//			[card addAnimation:animation forKey:nil];
		});
	}

//	CAAnimationGroup *group = [CAAnimationGroup animation];
////	group.beginTime = addTime + 1;
//	group.animations = [NSArray arrayWithObject:cardAnimations];
//	group.duration = 3.0; // _displayedCardCount * 0.65;
////	anim.beginTime = 0.5;
//	[group run
//
//	for (int i = 0; i < _displayedCardCount; i++) {
//		AEPlayerCard *card = _displayedCards[i];
//		NSLog(@"Animating card %@", @(i));
//		[card addAnimation:cardAnimations[i] forKey:@"transform"];
//	}

//	[SCNTransaction commit];
}

/* ========================================================================== */
- (void)animateCardsOut {
	CGFloat cardSpacingEndX = 6.0;
	CGFloat totalWidthEnd = (_displayedCardCount - 1) * cardSpacingEndX;
	for (int i = 0; i < _displayedCardCount; i++) {
		AEPlayerCard *card = _displayedCards[i];
//		[card configureWithPlayer:players[i]];
		//		[_displayedCards addObject:card];
		//		[root addChildNode:card];
		//	NSLog(@"card size = %fx%f", playerCard.cardSize.x, playerCard.cardSize.y);
		//		NSLog(@"total width = %f", @(totalWidth));
//		card.position = SCNVector3Make(-(totalWidth / 2.0) + cardSpacingX * i, (card.cardSize.y / 2.0) + .025, 0.0);
		//		card.rotation = SCNVector4Make(1.0, 1.0, 0.0, -card.position.x / 20.0);
		//		NSLog(@"x pos of card %@ = %f", @(i), card.position.x);

		double delayInSeconds = 0.125 * i;
		dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
		dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
			[SCNTransaction begin];
			[SCNTransaction setAnimationDuration:0.5];
			[SCNTransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
			[SCNTransaction setCompletionBlock:^{
				static NSUInteger cardsCompleted = 0;
				cardsCompleted++;
				NSLog(@"completed = %@/%@", @(cardsCompleted), @(_displayedCardCount));
				if (cardsCompleted >= _displayedCardCount) {
					NSLog(@"animation complete.");
					[_displayedCards removeAllObjects];
					_displayedCardCount = 0;
					cardsCompleted = 0;
				}
				[card removeFromParentNode];
			}];

			AEPlayerCard *card = _displayedCards[i];
			card.position = SCNVector3Make(-(totalWidthEnd / 2.0) + cardSpacingEndX * i, 2.0, 18.0);
			card.rotation = SCNVector4Make(1.0, 0.0, 0.0, AEDegToRad(-75.0));
//			card.rotation = SCNVector4Make(0.0, 0.0, 0.0, 0.0);
			[SCNTransaction commit];
			//			[card addAnimation:animation forKey:nil];
		});
	}
}

/* ========================================================================== */
- (NSArray*)randomUniquePlayersWithCount:(NSUInteger)playerCount {
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:playerCount];
	NSMutableArray *tempPlayerPool = [NSMutableArray arrayWithArray:_playerIDPool];
	for (int i = 0; i < playerCount; i++) {
		NSInteger randomPlayerIndex =  AERandInt(0, tempPlayerPool.count - 1);
		AEPlayer *player = [self playerWithID:tempPlayerPool[randomPlayerIndex]];
//		[_displayedCards[i] configureWithPlayer:player];
		[result addObject:player];
		[tempPlayerPool removeObject:tempPlayerPool[randomPlayerIndex]];
//		NSLog(@"Showing player card for player with id %@, data = %@", _playerIDPool[randomPlayerIndex], player.data);
	}
	return [NSArray arrayWithArray:result];
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

//	for (NSString *key in [_players allKeys]) {
//		AEPlayer *p = _players[key];
////		NSLog(@"Player with key %@ = %@", key, p.data);
//		NSString *headshotFilePath = [[[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"PC Headshots/%@", p.data[@"ID"]] withExtension:@"png"] path];
//		//	NSLog(@"Attempting to load image %@", filePath);
////		NSImage *headshotImage = [[NSImage alloc] initWithContentsOfFile:headshotFilePath];
//		if (![[NSFileManager defaultManager] fileExistsAtPath:headshotFilePath]) {
//			NSLog(@"*** Player headshot image for %@ not found.", p.data[@"ID"]);
//		}
//	}
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

//	NSLog(@"%@ teams found.", @(_teams.allKeys.count));
//
//	for (NSString *key in [_teams allKeys]) {
//		AEPlayer *t = _teams[key];
//		NSLog(@"%@", t.data);
//	}
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
