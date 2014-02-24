//
//  AEAppDelegate.h
//  SceneKitTest
//
//  Created by Ben Stahl on 2/11/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <SceneKit/SceneKit.h>

@class AESceneView;

@interface AEAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSView *menuView;
@property (assign) IBOutlet AESceneView *sceneView;

- (IBAction)newSetButtonClicked:(id)sender;

@end
