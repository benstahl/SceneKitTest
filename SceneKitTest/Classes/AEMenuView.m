//
//  AEMenuView.m
//  SceneKitTest
//
//  Created by Ben Stahl on 2/22/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import "AEMenuView.h"

@implementation AEMenuView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		[self setWantsLayer:YES];
		self.layer.backgroundColor = [[NSColor colorWithCalibratedHue:0.0 saturation:0.0 brightness:1.0 alpha:0.1] CGColor];
		self.layer.contentsGravity = kCAGravityCenter;
		self.layer.cornerRadius = 12.0;
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

@end
