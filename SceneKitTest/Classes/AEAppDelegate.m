//
//  AEAppDelegate.m
//  SceneKitTest
//
//  Created by Ben Stahl on 2/11/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import "AEAppDelegate.h"
#import "AEFFLSceneView.h"
#import "AEModule.h"

@implementation AEAppDelegate

@synthesize modules = _modules;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application
}

- (void)awakeFromNib {
	self.window.backgroundColor = [NSColor blackColor];

	AEModule *fflModule = [[AEModule alloc] init];
	fflModule.moduleDisplayedName = @"Fantasy Football Live";
	fflModule.moduleXibName = @"AEModuleFFL";
	NSString *modulePreviewImageFilePath = [[[NSBundle mainBundle] URLForResource:@"Images/module_preview_ffl" withExtension:@"png"] path];
	NSImage *modulePreviewImage = [[NSImage alloc] initWithContentsOfFile:modulePreviewImageFilePath];
	fflModule.modulePreviewImage = modulePreviewImage;

//	fflModule.modulePreviewImage = @"logo_ffl";

	[self setModules:[NSMutableArray arrayWithObjects:fflModule, nil]];

//	_infoView.layer = [CALayer layer];
//    _infoView.wantsLayer = YES;
//
//	CATextLayer *infoLayer = [CATextLayer layer];
//	infoLayer.font = CGFontCreateWithFontName((CFStringRef)@"DIN-Regular");
//	infoLayer.fontSize = 48.0;
//	infoLayer.backgroundColor = [[NSColor blueColor] CGColor];
//	infoLayer.string = [NSString stringWithFormat:@"%@ players\n%@ teams", @(1), @(1)];
//	[_infoView.layer addSublayer:infoLayer];
//	self.window.contentAspectRatio = NSMakeSize(16, 9);
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

#pragma mark - KVO

/* ========================================================================== */
-(void)insertObject:(AEModule*)module inModulesAtIndex:(NSUInteger)index {
    [_modules insertObject:module atIndex:index];
}

/* ========================================================================== */
-(void)removeObjectFromModulesAtIndex:(NSUInteger)index {
    [_modules removeObjectAtIndex:index];
}

/* ========================================================================== */
-(void)setModules:(NSMutableArray *)a {
    _modules = a;
}

/* ========================================================================== */
-(NSArray*)modules {
    return _modules;
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

/* ========================================================================== */
- (IBAction)launchSelectedModule:(id)sender {
	NSLog(@"%@", _modulesArrayController.selectedObjects);
	if (_modulesArrayController.selectedObjects.count == 0) { return; }

	NSLog(@"XXXXXXXXXX");
	AEModule *selectedModule = _modulesArrayController.selectedObjects[0];
	NSLog(@"Selected .xib name = %@", selectedModule.moduleXibName);
	NSViewController *moduleVC = [[NSViewController alloc] initWithNibName:selectedModule.moduleXibName bundle:[NSBundle mainBundle]];

	NSView *mainView = [[self window] contentView];

	for (NSView *subview in mainView.subviews) {
		[subview removeFromSuperview];
	}

	// fade out
	[mainView animator].alphaValue = 0.0;

	// make the sub view the same size as our super view
	[moduleVC.view setFrame:[mainView bounds]];
	// *push* our new sub view
	[mainView addSubview:moduleVC.view];
	//	[self window].contentView = moduleVC.view;

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

@end
