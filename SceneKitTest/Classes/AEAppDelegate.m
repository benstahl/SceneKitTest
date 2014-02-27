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
	self.window.backgroundColor = [NSColor magentaColor];

}

/* ========================================================================== */
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application
	NSLog(@"Application did finish launching.");
	[self launchModuleNamed:@"AEModuleSelect"];
}

/* ========================================================================== */
- (IBAction)launchModuleNamed:(NSString*)moduleName {
	NSLog(@"Launching module named %@", moduleName);
	
	NSViewController *moduleVC = [[NSViewController alloc] initWithNibName:moduleName bundle:[NSBundle mainBundle]];

	NSView *mainView = [[self window] contentView];

	for (NSView *subview in mainView.subviews) {
		[subview removeFromSuperview];
	}

	// fade out
	[mainView animator].alphaValue = 0.0;

	// make the sub view the same size as our super view
//	[moduleVC.view setFrame:[mainView bounds]];
	// *push* our new sub view
	[mainView addSubview:moduleVC.view];
	//	[self window].contentView = moduleVC.view;

//	self.contentViewController.view = moduleVC.view;
	self.contentViewController = moduleVC;

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
