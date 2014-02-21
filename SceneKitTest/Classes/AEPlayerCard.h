//
//  AEPlayerCard.h
//  SceneKitTest
//
//  Created by Ben Stahl on 2/19/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import <SceneKit/SceneKit.h>

@class AEPlayer;

@interface AEPlayerCard : SCNNode

@property (strong) AEPlayer *player;
@property SCNVector3 cardSize;
@property (strong) SCNNode *headshotBackgroundNode;
@property (strong) SCNNode *headshotNode;
@property (strong) SCNNode *baseNode;
@property (strong) SCNNode *primaryColorStripeNode;
@property (strong) SCNNode *secondaryColorStripeNode;
@property (strong) SCNNode *teamLogoNode;
@property (strong) CATextLayer *firstNameLayer;
@property (strong) CATextLayer *lastNameLayer;
@property (strong) CATextLayer *rankLayer;
@property (strong) SCNNode *nameNode;

- (id)init;
- (void)configureWithPlayer:(AEPlayer*)player;

@end
