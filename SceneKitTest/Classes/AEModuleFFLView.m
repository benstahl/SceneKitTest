//
//  AEModuleFFLView.m
//  DataCaster
//
//  Created by Ben Stahl on 2/27/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import "AEModuleFFLView.h"
#import <QuartzCore/QuartzCore.h>

@implementation AEModuleFFLView

/* ========================================================================== */
- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

/* ========================================================================== */
- (void)awakeFromNib {
	NSLog(@"Module FFL View awakeFromNib:");
//	self.translatesAutoresizingMaskIntoConstraints = YES;
	self.layer.contentsGravity = kCAGravityCenter;
	self.layer.backgroundColor = [[NSColor colorWithHue:0.0 saturation:1.0 brightness:0.0 alpha:1.0] CGColor];
	self.layer.borderWidth = 0.5;
	self.layer.borderColor = [[NSColor colorWithHue:0.0 saturation:0.0 brightness:1.0 alpha:1.0] CGColor];
}

/* ========================================================================== */
- (void)drawRect:(NSRect)dirtyRect {
	[super drawRect:dirtyRect];

	// Drawing code here.
}

@end
