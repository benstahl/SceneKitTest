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
	self.layer.backgroundColor = [[NSColor orangeColor] CGColor];
//	self.layer.backgroundColor = [[NSColor colorWithHue:0.0 saturation:1.0 brightness:1.0 alpha:1.0] CGColor];
//	self.layer.borderWidth = 0.5;
//	self.layer.borderColor = [[NSColor colorWithHue:0.0 saturation:0.0 brightness:1.0 alpha:1.0] CGColor];
	self.frame = self.superview.frame;
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
	[super adjustFrame];

	[_testPatternsController resizeLayerFrames];
	// resize your layers based on the view's new bounds
//	NSLog(@"Layout subviews, bounds size = %f,%f", self.bounds.size.width, self.bounds.size.height);

//	// Disable implicit animation on text changes for dynamic layers.
//	NSDictionary *newActions = @{@"contents" : [NSNull null], @"bounds" : [NSNull null], @"frame" : [NSNull null], @"position" : [NSNull null]};
//	_testPatternsController.patternImagePane.picLayer.actions = newActions;
//
//	_testPatternsController.splitView.frame = self.superview.frame;
//	_testPatternsController.patternImagePane.frame = self.superview.frame;
////	_testPatternsController.patternSelectPane.frame = self.superview.frame;
//
//	_testPatternsController.patternImagePane.picLayer.frame = self.bounds;
//	NSLog(@"New pic pane bounds size = %f, %f", self.bounds.size.width, self.bounds.size.height);
}

///* ========================================================================== */
//- (void)viewWillDraw {
//	[self adjustFrame];
//}

///* ========================================================================== */
//- (void)viewDidEndLiveResize {
//	[self adjustFrame];
//}

///* ========================================================================== */
//- (void)viewDidMoveToSuperview {
//	[self adjustFrame];
//}

///* ========================================================================== */
//- (void)viewDidMoveToSuperview {
//	[self adjustFrame];
//}

///* ========================================================================== */
//- (void)mouseDragged:(NSEvent *)theEvent {
//	NSLog(@"Mouse dragged.");
//
//}

/* ========================================================================== */
- (void)mouseDown:(NSEvent *)theEvent {
	NSLog(@"Mouse down.");
	
}

@end
