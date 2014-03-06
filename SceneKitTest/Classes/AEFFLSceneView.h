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
//@class AEHeaderView;
@class AEModuleFFLViewController;

@interface AEFFLSceneView : SCNView {
	SCNNode *_worldPivotNode;
	SCNNode *_cameraNode;
	SCNNode *_displayedCardsNode;
	SCNNode *_sponsorLogoNode;
	
	NSMutableArray *_displayedCards;
	NSDictionary *_cameraPositions;
	NSDictionary *_sponsorLogoPositions;
	NSDictionary *_cardPositions;
//	AEPlayerCard *_playerCard;
	BOOL _cardsAnimating;

	NSMutableArray *_playerPickSets;
	AEPlayerPickSet *_currentPickSet;

	BOOL _trackingMouseDrag;
	NSPoint _lastDragPoint;
	CFTimeInterval _lastDragTime;
}

@property (weak) IBOutlet AEModuleFFLViewController *vc;

- (IBAction)showCardsButtonClicked:(id)sender;

@end
