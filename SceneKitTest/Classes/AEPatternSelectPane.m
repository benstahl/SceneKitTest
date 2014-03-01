//
//  AEPatternSelectPaneView.m
//  DataCaster
//
//  Created by Ben Stahl on 2/28/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import "AEPatternSelectPane.h"

@implementation AEPatternSelectPane

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
//	self.frame = NSMakeRect(self.frame.origin.x, self.frame.origin.y, 200.0, self.frame.size.height);
	self.layer.backgroundColor = [[NSColor darkGrayColor] CGColor];
	self.layer.frame = self.frame;
}

@end