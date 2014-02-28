//
//  AETestPatternsView.m
//  DataCaster
//
//  Created by Ben Stahl on 2/27/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import "AEModuleTestPatternsView.h"
#import "AEModuleTestPatternsViewController.h"

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
//	NSLog(@"Module FFL View awakeFromNib:");
	//	self.translatesAutoresizingMaskIntoConstraints = YES;
	self.layer.contentsGravity = kCAGravityResizeAspectFill;
	self.layer.backgroundColor = [[NSColor colorWithHue:0.0 saturation:1.0 brightness:0.0 alpha:1.0] CGColor];
//	self.layer.borderWidth = 0.5;
//	self.layer.borderColor = [[NSColor colorWithHue:0.0 saturation:0.0 brightness:1.0 alpha:1.0] CGColor];
}

//- (void)swipeWithEvent:(NSEvent *)event {
//	NSLog(@"Swipe.");
//}

/* ========================================================================== */
- (void)drawRect:(NSRect)dirtyRect {
	[super drawRect:dirtyRect];

    // Drawing code here.
}

///* ========================================================================== */
//- (void)viewWillDraw {
//}
//
///* ========================================================================== */
//- (void)viewDidEndLiveResize {
//}
//
///* ========================================================================== */
//- (void)viewDidMoveToSuperview {
//}

/* ========================================================================== */
- (void)mouseDragged:(NSEvent *)theEvent {
	NSLog(@"Mouse dragged.");

}

/* ========================================================================== */
- (void)mouseDown:(NSEvent *)theEvent {
	NSLog(@"Mouse down.");
	
}

@end
