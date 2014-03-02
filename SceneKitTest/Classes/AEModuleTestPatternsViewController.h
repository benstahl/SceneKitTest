//
//  AEModuleTestPatternsViewController.h
//  DataCaster
//
//  Created by Ben Stahl on 2/27/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class AEModuleTestPatternsView;
@class AEPatternSelectPane;
@class AEPatternImagePane;

@interface AEModuleTestPatternsViewController : NSViewController

@property (strong) NSMutableArray *testPatterns;
@property (assign) IBOutlet NSArrayController *testPatternsArrayController;

@property (weak) IBOutlet AEModuleTestPatternsView *testPatternsView;

@property BOOL selectDrawerOpen;

// These MUST be strong references or these outlets will be nil!
@property (strong) IBOutlet AEPatternSelectPane *patternSelectPane;
@property (strong) IBOutlet AEPatternImagePane *patternImagePane;

//@property (strong) NSMutableArray *images;
//@property NSUInteger imageIndex;

//- (IBAction)nextPicture:(id)sender;
//- (IBAction)previousPicture:(id)sender;

- (void)resizeLayerFrames;

- (IBAction)exitButtonClicked:(id)sender;
- (IBAction)toggleSelectDrawer:(id)sender;

@end
