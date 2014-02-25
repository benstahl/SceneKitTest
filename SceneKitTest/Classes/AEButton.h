//
//  AEButton.h
//  SceneKitTest
//
//  Created by Ben Stahl on 2/22/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>

@interface AEButton : NSControl <NSWindowDelegate>

//@property (strong) IBOutlet id target;
@property (copy) NSString *actionSelectorString;
@property (copy) NSString *buttonLabelText;

@property (strong) CALayer *baseLayer;
@property (strong) CATextLayer *labelLayer;

@end
