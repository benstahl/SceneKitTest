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
#import "AETestPattern.h"

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
	[super adjustFrame];

	AEModuleTestPatternsViewController *vc = _testPatternsController;
	vc.patternSelectPane.autoresizingMask = NSViewHeightSizable;

	NSDictionary *newActions = @{@"contents" : [NSNull null], @"bounds" : [NSNull null], @"frame" : [NSNull null], @"position" : [NSNull null]};
	vc.patternImagePane.layer.actions = newActions;

	[vc reassignPatternImage];

	if (vc.selectDrawerOpen == YES) {
		vc.patternSelectPane.frame = NSMakeRect(0.0,0.0, kTestPatternDrawerPosX, self.frame.size.height);
//		vc.patternImagePane.frame = NSMakeRect(round(vc.patternSelectPane.frame.size.width), 0.0, newImageWidth, newImageHeight);
		vc.patternImagePane.frame = NSMakeRect(vc.patternSelectPane.frame.size.width, 0.0, self.frame.size.width, self.frame.size.height);
	} else {
		vc.patternSelectPane.frame = NSMakeRect(-kTestPatternDrawerPosX, 0.0, kTestPatternDrawerPosX, self.frame.size.height);
//		vc.patternImagePane.frame = NSMakeRect(0.0, 0.0, newImageWidth, newImageHeight);
		vc.patternImagePane.frame = NSMakeRect(0.0, 0.0, self.frame.size.width, self.frame.size.height);
	}
}

///* ========================================================================== */
//- (void)viewWillDraw {
//	[self adjustFrame];
//}

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
