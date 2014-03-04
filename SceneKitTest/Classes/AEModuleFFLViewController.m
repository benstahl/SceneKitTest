//
//  AEModuleFFLViewController.m
//  SceneKitTest
//
//  Created by Ben Stahl on 2/24/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import "AEModuleFFLViewController.h"
#import "AEModuleFFLView.h"
#import "AEFFLSceneView.h"
#import "AEHeaderView.h"

@interface AEModuleFFLViewController ()

@end

@implementation AEModuleFFLViewController

/* ========================================================================== */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	NSLog(@"FFL View Controller initWithNibName:%@ bundle:", nibNameOrNil);

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

/* ========================================================================== */
- (void)awakeFromNib {
	NSLog(@"FFL Module View Controller awakeFromNib:");
//	_headerView = [[AEHeaderView alloc] init];
//	[self.view addSubview:_headerView];
//	_headerView.frame = self.view.frame;
	[((AEModuleFFLView*)self.view) adjustHeaderLabels];
//	[_headerView adjustHeaderLabels];
}

#pragma mark - controls

/* ========================================================================== */
- (IBAction)showCardsButtonClicked:(id)sender {
	NSLog(@"Button clicked (view controller).");
	[_sceneView showCardsButtonClicked:sender];
}

/* ========================================================================== */
- (IBAction)exitButtonClicked:(id)sender {
	NSLog(@"Exit button clicked (view controller).");

//	[self launchModuleNamed:@"AEModuleSelect"];

	[[NSApp delegate] performSelector:@selector(launchModuleNamed:) withObject:@"AEModuleSelect"];
}

@end
