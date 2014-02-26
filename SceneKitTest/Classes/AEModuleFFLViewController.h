//
//  AEModuleFFLViewController.h
//  SceneKitTest
//
//  Created by Ben Stahl on 2/24/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class AEFFLSceneView;
@class AEHeaderView;

@interface AEModuleFFLViewController : NSViewController

@property (assign) IBOutlet NSView *menuView;
@property (assign) IBOutlet AEFFLSceneView *sceneView;
@property (strong) IBOutlet AEHeaderView *headerView;

- (IBAction)showCardsButtonClicked:(id)sender;

@end
