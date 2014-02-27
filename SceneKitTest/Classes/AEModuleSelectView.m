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
		[self setWantsLayer:YES];
		//		self.layer.backgroundColor = [[NSColor colorWithHue:0.0 saturation:0.0 brightness:1.0 alpha:0.1] CGColor];
//		self.layer.contentsGravity = kCAGravityResizeAspectFill;
		//		self.layer.cornerRadius = 12.0;
//		self.layerContentsPlacement = NSViewLayerContentsPlacementScaleProportionallyToFit;
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

/* ========================================================================== */
- (void)letterbox {
	if (!self.superview) { return; }

	self.superview.layer.contentsGravity = kCAGravityResizeAspectFill;
	self.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
	self.autoresizesSubviews = YES;

	CGRect superviewBounds = [[self superview] bounds];
	NSLog(@"Content view bounds = %f, %f", superviewBounds.size.width, superviewBounds.size.height);
	CGFloat superviewAspect = superviewBounds.size.width / superviewBounds.size.height;

	if (superviewAspect < kOutputAspectRatio) {
		// letterbox
		NSLog(@"aspect = %f, letterboxing", superviewAspect);
		CGSize newSize = CGSizeMake(superviewBounds.size.width, superviewBounds.size.width / kOutputAspectRatio);
		CGFloat leftoverHeight = superviewBounds.size.height - newSize.height;
		[self setFrame:CGRectMake(superviewBounds.origin.x, superviewBounds.origin.y + leftoverHeight / 2, superviewBounds.size.width, superviewBounds.size.width / kOutputAspectRatio)];
		NSLog(@"New size = %f, %f", self.frame.size.width, self.frame.size.height);
	} else {
		// pillarbox
		NSLog(@"aspect = %f, pillarboxing", superviewAspect);
		CGSize newSize = CGSizeMake(superviewBounds.size.width / kOutputAspectRatio, superviewBounds.size.height);
		CGFloat leftoverWidth = superviewBounds.size.width - newSize.width;
		NSLog(@"Bounds width = %f | new width = %f | leftover width = %f", superviewBounds.size.width, newSize.width, leftoverWidth);
		[self setFrame:CGRectMake(superviewBounds.origin.x + leftoverWidth / 2, superviewBounds.origin.y, superviewBounds.size.height / kOutputAspectRatioInverted, superviewBounds.size.height)];
		NSLog(@"New size = %f, %f", self.frame.size.width, self.frame.size.height);
	}
}

/* ========================================================================== */
- (void)viewWillDraw {
	[self letterbox];
}

/* ========================================================================== */
- (void)viewDidEndLiveResize {
//	NSLog(@"Module Select View viewDidEndLiveResize:");
//	self.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
//
	[self letterbox];
}

/* ========================================================================== */
- (void)viewDidMoveToSuperview {
	NSLog(@"Module Select View viewDidMoveToSuperview:");

//	if (!self.superview) { return; }

//	NSLog(@"*** window frame = {%f,%f : %f,%f}", self.window.frame.origin.x, self.window.frame.origin.y, self.window.frame.size.width, self.window.frame.size.height);
//	NSLog(@"*** view frame = {%f,%f : %f,%f}", self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
//	NSLog(@"*** superview frame = {%f,%f : %f,%f}", self.superview.frame.origin.x, self.superview.frame.origin.y, self.superview.frame.size.width, self.superview.frame.size.height);
//	NSLog(@"*** view bounds = {%f,%f : %f,%f}", self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height);

	[self letterbox];

//	NSView *contentView = self;
//	NSView *containerView = self.superview;
//	[contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
////	[containerView addSubview:contentView];
//
//	NSDictionary *viewBindings = NSDictionaryOfVariableBindings(contentView);
//	[containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentView]|" options:0 metrics:nil views:viewBindings]];
//	[containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentView]|" options:0 metrics:nil views:viewBindings]];
}

@end
