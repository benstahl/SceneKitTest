//
//  AEModuleTestPatternsViewController.m
//  imagesCaster
//
//  Created by Ben Stahl on 2/27/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import "AEModuleTestPatternsViewController.h"
#import "AEModuleTestPatternsView.h"
#import "AEPatternImagePane.h"
#import "AEPatternSelectPane.h"
#import "AETestPattern.h"

@implementation AEModuleTestPatternsViewController

@synthesize testPatterns = _testPatterns;

/* ========================================================================== */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

/* ========================================================================== */
- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		_selectDrawerOpen = NO;

		AETestPattern *colorBars = [[AETestPattern alloc] init];
		NSString *colorBarsImageFilePath = [[[NSBundle mainBundle] URLForResource:@"Images/test_pattern_color_bars" withExtension:@"png"] path];
		colorBars.patternImage = [[NSImage alloc] initWithContentsOfFile:colorBarsImageFilePath];
		colorBars.patternDisplayedName = @"Color bars";

		AETestPattern *grid = [[AETestPattern alloc] init];
		NSString *gridImageFilePath = [[[NSBundle mainBundle] URLForResource:@"Images/test_pattern_grid" withExtension:@"png"] path];
		grid.patternImage = [[NSImage alloc] initWithContentsOfFile:gridImageFilePath];
		grid.patternDisplayedName = @"Grid";

		AETestPattern *indianHead = [[AETestPattern alloc] init];
		NSString *indianHeadImageFilePath = [[[NSBundle mainBundle] URLForResource:@"Images/test_pattern_indian_head" withExtension:@"png"] path];
		indianHead.patternImage = [[NSImage alloc] initWithContentsOfFile:indianHeadImageFilePath];
		indianHead.patternDisplayedName = @"Indian Head";

		AETestPattern *overscan = [[AETestPattern alloc] init];
		NSString *overscanImageFilePath = [[[NSBundle mainBundle] URLForResource:@"Images/test_pattern_overscan" withExtension:@"png"] path];
		overscan.patternImage = [[NSImage alloc] initWithContentsOfFile:overscanImageFilePath];
		overscan.patternDisplayedName = @"Overscan";

		AETestPattern *resolution = [[AETestPattern alloc] init];
		NSString *resolutionImageFilePath = [[[NSBundle mainBundle] URLForResource:@"Images/test_pattern_resolution" withExtension:@"png"] path];
		resolution.patternImage = [[NSImage alloc] initWithContentsOfFile:resolutionImageFilePath];
		resolution.patternDisplayedName = @"Resolution";

		[self setTestPatterns:[NSMutableArray arrayWithObjects:colorBars, grid, indianHead, overscan, resolution, nil]];

		NSLog(@"%@ test patterns found.", @([self testPatterns].count));

	//		self.images = [[NSMutableArray alloc] initWithCapacity:1];
//
//		NSArray *imageURLs = [[NSBundle mainBundle] URLsForResourcesWithExtension:@"png" subdirectory:@"Images"];
		//	NSLog(@"IMAGE URLS = %@", imageURLs);

		//	NSURL *dirURL = [[NSBundle mainBundle] URLForResource:@"Resources/Images" withExtension:nil];
		//
		//    NSDirectoryEnumerator *itr = [[NSFileManager defaultManager] enumeratorAtURL:dirURL includingPropertiesForKeys:[NSArray arrayWithObjects:NSURLLocalizedNameKey, NSURLEffectiveIconKey, NSURLIsDirectoryKey, NSURLTypeIdentifierKey, nil] options:NSDirectoryEnumerationSkipsHiddenFiles | NSDirectoryEnumerationSkipsPackageDescendants | NSDirectoryEnumerationSkipsSubdirectoryDescendants errorHandler:nil];

//		for (NSURL *url in imageURLs) {
//			if (![[url lastPathComponent] hasPrefix:@"test_pattern"]) { continue; }
//
//			NSLog(@"test pattern found: %@", [url lastPathComponent]);
//			NSString *utiValue;
//			[url getResourceValue:&utiValue forKey:NSURLTypeIdentifierKey error:nil];
//
//			if (UTTypeConformsTo((__bridge CFStringRef)(utiValue), kUTTypeImage)) {
//				NSImage *image = [[NSImage alloc] initWithContentsOfURL:url];
//				[self.images addObject:image];
//			}
//		}
//
//		_imageIndex = 0;
	}
	return self;
}

/* ========================================================================== */
- (void)awakeFromNib {
	//	NSLog(@"Images array = %@", _controller.images);
	//	_patternImagePane = _patternImagePane.picLayer;

	//	[_splitView setPosition:200.0 ofDividerAtIndex:0];


	// Since the pattern image pane object may not yet have had awakeFromNib: called yet, finish setup after a slight delay.
	[self performSelector:@selector(finishSetup) withObject:nil afterDelay:0.025];
}

/* ========================================================================== */
- (void)finishSetup {
	//	if (!_patternImagePane.picLayer) {
	//		NSLog(@"_patternImagePane.picLayer is nil.");
	//	} else {
	//		NSLog(@"_patternImagePane.picLayer is not nil.");
	//	}

	//	_splitView.frame = _testPatternsView.frame;

	//	_testPatternsView.controller = self;
//	[_splitView addSubview:_patternSelectPane];
//	_patternSelectPane.frame = _splitView.frame;
//	[_splitView addSubview:_patternImagePane];
//	_patternImagePane.frame = _splitView.frame;
//	[_splitView adjustSubviews];
//	_splitView.frame = _splitView.superview.frame;

//	if (!_patternImagePane) {
//		NSLog(@"_patternImagePane is nil.");
//	} else {
//		NSLog(@"_patternImagePane is not nil.");
//	}

//	if (_images && _images.count > 0) {
//		_patternImagePane.picLayer.contents = _images[_imageIndex];
//	}

//	_testPatternsView.layer.bounds = NSMakeRect(0.0, 0.0, _testPatternsView.layer.frame.size.width + kTestPatternDrawerPosX, _testPatternsView.layer.frame.size.height);
	_patternSelectPane.layer.frame = NSMakeRect(-kTestPatternDrawerPosX, 0.0, kTestPatternDrawerPosX, _testPatternsView.frame.size.height);
	[_testPatternsView addSubview:_patternSelectPane];
	_patternImagePane.layer.frame = NSMakeRect(0.0, 0.0, _testPatternsView.frame.size.width, _testPatternsView.frame.size.height);
//	_patternImagePane.layer.bounds = NSMakeRect(0.0, 0.0, _testPatternsView.frame.size.width, _testPatternsView.frame.size.height);
	[_testPatternsView addSubview:_patternImagePane];

	[_testPatternsArrayController addObserver:self forKeyPath:@"selectionIndexes" options:0 context:nil];
	[_testPatternsArrayController setSelectionIndex:0];
	_patternImagePane.layer.contents = ((AETestPattern*)_testPatterns[0]).patternImage;

	[self performSelector:@selector(openSelectDrawer:) withObject:self afterDelay:0.125];
//	[self openSelectDrawer:self];
//	[self performSelector:@selector(openSelectDrawer:)];
}

#pragma mark - layer management

/* =============================================================================
 When window is resized, if the resulting image pane would have a size that does
 not exactly match the aspect ration of the original image, it will disappear.
 This is a shortcut to re-assign the image pane contents when resized.
 ============================================================================ */
- (void)reassignPatternImage {
	NSUInteger imageIndex = _testPatternsArrayController.selectionIndex;
	_patternImagePane.layer.contents = ((AETestPattern*)_testPatterns[imageIndex]).patternImage;
}

/* ========================================================================== */
- (void)resizeLayerFrames {
//	_splitView.frame = _splitView.superview.frame;
//	_splitView.frame = _testPatternsView.frame;
//	_splitView.frame = NSMakeRect(0.0, 0.0, _testPatternsView.frame.size.width, _testPatternsView.frame.size.height);
//	[_splitView display];
//	_patternImagePane.frame = _testPatternsView.frame;
// Disable implicit animation on text changes for dynamic layers.
//	NSDictionary *newActions = @{@"contents" : [NSNull null], @"bounds" : [NSNull null], @"frame" : [NSNull null], @"position" : [NSNull null]};
//	_patternImagePane.layer.actions = newActions;

	_patternSelectPane.layer.frame = NSMakeRect(0.0, 0.0, kTestPatternDrawerPosX, _testPatternsView.frame.size.height);
//	[_testPatternsView addSubview:_patternImagePane];
	_patternImagePane.layer.frame = NSMakeRect(kTestPatternDrawerPosX, 0.0, _testPatternsView.frame.size.width, _testPatternsView.frame.size.height);

//	_patternImagePane.frame = NSMakeRect(0.0, 0.0, _testPatternsView.frame.size.width, _testPatternsView.frame.size.height);
//	[_patternImagePane display];

//	_controller.patternImagePane.frame = self.superview.frame;
//	_controller.patternSelectPane.frame = self.superview.frame;
//
//	_controller.patternImagePane.picLayer.frame = self.bounds;

//	_patternImagePane.picLayer.contentsGravity = kCAGravityResizeAspectFill;
//	NSView *rightView = _splitView.subviews[1];
//	rightView.frame = _splitView.frame;
//	_patternImagePane.frame = _testPatternsView.frame;
//	_patternImagePane.layer.frame = _patternImagePane.superview.frame;
//	_patternImagePane.picLayer.frame = _testPatternsView.frame;

//	_patternImagePane.layer.frame = NSMakeRect(0.0, 0.0, _testPatternsView.frame.size.width, _testPatternsView.frame.size.height);
//	NSLog(@"_splitView.frame = %@",  NSStringFromRect(_splitView.frame));
}

#pragma mark - actions

/* ========================================================================== */
- (IBAction)exitButtonClicked:(id)sender {
	NSLog(@"Exit button clicked (view controller).");

	//	[self launchModuleNamed:@"AEModuleSelect"];

	[_testPatternsArrayController removeObserver:self forKeyPath:@"selectionIndexes"];

	[[NSApp delegate] performSelector:@selector(launchModuleNamed:) withObject:@"AEModuleSelect"];
}

/* ========================================================================== */
- (IBAction)openSelectDrawer:(id)sender {
 	// Disable implicit animation on changes for dynamic layers.
//	NSDictionary *newActions = @{@"bounds" : [NSNull null]};
//	_patternImagePane.layer.actions = newActions;

	if (_selectDrawerOpen) { return; }

	NSLog(@"Opening drawer...");
	[NSAnimationContext currentContext].duration = 0.3;
	[NSAnimationContext currentContext].timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
	[NSAnimationContext currentContext].completionHandler = ^(){
//		CGDisplayShowCursor(kCGNullDirectDisplay);
		_selectDrawerOpen = YES;
		NSLog(@"Drawer open.");
//		[self performSelector:@selector(toggleSelectDrawer:) withObject:self afterDelay:0.25];
	};
	[NSAnimationContext beginGrouping];
	[[_patternSelectPane animator] setFrame:NSMakeRect(0.0, _patternSelectPane.frame.origin.y, kTestPatternDrawerPosX, _testPatternsView.frame.size.height)];
	[[_patternImagePane animator] setFrame:NSMakeRect(_patternSelectPane.frame.size.width, 0.0, _testPatternsView.frame.size.width, _testPatternsView.frame.size.height)];
	[NSAnimationContext endGrouping];
}

/* ========================================================================== */
- (IBAction)closeSelectDrawer:(id)sender {
 	// Disable implicit animation on changes for dynamic layers.
//	NSDictionary *newActions = @{@"bounds" : [NSNull null]};
//	_patternImagePane.layer.actions = newActions;

	if (!_selectDrawerOpen) { return; }

	NSLog(@"Closing drawer...");
	[NSAnimationContext currentContext].duration = 0.15;
	[NSAnimationContext currentContext].timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
	[NSAnimationContext currentContext].completionHandler = ^(){
//		CGDisplayHideCursor(kCGNullDirectDisplay);
		_selectDrawerOpen = NO;
		NSLog(@"Drawer closed.");
//		[self performSelector:@selector(toggleSelectDrawer:) withObject:self afterDelay:0.25];
	};
	[NSAnimationContext beginGrouping];
	[[_patternSelectPane animator] setFrame:NSMakeRect(-kTestPatternDrawerPosX, _patternSelectPane.frame.origin.y, kTestPatternDrawerPosX, _testPatternsView.frame.size.height)];
	[[_patternImagePane animator] setFrame:NSMakeRect(0.0, 0.0, _testPatternsView.frame.size.width, _testPatternsView.frame.size.height)];
	[NSAnimationContext endGrouping];
}

/* ========================================================================== */
- (IBAction)toggleSelectDrawer:(id)sender {
//	_selectDrawerOpen = !_selectDrawerOpen;
	if (!_selectDrawerOpen) {
		NSLog(@"Opening.");
//		[self performSelectorOnMainThread:@selector(openSelectDrawer:) withObject:nil waitUntilDone:NO];
//		[self performSelector:@selector(openSelectDrawer:) withObject:self afterDelay:0.025];
		[self openSelectDrawer:self];
	} else {
		NSLog(@"Closing.");
//		[self performSelectorOnMainThread:@selector(closeSelectDrawer:) withObject:nil waitUntilDone:NO];
//		[self performSelector:@selector(closeSelectDrawer:) withObject:self afterDelay:0.025];
		[self closeSelectDrawer:self];
	}
}

#pragma mark - KVO

/* ========================================================================== */
-(void)insertObject:(AETestPattern*)testPattern inTestPatternsAtIndex:(NSUInteger)index {
    [_testPatterns insertObject:testPattern atIndex:index];
}

/* ========================================================================== */
-(void)removeObjectFromTestPatternsAtIndex:(NSUInteger)index {
    [_testPatterns removeObjectAtIndex:index];
}

/* ========================================================================== */
-(void)setTestPatterns:(NSMutableArray*)a {
    _testPatterns = a;
}

/* ========================================================================== */
-(NSMutableArray*)testPatterns {
    return _testPatterns;
}

/* ========================================================================== */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
//	NSLog(@"Property %@ changed, change dict = %@", keyPath, change);
	NSUInteger newValue = _testPatternsArrayController.selectionIndex;
	_patternImagePane.layer.contents = ((AETestPattern*)_testPatterns[newValue]).patternImage;

	//	[self closeSelectDrawer:self];
	[self performSelector:@selector(closeSelectDrawer:) withObject:self afterDelay:0.025];
}

@end