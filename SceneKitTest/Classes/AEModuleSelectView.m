//
//  AEMainMenuView.m
//  SceneKitTest
//
//  Created by Ben Stahl on 2/24/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import "AEModuleSelectView.h"
#import <QuartzCore/QuartzCore.h>

@implementation AEModuleSelectView

/* ========================================================================== */
- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		NSLog(@"Module Select View initWithFrame:");
    }
    return self;
}

/* ========================================================================== */
- (void)awakeFromNib {
	NSLog(@"Module Select View awakeFromNib:");
//	self.translatesAutoresizingMaskIntoConstraints = YES;
	self.layer.contentsGravity = kCAGravityResizeAspectFill;
//	self.layer.contentsGravity = kCAGravityCenter;
	self.layer.backgroundColor = [[NSColor darkGrayColor] CGColor]; // [[NSColor colorWithHue:0.825 saturation:1.0 brightness:1.0 alpha:1.0] CGColor];
//	self.layer.borderWidth = 0.5;
//	self.layer.borderColor = [[NSColor colorWithHue:0.0 saturation:0.0 brightness:1.0 alpha:1.0] CGColor];
}

/* ========================================================================== */
- (void)drawRect:(NSRect)dirtyRect {
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

@end
