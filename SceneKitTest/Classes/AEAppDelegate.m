//
//  AEAppDelegate.m
//  SceneKitTest
//
//  Created by Ben Stahl on 2/11/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import "AEAppDelegate.h"

@implementation AEAppDelegate

/* ========================================================================== */
- (void)awakeFromNib {
	NSLog(@"App delegate awakeFromNib:");
//	_window.backgroundColor = [NSColor magentaColor];
//	[((NSView*)_window.contentView) setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
//	[self.window.contentView setFrame:viewBounds];
//	- (void)windowControllerDidLoadNib:(NSWindowController *)aController
//	{
//		[super windowControllerDidLoadNib:aController];
	[_window setBackgroundColor:[NSColor blackColor]];
//	[_window setAspectRatio:NSMakeSize(kOutputAspectH, kOutputAspectV)];
	[_window setContentAspectRatio:NSMakeSize(kOutputPixelsH, kOutputPixelsV)];
	// Set window size to exactly 1/2 output resolution.
	[_window setContentSize:NSMakeSize(kOutputPixelsH * 0.5, kOutputPixelsV * 0.5)];
}

/* ========================================================================== */
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application
	NSLog(@"Application did finish launching.");
	[self launchModuleNamed:@"AEModuleSelect"];
}

/* ========================================================================== */
-(NSSize)window:(NSWindow *)window willUseFullScreenContentSize:(NSSize)proposedSize {
//	NSLog(@"Proposed window size = %f, %f", proposedSize.width, proposedSize.height);
	/* --------------------------------------------------------------------------
	 We don't actually do anything here, but for some reason, returning the passed
	 in argument makes sure the window's content view will be full screen. Without
	 overriding this method, the content view gets sized down.
	 ------------------------------------------------------------------------- */
	return proposedSize;
}

/* ========================================================================== */
- (IBAction)launchModuleNamed:(NSString*)moduleName {
	NSLog(@"Launching module named %@", moduleName);
	
	NSViewController *moduleVC = [[NSViewController alloc] initWithNibName:moduleName bundle:[NSBundle mainBundle]];

	NSView *mainView = [[self window] contentView];
//	[mainView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];

	NSView *topView = nil;

	if ([mainView subviews].count > 0) {
		topView = [mainView subviews][0];
	}

	CGRect viewBounds = [mainView bounds];

//	for (NSView *subview in mainView.subviews) {
//		[subview removeFromSuperview];
//	}
//
//	[mainView addSubview:moduleVC.view atI];
//	[mainView addSubview:moduleVC.view];

	[moduleVC.view setFrame:viewBounds];

	[NSAnimationContext currentContext].duration = 0.4;
	[NSAnimationContext currentContext].timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	[NSAnimationContext currentContext].completionHandler = ^(){
		NSLog(@"Transition complete.");
		self.contentViewController = moduleVC;
		mainView.layer.contentsGravity = kCAGravityResizeAspectFill;
	};
	[NSAnimationContext beginGrouping];
	[mainView animator].alphaValue = 0.0;
	if (topView) {
		[[mainView animator] replaceSubview:topView with:moduleVC.view];
	} else {
		[[mainView animator] addSubview:moduleVC.view];
	}
	[mainView animator].alphaValue = 1.0;
	[NSAnimationContext endGrouping];


	// fade out
//	[mainView animator].alphaValue = 0.0;

//	self.contentViewController = moduleVC;

//	CGSize newSize = CGSizeMake(viewBounds.size.width, viewBounds.size.width * 0.5625);
//	[moduleVC.view setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable | NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin | NSViewMaxYMargin];
//	[moduleVC.view setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];

//	[moduleVC.view setFrame:viewBounds];
//	[moduleVC.view setFrame:NSMakeRect(0.0, 0.0, newSize.width, newSize.height)];
//	[moduleVC.view setFrameOrigin:NSMakePoint(-newSize.width / 2, -newSize.height / 2)];

//	mainView.layer.contentsGravity = kCAGravityResizeAspectFill;
//	[mainView addSubview:moduleVC.view];

//	// make the sub view the same size as our super view
//	CGRect viewBounds = [mainView bounds];
//	//	[moduleVC.view setFrame:[mainView bounds]];
//	//	NSLog(@"New view size = %f,%f", viewBounds.size.width, viewBounds.size.width * 0.5625);
//	CGSize newSize = CGSizeMake(viewBounds.size.width, viewBounds.size.width * 0.5625);
//	[moduleVC.view setFrame:CGRectMake(viewBounds.origin.x, viewBounds.origin.y, newSize.width, newSize.height)];
	// *push* our new sub view

	//	[self window].contentView = moduleVC.view;

//	self.contentViewController.view = moduleVC.view;

	//	[self prepareViews];

	// fade in
	[mainView animator].alphaValue = 1.0;

	//	if (!moduleVC) {
	//		NSLog(@"moduleVC is nil.");
	//	} else {
	//		NSLog(@"moduleVC is not nil.");
	//	}
	//	if (!self.window) {
	//		[NSBundle loadNibNamed:selectedModule.moduleXibName owner:self];
	//	}
	//
	//	[self.window makeKeyAndOrderFront:self];
}

/* ========================================================================== */
- (void)prepareViews { // this method will make sure we can animate in the switchSubViewsMethod
	CATransition *transition = [CATransition animation];
	transition.type = kCATransitionPush;
	transition.subtype = kCATransitionFromLeft;
	NSView *mainView = [[self window] contentView];
	[mainView setAnimations:[NSDictionary dictionaryWithObject:transition forKey:@"subviews"]];
	[mainView setWantsLayer:YES];
}


#pragma mark - controls

/* ========================================================================== */
- (IBAction)exitButtonClicked:(id)sender {
	NSLog(@"Exit button clicked (view controller).");

	NSViewController *mainMenuVC = [[NSViewController alloc] initWithNibName:@"MainMenu" bundle:[NSBundle mainBundle]];

	NSView *mainView = [[self window] contentView];

	for (NSView *subview in mainView.subviews) {
		[subview removeFromSuperview];
	}

	// fade out
	[mainView animator].alphaValue = 0.0;

	// make the sub view the same size as our super view
	[mainMenuVC.view setFrame:[mainView bounds]];

	// *push* our new sub view
	[mainView addSubview:mainMenuVC.view];
	//	[self window].contentView = moduleVC.view;

	self.contentViewController = mainMenuVC;

	//	[self prepareViews];

	// fade in
	[mainView animator].alphaValue = 1.0;

}

@end
