//
//  AETestPatternsView.m
//  DataCaster
//
//  Created by Ben Stahl on 2/27/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import "AEModuleTestPatternsView.h"
#import "AEModuleTestPatternsViewController.h"
#import "AEPatternImagePane.h"
#import "AEPatternSelectPane.h"

@implementation AEModuleTestPatternsView

/* ========================================================================== */
- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

/* ========================================================================== */
- (void)awakeFromNib {
//	self.translatesAutoresizingMaskIntoConstraints = YES;
//	self.layer.contentsGravity = kCAGravityResizeAspectFill;
//	self.layer.backgroundColor = [[NSColor orangeColor] CGColor];
	self.layer.backgroundColor = [[NSColor blackColor] CGColor];
//	self.layer.backgroundColor = [[NSColor colorWithHue:0.0 saturation:1.0 brightness:1.0 alpha:1.0] CGColor];
//	self.layer.borderWidth = 0.5;
//	self.layer.borderColor = [[NSColor colorWithHue:0.0 saturation:0.0 brightness:1.0 alpha:1.0] CGColor];
	self.layer.frame = self.superview.frame;
//	NSLog(@"AEModuleTestPatternsView frame size = %f, %f", self.frame.size.width, self.frame.size.height);
//	[self performSelector:@selector(finishSetup) withObject:nil afterDelay:0.1];
}

/* ========================================================================== */
//- (void)finishSetup {
//	NSLog(@"AEModuleTestPatternsView frame size = %f, %f", self.frame.size.width, self.frame.size.height);
//	[_testPatternsController setTitle:@""];
//
//}

/* ========================================================================== */
- (void)drawRect:(NSRect)dirtyRect {
	[super drawRect:dirtyRect];

    // Drawing code here.
}

/* ========================================================================== */
- (void)adjustFrame {
	NSLog(@"Adjusting frames.");
	NSLog(@"  Old view frame = %@", NSStringFromRect(self.frame));
	[super adjustFrame];
	NSLog(@"  New view frame = %@", NSStringFromRect(self.frame));

//	self.frame = self.superview.frame;
//	[_testPatternsController resizeLayerFrames];

	// resize your layers based on the view's new bounds
	_testPatternsController.patternSelectPane.autoresizingMask = NSViewHeightSizable;
//	_testPatternsController.patternSelectPane.frame = NSMakeRect(0.0, 0.0, kTestPatternDrawerPosX, self.frame.size.height);
//	_testPatternsController.patternSelectPane.frame = self.frame;
//	NSLog(@"Layout subviews, bounds size = %f,%f", self.bounds.size.width, self.bounds.size.height);

	// Disable implicit animation on text changes for dynamic layers.
//	NSDictionary *newActions = @{@"contents" : [NSNull null], @"bounds" : [NSNull null], @"frame" : [NSNull null], @"position" : [NSNull null]};
//	_testPatternsController.patternImagePane.layer.actions = newActions;

//	_testPatternsController.patternImagePane.frame = self.superview.frame;
////	_testPatternsController.patternSelectPane.frame = self.superview.frame;
//
//	_testPatternsController.patternImagePane.picLayer.frame = self.bounds;
//	NSLog(@"New pic pane bounds size = %f, %f", self.bounds.size.width, self.bounds.size.height);

//	_testPatternsController.patternImagePane.layer.hidden = NO;
	_testPatternsController.patternImagePane.layer.contentsGravity = kCAGravityResizeAspect;

//	_testPatternsController.patternImagePane.autoresizesSubviews = YES;

	if (_testPatternsController.selectDrawerOpen == YES) {
		_testPatternsController.patternSelectPane.frame = NSMakeRect(0.0,0.0, kTestPatternDrawerPosX, self.frame.size.height);
		_testPatternsController.patternImagePane.frame = NSMakeRect(_testPatternsController.patternSelectPane.frame.size.width, 0.0, self.frame.size.width, self.frame.size.height);
	} else {
		_testPatternsController.patternSelectPane.frame = NSMakeRect(-kTestPatternDrawerPosX, 0.0, kTestPatternDrawerPosX, self.frame.size.height);
		_testPatternsController.patternImagePane.frame = NSMakeRect(0.0, 0.0, self.frame.size.width, self.frame.size.height);
	}

//	NSLog(@"  New select pane frame = %@", NSStringFromRect(_testPatternsController.patternSelectPane.frame));
	NSLog(@"  New image pane frame = %@", NSStringFromRect(_testPatternsController.patternImagePane.frame));
	NSLog(@"  New image layer frame = %@", NSStringFromRect(_testPatternsController.patternImagePane.layer.frame));
//	NSLog(@"  New image layer bounds = %@", NSStringFromRect(_testPatternsController.patternImagePane.layer.bounds));
	NSLog(@"  Image pane contents = %@", _testPatternsController.patternImagePane.layer.contents);
}

/* ========================================================================== */
- (void)viewWillDraw {
	[self adjustFrame];
}

///* ========================================================================== */
//- (void)viewDidEndLiveResize {
//	[self adjustFrame];
//}

/* ========================================================================== */
- (void)viewDidMoveToSuperview {
	[self adjustFrame];
}

///* ========================================================================== */
//- (void)mouseDragged:(NSEvent *)theEvent {
//	NSLog(@"Mouse dragged.");
//
//}

/* ========================================================================== */
- (void)mouseDown:(NSEvent *)theEvent {
//	NSLog(@"Mouse down.");
	[_testPatternsController toggleSelectDrawer:self];
}

@end
