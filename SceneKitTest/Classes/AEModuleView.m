//
//  AEModuleView.m
//  DataCaster
//
//  Created by Ben Stahl on 2/27/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import "AEModuleView.h"

@implementation AEModuleView

/* ========================================================================== */
- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		[self setWantsLayer:YES];
    }
    return self;
}

/* ========================================================================== */
- (void)drawRect:(NSRect)dirtyRect {
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

/* =============================================================================
 Adjust the module view frame to maintain the current output  aspect ratio,
 and fill to whichever edge is closest to the superview.
 ============================================================================ */
- (void)adjustFrame {
	if (!self.superview) { return; }

	self.superview.layer.contentsGravity = kCAGravityResizeAspectFill;
	self.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
	self.autoresizesSubviews = YES;

	CGRect superviewBounds = [[self superview] bounds];
	//	NSLog(@"Content view bounds = %f, %f", superviewBounds.size.width, superviewBounds.size.height);

	// Add a fraction of a pixel so the aspect won't flip between letterbox and pillarbox while live resizing.
	CGFloat superviewAspect = (superviewBounds.size.width) / (superviewBounds.size.height + 0.999);

	if (superviewAspect < kOutputAspectRatio) {
		// letterbox
		//		NSLog(@"aspect = %f, letterboxing", superviewAspect);
		CGSize newSize = CGSizeMake(superviewBounds.size.width, superviewBounds.size.width / kOutputAspectRatio);
		CGFloat leftoverHeight = superviewBounds.size.height - newSize.height;
		[self setFrame:CGRectMake(superviewBounds.origin.x, superviewBounds.origin.y + leftoverHeight / 2, newSize.width, newSize.height)];
		//		NSLog(@"New size = %f, %f", self.frame.size.width, self.frame.size.height);
	} else {
		// pillarbox
		//		NSLog(@"aspect = %f, pillarboxing", superviewAspect);
		CGSize newSize = CGSizeMake(superviewBounds.size.height * kOutputAspectRatio, superviewBounds.size.height);
		CGFloat leftoverWidth = superviewBounds.size.width - newSize.width;
		//		NSLog(@"Bounds width = %f | new width = %f | leftover width = %f", superviewBounds.size.width, newSize.width, leftoverWidth);
		[self setFrame:CGRectMake(superviewBounds.origin.x + leftoverWidth / 2, superviewBounds.origin.y, newSize.width, newSize.height)];
		//		NSLog(@"New size = %f, %f", self.frame.size.width, self.frame.size.height);
	}
}

/* ========================================================================== */
- (void)viewWillDraw {
	[self adjustFrame];
}

/* ========================================================================== */
- (void)viewDidEndLiveResize {
	//	NSLog(@"Module Select View viewDidEndLiveResize:");
	//	self.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;

//	[self adjustFrame];
}

/* ========================================================================== */
- (void)viewDidMoveToSuperview {
	//	NSLog(@"Module Select View viewDidMoveToSuperview:");

	[self adjustFrame];

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
