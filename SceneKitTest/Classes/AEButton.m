//
//  AEButton.m
//  SceneKitTest
//
//  Created by Ben Stahl on 2/22/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import "AEAppDelegate.h"
#import "AEButton.h"
#import "AEUtility.h"

@implementation AEButton

@synthesize actionSelectorString = _actionSelectorString;
@synthesize buttonLabelText = _buttonLabelText;

/* ========================================================================== */
- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//		SEL actionSelector = @selector(newPickSetButtonClicked:);
//		[self sendActionOn:NSLeftMouseUpMask];
//		[self setAction:actionSelector];
		[self setWantsLayer:YES];

		_baseLayer = [CALayer layer];
		_baseLayer.anchorPoint = CGPointMake(0.5, 0.5);
		_baseLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
//		_baseLayer.frame = CGRectMake(- frame.size.width / 2.0, -frame.size.height / 2.0, frame.size.width, frame.size.height);
		_baseLayer.bounds = _baseLayer.frame;
//		_baseLayer.bounds = CGRectMake(0, 0, frame.size.width, frame.size.height);
//		_baseLayer.bounds = CGRectMake(- frame.size.width / 2.0, -frame.size.height / 2.0, frame.size.width, frame.size.height);
		_baseLayer.borderColor = [[NSColor whiteColor] CGColor];
		_baseLayer.borderWidth = 2.5;
		_baseLayer.cornerRadius = 10.0;
//		_baseLayer.backgroundColor = [[NSColor colorWithHue:0.62 saturation:0.85 brightness:0.50 alpha:0.25] CGColor];
		_baseLayer.backgroundColor = [[NSColor colorWithHue:0.62 saturation:0.0 brightness:0.0 alpha:0.50] CGColor];
		_baseLayer.contentsGravity = kCAGravityCenter;

		CGFloat fontSize = frame.size.height * 0.5;
		CFTypeRef labelFont = CGFontCreateWithFontName((CFStringRef)@"HelveticaNeue");
//		CGSize labelTextSize = [buttonLabel sizeWithAttributes:@{NSFontNameAttribute:@"DIN-Bold", NSFontSizeAttribute:@(fontSize)}];
//		NSLog(@"Label text size = %@", NSStringFromSize(labelTextSize));

		_labelLayer = [CATextLayer layer];
		_labelLayer.alignmentMode = kCAAlignmentCenter;
		_labelLayer.contentsGravity = kCAGravityCenter;
		_labelLayer.font = labelFont;
		_labelLayer.fontSize = fontSize;
		_labelLayer.alignmentMode = kCAAlignmentCenter;
		_labelLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
//		_labelLayer.bounds = CGRectMake(0, 0, frame.size.width, frame.size.height);
		_labelLayer.truncationMode = kCATruncationMiddle;
		_labelLayer.string = @""; // Since we're pulling from the .xib file, needs to be set in awakeFromNib:
//		_labelLayer.shadowColor = [[NSColor blackColor] CGColor];
//		_labelLayer.shadowOpacity = 0.65;
//		_labelLayer.shadowOffset = CGSizeMake(3.0, -3.0);
//		_labelLayer.shadowRadius = 2.0;
		_labelLayer.shouldRasterize = YES;
//		_labelLayer.bounds = CGRectMake(_labelLayer.bounds.origin.x, _labelLayer.bounds.origin.y - fontSize * 5.0, _labelLayer.bounds.size.width, _labelLayer.bounds.size.height);
		_labelLayer.position = CGPointMake(_labelLayer.position.x, fontSize * 0.6);
		[_baseLayer addSublayer:_labelLayer];

//		NSButton *button;

		// Disable implicit animation on text changes for dynamic layers.
//		NSDictionary *newActions = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNull null], @"contents", nil];
//		_labelLayer.actions = newActions;

		[self.layer addSublayer:_baseLayer];
    }
    return self;
}

/* ========================================================================== */
- (void)awakeFromNib {
	_labelLayer.string = [NSString stringWithFormat:@"%@", _buttonLabelText];
}

/* ========================================================================== */
- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

/* ========================================================================== */
- (void)mouseDown:(NSEvent *)theEvent {
//	NSLog(@"mouseDown.");
	[_baseLayer removeAnimationForKey:@"transform.scale"];
//	_baseLayer.transform = CATransform3DScale(_baseLayer.transform, 0.80, 0.80, 1.0);
//	CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//	[scale setFromValue:[NSValue valueWithCATransform3D:_baseLayer.transform]];
//	[scale setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.80, 0.80, 1.0)]];
//	[scale setDuration:0.165f];
//	[scale setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
//	[scale setRemovedOnCompletion:NO];
//	[scale setFillMode:kCAFillModeForwards];
//	[_baseLayer addAnimation:scale forKey:@"transform.scale"];

	CAKeyframeAnimation *scaleDownUp = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
	scaleDownUp.values = @[
	   [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)],
	   [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1.0)],
	   [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)],
	];
	scaleDownUp.keyTimes = @[@0.0, @0.35, @1.0];
	scaleDownUp.duration = 0.165;
	scaleDownUp.delegate = self;
	_clickAnimation = (CAAnimation*)scaleDownUp;
	[_baseLayer addAnimation:scaleDownUp forKey:@"transform.scale"];
}

/* ========================================================================== */
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
	if (flag) {
		[self sendAction:NSSelectorFromString(_actionSelectorString) to:self.target];
	}
}

/* ========================================================================== */
- (void)mouseUp:(NSEvent *)theEvent {
//	NSLog(@"mouseUp.");
//	[_baseLayer removeAnimationForKey:@"transform.scale"];
////	_baseLayer.transform = CATransform3DScale(_baseLayer.transform, 1.0, 1.0, 1.0);
//	CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//	[scale setFromValue:[NSValue valueWithCATransform3D:_baseLayer.transform]];
//	[scale setToValue:[NSValue valueWithCATransform3D:CATransform3DIdentity]];
//	[scale setDuration:0.2f];
//	[scale setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
//	[scale setRemovedOnCompletion:NO];
//	[scale setFillMode:kCAFillModeForwards];
//	[_baseLayer addAnimation:scale forKey:@"transform.scale"];
//
//	[self sendAction:NSSelectorFromString(_actionSelectorString) to:self.target];
}

@end
