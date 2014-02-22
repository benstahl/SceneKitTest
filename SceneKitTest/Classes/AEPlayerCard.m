//
//  AESceneView.m
//  SceneKitTest
//
//  Created by Ben Stahl on 2/19/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import "AEAppDelegate.h"
#import "AESceneView.h"
#import "AEPlayerCard.h"
#import "AEPlayer.h"
#import "AETeam.h"
#import "AEUtility.h"

@implementation AEPlayerCard

/* ========================================================================== */
- (id)init {
	if (self = [super init]) {
		_cardSize = SCNVector3Make(4.0, 5.6, 0.0);
		
		NSImage *reflectionImg = [NSImage imageNamed:@"reflection"];

		// Headshot BG geometry
		SCNPlane *headshotBackgroundPlane = [SCNPlane planeWithWidth:_cardSize.x height:_cardSize.y];
		_headshotBackgroundNode = [SCNNode nodeWithGeometry:headshotBackgroundPlane];
		_headshotBackgroundNode.position = SCNVector3Make(0.0, 0.0, 0.0);
		[self addChildNode:_headshotBackgroundNode];

		// Headshot BG materials
		SCNMaterial *headshotBackgroundMat = [SCNMaterial material];
		[AEUtility configureMaterial:headshotBackgroundMat];
		headshotBackgroundMat.diffuse.contents = [NSImage imageNamed:@"pc_hs_bg"];
		headshotBackgroundMat.reflective.contents = reflectionImg;
		headshotBackgroundMat.shininess = 0.3;
//		headshotBackgroundMat.lightingModelName = SCNLightingModelBlinn;
		_headshotBackgroundNode.geometry.firstMaterial = headshotBackgroundMat;

		// Headshot geometry
		SCNPlane *headshotPlane = [SCNPlane planeWithWidth:_cardSize.x height:_cardSize.y];
		_headshotNode = [SCNNode nodeWithGeometry:headshotPlane];
		_headshotNode.position = SCNVector3Make(0.0, 0.0, 0.002);
		[self addChildNode:_headshotNode];

		// Headshot materials
		SCNMaterial *headshotMat = [SCNMaterial material];
		[AEUtility configureMaterial:headshotMat];
		_headshotNode.geometry.firstMaterial = headshotMat;

		// Base geometry (card outline, bg, etc.)
		SCNPlane *basePlane = [SCNPlane planeWithWidth:_cardSize.x height:_cardSize.y];
		_baseNode = [SCNNode nodeWithGeometry:basePlane];
		_baseNode.position = SCNVector3Make(0.0, 0.0, 0.004);
		[self addChildNode:_baseNode];

		// Base materials (card outline, bg, etc.)
		SCNMaterial *baseMat = [SCNMaterial material];
		[AEUtility configureMaterial:baseMat];
		baseMat.diffuse.contents = [NSImage imageNamed:@"pc_base"];
		_baseNode.geometry.firstMaterial = baseMat;

		// Primary color stripe geometry
		SCNPlane *primaryColorStripePlane = [SCNPlane planeWithWidth:_cardSize.x height:_cardSize.y];
		_primaryColorStripeNode = [SCNNode nodeWithGeometry:primaryColorStripePlane];
		_primaryColorStripeNode.position = SCNVector3Make(0.0, 0.0, 0.006);
		[self addChildNode:_primaryColorStripeNode];

		// Primary color stripe materials
		SCNMaterial *primaryColorStripeMat = [SCNMaterial material];
		[AEUtility configureMaterial:primaryColorStripeMat];
		primaryColorStripeMat.diffuse.contents = [NSImage imageNamed:@"pc_color_stripe_primary"];
		primaryColorStripeMat.reflective.contents = reflectionImg;
		primaryColorStripeMat.shininess = 0.3;
		_primaryColorStripeNode.geometry.firstMaterial = primaryColorStripeMat;
		
		// Secondary color stripe geometry
		SCNPlane *secondaryColorStripePlane = [SCNPlane planeWithWidth:_cardSize.x height:_cardSize.y];
		_secondaryColorStripeNode = [SCNNode nodeWithGeometry:secondaryColorStripePlane];
		_secondaryColorStripeNode.position = SCNVector3Make(0.0, 0.0, 0.008);
		[self addChildNode:_secondaryColorStripeNode];

		// Secondary color stripe materials
		SCNMaterial *secondaryColorStripeMat = [SCNMaterial material];
		[AEUtility configureMaterial:secondaryColorStripeMat];
		secondaryColorStripeMat.diffuse.contents = [NSImage imageNamed:@"pc_color_stripe_secondary"];
		secondaryColorStripeMat.reflective.contents = reflectionImg;
		secondaryColorStripeMat.shininess = 0.3;
		_secondaryColorStripeNode.geometry.firstMaterial = secondaryColorStripeMat;

		// Team logo geometry
		SCNPlane *teamLogoPlane = [SCNPlane planeWithWidth:_cardSize.x height:_cardSize.y];
		_teamLogoNode = [SCNNode nodeWithGeometry:teamLogoPlane];
		_teamLogoNode.position = SCNVector3Make(0.0, 0.0, 0.010);
		[self addChildNode:_teamLogoNode];

		// Team logo materials
		SCNMaterial *teamLogoMat = [SCNMaterial material];
		[AEUtility configureMaterial:teamLogoMat];
		_teamLogoNode.geometry.firstMaterial = teamLogoMat;

//		_nameText = [SCNText textWithString:@"FIRSTNAME\nLASTNAME" extrusionDepth:0.0f];
//		////	text.materials[1] = [SCNMaterial material];
//		_nameText.font = [NSFont fontWithName:@"DIN-Bold" size:100];
//		_nameText.containerFrame = CGRectMake(-_cardSize.x / 2, -_cardSize.y / 2, 400, 400);
//		_nameText.alignmentMode = kCAAlignmentCenter;
//		SCNNode *nameNode = [SCNNode nodeWithGeometry:_nameText];
////		nameNode.scale = SCNVector3Make(0.2, 0.2, 0.2);
//		nameNode.position = SCNVector3Make(0, _cardSize.y * 0.25, 0.006);
//		nameNode.transform = CATransform3DScale(nameNode.transform, .005f, .005f, .005f);
//		[self addChildNode:nameNode];

		CALayer *textLayer = [CALayer layer];
//		textLayer.backgroundColor = [[NSColor blueColor] CGColor];
//		textLayer.borderColor = [[NSColor yellowColor] CGColor];
//		textLayer.delegate = self;
		textLayer.frame = CGRectMake(0, 0, 400, 560);

		_firstNameLayer = [CATextLayer layer];
		_firstNameLayer.font = CGFontCreateWithFontName((CFStringRef)@"DIN-Bold");
		_firstNameLayer.fontSize = 48.0;
		_firstNameLayer.alignmentMode = kCAAlignmentCenter;
		_firstNameLayer.frame = CGRectMake(0, -10, 400, 560);
		_firstNameLayer.truncationMode = kCATruncationEnd;
		_firstNameLayer.string = [NSString stringWithFormat:@"VERNON"];
		[textLayer addSublayer:_firstNameLayer];

		_lastNameLayer = [CATextLayer layer];
		_lastNameLayer.font = CGFontCreateWithFontName((CFStringRef)@"DIN-Bold");
		_lastNameLayer.fontSize = 48.0;
		_lastNameLayer.alignmentMode = kCAAlignmentCenter;
		_lastNameLayer.frame = CGRectMake(0, -60, 400, 560);
		_lastNameLayer.truncationMode = kCATruncationEnd;
		_lastNameLayer.string = [NSString stringWithFormat:@"DAVIS"];
		[textLayer addSublayer:_lastNameLayer];

		_rankLayer = [CATextLayer layer];
		_rankLayer.font = CGFontCreateWithFontName((CFStringRef)@"DIN-Bold");
		_rankLayer.fontSize = 48.0;
		_rankLayer.alignmentMode = kCAAlignmentCenter;
		_rankLayer.frame = CGRectMake(0, -478, 400, 560);
//		_rankLayer.foregroundColor = [[NSColor colorWithCalibratedHue:0.0 saturation:0.0 brightness:75.0 alpha:1.0] CGColor];
		_rankLayer.string = [NSString stringWithFormat:@"TE RANK 12"];
		[textLayer addSublayer:_rankLayer];

		// Disable implicit animation on text changes for dynamic layers.
		NSDictionary *newActions = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNull null], @"contents", nil];
		_firstNameLayer.actions = newActions;
		_lastNameLayer.actions = newActions;
		_rankLayer.actions = newActions;

//		[infoLayer setNeedsDisplay];
//		[baseLayer setNeedsDisplay];

		SCNPlane *namePlane = [SCNPlane planeWithWidth:_cardSize.x height:_cardSize.y];
		_nameNode = [SCNNode nodeWithGeometry:namePlane];
		_nameNode.position = SCNVector3Make(0.0, 0.0, 0.012);
		[self addChildNode:_nameNode];

		SCNMaterial *nameMat = [SCNMaterial material];
		[AEUtility configureMaterial:nameMat];
		nameMat.diffuse.contents = textLayer;
//		nameMat.transparent.contents = baseLayer;
		//	nameMat.reflective.contents = reflectionImg;
		//	nameMat.shininess = 0.2;
		//	nameMat.multiply.contents = [AEUtility colorFromHexString:team.data[@"COLOR_SECONDARY"]];
		_nameNode.geometry.firstMaterial = nameMat;


//		[self configureWithPlayer:player];
	}
	return self;
}

/* ========================================================================== */
- (void)configureWithPlayer:(AEPlayer*)player {
	_player = player;

	AESceneView *sceneView = (AESceneView*)((AEAppDelegate*)[NSApp delegate]).sceneView;
	AETeam *team = [sceneView teamWithID:player.data[@"TEAM_ID"]];

	_headshotBackgroundNode.geometry.firstMaterial.multiply.contents = [AEUtility colorFromHexString:team.data[@"COLOR_BG_TINT"]];

	NSString *headshotFilePath = [[[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"PC Headshots/%@", player.data[@"ID"]] withExtension:@"png"] path];
	NSImage *headshotImage = [[NSImage alloc] initWithContentsOfFile:headshotFilePath];
	_headshotNode.geometry.firstMaterial.diffuse.contents = headshotImage;

	_primaryColorStripeNode.geometry.firstMaterial.multiply.contents = [AEUtility colorFromHexString:team.data[@"COLOR_PRIMARY"]];

	_secondaryColorStripeNode.geometry.firstMaterial.multiply.contents = [AEUtility colorFromHexString:team.data[@"COLOR_SECONDARY"]];

	NSString *teamLogoFilePath = [[[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"PC Team Logos/%@", player.data[@"TEAM_ID"]] withExtension:@"png"] path];
	NSImage *teamLogoImage = [[NSImage alloc] initWithContentsOfFile:teamLogoFilePath];
	_teamLogoNode.geometry.firstMaterial.diffuse.contents = teamLogoImage;

//	[CATransaction begin];
//	[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];

	NSDictionary *newActions = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNull null], @"contents", nil];
	_firstNameLayer.actions = newActions;
	_lastNameLayer.actions = newActions;
	_rankLayer.actions = newActions;

	NSString *firstNameText = [[NSString stringWithFormat:@"%@", player.data[@"FIRST_NAME"]] uppercaseString];
	[_firstNameLayer performSelectorOnMainThread:@selector(setString:) withObject:firstNameText waitUntilDone:YES];

	NSString *lastNameText = [[NSString stringWithFormat:@"%@", player.data[@"LAST_NAME"]] uppercaseString];
	[_lastNameLayer performSelectorOnMainThread:@selector(setString:) withObject:lastNameText waitUntilDone:YES];

	NSString *rankNameText = [[NSString stringWithFormat:@"%@ RANK %@", player.data[@"POSITION"], player.data[@"POS_RANK"]] uppercaseString];
	[_rankLayer performSelectorOnMainThread:@selector(setString:) withObject:rankNameText waitUntilDone:YES];

//	[CATransaction commit];

//	_firstNameLayer.contents = nil;
//	_lastNameLayer.contents = nil;
//	_rankLayer.contents = nil;
//
//	_firstNameLayer.string = [[NSString stringWithFormat:@"%@", player.data[@"FIRST_NAME"]] uppercaseString];
//	_lastNameLayer.string = [[NSString stringWithFormat:@"%@", player.data[@"LAST_NAME"]] uppercaseString];
//	_rankLayer.string = [[NSString stringWithFormat:@"%@ RANK %@", player.data[@"POSITION"], player.data[@"POS_RANK"]] uppercaseString];

//	[_firstNameLayer displayIfNeeded];
//	[_lastNameLayer displayIfNeeded];
//	[_rankLayer displayIfNeeded];
}

/* ========================================================================== */
- (void) drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
	NSLog(@"***");

	CGContextSetFillColorWithColor(ctx, [[NSColor clearColor] CGColor]);

	//	NSGraphicsPushContext(ctx);
	/*[word drawInRect:layer.bounds
	 withFont:[UIFont systemFontOfSize:32]
     lineBreakMode:UILineBreakModeWordWrap
	 alignment:UITextAlignmentCenter];*/

	CGContextSetFont(ctx, CGFontCreateWithFontName((CFStringRef)@"DIN-Bold"));
	CGContextSetFontSize(ctx, 24.0);
	[@"VERNON\nDAVIS" drawAtPoint:CGPointZero withAttributes:nil];

	//	[@"VERNON\nDAVIS" drawAtPoint:CGPointMake(30.0f, 30.0f)
	//			 forWidth:200.0f
	//			 withFont:[NSFont fontWithName:@"DIN-Bold" size:72.0]
	//		lineBreakMode:NSLineBreakByWordWrapping];

	//	UIGraphicsPopContext();
}

@end
