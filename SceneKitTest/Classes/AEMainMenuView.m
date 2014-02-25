//
//  AEMainMenuView.m
//  SceneKitTest
//
//  Created by Ben Stahl on 2/24/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import "AEMainMenuView.h"
#import <QuartzCore/QuartzCore.h>

@implementation AEMainMenuView

/* ========================================================================== */
- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		[self setWantsLayer:YES];
		//		self.layer.backgroundColor = [[NSColor colorWithHue:0.0 saturation:0.0 brightness:1.0 alpha:0.1] CGColor];
		self.layer.contentsGravity = kCAGravityCenter;
		//		self.layer.cornerRadius = 12.0;
		self.layer.backgroundColor = [[NSColor darkGrayColor] CGColor];
		self.layer.borderWidth = 0.5;
		self.layer.borderColor = [[NSColor colorWithHue:0.0 saturation:1.0 brightness:0.25 alpha:1.0] CGColor];
    }
    return self;
}

/* ========================================================================== */
- (void)awakeFromNib {
}

/* ========================================================================== */
- (void)drawRect:(NSRect)dirtyRect {
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

@end
