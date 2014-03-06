//
//  AESceneView.m
//  SceneKitTest
//
//  Created by Ben Stahl on 2/19/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import "AEAppDelegate.h"
#import "AEFFLSceneView.h"
#import "AEPlayerCard.h"
#import "AEPlayer.h"
#import "AETeam.h"
#import "AEUtility.h"
#import "AEModuleFFLViewController.h"

@implementation AEPlayerCard

/* ========================================================================== */
- (id)initWithViewController:(AEModuleFFLViewController*)vc {
	if (self = [super init]) {
		_vc = vc;
		_cardSize = SCNVector3Make(4.0, 5.6, 0.0);
		
//		NSString *reflectionFilePath = [[[NSBundle mainBundle] URLForResource:@"Images/reflection" withExtension:@"png"] path];
//		NSImage *reflectionImg = [[NSImage alloc] initWithContentsOfFile:reflectionFilePath];

		/* --------------------------------------------------------------------------
		 Headshot background
		 ------------------------------------------------------------------------- */
		SCNPlane *headshotBackgroundPlane = [SCNPlane planeWithWidth:_cardSize.x height:_cardSize.y];
		_headshotBackgroundNode = [SCNNode nodeWithGeometry:headshotBackgroundPlane];
		_headshotBackgroundNode.position = SCNVector3Make(0.0, 0.0, 0.0);
		[self addChildNode:_headshotBackgroundNode];

		SCNMaterial *headshotBackgroundMat = [SCNMaterial material];
		[AEUtility configureMaterial:headshotBackgroundMat];
		NSString *headshotBackgroundFilePath = [[[NSBundle mainBundle] URLForResource:@"Images/pc_hs_bg" withExtension:@"png"] path];
		NSImage *headshotBackgroundImage = [[NSImage alloc] initWithContentsOfFile:headshotBackgroundFilePath];
		headshotBackgroundMat.diffuse.contents = headshotBackgroundImage;
		headshotBackgroundMat.diffuse.intensity = 0.0;
		headshotBackgroundMat.emission.contents = headshotBackgroundImage;
		headshotBackgroundMat.emission.intensity = 1.0;
//		headshotBackgroundMat.reflective.contents = reflectionImg;
//		headshotBackgroundMat.reflective.intensity = 0.25;
//		headshotBackgroundMat.shininess = 1.0;
//		headshotBackgroundMat.lightingModelName = SCNLightingModelBlinn;
		_headshotBackgroundNode.geometry.firstMaterial = headshotBackgroundMat;
//		_headshotBackgroundNode.geometry.firstMaterial.reflective.contentsTransform = CATransform3DMakeTranslation(0.0, 0.0, 0.0);

		/* --------------------------------------------------------------------------
		 Headshot image
		 ------------------------------------------------------------------------- */
		SCNPlane *headshotPlane = [SCNPlane planeWithWidth:_cardSize.x height:_cardSize.y];
		_headshotNode = [SCNNode nodeWithGeometry:headshotPlane];
		_headshotNode.position = SCNVector3Make(0.0, 0.0, 0.002);
		[self addChildNode:_headshotNode];

		SCNMaterial *headshotMat = [SCNMaterial material];
		[AEUtility configureMaterial:headshotMat];
		headshotMat.diffuse.contents = [CALayer layer];
		headshotMat.diffuse.intensity = 0.0;
		headshotMat.emission.contents = [CALayer layer];
		headshotMat.emission.intensity = 1.0;
		_headshotNode.geometry.firstMaterial = headshotMat;

		/* --------------------------------------------------------------------------
		 Card base (card outline, bg, etc.)
		 ------------------------------------------------------------------------- */
		SCNPlane *basePlane = [SCNPlane planeWithWidth:_cardSize.x height:_cardSize.y];
		_baseNode = [SCNNode nodeWithGeometry:basePlane];
		_baseNode.position = SCNVector3Make(0.0, 0.0, 0.004);
		[self addChildNode:_baseNode];

		SCNMaterial *baseMat = [SCNMaterial material];
		[AEUtility configureMaterial:baseMat];

		NSString *baseFilePath = [[[NSBundle mainBundle] URLForResource:@"Images/pc_base" withExtension:@"png"] path];
		NSImage *baseImage = [[NSImage alloc] initWithContentsOfFile:baseFilePath];
		baseMat.diffuse.contents = baseImage;
		baseMat.diffuse.intensity = 0.0;
		baseMat.emission.contents = baseImage;
		baseMat.emission.intensity = 1.0;
//		baseMat.diffuse.contents = [NSColor clearColor];
//		baseMat.emission.contents = baseImage;
//		baseMat.reflective.contents = reflectionImg;
//		baseMat.reflective.intensity = 0.35;
//		baseMat.shininess = 1.0;
		_baseNode.geometry.firstMaterial = baseMat;

		/* --------------------------------------------------------------------------
		 Primary color stripe geometry
		 ------------------------------------------------------------------------- */
		SCNPlane *primaryColorStripePlane = [SCNPlane planeWithWidth:_cardSize.x height:_cardSize.y];
		_primaryColorStripeNode = [SCNNode nodeWithGeometry:primaryColorStripePlane];
		_primaryColorStripeNode.position = SCNVector3Make(0.0, 0.0, 0.006);
		[self addChildNode:_primaryColorStripeNode];

		SCNMaterial *primaryColorStripeMat = [SCNMaterial material];
		[AEUtility configureMaterial:primaryColorStripeMat];
		NSString *primaryColorStripeFilePath = [[[NSBundle mainBundle] URLForResource:@"Images/pc_color_stripe_primary" withExtension:@"png"] path];
		NSImage *primaryColorStripeImage = [[NSImage alloc] initWithContentsOfFile:primaryColorStripeFilePath];
		primaryColorStripeMat.diffuse.contents = primaryColorStripeImage;
		primaryColorStripeMat.diffuse.intensity = 0.0;
		primaryColorStripeMat.emission.contents = primaryColorStripeImage;
		primaryColorStripeMat.emission.intensity = 1.0;
//		primaryColorStripeMat.reflective.contents = reflectionImg;
//		primaryColorStripeMat.shininess = 0.3;
		_primaryColorStripeNode.geometry.firstMaterial = primaryColorStripeMat;
		
		/* --------------------------------------------------------------------------
		 Secondary color stripe
		 ------------------------------------------------------------------------- */
		SCNPlane *secondaryColorStripePlane = [SCNPlane planeWithWidth:_cardSize.x height:_cardSize.y];
		_secondaryColorStripeNode = [SCNNode nodeWithGeometry:secondaryColorStripePlane];
		_secondaryColorStripeNode.position = SCNVector3Make(0.0, 0.0, 0.008);
		[self addChildNode:_secondaryColorStripeNode];

		SCNMaterial *secondaryColorStripeMat = [SCNMaterial material];
		[AEUtility configureMaterial:secondaryColorStripeMat];
		NSString *secondaryColorStripeFilePath = [[[NSBundle mainBundle] URLForResource:@"Images/pc_color_stripe_secondary" withExtension:@"png"] path];
		NSImage *secondaryColorStripeImage = [[NSImage alloc] initWithContentsOfFile:secondaryColorStripeFilePath];
		secondaryColorStripeMat.diffuse.contents = secondaryColorStripeImage;
		secondaryColorStripeMat.diffuse.intensity = 0.0;
		secondaryColorStripeMat.emission.contents = secondaryColorStripeImage;
		secondaryColorStripeMat.emission.intensity = 1.0;
//		secondaryColorStripeMat.reflective.contents = reflectionImg;
//		secondaryColorStripeMat.shininess = 0.3;
		_secondaryColorStripeNode.geometry.firstMaterial = secondaryColorStripeMat;

		/* --------------------------------------------------------------------------
		 Team logo image
		 ------------------------------------------------------------------------- */
		SCNPlane *teamLogoPlane = [SCNPlane planeWithWidth:_cardSize.x height:_cardSize.y];
		_teamLogoNode = [SCNNode nodeWithGeometry:teamLogoPlane];
		_teamLogoNode.position = SCNVector3Make(0.0, 0.0, 0.010);
		[self addChildNode:_teamLogoNode];

		SCNMaterial *teamLogoMat = [SCNMaterial material];
		[AEUtility configureMaterial:teamLogoMat];
		teamLogoMat.diffuse.contents = [CALayer layer];
		teamLogoMat.diffuse.intensity = 0.0;
		teamLogoMat.emission.contents =  [CALayer layer];
		teamLogoMat.emission.intensity = 1.0;
		_teamLogoNode.geometry.firstMaterial = teamLogoMat;

		/* --------------------------------------------------------------------------
		 Text layer (name and position ranking)
		 ------------------------------------------------------------------------- */
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
		_firstNameLayer.shadowColor = [[NSColor blackColor] CGColor];
		_firstNameLayer.shadowOpacity = 1.0;
		_firstNameLayer.shadowOffset = CGSizeMake(6.0, -6.0);
		_firstNameLayer.shadowRadius = 2.5;
		_firstNameLayer.shouldRasterize = YES;
		[textLayer addSublayer:_firstNameLayer];

		_lastNameLayer = [CATextLayer layer];
		_lastNameLayer.font = CGFontCreateWithFontName((CFStringRef)@"DIN-Bold");
		_lastNameLayer.fontSize = 48.0;
		_lastNameLayer.alignmentMode = kCAAlignmentCenter;
		_lastNameLayer.frame = CGRectMake(0, -60, 400, 560);
		_lastNameLayer.truncationMode = kCATruncationEnd;
		_lastNameLayer.string = [NSString stringWithFormat:@"DAVIS"];
		_lastNameLayer.shadowColor = [[NSColor blackColor] CGColor];
		_lastNameLayer.shadowOpacity = 1.0;
		_lastNameLayer.shadowOffset = CGSizeMake(6.0, -6.0);
		_lastNameLayer.shadowRadius = 2.5;
		_lastNameLayer.shouldRasterize = YES;
		[textLayer addSublayer:_lastNameLayer];

		_rankLayer = [CATextLayer layer];
		_rankLayer.font = CGFontCreateWithFontName((CFStringRef)@"DIN-Bold");
		_rankLayer.fontSize = 48.0;
		_rankLayer.alignmentMode = kCAAlignmentCenter;
		_rankLayer.frame = CGRectMake(0, -478, 400, 560);
//		_rankLayer.foregroundColor = [[NSColor colorWithHue:0.0 saturation:0.0 brightness:75.0 alpha:1.0] CGColor];
		_rankLayer.string = [NSString stringWithFormat:@"TE RANK 12"];
		_rankLayer.shadowColor = [[NSColor blackColor] CGColor];
		_rankLayer.shadowOpacity = 1.0;
		_rankLayer.shadowOffset = CGSizeMake(6.0, -6.0);
		_rankLayer.shadowRadius = 2.5;
		_rankLayer.shouldRasterize = YES;
		[textLayer addSublayer:_rankLayer];

		SCNPlane *textPlane = [SCNPlane planeWithWidth:_cardSize.x height:_cardSize.y];
		_textNode = [SCNNode nodeWithGeometry:textPlane];
		_textNode.position = SCNVector3Make(0.0, 0.0, 0.012);
		[self addChildNode:_textNode];

		SCNMaterial *textMat = [SCNMaterial material];
		[AEUtility configureMaterial:textMat];
		textMat.diffuse.contents = textLayer;
		textMat.diffuse.intensity = 0.0;
		textMat.emission.contents = textLayer;
		textMat.emission.intensity = 1.0;
		_textNode.geometry.firstMaterial = textMat;

		/* --------------------------------------------------------------------------
		 Confirmation or denial icon (checkmark or 'X')
		 ------------------------------------------------------------------------- */
		CALayer *acceptRejectLayer = [CALayer layer];
//		acceptRejectLayer.backgroundColor = [[NSColor orangeColor] CGColor];
//		acceptRejectLayer.borderColor = [[NSColor yellowColor] CGColor];
		acceptRejectLayer.frame = CGRectMake(0, 0, 400, 560);
//		acceptRejectLayer.contentsGravity = kCAGravityResize;

		_acceptRejectNodeIcon = [CATextLayer layer];
		_acceptRejectNodeIcon.frame = CGRectMake(0, -320, 400, 560);
		_acceptRejectNodeIcon.font = CGFontCreateWithFontName((CFStringRef)@"Helvetica Bold");
		_acceptRejectNodeIcon.fontSize = 160.0;
		_acceptRejectNodeIcon.alignmentMode = kCAAlignmentCenter;
		_acceptRejectNodeIcon.string = @"\u2713";
		_acceptRejectNodeIcon.foregroundColor = [[NSColor colorWithHue:0.33 saturation:1.0 brightness:0.85 alpha:1.0] CGColor];
		_acceptRejectNodeIcon.shadowColor = [[NSColor blackColor] CGColor];
		_acceptRejectNodeIcon.shadowOpacity = 1.0;
		_acceptRejectNodeIcon.shadowOffset = CGSizeMake(6.0, -6.0);
		_acceptRejectNodeIcon.shadowRadius = 2.5;
		_acceptRejectNodeIcon.shouldRasterize = YES;
		[acceptRejectLayer addSublayer:_acceptRejectNodeIcon];

		SCNPlane *acceptRejectPlane = [SCNPlane planeWithWidth:_cardSize.x height:_cardSize.y];
		_acceptRejectNode = [SCNNode nodeWithGeometry:acceptRejectPlane];
		_acceptRejectNode.position = SCNVector3Make(0.0, 0.0, 0.014);
		_acceptRejectNode.hidden = YES;
		[self addChildNode:_acceptRejectNode];

		SCNMaterial *acceptRejectMat = [SCNMaterial material];
		[AEUtility configureMaterial:acceptRejectMat];
		acceptRejectMat.diffuse.contents = acceptRejectLayer;
		acceptRejectMat.diffuse.intensity = 0.0;
		acceptRejectMat.emission.contents = acceptRejectLayer;
		acceptRejectMat.emission.intensity = 1.0;
		_acceptRejectNode.geometry.firstMaterial = acceptRejectMat;
	}
	return self;
}

/* ========================================================================== */
- (void)configurePickSetStatus {
	NSDictionary *newActions = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNull null], @"string", nil];
	_acceptRejectNodeIcon.actions = newActions;

	if (_player.pickSetStatus == kPickSetStatusAccepted) {
		_acceptRejectNodeIcon.fontSize = 160.0;
		_acceptRejectNodeIcon.string = @"\u2713";
		_acceptRejectNodeIcon.foregroundColor = [[NSColor colorWithHue:0.33 saturation:1.0 brightness:0.85 alpha:1.0] CGColor];
		_acceptRejectNode.hidden = NO;
		_teamLogoNode.hidden = YES;
	} else if (_player.pickSetStatus == kPickSetStatusRejected) {
		_acceptRejectNodeIcon.fontSize = 160.0;
		_acceptRejectNodeIcon.string = @"\u2718";
		_acceptRejectNodeIcon.foregroundColor = [[NSColor colorWithHue:0.0 saturation:1.0 brightness:0.85 alpha:1.0] CGColor];
		_acceptRejectNode.hidden = NO;
		_teamLogoNode.hidden = YES;
	} else {
		_acceptRejectNode.hidden = YES;
		_teamLogoNode.hidden = NO;
	}
}

/* ========================================================================== */
- (void)configureWithPlayer:(AEPlayer*)player {
	_player = player;

//	AEFFLSceneView *sceneView = sceneView;

//	AEFFLSceneView *sceneView = _vc.sceneView;
	AETeam *team = [_vc teamWithID:player.data[@"TEAM_ID"]];

//	NSString *headshotBackgroundFilePath = [[[NSBundle mainBundle] URLForResource:@"Images/pc_hs_bg" withExtension:@"png"] path];
//	NSImage *headshotBackgroundImage = [[NSImage alloc] initWithContentsOfFile:headshotBackgroundFilePath];
//	_headshotBackgroundNode.geometry.firstMaterial.diffuse.contents = headshotBackgroundImage;
//	_headshotBackgroundNode.geometry.firstMaterial.diffuse.intensity = 0.0;
//	_headshotBackgroundNode.geometry.firstMaterial.emission.contents = headshotBackgroundImage;
//	_headshotBackgroundNode.geometry.firstMaterial.emission.intensity = 1.0;
	_headshotBackgroundNode.geometry.firstMaterial.multiply.contents = [AEUtility colorFromHexString:team.data[@"COLOR_BG_TINT"]];

	NSString *headshotFilePath = [[[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"PC Headshots/%@", player.data[@"ID"]] withExtension:@"png"] path];
	NSImage *headshotImage = [[NSImage alloc] initWithContentsOfFile:headshotFilePath];
	_headshotNode.geometry.firstMaterial.diffuse.contents = headshotImage;
	_headshotNode.geometry.firstMaterial.emission.contents = headshotImage;

	_primaryColorStripeNode.geometry.firstMaterial.multiply.contents = [AEUtility colorFromHexString:team.data[@"COLOR_PRIMARY"]];

	_secondaryColorStripeNode.geometry.firstMaterial.multiply.contents = [AEUtility colorFromHexString:team.data[@"COLOR_SECONDARY"]];

	NSString *teamLogoFilePath = [[[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"PC Team Logos/%@", player.data[@"TEAM_ID"]] withExtension:@"png"] path];
	NSImage *teamLogoImage = [[NSImage alloc] initWithContentsOfFile:teamLogoFilePath];
//	_teamLogoNode.geometry.firstMaterial.diffuse.contents = teamLogoImage;
	_teamLogoNode.geometry.firstMaterial.emission.contents = teamLogoImage;

//	[CATransaction begin];
//	[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];

	NSDictionary *newActions = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNull null], @"contents", nil];
	_firstNameLayer.actions = newActions;
	_lastNameLayer.actions = newActions;
	_rankLayer.actions = newActions;

	NSString *firstNameText = [[NSString stringWithFormat:@"%@", player.data[@"FIRST_NAME"]] uppercaseString];
	_firstNameLayer.string = firstNameText;
//	[_firstNameLayer performSelectorOnMainThread:@selector(setString:) withObject:firstNameText waitUntilDone:YES];

	NSString *lastNameText = [[NSString stringWithFormat:@"%@", player.data[@"LAST_NAME"]] uppercaseString];
	_lastNameLayer.string = lastNameText;
//	[_lastNameLayer performSelectorOnMainThread:@selector(setString:) withObject:lastNameText waitUntilDone:YES];

	NSString *rankNameText = [[NSString stringWithFormat:@"%@ RANK %@", player.data[@"POSITION"], player.data[@"POS_RANK"]] uppercaseString];
	_rankLayer.string = rankNameText;
//	[_rankLayer performSelectorOnMainThread:@selector(setString:) withObject:rankNameText waitUntilDone:YES];

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

//	[SCNTransaction begin];
//	[SCNTransaction setAnimationDuration:10.0];
//	[SCNTransaction setCompletionBlock:^{
//		_headshotBackgroundNode.geometry.firstMaterial.reflective.contentsTransform = CATransform3DMakeTranslation(0.0, 0.0, 0.0);
//	}];
//	_headshotBackgroundNode.geometry.firstMaterial.reflective.contentsTransform = CATransform3DMakeTranslation(512.0, 0.0, 0.0);
//	[SCNTransaction commit];
//	[self startEnvironmentLoop];
}

/* ========================================================================== */
- (void)startEnvironmentLoop {
	NSLog(@"Starting environment loop.");
	_animateEnvironment = YES;
//	_headshotBackgroundNode.geometry.firstMaterial.reflective.contentsTransform = CATransform3DMakeTranslation(-1.0, 0.0, 0.0);
//	_headshotBackgroundNode.geometry.firstMaterial.diffuse.contentsTransform =  CATransform3DMakeRotation(M_PI * 2, 0.0, 0.0, 1.0);
	_headshotBackgroundNode.geometry.firstMaterial.reflective.contentsTransform =  CATransform3DMakeScale(1.0, 1.0, 1.0);
	[SCNTransaction begin];
	[SCNTransaction setAnimationDuration:3.0];
	[SCNTransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
	[SCNTransaction setCompletionBlock:^{
		NSLog(@"Finished environment loop, resetting.");
		if (_animateEnvironment) {
			[self performSelector:@selector(startEnvironmentLoop)];
		}
	}];
//	_headshotBackgroundNode.geometry.firstMaterial.reflective.contentsTransform = CATransform3DMakeTranslation(1.0, 0.0, 0.0);
//	_headshotBackgroundNode.geometry.firstMaterial.diffuse.contentsTransform = CATransform3DMakeRotation(0.0, 0.0, 0.0, 1.0);
	_headshotBackgroundNode.geometry.firstMaterial.reflective.contentsTransform =  CATransform3DMakeScale(1.5, 1.5, 1.0);
	[SCNTransaction commit];
}

/* ========================================================================== */
- (void)stopEnvironmentLoop {
	[_headshotBackgroundNode.geometry.firstMaterial removeAllAnimations];
}

/* ========================================================================== */
- (void)fadeOutReflectionAfterDelay:(NSTimeInterval)delayInSeconds {
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
	NSImage *blackImg = [NSImage imageNamed:@"black_pixel"];
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		[SCNTransaction begin];
		[SCNTransaction setAnimationDuration:1.0];
//		[SCNTransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
		_headshotBackgroundNode.geometry.firstMaterial.reflective.contents = blackImg;
		[SCNTransaction commit];
	});
}

/* ========================================================================== */
- (void) drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
//	NSLog(@"***");
//
//	CGContextSetFillColorWithColor(ctx, [[NSColor clearColor] CGColor]);
//
//	//	NSGraphicsPushContext(ctx);
//	/*[word drawInRect:layer.bounds
//	 withFont:[UIFont systemFontOfSize:32]
//     lineBreakMode:UILineBreakModeWordWrap
//	 alignment:UITextAlignmentCenter];*/
//
//	CGContextSetFont(ctx, CGFontCreateWithFontName((CFStringRef)@"DIN-Bold"));
//	CGContextSetFontSize(ctx, 24.0);
//	[@"VERNON\nDAVIS" drawAtPoint:CGPointZero withAttributes:nil];
//
//	//	[@"VERNON\nDAVIS" drawAtPoint:CGPointMake(30.0f, 30.0f)
//	//			 forWidth:200.0f
//	//			 withFont:[NSFont fontWithName:@"DIN-Bold" size:72.0]
//	//		lineBreakMode:NSLineBreakByWordWrapping];
//
//	//	UIGraphicsPopContext();
}

@end
