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
	self.layer.backgroundColor = [[NSColor colorWithHue:0.0 saturation:1.0 brightness:1.0 alpha:1.0] CGColor];
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

/* ========================================================================== */
- (void)resizeSubviews {
	// resize your layers based on the view's new bounds
//	NSLog(@"Layout subviews, bounds size = %f,%f", self.bounds.size.width, self.bounds.size.height);

	// Disable implicit animation on text changes for dynamic layers.
	NSDictionary *newActions = @{@"contents" : [NSNull null], @"bounds" : [NSNull null], @"frame" : [NSNull null], @"position" : [NSNull null]};
	_picLayer.actions = newActions;

	_picLayer.frame = self.bounds;
}

/* ========================================================================== */
- (void)viewWillDraw {
	[self resizeSubviews];
}

/* ========================================================================== */
- (void)viewDidEndLiveResize {
	[self resizeSubviews];
}

/* ========================================================================== */
- (void)viewDidMoveToSuperview {
	[self resizeSubviews];
}

/* ========================================================================== */
- (void)mouseDragged:(NSEvent *)theEvent {
	NSLog(@"Mouse dragged.");

}

/* ========================================================================== */
- (void)mouseDown:(NSEvent *)theEvent {
	NSLog(@"Mouse down.");
	
}

@end
