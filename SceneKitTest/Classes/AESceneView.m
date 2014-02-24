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
#import "AEPlayerPickSet.h"
#import "AEUtility.h"
#import "CHCSVParser.h"

#define kMasterKey	@"ID"

@implementation AESceneView

-(void)awakeFromNib {
//	[AEUtility listAvailableFonts];

	_displayedCards = [NSMutableArray arrayWithCapacity:5];
	_players = [NSMutableDictionary dictionary];
	_teams = [NSMutableDictionary dictionary];
	_playerPickSets = [NSMutableArray array];
	_currentPickSet = nil;
	_currentParserLine = 0;
	_cardsAnimating = NO;

	[self initPlayersFromCSVFileWithBaseFilenames:@[@"ffl_2009_players"]];
	[self initTeamsFromCSVFileWithBaseFilenames:@[@"ffl_2009_teams", @"ffl_2009_teams_supplemental"]];

	_validPlayerPositions = @[@"QB", @"WR", @"RB", @"TE", @"K"];
	_playerIDPool = @[@"nfl.p.2914", @"nfl.p.3116", @"nfl.p.3511", @"nfl.p.3664", @"nfl.p.4262", @"nfl.p.4269", @"nfl.p.4653", @"nfl.p.4659", @"nfl.p.4878", @"nfl.p.4695", @"nfl.p.5034", @"nfl.p.5036", @"nfl.p.5104", @"nfl.p.5228", @"nfl.p.5388", @"nfl.p.5474", @"nfl.p.5482", @"nfl.p.5521", @"nfl.p.5652", @"nfl.p.5557", @"nfl.p.5900", @"nfl.p.5919", @"nfl.p.5922", @"nfl.p.6046", @"nfl.p.6103", @"nfl.p.6119", @"nfl.p.6142", @"nfl.p.6169", @"nfl.p.6353", @"nfl.p.6355", @"nfl.p.6359", @"nfl.p.6410", @"nfl.p.6427", @"nfl.p.6475", @"nfl.p.6479", @"nfl.p.6492", @"nfl.p.6591", @"nfl.p.6669", @"nfl.p.6752", @"nfl.p.6788", @"nfl.p.6802", @"nfl.p.6824", @"nfl.p.6827", @"nfl.p.6837", @"nfl.p.6840", @"nfl.p.6845", @"nfl.p.6867", @"nfl.p.6913", @"nfl.p.6994", @"nfl.p.7073", @"nfl.p.7108", @"nfl.p.7149", @"nfl.p.7178", @"nfl.p.7179", @"nfl.p.7200", @"nfl.p.7203", @"nfl.p.7215", @"nfl.p.7237", @"nfl.p.7241", @"nfl.p.7247", @"nfl.p.7253", @"nfl.p.7259", @"nfl.p.7282", @"nfl.p.7306", @"nfl.p.7406", @"nfl.p.7426", @"nfl.p.7434", @"nfl.p.7492", @"nfl.p.7527", @"nfl.p.7544", @"nfl.p.7635", @"nfl.p.7657", @"nfl.p.7776", @"nfl.p.7777", @"nfl.p.7802", @"nfl.p.7809", @"nfl.p.7810", @"nfl.p.7821", @"nfl.p.7858", @"nfl.p.7860", @"nfl.p.7868", @"nfl.p.7879", @"nfl.p.7894", @"nfl.p.7904", @"nfl.p.8021", @"nfl.p.8063", @"nfl.p.8177", @"nfl.p.8255", @"nfl.p.8256", @"nfl.p.8261", @"nfl.p.8263", @"nfl.p.8266", @"nfl.p.8276", @"nfl.p.8277", @"nfl.p.8281", @"nfl.p.8285", @"nfl.p.8286", @"nfl.p.8292", @"nfl.p.8298", @"nfl.p.8306", @"nfl.p.8317", @"nfl.p.8327", @"nfl.p.8330", @"nfl.p.8331", @"nfl.p.8346", @"nfl.p.8354", @"nfl.p.8391", @"nfl.p.8396", @"nfl.p.8407", @"nfl.p.8409", @"nfl.p.8416", @"nfl.p.8432", @"nfl.p.8447", @"nfl.p.8471", @"nfl.p.8482", @"nfl.p.8504", @"nfl.p.8561", @"nfl.p.8780", @"nfl.p.8781", @"nfl.p.8790", @"nfl.p.8795", @"nfl.p.8800", @"nfl.p.8801", @"nfl.p.8807", @"nfl.p.8810", @"nfl.p.8813", @"nfl.p.8815", @"nfl.p.8819", @"nfl.p.8821", @"nfl.p.8826", @"nfl.p.8850", @"nfl.p.8866", @"nfl.p.8868", @"nfl.p.8872", @"nfl.p.8926", @"nfl.p.8935", @"nfl.p.8951", @"nfl.p.8979", @"nfl.p.8981", @"nfl.p.8982", @"nfl.p.9004", @"nfl.p.9030", @"nfl.p.9037", @"nfl.p.9039", @"nfl.p.9126", @"nfl.p.9265", @"nfl.p.9271", @"nfl.p.9274", @"nfl.p.9284", @"nfl.p.9293", @"nfl.p.9294", @"nfl.p.9295", @"nfl.p.9314", @"nfl.p.9348", @"nfl.p.9404", @"nfl.p.9496", @"nfl.p.9497"];

	_cameraPositions = @{@"0" : [NSValue valueWithSCNVector3:SCNVector3Make(0.0, 2.5, 44.5)], // 0 cards
						 @"2" : [NSValue valueWithSCNVector3:SCNVector3Make(0.0, 2.9, 32.0)], // 2 cards
						 @"3" : [NSValue valueWithSCNVector3:SCNVector3Make(0.0, 2.6, 34.0)], // 3 cards
						 @"4" : [NSValue valueWithSCNVector3:SCNVector3Make(0.0, 2.3, 36.0)], // 4 cards
						 @"5" : [NSValue valueWithSCNVector3:SCNVector3Make(0.0, 2.0, 42.5)], // 5 cards
	};

	CGFloat cardSpacingX = 4.25;
	CGFloat cardPosY = 0.025;
	_cardPositions = @{
		@"2" : @[[NSValue valueWithSCNVector3:SCNVector3Make(-cardSpacingX * 0.5, cardPosY, 0.0)],
				 [NSValue valueWithSCNVector3:SCNVector3Make(cardSpacingX * 0.5, cardPosY, .0)]
		], // 2 cards

		@"3" : @[[NSValue valueWithSCNVector3:SCNVector3Make(-cardSpacingX * 1.0, cardPosY, 0.9)],
				 [NSValue valueWithSCNVector3:SCNVector3Make(0.0, cardPosY, 0.0)],
				 [NSValue valueWithSCNVector3:SCNVector3Make(cardSpacingX * 1.0, cardPosY, 0.9)]
		], // 3 cards

		@"4" : @[[NSValue valueWithSCNVector3:SCNVector3Make(-cardSpacingX * 1.45, cardPosY, 1.4)],
				 [NSValue valueWithSCNVector3:SCNVector3Make(-cardSpacingX * 0.5, cardPosY, 0.0)],
				 [NSValue valueWithSCNVector3:SCNVector3Make(cardSpacingX * 0.5, cardPosY, 0.0)],
				 [NSValue valueWithSCNVector3:SCNVector3Make(cardSpacingX * 1.45, cardPosY, 1.4)]
		], // 4 cards

		@"5" : @[[NSValue valueWithSCNVector3:SCNVector3Make(-cardSpacingX * 1.91, cardPosY, 2.85)],
				 [NSValue valueWithSCNVector3:SCNVector3Make(-cardSpacingX * 1.0, cardPosY, 0.9)],
				 [NSValue valueWithSCNVector3:SCNVector3Make(0.0, cardPosY, 0.0)],
				 [NSValue valueWithSCNVector3:SCNVector3Make(cardSpacingX * 1.0, cardPosY, 0.9)],
				 [NSValue valueWithSCNVector3:SCNVector3Make(cardSpacingX * 1.91, cardPosY, 2.85)]
		] // 5 cards
	};
	

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
	self.jitteringEnabled = YES;
	self.backgroundColor = [NSColor blackColor];
//	self.allowsCameraControl = YES;
//	self.showsStatistics = YES;

	// Main camera
	SCNCamera *camera = [SCNCamera camera];
	camera.xFov = 17;   // Degrees, not radians
	camera.yFov = 17;
//	camera.usesOrthographicProjection = YES;
	_cameraNode = [SCNNode node];
	_cameraNode.camera = camera;
//	_cameraNode.position = SCNVector3Make(0, 1.0, 18);
	_cameraNode.position = [_cameraPositions[[@(0) stringValue]] SCNVector3Value];
	[scene.rootNode addChildNode:_cameraNode];

	// left light
	SCNLight *leftLight = [SCNLight light];
	leftLight.name = @"left light";
    leftLight.type = SCNLightTypeDirectional;
	leftLight.castsShadow = NO;
    [leftLight setAttribute:@75 forKey:SCNLightSpotInnerAngleKey];
    [leftLight setAttribute:@90 forKey:SCNLightSpotOuterAngleKey];
	SCNNode *leftLightNode = [SCNNode node];
	leftLightNode.light = leftLight;
	leftLightNode.position = SCNVector3Make(-5, 10, -100);
    leftLightNode.rotation = SCNVector4Make(0, 1, 0, -3.0);
	[root addChildNode:leftLightNode];

	// main light
	SCNLight *light = [SCNLight light];
	light.name = @"center light";
    light.type = SCNLightTypeDirectional;
	light.castsShadow = NO;
    [light setAttribute:@75 forKey:SCNLightSpotInnerAngleKey];
    [light setAttribute:@90 forKey:SCNLightSpotOuterAngleKey];
	SCNNode *lightNode = [SCNNode node];
	lightNode.light = light;
	lightNode.position = SCNVector3Make(0, 10, -100);
    lightNode.rotation = SCNVector4Make(0, 0, 0, 0);
	[root addChildNode:lightNode];

	// right light
	SCNLight *rightLight = [SCNLight light];
	rightLight.name = @"right light";
    rightLight.type = SCNLightTypeDirectional;
	rightLight.castsShadow = NO;
    [rightLight setAttribute:@75 forKey:SCNLightSpotInnerAngleKey];
    [rightLight setAttribute:@90 forKey:SCNLightSpotOuterAngleKey];
	SCNNode *rightLightNode = [SCNNode node];
	rightLightNode.light = rightLight;
	rightLightNode.position = SCNVector3Make(5, 10, -100);
    rightLightNode.rotation = SCNVector4Make(0, 1, 0, 3.0);
	[root addChildNode:rightLightNode];

//    root.light = light;

//	// omni light
//	SCNLight *omni = [SCNLight light];
//    omni.type = SCNLightTypeOmni;
//	SCNNode *omniNode = [SCNNode node];
//	omniNode.light = omni;
//	omniNode.position = SCNVector3Make(0, 2.8, -50);
//	[root addChildNode:omniNode];

	SCNNode *spotNode = [SCNNode node];
    spotNode.name = @"floor spot light";
    spotNode.position = SCNVector3Make(0, 30, 2);
    spotNode.rotation = SCNVector4Make(1, 0, 0, -M_PI_2);
	spotNode.light = [SCNLight light];
	spotNode.light.color = [NSColor colorWithHue:.60 saturation:100.0 brightness:0.30 alpha:1.0];
	//	spotNode.light.color = [NSColor colorWithHue:0.0 saturation:0.0 brightness:0.30 alpha:1.0];
	spotNode.light.type = SCNLightTypeSpot;
	spotNode.light.castsShadow = NO;
	//    spotNode.light.shadowRadius = 10;
	//    [spotNode.light setAttribute:@30 forKey:SCNLightShadowNearClippingKey];
	//    [spotNode.light setAttribute:@50 forKey:SCNLightShadowFarClippingKey];
    [spotNode.light setAttribute:@8 forKey:SCNLightSpotInnerAngleKey];
    [spotNode.light setAttribute:@45 forKey:SCNLightSpotOuterAngleKey];
	[root addChildNode:spotNode];

//	SCNNode *cardSpotNode = [SCNNode node];
//    cardSpotNode.name = @"card spot light";
//    cardSpotNode.position = SCNVector3Make(0, 2.8, 50);
//    cardSpotNode.rotation = SCNVector4Make(1, 0, 0, 0);
//	cardSpotNode.light = [SCNLight light];
//	cardSpotNode.light.color = [NSColor colorWithHue:.00 saturation:00.0 brightness:1.0 alpha:1.0];
//	//	spotNode.light.color = [NSColor colorWithHue:0.0 saturation:0.0 brightness:0.30 alpha:1.0];
//	cardSpotNode.light.type = SCNLightTypeSpot;
//	cardSpotNode.light.castsShadow = NO;
//	//    spotNode.light.shadowRadius = 10;
//	//    [spotNode.light setAttribute:@30 forKey:SCNLightShadowNearClippingKey];
//	//    [spotNode.light setAttribute:@50 forKey:SCNLightShadowFarClippingKey];
//    [cardSpotNode.light setAttribute:@75 forKey:SCNLightSpotInnerAngleKey];
//    [cardSpotNode.light setAttribute:@90 forKey:SCNLightSpotOuterAngleKey];
//	[root addChildNode:cardSpotNode];

//	SCNNode *ambientNode = [SCNNode node];
//	SCNLight *ambientLight = [SCNLight light];
//	ambientNode.light = ambientLight;
//	ambientLight.color = [NSColor colorWithHue:0.0 saturation:0.0 brightness:0.20 alpha:1.0];
//	[root addChildNode:ambientNode];

	// floor geometry
	SCNFloor *floor = [SCNFloor floor];
	SCNMaterial *floorMaterial = [SCNMaterial material];
	[AEUtility configureMaterial:floorMaterial];
//	NSString *floorTexPath = [[[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"Images/floor_tex_seamless"] withExtension:@"png"] path];
//	NSImage *floorTexImg = [[NSImage alloc] initWithContentsOfFile:floorTexPath];
//	floorTexImg.size = CGSizeMake(10.0, 10.0);
//	floorMaterial.diffuse.contents = floorTexImg; //[NSColor darkGrayColor];
//	floorMaterial.diffuse.contentsTransform = CATransform3DMakeScale(5.0, 5.0, 1.0);
//	floorMaterial.emission.contents = floorTexImg;
	floor.reflectivity = 0.30;
	floor.reflectionFalloffStart = 0.5;
	floor.reflectionFalloffEnd = 3.0;
	floor.firstMaterial = floorMaterial;
	SCNNode *floorNode = [SCNNode nodeWithGeometry:floor];
	[root addChildNode:floorNode];

	_displayedCardsNode = [SCNNode node];
	[root addChildNode:_displayedCardsNode];

	// Sponsor logo geometry
	CGSize sponsorLogoPlaneSize = CGSizeMake(8.0, 4.0);
	CGFloat sponsorLogoScale = 1.5;
	SCNPlane *sponsorLogoPlane = [SCNPlane planeWithWidth:sponsorLogoPlaneSize.width height:sponsorLogoPlaneSize.height];
	_sponsorLogoNode = [SCNNode nodeWithGeometry:sponsorLogoPlane];
	_sponsorLogoNode.position = SCNVector3Make(0.0, 0.0, 0.0);
	_sponsorLogoNode.scale = SCNVector3Make(sponsorLogoScale, sponsorLogoScale, sponsorLogoScale);
	[root addChildNode:_sponsorLogoNode];

	// Sponsor logo materials
	SCNMaterial *sponsorLogoMat = [SCNMaterial material];
	[AEUtility configureMaterial:sponsorLogoMat];
//	NSString *sponsorLogoFilePath = [[[NSBundle mainBundle] URLForResource:@"Images/logo_tropicana" withExtension:@"png"] path];
	NSString *sponsorLogoFilePath = [[[NSBundle mainBundle] URLForResource:@"Images/logo_ffl" withExtension:@"png"] path];
	NSImage *sponsorLogoImg = [[NSImage alloc] initWithContentsOfFile:sponsorLogoFilePath];
	sponsorLogoMat.diffuse.contents = sponsorLogoImg;

	_sponsorLogoPositions = @{
		@"out" : [NSValue valueWithSCNVector3:SCNVector3Make(0.0, sponsorLogoPlaneSize.height / 2 + .1, -20.0)],
		@"in" :  [NSValue valueWithSCNVector3:SCNVector3Make(0.0, sponsorLogoPlaneSize.height / 2 + .1, 10.0)]
	};

//	sponsorLogoMat.emission.contents = sponsorLogoImg;
//	sponsorLogoMat.diffuse.contents = [NSImage imageNamed:@"logo_tropicana"];
//	sponsorLogoMat.reflective.contents = reflectionImg;
//	sponsorLogoMat.shininess = 0.3;
	_sponsorLogoNode.opacity = 0.0;
	_sponsorLogoNode.position = [_sponsorLogoPositions[@"out"] SCNVector3Value];
	_sponsorLogoNode.geometry.firstMaterial = sponsorLogoMat;

	[self animateLogoIn];

//	SCNPlane *infoPlane = [SCNPlane planeWithWidth:4.0 height:5.6];
//	SCNNode *infoNode = [SCNNode nodeWithGeometry:infoPlane];
//	SCNMaterial *infoMat = [SCNMaterial material];
//	infoNode.position = SCNVector3Make(0.0, 2.8 + .1, 0.0);
//	[AEUtility configureMaterial:infoMat];
//	[root addChildNode:infoNode];

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

//	[SCNTransaction begin];
//	[SCNTransaction setAnimationDuration:300.0];
////	[SCNTransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//	_displayedCardsNode.rotation = SCNVector4Make(0.0, 1.0, 0.0, (M_PI * 2) * 10.0);
//	[SCNTransaction commit];
}

/* ========================================================================== */
- (void)mouseDown:(NSEvent *)theEvent {
	NSPoint winp = [theEvent locationInWindow];
    NSPoint p = [self convertPoint:winp fromView:nil];

    CGPoint p2 = CGPointMake(p.x, p.y);
    NSArray *pts = [(SCNView *)self hitTest:p2 options:@{SCNHitTestBoundingBoxOnlyKey : @YES, SCNHitTestRootNodeKey : _displayedCardsNode}];
    for (SCNHitTestResult *result in pts) {
        SCNNode *n = result.node;
		
		// Hit test will find the exact node touched, move up the hierarchy until we find the player card object.
		while ([n class] != [AEPlayerCard class]) {
			n = n.parentNode;
		}

        CAKeyframeAnimation *jumpAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        float x = n.position.x;
        jumpAnim.duration = 0.75;
        jumpAnim.values = @[
			[NSValue valueWithSCNVector3:SCNVector3Make(x, 0.0, 0.0)],
			[NSValue valueWithSCNVector3:SCNVector3Make(x, 1.5, 0.0)],
			[NSValue valueWithSCNVector3:SCNVector3Make(x, 0.0, 0.0)]
		];
        jumpAnim.timingFunction =
		[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [n addAnimation:jumpAnim forKey:@"jump"];
    }
}

/* ========================================================================== */
- (void)animateCameraForCardCount:(NSUInteger)cardCount {
	NSInteger cardDelta = abs((int)cardCount - (int)_displayedCardCount);
//	NSLog(@"Card count = %@ | Displayed card count = %@ | Card delta = %@", @(cardCount), @(_displayedCardCount), @(cardDelta));

	[SCNTransaction begin];
	[SCNTransaction setAnimationDuration:0.5 + (.25 * cardDelta)];
	[SCNTransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	_cameraNode.position = [_cameraPositions[[@(cardCount) stringValue]] SCNVector3Value];
	[SCNTransaction commit];
}

/* ========================================================================== */
- (void)animateCardsInForPlayers:(NSArray*)players {
//	_displayedCardCount = players.count;
	NSUInteger playerCount = players.count;
	CGFloat cardSpacingStartX = 6.0;
	CGFloat cardSpacingEndX = 4.25;
	CGFloat totalWidthStart = (playerCount - 1) * cardSpacingStartX;
	CGFloat totalWidthEnd = (playerCount - 1) * cardSpacingEndX;

	// First create cards and place them in their starting positions.
	for (int i = 0; i < playerCount; i++) {
		AEPlayerCard *card = [[AEPlayerCard alloc] init];
		[card configureWithPlayer:players[i]];
		card.pivot = CATransform3DMakeTranslation(0.0, -2.8, 0.0);
		card.position = SCNVector3Make(-(-(totalWidthStart / 2.0) + cardSpacingStartX * i), .5, 48.0);
//		card.position = SCNVector3Make(-(totalWidthEnd / 2.0) + cardSpacingEndX * i, .025, 0.0);
//		card.position = SCNVector3Make(-(totalWidthStart / 2.0) + cardSpacingStartX * i, (card.cardSize.y * 1.5) + .025, 18.0);
//		card.position = SCNVector3Make(-(totalWidthStart / 2.0) + cardSpacingStartX * i, (card.cardSize.y / 2.0) + .025, 18.0);
//		card.position = SCNVector3Make(-(totalWidthEnd / 2.0) + cardSpacingEndX * i, (card.cardSize.y / 2.0) + .025, 0.0);
		card.rotation = SCNVector4Make(1.0, 0.75, 0.0, AEDegToRad(-80.0));
		[_displayedCards addObject:card];
		[_displayedCardsNode addChildNode:card];
	}

	NSArray *orderOfCards = nil;
	if (playerCount == 2) {
		orderOfCards = @[@0, @1];
	} else if (playerCount == 3) {
		orderOfCards = @[@0, @2, @1];
	} else if (playerCount == 4) {
		orderOfCards = @[@0, @3, @1, @2];
	} else if (playerCount == 5) {
		orderOfCards = @[@0, @4, @1, @3, @2];
	}

	_cardsAnimating = YES;
	for (int i = 0; i < playerCount; i++) {
		double delayInSeconds = 0.25 * i;
		dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
		dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
			[SCNTransaction begin];
//			[SCNTransaction setAnimationDuration:2.0];
			[SCNTransaction setAnimationDuration:0.65];
			[SCNTransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
			[SCNTransaction setCompletionBlock:^{
				static NSUInteger cardsInCompleted = 0;
				cardsInCompleted++;
				//				NSLog(@"completed = %@/%@", @(cardsCompleted), @(_displayedCardCount));
				if (cardsInCompleted >= playerCount) {
					//					NSLog(@"animation complete.");
					//					[_displayedCards removeAllObjects];
					_cardsAnimating = NO;
					_displayedCardCount = players.count;
					cardsInCompleted = 0;
				}
			}];

			AEPlayerCard *card = _displayedCards[[orderOfCards[i] intValue]];
			CGFloat posX = -(totalWidthEnd / 2.0) + cardSpacingEndX * i;
//			card.position = SCNVector3Make(posX, .025, fabs(posX) * 0.30);
			card.position = [_cardPositions[[@(playerCount) stringValue]][i] SCNVector3Value];
//			card.position = SCNVector3Make(-(totalWidthEnd / 2.0) + cardSpacingEndX * i, (card.cardSize.y / 2.0) + .025, 0.0);
//			card.rotation = SCNVector4Make(0.0, 0.0, 0.0, 0.0);
			card.rotation = SCNVector4Make(0.0, 1.0, 0.0, -posX * 0.075);
			NSLog(@"Moving card at index %@ to %f", @(i), fabs(posX) * 0.30);
			[SCNTransaction commit];
//			[card addAnimation:animation forKey:nil];
//			[card fadeOutReflectionAfterDelay:2.0];
		});
	}
}

/* ========================================================================== */
- (void)animateCardsOut {
//	CGFloat cardSpacingEndX = 6.0;
//	CGFloat totalWidthEnd = (_displayedCardCount - 1) * cardSpacingEndX;
	NSArray *orderOfCards = nil;

	if (_displayedCardCount == 2) {
		orderOfCards = @[@0, @1];
	} else if (_displayedCardCount == 3) {
		orderOfCards = @[@0, @2, @1];
	} else if (_displayedCardCount == 4) {
		orderOfCards = @[@0, @3, @1, @2];
	} else if (_displayedCardCount == 5) {
		orderOfCards = @[@0, @4, @1, @3, @2];
	}

	_cardsAnimating = YES;
	for (int i = 0; i < _displayedCardCount; i++) {
		AEPlayerCard *card = _displayedCards[i];

		double delayInSeconds = 0.125 * i;
		dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
		dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
			[SCNTransaction begin];
			[SCNTransaction setAnimationDuration:0.65];
			[SCNTransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
			[SCNTransaction setCompletionBlock:^{
				static NSUInteger cardsOutCompleted = 0;
				cardsOutCompleted++;
//				NSLog(@"completed = %@/%@", @(cardsCompleted), @(_displayedCardCount));
				if (cardsOutCompleted >= _displayedCardCount) {
//					NSLog(@"animation complete.");
//					[_displayedCards removeAllObjects];
					_cardsAnimating = NO;
					_displayedCardCount = 0;
					cardsOutCompleted = 0;
				}
				card.animateEnvironment = NO;
				[card removeFromParentNode];
				[_displayedCards removeObject:card];
			}];

			AEPlayerCard *card = _displayedCards[[orderOfCards[i] intValue]];
//			AEPlayerCard *card = _displayedCards[i];
			card.position = SCNVector3Make(card.position.x + 20.0, 0.5, 10.0 - (1.5 * i));
//			card.position = SCNVector3Make(-(totalWidthEnd / 2.0) + cardSpacingEndX * i, 2.0, 22.0);
			card.rotation = SCNVector4Make(1.0, 1.0, 0.0, AEDegToRad(-90.0));
//			card.rotation = SCNVector4Make(0.0, 0.0, 0.0, 0.0);
			[SCNTransaction commit];
//			[card addAnimation:animation forKey:nil];
		});
	}
}

/* ========================================================================== */
- (void)animateLogoIn {
	double delayInSeconds = 0.5;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		[SCNTransaction begin];
		[SCNTransaction setAnimationDuration:0.6];
		[SCNTransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
		_sponsorLogoNode.opacity = 1.0;
		_sponsorLogoNode.position = [_sponsorLogoPositions[@"in"] SCNVector3Value];
		[SCNTransaction commit];
	});
}

/* ========================================================================== */
- (void)animateLogoOut {
//	double delayInSeconds = 0.15;
//	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		[SCNTransaction begin];
		[SCNTransaction setAnimationDuration:0.6];
		[SCNTransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
		_sponsorLogoNode.opacity = 0.0;
		_sponsorLogoNode.position = [_sponsorLogoPositions[@"out"] SCNVector3Value];
		[SCNTransaction commit];
//	});
}

#pragma mark - player pick sets

/* ========================================================================== */
- (AEPlayerPickSet*)randomPickSet {
	NSUInteger randomPositionIndex = AERandInt(0, _validPlayerPositions.count - 1);
	NSString *randomPosition = _validPlayerPositions[randomPositionIndex];

	NSUInteger maxPlayers = 5;

	// Limit kickers to 3 cards max.
	if ([randomPosition isEqualToString:@"K"]) {
		maxPlayers = 3;
	}

	static NSArray *teamOwnerNames;
	static NSArray *teamOwnerLocations;
	static NSArray *fantasyTeamNames;

	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		teamOwnerNames = @[@"Benjamin", @"Howard", @"E.J.", @"Brian", @"Joel", @"Ruby", @"Ricky", @"Brad", @"Geoff", @"Lisa", @"Lawrence", @"Alan", @"Evan", @"Mike", @"Victor", @"Consuela", @"Gabrielle", @"Ernesto", @"Kim", @"Kojiro", @"Franky"];
		teamOwnerLocations = @[@"Brooklyn", @"Sunnyvale", @"Ft. Lauderdale", @"Chicago", @"New York", @"Buffalo", @"Indianapolis", @"Tucson", @"San Francisco", @"San Rafael", @"Texas", @"Colorado", @"Paris", @"Tokyo", @"Madrid", @"Calgary", @"Toronto", @"Cairo", @"Santiago", @"Boise", @"New Orleans"];
		fantasyTeamNames = @[@"Montezuma's Revenge", @"The Agony Of Defeat", @"Fail Whale", @"Cholula Luvrs Anonymous", @"Couch Potatos", @"Mingo Ate My Baby", @"Jamaal Charles In Charge", @"What Would Jones-Drew", @"My Favorite Marshawn", @"There's Gore In Dem Hills", @"Vladimir Putin's Bling Ring", @"Injured Head & Shoulders", @"Butt-Fumbling Foot Fetishers", @"Connecticut Cholos", @"White Cassel", @"Back that Asomugha Up", @"James Starks of Winterfell", @"Van Buren Boys", @"Somewhere Over Dwayne Bowe", @"Somewhere Over Dwayne Bowe", @"Straight Cash Homey"];
	});

	AEPlayerPickSet *result = [[AEPlayerPickSet alloc] init];
	result.fantasyTeamName = fantasyTeamNames[AERandInt(0, fantasyTeamNames.count - 1)];
	result.fantasyTeamOwnerName = teamOwnerLocations[AERandInt(0, teamOwnerLocations.count - 1)];
	result.fantasyTeamOwnerLocation = teamOwnerLocations[AERandInt(0, teamOwnerLocations.count - 1)];
	result.cardCount = AERandInt(2, maxPlayers);
	result.players = [self randomUniquePlayersWithCount:result.cardCount position:randomPosition];
	result.playerPosition = randomPosition;
	result.needCount = AERandInt(1, result.cardCount - 1);

	return result;
}

/* ========================================================================== */
- (NSArray*)randomUniquePlayersWithCount:(NSUInteger)playerCount {
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:playerCount];
	NSMutableArray *tempPlayerIDPool = [NSMutableArray arrayWithArray:_playerIDPool];
	for (int i = 0; i < playerCount; i++) {
		NSInteger randomPlayerIndex = AERandInt(0, tempPlayerIDPool.count - 1);
		AEPlayer *player = [self playerWithID:tempPlayerIDPool[randomPlayerIndex]];
		//		[_displayedCards[i] configureWithPlayer:player];
		[result addObject:player];
		[tempPlayerIDPool removeObject:tempPlayerIDPool[randomPlayerIndex]];
		//		NSLog(@"Showing player card for player with id %@, data = %@", _playerIDPool[randomPlayerIndex], player.data);
	}
	return [NSArray arrayWithArray:result];
}

/* ========================================================================== */
- (NSArray*)randomUniquePlayersWithCount:(NSUInteger)playerCount position:(NSString*)position {
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:playerCount];
	NSMutableArray *tempPlayerIDPool = [NSMutableArray array];

	for (NSString *playerID in _playerIDPool) {
		AEPlayer *p = _players[playerID];
//		NSLog(@"Checking player %@", [p.data description]);
		if ([p.data[@"POSITION"] isEqualToString:position]) {
//			NSLog(@"---> Adding player %@", p.data[@"DISPLAY_NAME"]);
			[tempPlayerIDPool addObject:playerID];
		}
	}

//	NSLog(@"Found %@ %@s", @(tempPlayerIDPool.count), position);

	for (int i = 0; i < playerCount; i++) {
		NSInteger randomPlayerIndex = AERandInt(0, tempPlayerIDPool.count - 1);
		AEPlayer *player = [self playerWithID:tempPlayerIDPool[randomPlayerIndex]];
		//		[_displayedCards[i] configureWithPlayer:player];
		[result addObject:player];
		[tempPlayerIDPool removeObject:tempPlayerIDPool[randomPlayerIndex]];
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
//	NSLog(@"parserDidBeginDocument:");
	_currentParserLine = 0;
	if (parser == _playerParser) {
		_playerKeys = [NSMutableArray array];
	} else if (parser == _teamParser) {
		_teamKeys = [NSMutableArray array];
	}
}

/* ========================================================================== */
- (void)parserDidEndDocument:(CHCSVParser *)parser {
//	NSLog(@"parserDidEndDocument:");
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
//	NSLog(@"parser:didStartElement: %@ namespaceURI: %@ qualifiedName: %@ attributes: %@", elementName, namespaceURI, qName, attributeDict);
}

/* ========================================================================== */
- (void)parser:(CHCSVParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
//	NSLog(@"parser:didEndElement: %@ namespaceURI: %@ qualifiedName: %@", elementName, namespaceURI, qName);
}

/* ========================================================================== */
- (IBAction)newSetButtonClicked:(id)sender {
//	NSLog(@"Button clicked (scene view).");
	if (_cardsAnimating) { return; }

	if (_displayedCardCount == 0) {
//		NSUInteger randomPositionIndex = AERandInt(0, _validPlayerPositions.count - 1);
//		NSString *randomPosition = _validPlayerPositions[randomPositionIndex];
//
//		NSUInteger maxPlayers = 5;
//
//		// Limit kickers to 3 cards max.
//		if ([randomPosition isEqualToString:@"K"]) {
//			maxPlayers = 3;
//		}
//
//		NSInteger randomPlayerCount = AERandInt(2, maxPlayers);
////		NSLog(@"Showing %@ cards for position %@", @(randomPlayerCount), randomPosition);
//		NSArray *randomPlayers = [self randomUniquePlayersWithCount:randomPlayerCount position:randomPosition];

		_currentPickSet = [self randomPickSet];
		[self animateLogoOut];
		[self animateCardsInForPlayers:_currentPickSet.players];
		[self animateCameraForCardCount:_currentPickSet.cardCount];
	} else {
		[self animateCardsOut];
		[self animateCameraForCardCount:0];
		[self animateLogoIn];
	}
}

@end
