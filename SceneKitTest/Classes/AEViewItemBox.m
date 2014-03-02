//
//  AEViewItemBox.m
//  DataCaster
//
//  Created by Ben Stahl on 3/1/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import "AEViewItemBox.h"

@implementation AEViewItemBox

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
//	self.frame = self.superview.frame;
	self.wantsLayer = YES;
//	_box = [CALayer layer];
//	_box.frame = NSMakeRect(0.0, 0.0, 200.0, 150.0);
//	_box.contentsGravity = kCAGravityResizeAspectFill;
//	_box.backgroundColor = [[NSColor greenColor] CGColor];
//	_box.shadowColor = [[NSColor blackColor] CGColor];
//	_box.shadowOpacity = 0.65;
//	_box.shadowOffset = CGSizeMake(3.0, -3.0);
//	_box.shadowRadius = 2.0;
//	_box.borderColor = [[NSColor whiteColor] CGColor];
//	_box.borderWidth = 2.5;
//	_box.cornerRadius = 10.0;
//	[self.layer addSublayer:_box];
//	[self displayIfNeeded];
//	[self performSelector:@selector(finishSetup) withObject:self afterDelay:0.5];
}

/* ========================================================================== */
- (void)renderBox {
	_box = [CALayer layer];
//	_box.frame = NSMakeRect(0.0, 0.0, 200.0, 150.0);
	_box.frame = NSInsetRect(self.frame, 5.0, 5.0); // self.frame;
	_box.contentsGravity = kCAGravityResizeAspectFill;
	if (_selected) {
		_box.backgroundColor = [[NSColor orangeColor] CGColor];
	} else {
		_box.backgroundColor = [[NSColor grayColor] CGColor];
	}
//	_box.backgroundColor = [[NSColor clearColor] CGColor];
	_box.shadowColor = [[NSColor blackColor] CGColor];
	_box.shadowOpacity = 0.5;
	_box.shadowOffset = CGSizeMake(4.0, -4.0);
	_box.shadowRadius = 3.0;
	_box.borderColor = [[NSColor whiteColor] CGColor];
	_box.borderWidth = 2.0;
	_box.cornerRadius = 0.0;
	[self.layer addSublayer:_box];
}

/* ========================================================================== */
- (void)drawRect:(NSRect)dirtyRect {
	[super drawRect:dirtyRect];
	[self renderBox];

//	NSLog(@"%@ sublayers.", @(self.layer.sublayers.count));
//	_box.frame = NSMakeRect(0.0, 0.0, 200.0, 150.0);

//	[[NSColor orangeColor] set];
//	NSRectFill(dirtyRect);
}

/* ========================================================================== */
- (void)setToolTip:(NSString *)string {
//	NSLog(@"Tool tip value = %@", string);
	_selected = [string boolValue];
	[self display];
}

///* ========================================================================== */
//- (void)setSelected:(NSNumber *)selected {
//	_selected = [
//}

//- (void)bind:(NSString *)binding toObject:(id)observable withKeyPath:(NSString *)keyPath options:(NSDictionary *)options {
//
//}

@end
