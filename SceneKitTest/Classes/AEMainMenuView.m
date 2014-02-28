//
//  AEMainMenuView.m
//  DataCaster
//
//  Created by Ben Stahl on 2/27/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import "AEMainMenuView.h"

@implementation AEMainMenuView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

/* ========================================================================== */
- (void)awakeFromNib {
	NSLog(@"Main Menu View awakeFromNib:");
	//	self.translatesAutoresizingMaskIntoConstraints = YES;
	self.layer.contentsGravity = kCAGravityCenter;
//	self.layer.backgroundColor = [[NSColor colorWithHue:0.52 saturation:1.0 brightness:0.50 alpha:1.0] CGColor];
	self.layer.backgroundColor = [[NSColor blackColor] CGColor];
//	self.layer.borderWidth = 0.5;
//	self.layer.borderColor = [[NSColor colorWithHue:0.0 saturation:0.0 brightness:1.0 alpha:1.0] CGColor];

	self.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
}

///* ========================================================================== */
//- (void)viewDidEndLiveResize {
//	NSLog(@"Module Select View viewDidEndLiveResize:");
////	self.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
//
////	NSLog(@"*** window frame = {%f,%f : %f,%f}", self.window.frame.origin.x, self.window.frame.origin.y, self.window.frame.size.width, self.window.frame.size.height);
////	NSLog(@"*** view frame = {%f,%f : %f,%f}", self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
////	NSLog(@"*** view bounds = {%f,%f : %f,%f}", self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height);
//}
//
///* ========================================================================== */
//- (void)viewDidMoveToWindow {
//	NSLog(@"Main Menu View viewDidMoveToWindow:");
//	//	CGRect viewBounds = [[self superview] bounds];
//	//	[self setFrame:viewBounds];
//	//	self.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
//	////	NSLog(@"New view size = %f,%f", viewBounds.size.width, viewBounds.size.width * 0.5625);
//	//	[self setFrame:CGRectMake(viewBounds.origin.x, viewBounds.origin.y, viewBounds.size.width, viewBounds.size.width * 0.5625)];
//
//	if (!self.superview) { return; }
//
////	NSLog(@"*** window frame = {%f,%f : %f,%f}", self.window.frame.origin.x, self.window.frame.origin.y, self.window.frame.size.width, self.window.frame.size.height);
////	NSLog(@"*** view frame = {%f,%f : %f,%f}", self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
////	NSLog(@"*** view bounds = {%f,%f : %f,%f}", self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height);
////	NSLog(@"*** content view frame = %@", NSStringFromCGRect(self.frame));
////	NSLog(@"*** content view bounds = %@", NSStringFromCGRect(self.bounds));
//
////	NSView *contentView = self;
////	NSView *containerView = self.superview;
////	[contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
////	//	[containerView addSubview:contentView];
////
////	NSDictionary *viewBindings = NSDictionaryOfVariableBindings(contentView);
////	[containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentView]|" options:0 metrics:nil views:viewBindings]];
////	[containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentView]|" options:0 metrics:nil views:viewBindings]];
//}

@end
