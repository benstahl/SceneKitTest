//
//  AEButton.m
//  SceneKitTest
//
//  Created by Ben Stahl on 2/22/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import "AEButton.h"
#import "AEUtility.h"

@implementation AEButton

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		[self setWantsLayer:YES];

//		_baseLayer = [CALayer layer];
		self.layer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
		self.layer.borderColor = [[NSColor whiteColor] CGColor];
		self.layer.borderWidth = 2.5;
		self.layer.cornerRadius = 10.0;
//		self.layer.backgroundColor = [[NSColor colorWithCalibratedHue:0.62 saturation:0.85 brightness:0.50 alpha:0.25] CGColor];
		self.layer.backgroundColor = [[NSColor colorWithCalibratedHue:0.62 saturation:0.0 brightness:0.0 alpha:0.50] CGColor];
		self.layer.contentsGravity = kCAGravityCenter;

		CGFloat fontSize = frame.size.height * 0.5;
		CFTypeRef labelFont = CGFontCreateWithFontName((CFStringRef)@"Univers");
		NSString *buttonLabel = @"NEW SET";
//		CGSize labelTextSize = [buttonLabel sizeWithAttributes:@{NSFontNameAttribute:@"DIN-Bold", NSFontSizeAttribute:@(fontSize)}];
//		NSLog(@"Label text size = %@", NSStringFromSize(labelTextSize));

		_labelLayer = [CATextLayer layer];
		_labelLayer.alignmentMode = kCAAlignmentCenter;
		_labelLayer.contentsGravity = kCAGravityCenter;
		_labelLayer.font = labelFont;
		_labelLayer.fontSize = fontSize;
		_labelLayer.alignmentMode = kCAAlignmentCenter;
		_labelLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
		_labelLayer.truncationMode = kCATruncationMiddle;
		_labelLayer.string = [NSString stringWithFormat:@"%@", buttonLabel];
		_labelLayer.shadowColor = [[NSColor blackColor] CGColor];
		_labelLayer.shadowOpacity = 0.65;
		_labelLayer.shadowOffset = CGSizeMake(3.0, -3.0);
		_labelLayer.shadowRadius = 2.0;
		_labelLayer.shouldRasterize = YES;
//		_labelLayer.bounds = CGRectMake(_labelLayer.bounds.origin.x, _labelLayer.bounds.origin.y - fontSize * 5.0, _labelLayer.bounds.size.width, _labelLayer.bounds.size.height);
		_labelLayer.position = CGPointMake(_labelLayer.position.x, fontSize * 0.4);
		[self.layer addSublayer:_labelLayer];

//		NSButton *button;

		// Disable implicit animation on text changes for dynamic layers.
		NSDictionary *newActions = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNull null], @"contents", nil];
		_labelLayer.actions = newActions;

		[self.layer addSublayer:_baseLayer];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

@end