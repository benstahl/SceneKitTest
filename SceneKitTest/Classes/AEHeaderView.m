//
//  AEHeaderView.m
//  SceneKitTest
//
//  Created by Ben Stahl on 2/24/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import "AEHeaderView.h"
#import <QuartzCore/QuartzCore.h>

@implementation AEHeaderView

/* ========================================================================== */
- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		[self setWantsLayer:YES];
//		self.layer.backgroundColor = [[NSColor colorWithHue:0.0 saturation:0.0 brightness:1.0 alpha:0.1] CGColor];
		self.layer.contentsGravity = kCAGravityCenter;
//		self.layer.cornerRadius = 12.0;
    }
    return self;
}

/* ========================================================================== */
- (void)awakeFromNib {
	_topLabel.stringValue = @"";
	_bottomLabel.stringValue = @"";
	self.layer.opacity = 0.0;
}

/* ========================================================================== */
- (void)fadeIn {
	CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"opacity"];
	//	[scale setFromValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.85, 0.85, 1.0)]];
	[fade setFromValue:@(self.layer.opacity)];
	[fade setToValue:@1.0];
	[fade setDuration:kHeaderFadeInTime];
	//	[fade setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
	[fade setRemovedOnCompletion:NO];
	[fade setFillMode:kCAFillModeForwards];
	[self.layer addAnimation:fade forKey:@"fadeIn"];
}

/* ========================================================================== */
- (void)fadeOut {
	CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"opacity"];
	//	[scale setFromValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.85, 0.85, 1.0)]];
	[fade setFromValue:@(self.layer.opacity)];
	[fade setToValue:@0.0];
	[fade setDuration:kHeaderFadeOutTime];
//	[fade setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
	[fade setRemovedOnCompletion:NO];
	[fade setFillMode:kCAFillModeForwards];
	[self.layer addAnimation:fade forKey:@"fadeOut"];
}

/* ========================================================================== */

- (void)drawRect:(NSRect)dirtyRect {
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

@end
