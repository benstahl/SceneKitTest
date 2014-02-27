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
		NSLog(@"Module FFL View initWithFrame:");
		[self setWantsLayer:YES];
    }
    return self;
}

/* ========================================================================== */
- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

/* ========================================================================== */
- (void)awakeFromNib {
	NSLog(@"Module FFL View awakeFromNib:");
//	self.translatesAutoresizingMaskIntoConstraints = YES;
	self.layer.contentsGravity = kCAGravityCenter;
	self.layer.backgroundColor = [[NSColor colorWithHue:0.0 saturation:0.0 brightness:0.0 alpha:1.0] CGColor];
	self.layer.borderWidth = 0.5;
	self.layer.borderColor = [[NSColor colorWithHue:0.0 saturation:0.0 brightness:1.0 alpha:1.0] CGColor];
}

/* ========================================================================== */
- (void)letterbox {
	if (!self.superview) { return; }

	self.superview.layer.contentsGravity = kCAGravityResizeAspectFill;
	self.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
	self.autoresizesSubviews = YES;

	CGRect superviewBounds = [[self superview] bounds];
	CGSize newSize = CGSizeMake(superviewBounds.size.width, superviewBounds.size.width * 0.5625);
	CGFloat leftoverHeight = superviewBounds.size.height - newSize.height;

	[self setFrame:CGRectMake(superviewBounds.origin.x, superviewBounds.origin.y + leftoverHeight / 2, superviewBounds.size.width, superviewBounds.size.width * 0.5625)];
}

/* ========================================================================== */
//- (void)viewWillDraw {
//	[self letterbox];
//}

/* ========================================================================== */
- (void)viewDidEndLiveResize {
	//	NSLog(@"Module Select View viewDidEndLiveResize:");
	//	self.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
	//
	[self letterbox];
}

/* ========================================================================== */
- (void)viewDidMoveToSuperview {
//	NSLog(@"Module FFL View viewDidMoveToSuperview:");

	[self letterbox];

//	//	CGRect viewBounds = [[self superview] bounds];
//	//	[self setFrame:viewBounds];
//	//	self.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
//	////	NSLog(@"New view size = %f,%f", viewBounds.size.width, viewBounds.size.width * 0.5625);
//	//	[self setFrame:CGRectMake(viewBounds.origin.x, viewBounds.origin.y, viewBounds.size.width, viewBounds.size.width * 0.5625)];
//
//	if (!self.superview) { return; }
//
//	NSView *contentView = self;
//	NSView *containerView = self.superview;
//	[contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
//	//	[containerView addSubview:contentView];
//
//	NSDictionary *viewBindings = NSDictionaryOfVariableBindings(contentView);
//	[containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentView]|" options:0 metrics:nil views:viewBindings]];
//	[containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentView]|" options:0 metrics:nil views:viewBindings]];
}

@end
