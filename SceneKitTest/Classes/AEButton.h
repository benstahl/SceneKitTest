//
//  AEButton.h
//  SceneKitTest
//
//  Created by Ben Stahl on 2/22/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>

@interface AEButton : NSControl

@property (strong) CALayer *baseLayer;
@property (strong) CATextLayer *labelLayer;

@end
