//
//  AEModuleSelectViewController.m
//  DataCaster
//
//  Created by Ben Stahl on 2/26/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import "AEModuleSelectViewController.h"
#import "AEModule.h"

@interface AEModuleSelectViewController ()

@end

@implementation AEModuleSelectViewController

@synthesize modules = _modules;

/* ========================================================================== */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	NSLog(@"Module Select View Controller initWithNibName:%@ bundle:", nibNameOrNil);

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

//@synthesize modules = _modules;

/* ========================================================================== */
- (void)awakeFromNib {
	NSLog(@"Module Select View Controller awakeFromNib:");

	AEModule *testPatternsModule = [[AEModule alloc] init];
	testPatternsModule.moduleDisplayedName = @"Test patterns";
	testPatternsModule.moduleXibName = @"AEModuleTestPatterns";
	NSString *testPatternsModulePreviewImageFilePath = [[[NSBundle mainBundle] URLForResource:@"Images/module_preview_test_patterns" withExtension:@"png"] path];
	NSImage *testPatternsModulePreviewImage = [[NSImage alloc] initWithContentsOfFile:testPatternsModulePreviewImageFilePath];
	testPatternsModule.modulePreviewImage = testPatternsModulePreviewImage;

	AEModule *fflModule = [[AEModule alloc] init];
	fflModule.moduleDisplayedName = @"Fantasy Football Live";
	fflModule.moduleXibName = @"AEModuleFFL";
	NSString *fflModulePreviewImageFilePath = [[[NSBundle mainBundle] URLForResource:@"Images/module_preview_ffl" withExtension:@"png"] path];
	NSImage *fflModulePreviewImage = [[NSImage alloc] initWithContentsOfFile:fflModulePreviewImageFilePath];
	fflModule.modulePreviewImage = fflModulePreviewImage;

//	_modulesArrayController.selectsInsertedObjects = NO;
	[self setModules:[NSMutableArray arrayWithObjects:testPatternsModule, fflModule, nil]];
	_modulesArrayController.selectionIndex = 0;
	NSLog(@"Array count = %@", @(self.modules.count));

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
//	NSLog(@"Module Select View Controller awakeFromNib: (exit)");
}

#pragma mark - controls

/* ========================================================================== */
- (IBAction)launchModuleButtonClicked:(id)sender {

//	NSLog(@"Array: %@", _modules);
//	NSLog(@"Array controller: %@", _modulesArrayController);
//	NSLog(@"Launch module button clicked: %@", _modulesArrayController.selectedObjects);
	if (_modulesArrayController.selectedObjects.count == 0) { return; }


	AEModule *selectedModule = _modulesArrayController.selectedObjects[0];

	[[NSApp delegate] performSelector:@selector(launchModuleNamed:) withObject:selectedModule.moduleXibName];
//	[[NSApp delegate] launchModuleNamed:selectedModule.moduleXibName];
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
-(void)setModules:(NSMutableArray*)a {
    _modules = a;
}

/* ========================================================================== */
-(NSMutableArray*)modules {
    return _modules;
}

@end
