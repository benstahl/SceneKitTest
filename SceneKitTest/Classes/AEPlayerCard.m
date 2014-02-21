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
		
		SCNPlane *headshotBackgroundPlane = [SCNPlane planeWithWidth:_cardSize.x height:_cardSize.y];
		_headshotBackgroundNode = [SCNNode nodeWithGeometry:headshotBackgroundPlane];
		_headshotBackgroundNode.position = SCNVector3Make(0.0, 0.0, 0.0);
		[self addChildNode:_headshotBackgroundNode];

		SCNPlane *headshotPlane = [SCNPlane planeWithWidth:_cardSize.x height:_cardSize.y];
		_headshotNode = [SCNNode nodeWithGeometry:headshotPlane];
		_headshotNode.position = SCNVector3Make(0.0, 0.0, 0.002);
		[self addChildNode:_headshotNode];

		SCNPlane *basePlane = [SCNPlane planeWithWidth:_cardSize.x height:_cardSize.y];
		_baseNode = [SCNNode nodeWithGeometry:basePlane];
		_baseNode.position = SCNVector3Make(0.0, 0.0, 0.004);
		[self addChildNode:_baseNode];

		SCNPlane *primaryColorStripePlane = [SCNPlane planeWithWidth:_cardSize.x height:_cardSize.y];
		_primaryColorStripeNode = [SCNNode nodeWithGeometry:primaryColorStripePlane];
		_primaryColorStripeNode.position = SCNVector3Make(0.0, 0.0, 0.006);
		[self addChildNode:_primaryColorStripeNode];

		SCNPlane *secondaryColorStripePlane = [SCNPlane planeWithWidth:_cardSize.x height:_cardSize.y];
		_secondaryColorStripeNode = [SCNNode nodeWithGeometry:secondaryColorStripePlane];
		_secondaryColorStripeNode.position = SCNVector3Make(0.0, 0.0, 0.008);
		[self addChildNode:_secondaryColorStripeNode];

		SCNPlane *teamLogoPlane = [SCNPlane planeWithWidth:_cardSize.x height:_cardSize.y];
		_teamLogoNode = [SCNNode nodeWithGeometry:teamLogoPlane];
		_teamLogoNode.position = SCNVector3Make(0.0, 0.0, 0.010);
		[self addChildNode:_teamLogoNode];

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
		_firstNameLayer.fontSize = 50.0;
		_firstNameLayer.alignmentMode = kCAAlignmentCenter;
		_firstNameLayer.frame = CGRectMake(0, -10, 400, 560);
		_firstNameLayer.string = [NSString stringWithFormat:@"VERNON"];
		[textLayer addSublayer:_firstNameLayer];

		_lastNameLayer = [CATextLayer layer];
		_lastNameLayer.font = CGFontCreateWithFontName((CFStringRef)@"DIN-Bold");
		_lastNameLayer.fontSize = 50.0;
		_lastNameLayer.alignmentMode = kCAAlignmentCenter;
		_lastNameLayer.frame = CGRectMake(0, -60, 400, 560);
		_lastNameLayer.string = [NSString stringWithFormat:@"DAVIS"];
		[textLayer addSublayer:_lastNameLayer];

		_rankLayer = [CATextLayer layer];
		_rankLayer.font = CGFontCreateWithFontName((CFStringRef)@"DIN-Bold");
		_rankLayer.fontSize = 50.0;
		_rankLayer.alignmentMode = kCAAlignmentCenter;
		_rankLayer.frame = CGRectMake(0, -478, 400, 560);
//		_rankLayer.foregroundColor = [[NSColor colorWithCalibratedHue:0.0 saturation:0.0 brightness:75.0 alpha:1.0] CGColor];
		_rankLayer.string = [NSString stringWithFormat:@"TE RANK 12"];
		[textLayer addSublayer:_rankLayer];

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

/* ========================================================================== */
- (void)configureWithPlayer:(AEPlayer*)player {
	_player = player;

	AESceneView *sceneView = (AESceneView*)((AEAppDelegate*)[NSApp delegate]).sceneView;
	AETeam *team = [sceneView teamWithID:player.data[@"TEAM_ID"]];

	NSImage *reflectionImg = [NSImage imageNamed:@"reflection"];

	SCNMaterial *headshotBackgroundMat = [SCNMaterial material];
	[AEUtility configureMaterial:headshotBackgroundMat];
	headshotBackgroundMat.diffuse.contents = [NSImage imageNamed:@"pc_hs_bg"];
	headshotBackgroundMat.reflective.contents = reflectionImg;
	headshotBackgroundMat.shininess = 0.3;
	headshotBackgroundMat.multiply.contents = [AEUtility colorFromHexString:team.data[@"COLOR_BG_TINT"]];
	_headshotBackgroundNode.geometry.firstMaterial = headshotBackgroundMat;

	SCNMaterial *headshotMat = [SCNMaterial material];
	[AEUtility configureMaterial:headshotMat];
	NSString *headshotFilePath = [[[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"PC Headshots/%@", player.data[@"ID"]] withExtension:@"png"] path];
	//	NSLog(@"Attempting to load image %@", filePath);
	NSImage *headshotImage = [[NSImage alloc] initWithContentsOfFile:headshotFilePath];
	headshotMat.diffuse.contents = headshotImage;
	//		headshotMat.diffuse.contents = [NSImage imageNamed:@"nfl.p.7755"];
	//	headshotMat.reflective.contents = reflectionImg;
	//	headshotMat.shininess = 0.2;
	_headshotNode.geometry.firstMaterial = headshotMat;

	SCNMaterial *baseMat = [SCNMaterial material];
	[AEUtility configureMaterial:baseMat];
	baseMat.diffuse.contents = [NSImage imageNamed:@"pc_base"];
//	baseMat.reflective.contents = reflectionImg;
//	baseMat.shininess = 0.2;
	_baseNode.geometry.firstMaterial = baseMat;

	SCNMaterial *primaryColorStripeMat = [SCNMaterial material];
	[AEUtility configureMaterial:primaryColorStripeMat];
	primaryColorStripeMat.diffuse.contents = [NSImage imageNamed:@"pc_color_stripe_primary"];
	primaryColorStripeMat.reflective.contents = reflectionImg;
	primaryColorStripeMat.shininess = 0.3;
	primaryColorStripeMat.multiply.contents = [AEUtility colorFromHexString:team.data[@"COLOR_PRIMARY"]];
	_primaryColorStripeNode.geometry.firstMaterial = primaryColorStripeMat;

	SCNMaterial *secondaryColorStripeMat = [SCNMaterial material];
	[AEUtility configureMaterial:secondaryColorStripeMat];
	secondaryColorStripeMat.diffuse.contents = [NSImage imageNamed:@"pc_color_stripe_secondary"];
	secondaryColorStripeMat.reflective.contents = reflectionImg;
	secondaryColorStripeMat.shininess = 0.3;
	secondaryColorStripeMat.multiply.contents = [AEUtility colorFromHexString:team.data[@"COLOR_SECONDARY"]];
	_secondaryColorStripeNode.geometry.firstMaterial = secondaryColorStripeMat;

	SCNMaterial *teamLogoMat = [SCNMaterial material];
	[AEUtility configureMaterial:teamLogoMat];
//	NSImage *img = [NSImage imageNamed:[NSString stringWithFormat:@"PC Team Logos/%@", player.data[@"TEAM_ID"]]];
//	NSString *filePath = [[[NSBundle mainBundle] URLForResource:@"PC Headshots/nfl.p.3899" withExtension:@"png"] path];
	NSString *teamLogoFilePath = [[[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"PC Team Logos/%@", player.data[@"TEAM_ID"]] withExtension:@"png"] path];
//	NSLog(@"Attempting to load image %@", filePath);
	NSImage *teamLogoImage = [[NSImage alloc] initWithContentsOfFile:teamLogoFilePath];
	teamLogoMat.diffuse.contents = teamLogoImage;
	//	teamLogoMat.reflective.contents = reflectionImg;
	//	teamLogoMat.shininess = 0.2;
	_teamLogoNode.geometry.firstMaterial = teamLogoMat;

	_firstNameLayer.string = [[NSString stringWithFormat:@"%@", player.data[@"FIRST_NAME"]] uppercaseString];
	_lastNameLayer.string = [[NSString stringWithFormat:@"%@", player.data[@"LAST_NAME"]] uppercaseString];
	_rankLayer.string = [[NSString stringWithFormat:@"%@ RANK %@", player.data[@"POSITION"], player.data[@"POS_RANK"]] uppercaseString];

	[_firstNameLayer setNeedsDisplay];
	[_lastNameLayer setNeedsDisplay];
	[_rankLayer setNeedsDisplay];

//	SCNText *name = [SCNText textWithString:@"FIRSTNAME\nLASTNAME" extrusionDepth:0.0f];
//	name.alignmentMode = kCAAlignmentCenter;
//	////	text.materials[1] = [SCNMaterial material];
//	name.font = [NSFont fontWithName:@"DIN-Regular" size:200];
//	SCNNode *nameNode = [SCNNode nodeWithGeometry:name];
//	nameNode.scale = SCNVector3Make(0.2, 0.2, 0.2);
//	nameNode.position = SCNVector3Make(0, 0, 0.006);
	//	textNode.transform = CATransform3DScale(textNode.transform, .1f, .1f, .1f);
//	[self addChildNode:nameNode];

}

@end
