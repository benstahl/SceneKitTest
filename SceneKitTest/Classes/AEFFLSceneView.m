//
//  AESceneView.m
//  SceneKitTest
//
//  Created by Ben Stahl on 2/11/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "AEFFLSceneView.h"
#import "AEPlayer.h"
#import "AETeam.h"
#import "AEPlayerCard.h"
#import "AEPlayerPickSet.h"
#import "AEUtility.h"
#import "AEHeaderView.h"
#import "AEModuleFFLViewController.h"

@implementation AEFFLSceneView

-(void)awakeFromNib {
//	[AEUtility listAvailableFonts];

//	if (!_vc) {
//		NSLog(@"(scene)vc is nil.");
//	} else {
//		NSLog(@"(scene)vc is not nil.");
//	}

	self.layer.contentsGravity = kCAGravityResizeAspectFill;
	self.layer.borderWidth = 0.5;
	self.layer.borderColor = [[NSColor darkGrayColor] CGColor];

	_displayedCards = [NSMutableArray arrayWithCapacity:5];
	_playerPickSets = [NSMutableArray array];
	_currentPickSet = nil;
	_cardsAnimating = NO;

	_cameraPositions = @{@"0" : [NSValue valueWithSCNVector3:SCNVector3Make(0.0, 1.8, 44.5)], // 0 cards
						 @"2" : [NSValue valueWithSCNVector3:SCNVector3Make(0.0, 3.25, 32.0)], // 2 cards
						 @"3" : [NSValue valueWithSCNVector3:SCNVector3Make(0.0, 3.05, 34.0)], // 3 cards
						 @"4" : [NSValue valueWithSCNVector3:SCNVector3Make(0.0, 2.8, 36.0)], // 4 cards
						 @"5" : [NSValue valueWithSCNVector3:SCNVector3Make(0.0, 2.6, 44.5)], // 5 cards
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
	

//	for (NSString *s in _vc.playerIDPool) {
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

	[self animateLogoInAfterDelay:0.0];

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
		AEPlayerCard *card = [[AEPlayerCard alloc] initWithViewController:_vc];
		[card configureWithPlayer:players[i]];
		card.pivot = CATransform3DMakeTranslation(0.0, -2.8, 0.0);
		card.position = SCNVector3Make(-(-(totalWidthStart / 2.0) + cardSpacingStartX * i), .5, 50.0);
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
//			NSLog(@"Moving card at index %@ to %f", @(i), fabs(posX) * 0.30);
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
- (void)animateLogoInAfterDelay:(CFTimeInterval)delayInSeconds {
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
	NSUInteger randomPositionIndex = AERandInt(0, _vc.validPlayerPositions.count - 1);
	NSString *randomPosition = _vc.validPlayerPositions[randomPositionIndex];

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
		teamOwnerNames = @[@"Benjamin", @"Howard", @"E.J.", @"Brian", @"Joel", @"Ruby", @"Ricky", @"Brad", @"Geoff", @"Lisa", @"Lawrence", @"Alan", @"Evan", @"Mike", @"Victor", @"Consuela", @"Gabrielle", @"Ernesto", @"Kim", @"Kojiro", @"Franky", @"Simone", @"Felipe", @"Muhammad", @"Matthew", @"The Ghost", @"El Guapo", @"Sweet Caroline", @"Finklestein", @"Captain Kirk", @"Spock", @"The Terminator", @"Dirty Sanchez", @"Lonely Heart", @"Stone Cold Killa", @"James Bond", @"Cosmo Kramer", @"Gilligan", @"Captain Stubing", @"Ricardo Nixon", @"Buster McThunderstick", @"MacGyver", @"Homer Simpson", @"Troy McClure"];
		teamOwnerLocations = @[@"Brooklyn", @"Sunnyvale", @"Ft. Lauderdale", @"Chicago", @"New York", @"Buffalo", @"Indianapolis", @"Tucson", @"San Francisco", @"San Rafael", @"Texas", @"Colorado", @"Paris", @"Tokyo", @"Madrid", @"Calgary", @"Toronto", @"Cairo", @"Santiago", @"Boise", @"New Orleans", @"Germany", @"Oslo", @"South Africa", @"Perth", @"Magagascar", @"Baghdad", @"London", @"Vancouver", @"Sonoma", @"Honolulu", @"Death Valley", @"Santa Monica", @"Boston", @"Potsdam", @"Albuquerque", @"Atlanta", @"Springfield", @"The North Pole", @"Iowa", @"Seattle", @"Houston", @"Austin", @"Oklahoma City", @"Portland", @"Westeros", @"New Zealand"];
		fantasyTeamNames = @[@"Montezuma's Revenge", @"The Agony Of Defeat", @"Fail Whale", @"Cholula Luvrs Anonymous", @"Couch Potatos", @"Mingo Ate My Baby", @"Jamaal Charles In Charge", @"What Would Jones-Drew?", @"My Favorite Marshawn", @"There's Gore In Dem Hills", @"Vladimir Putin's Bling Ring", @"Injured Head & Shoulders", @"Butt-Fumbling Foot Fetishers", @"Connecticut Cholos", @"White Cassel", @"Back that Asomugha Up", @"James Starks of Winterfell", @"Van Buren Boys", @"Somewhere Over Dwayne Bowe", @"Somewhere Over Dwayne Bowe", @"Straight Cash Homey", @"Livin' On A Prayer", @"Bone Breakers", @"Addai late, Amendola short", @"Pop a Kaep", @"Badonkagronk", @"Multiple Scorgasms", @"Victorious Secret", @"Big Test Icicles", @"Wii Not Fit", @"Fire Breathing Rubber Duckies", @"The Mighty Morphin Flower Arrangers", @"The Muffin Stuffers", @"Cow Tipping Dwarfs", @"Viscious and Delicious", @"The Cereal Killers", @"Swamp Donkeys", @"Walla Walla Weasel Wackers", @"Super Heroes In Training", @"Red Hot Oompa-Loompas", @"Blue Balls of Destiny", @"One Hit Wonders", @"Brew Crew", @"Spinal Tappers", @"The Untouchables", @"Smokin Aces", @"Pigs Might Fly", @"The Y-Nots!", @"The Cheezeweasels", @"Wood Chuckers!", @"Wrecking Crew", @"Smooth Operators", @"Eleven Wise Monkeys", @"Unfrozen Caveman Lawyers"];
	});

	AEPlayerPickSet *result = [[AEPlayerPickSet alloc] init];
	result.fantasyTeamName = fantasyTeamNames[AERandInt(0, fantasyTeamNames.count - 1)];
	result.fantasyTeamOwnerName = teamOwnerNames[AERandInt(0, teamOwnerNames.count - 1)];
	result.fantasyTeamOwnerLocation = teamOwnerLocations[AERandInt(0, teamOwnerLocations.count - 1)];
	result.cardCount = AERandInt(2, maxPlayers);
	result.players = [self randomUniquePlayersWithCount:result.cardCount position:randomPosition];
	result.playerPosition = randomPosition;
	result.needCount = AERandInt(1, result.cardCount - 1);
	result.remainingCount = AERandInt(1, result.cardCount - 1);

	return result;
}

/* ========================================================================== */
- (NSArray*)randomUniquePlayersWithCount:(NSUInteger)playerCount {
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:playerCount];
	NSMutableArray *tempPlayerIDPool = [NSMutableArray arrayWithArray:_vc.playerIDPool];
	for (int i = 0; i < playerCount; i++) {
		NSInteger randomPlayerIndex = AERandInt(0, tempPlayerIDPool.count - 1);
		AEPlayer *player = [_vc playerWithID:tempPlayerIDPool[randomPlayerIndex]];
		//		[_displayedCards[i] configureWithPlayer:player];
		[result addObject:player];
		[tempPlayerIDPool removeObject:tempPlayerIDPool[randomPlayerIndex]];
		//		NSLog(@"Showing player card for player with id %@, data = %@", _vc.playerIDPool[randomPlayerIndex], player.data);
	}
	return [NSArray arrayWithArray:result];
}

/* ========================================================================== */
- (NSArray*)randomUniquePlayersWithCount:(NSUInteger)playerCount position:(NSString*)position {
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:playerCount];
	NSMutableArray *tempPlayerIDPool = [NSMutableArray array];

	for (NSString *playerID in _vc.playerIDPool) {
		AEPlayer *p = _vc.players[playerID];
//		NSLog(@"Checking player %@", [p.data description]);
		if ([p.data[@"POSITION"] isEqualToString:position]) {
//			NSLog(@"---> Adding player %@", p.data[@"DISPLAY_NAME"]);
			[tempPlayerIDPool addObject:playerID];
		}
	}

//	NSLog(@"Found %@ %@s", @(tempPlayerIDPool.count), position);

	for (int i = 0; i < playerCount; i++) {
		NSInteger randomPlayerIndex = AERandInt(0, tempPlayerIDPool.count - 1);
		AEPlayer *player = [_vc playerWithID:tempPlayerIDPool[randomPlayerIndex]];
		//		[_displayedCards[i] configureWithPlayer:player];
		[result addObject:player];
		[tempPlayerIDPool removeObject:tempPlayerIDPool[randomPlayerIndex]];
		//		NSLog(@"Showing player card for player with id %@, data = %@", _vc.playerIDPool[randomPlayerIndex], player.data);
	}
	return [NSArray arrayWithArray:result];
}

/* ========================================================================== */
- (IBAction)showCardsButtonClicked:(id)sender {
//	NSLog(@"Button clicked (scene view).");
	if (_cardsAnimating) { return; }

	if (_displayedCardCount == 0) {
		_currentPickSet = [self randomPickSet];
		NSString *topLabelString = [NSString stringWithFormat:@"\"%@\"", _currentPickSet.fantasyTeamName];
		NSString *bottomLabelString = _currentPickSet.headerPickString;

//		NSLog(@"Header string = %@", bottomLabelString);

//		NSColor *highlightColor = [NSColor colorWithHue:0.135 saturation:1.0 brightness:1.0 alpha:1.0];
//
//		// text centering paragraph style
//		NSMutableParagraphStyle *centeringParagraphStyle = [[NSMutableParagraphStyle alloc] init];
//		[centeringParagraphStyle setAlignment:NSCenterTextAlignment];
//
//		/* --- Top label --- */
////		NSMutableAttributedString *topAttrString = [[NSMutableAttributedString alloc] initWithString:topLabelString];
//		NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", topLabelString, bottomLabelString]];
//		[attrString addAttribute:NSParagraphStyleAttributeName value:centeringParagraphStyle range:NSMakeRange(0, topLabelString.length)];
//
//		// Highlight top line
//		[attrString addAttribute:NSForegroundColorAttributeName value:highlightColor range:NSMakeRange(0, topLabelString.length)];
//
//		// Highlight "needs" number
//		NSUInteger needsCountIndex = topLabelString.length + 1 + (_currentPickSet.fantasyTeamOwnerName.length) + 6 + _currentPickSet.fantasyTeamOwnerLocation.length + 7;
//		[attrString addAttribute:NSForegroundColorAttributeName value:highlightColor range:NSMakeRange(needsCountIndex, 1)];
//
//		// Highlight "of" number
//		NSUInteger cardsCountIndex = needsCountIndex + 5;
//		[attrString addAttribute:NSForegroundColorAttributeName value:highlightColor range:NSMakeRange(cardsCountIndex, 1)];

		// center string
//		[topAttrString addAttribute:NSParagraphStyleAttributeName value:centeringParagraphStyle range:NSMakeRange(0, topAttrString.length)];
//		CTFontRef fontFace = CTFontCreateWithName((__bridge CFStringRef)(@"DIN-Bold"), 150.0, NULL);
//		NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
//		[attributes setObject:(__bridge id)fontFace forKey:(NSString*)kCTFontAttributeName];
//
//		NSMutableAttributedString *topAttrString = [[NSMutableAttributedString alloc] initWithString:topLabelString attributes:attributes];

//		[topAttrString addAttribute:NSFontNameAttribute value:@"DIN-Bold" range:NSMakeRange(0, topAttrString.length)];
//		[topAttrString addAttribute:NSFontSizeAttribute value:@100.0 range:NSMakeRange(0, topAttrString.length)];

//		CGFloat fontSize = 20.0;
//		NSApplicationPresentationOptions currentOptions = [NSApp currentSystemPresentationOptions];
//		if (currentOptions &= NSApplicationPresentationFullScreen) {
//			fontSize *= 2.0;
//		} else {
//		}
//		[topAttrString addAttribute:NSFontNameAttribute value:@"Helvetica" range:NSMakeRange(0, topAttrString.length)];
//		[topAttrString addAttribute:NSFontSizeAttribute value:@(fontSize) range:NSMakeRange(0, topAttrString.length)];

//		// highlight and stroke the entire line.
//		[topAttrString addAttribute:NSForegroundColorAttributeName value:highlightColor range:NSMakeRange(0, topAttrString.length)];
////		[topAttrString addAttribute:NSForegroundColorAttributeName value:[NSColor clearColor] range:NSMakeRange(0, topAttrString.length)];
////		[topAttrString addAttribute:NSStrokeColorAttributeName value:highlightColor range:NSMakeRange(0, topAttrString.length)];
////		[topAttrString addAttribute:NSStrokeWidthAttributeName value:@5.0 range:NSMakeRange(0, topAttrString.length)];
//
//		[_vc.headerView.topLabel setAttributedStringValue:topAttrString];
////		_vc.headerView.topLabel.string = @"THIS IS A STRING TEST"; //topAttrString;
//
//		/* --- Bottom label --- */
//		NSUInteger needsCountIndex = (_currentPickSet.fantasyTeamOwnerName.length) + 6 + _currentPickSet.fantasyTeamOwnerLocation.length + 7;
//		NSUInteger cardsCountIndex = needsCountIndex + 5;
//
////		NSLog(@"needsCountIndex = %@ | cardsCountIndex = %@", @(needsCountIndex), @(cardsCountIndex));
//
//		NSMutableAttributedString *bottomAttrString = [[NSMutableAttributedString alloc] initWithString:bottomLabelString];
//
//		// center string
//		[bottomAttrString addAttribute:NSParagraphStyleAttributeName value:centeringParagraphStyle range:NSMakeRange(0, bottomAttrString.length)];
//
//		// highlight the needs and card count letters.
//		[bottomAttrString addAttribute:NSForegroundColorAttributeName value:highlightColor range:NSMakeRange(needsCountIndex, 1)];
//		[bottomAttrString addAttribute:NSForegroundColorAttributeName value:highlightColor range:NSMakeRange(cardsCountIndex, 1)];

//		[_vc.headerView.bottomLabel setAttributedStringValue:bottomAttrString];
		_vc.headerView.topLabel.string = topLabelString;
		_vc.headerView.bottomLabel.string = bottomLabelString;

		[_vc.headerView fadeIn];
		[self animateLogoOut];
		[self animateCardsInForPlayers:_currentPickSet.players];
		[self animateCameraForCardCount:_currentPickSet.cardCount];
	} else {
		[self animateCardsOut];
		[self animateCameraForCardCount:0];
		[self animateLogoInAfterDelay:0.5];
		[_vc.headerView fadeOut];

		// Wait until after fade out to blank labels.
		double delayInSeconds = kHeaderFadeOutTime + 0.1;
		dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
		dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//			[_vc.headerView.topLabel setStringValue:@""];
//			[_vc.headerView.bottomLabel setStringValue:@""];
			_vc.headerView.topLabel.string = @"";
			_vc.headerView.bottomLabel.string = @"";
		});
	}
}

@end
