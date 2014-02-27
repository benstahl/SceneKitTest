//
//  AEModuleFFLViewController.m
//  SceneKitTest
//
//  Created by Ben Stahl on 2/24/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import "AEModuleFFLViewController.h"
#import "AEFFLSceneView.h"

@interface AEModuleFFLViewController ()

@end

@implementation AEModuleFFLViewController

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
}

#pragma mark - controls

/* ========================================================================== */
- (IBAction)showCardsButtonClicked:(id)sender {
	NSLog(@"Button clicked (view controller).");
	[_sceneView showCardsButtonClicked:sender];
}

@end
