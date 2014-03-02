//
//  AEPatternImagePane.m
//  DataCaster
//
//  Created by Ben Stahl on 2/28/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import "AEPatternImagePane.h"

@implementation AEPatternImagePane

/* ========================================================================== */
- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

/* ========================================================================== */
- (void)drawRect:(NSRect)dirtyRect {
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

/* ========================================================================== */
- (void)awakeFromNib {
//	NSLog(@"AEPatternImagePane awakeFromNib:");
	self.frame = self.superview.frame;
//	NSLog(@"AEPatternImagePane frame size = %f, %f", self.frame.size.width, self.frame.size.height);
//	self.frame = NSMakeRect(0, 0, 400, 400);
//	self.layer.frame = self.superview.frame;
	self.layer.contentsGravity = kCAGravityResizeAspectFill;
//	self.layer.backgroundColor = [[NSColor magentaColor] CGColor];
//	self.frame = NSMakeRect(self.frame.origin.x, self.frame.origin.y, 200.0, self.frame.size.height);
//	self.layer.bounds = self.frame;

//	_picLayer = [CALayer layer];
//	_picLayer.contentsGravity = kCAGravityResizeAspectFill;
////	_picLayer.contents = [NSColor greenColor];
//	[self.layer insertSublayer:_picLayer atIndex:0];
//	_picLayer.frame = self.layer.frame;
//	NSLog(@"Image pane frame size = %f, %f", self.frame.size.width, self.frame.size.height);
}

@end
