//
//  AEHeaderView.m
//  SceneKitTest
//
//  Created by Ben Stahl on 2/24/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import "AEHeaderView.h"
#import <QuartzCore/QuartzCore.h>

@implementation AEHeaderView

/* ========================================================================== */
- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//		[self setWantsLayer:YES];
//		self.layer.backgroundColor = [[NSColor colorWithHue:0.0 saturation:1.0 brightness:1.0 alpha:0.5] CGColor];
//		self.layer.contentsGravity = kCAGravityResizeAspect;
//		self.layer.cornerRadius = 12.0;

		[self setWantsLayer:YES];
		self.layer.opacity = 0.0;
//		self.layer.anchorPoint = CGPointMake(0.5, 0.5);
//		self.layer.frame = CGRectMake(0.0, 0.0, self.superview.frame.size.width, self.superview.frame.size.height);
//		self.layer.contentsGravity = kCAGravityCenter;
//
//		//	NSLog(@"Self frame = %@", NSStringFromRect(self.frame));
//		//	NSLog(@"Header frame = %@", NSStringFromRect(self.layer.frame));
//		//	NSLog(@"Header position = %@", NSStringFromRect(self.layer.frame));
//
//		self.layer.borderColor = [[NSColor whiteColor] CGColor];
//		self.layer.borderWidth = 1.0;
//
//		CGFloat fontSize = 100.0; //self.frame.size.height * 0.5;
//		CFTypeRef labelFont = CGFontCreateWithFontName((CFStringRef)@"Helvetica Neue");
//		//	CFTypeRef labelFont = CGFontCreateWithFontName((CFStringRef)@"DIN-Bold");
//		//		CGSize labelTextSize = [buttonLabel sizeWithAttributes:@{NSFontNameAttribute:@"DIN-Bold", NSFontSizeAttribute:@(fontSize)}];
//		//		NSLog(@"Label text size = %@", NSStringFromSize(labelTextSize));
//
//		_baseLayer = [CALayer layer];
//		_baseLayer.anchorPoint = CGPointMake(0.5, 0.5);
//		_baseLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//		//		_baseLayer.frame = CGRectMake(- frame.size.width / 2.0, -frame.size.height / 2.0, frame.size.width, frame.size.height);
//		_baseLayer.bounds = _baseLayer.frame;
//		//		_baseLayer.bounds = CGRectMake(0, 0, frame.size.width, frame.size.height);
//		//		_baseLayer.bounds = CGRectMake(- frame.size.width / 2.0, -frame.size.height / 2.0, frame.size.width, frame.size.height);
//		_baseLayer.borderColor = [[NSColor whiteColor] CGColor];
//		_baseLayer.borderWidth = 2.5;
//		_baseLayer.cornerRadius = 10.0;
//		//		_baseLayer.backgroundColor = [[NSColor colorWithHue:0.62 saturation:0.85 brightness:0.50 alpha:0.25] CGColor];
//		_baseLayer.backgroundColor = [[NSColor colorWithHue:0.62 saturation:0.0 brightness:0.0 alpha:0.50] CGColor];
//		_baseLayer.contentsGravity = kCAGravityCenter;
//
//		_topLabel = [CATextLayer layer];
//		_topLabel.alignmentMode = kCAAlignmentCenter;
//		_topLabel.contentsGravity = kCAGravityCenter;
//		_topLabel.font = labelFont;
//		_topLabel.fontSize = fontSize;
//		//		_topLabel.frame = CGRectMake(0, 0, self.layer.frame.size.width, self.layer.frame.size.height);
//		//	_topLabel.bounds = CGRectMake(0, 0, frame.size.width, frame.size.height);
//		_topLabel.truncationMode = kCATruncationMiddle;
//		_topLabel.string = @"";
//		//	_topLabel.shadowColor = [[NSColor blackColor] CGColor];
//		//	_topLabel.shadowOpacity = 0.65;
//		//	_topLabel.shadowOffset = CGSizeMake(3.0, -3.0);
//		//	_topLabel.shadowRadius = 2.0;
//		_topLabel.shouldRasterize = YES;
//		_topLabel.borderColor = [[NSColor greenColor] CGColor];
//		_topLabel.borderWidth = 2.0;
//		//	_bottomLabel.bounds = CGRectMake(_labelLayer.bounds.origin.x, _labelLayer.bounds.origin.y - fontSize * 5.0, _bottomLabel.bounds.size.width, _labelLayer.bounds.size.height);
//		//	_topLabel.position = CGPointMake(_baseLayer.frame.size.width / 2.0, _baseLayer.frame.size.width / 2.0);
//		//	_topLabel.position = CGPointMake(_baseLayer.frame.size.width / 2.0, _baseLayer.frame.size.width * 0.3);
//		//	_topLabel.anchorPoint = CGPointMake(0.5, 0.5);
//		_topLabel.frame = CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height);
//		_topLabel.bounds = _topLabel.frame;
//		NSLog(@"Self frame = %@", NSStringFromRect(self.frame));
//		//	_topLabel.position = CGPointMake(self.layer.frame.size.width / 2.0, 450.0);
//		NSLog(@"Label position = %@", NSStringFromPoint((CGPoint)_topLabel.position));
//		[self.layer addSublayer:_topLabel];
//
//		fontSize = self.frame.size.height * 0.3;
//
//		_bottomLabel = [CATextLayer layer];
//		_bottomLabel.alignmentMode = kCAAlignmentCenter;
//		_bottomLabel.contentsGravity = kCAGravityCenter;
//		_bottomLabel.font = labelFont;
//		_bottomLabel.fontSize = fontSize;
//		//	_bottomLabel.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
//		//	_bottomLabel.bounds = CGRectMake(0, 0, frame.size.width, frame.size.height);
//		_bottomLabel.truncationMode = kCATruncationMiddle;
//		_bottomLabel.string = @"";
//		//	_bottomLabel.shadowColor = [[NSColor blackColor] CGColor];
//		//	_bottomLabel.shadowOpacity = 0.65;
//		//	_bottomLabel.shadowOffset = CGSizeMake(3.0, -3.0);
//		//	_bottomLabel.shadowRadius = 2.0;
//		_bottomLabel.shouldRasterize = YES;
//		_topLabel.borderColor = [[NSColor magentaColor] CGColor];
//		_topLabel.borderWidth = 2.0;
//		//	_bottomLabel.bounds = CGRectMake(_labelLayer.bounds.origin.x, _labelLayer.bounds.origin.y - fontSize * 5.0, _bottomLabel.bounds.size.width, _labelLayer.bounds.size.height);
//		_bottomLabel.frame = CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height);
//		//	_bottomLabel.position = CGPointMake(_baseLayer.frame.size.width / 2.0, _baseLayer.frame.size.width * 0.7);
//		[self.layer addSublayer:_bottomLabel];
//		
//		//	[self.layer addSublayer:_baseLayer];
    }
    return self;
}

/* ========================================================================== */
- (void)awakeFromNib {

}

/* ========================================================================== */
- (void)fadeIn {
	CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"opacity"];
	//	[scale setFromValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.85, 0.85, 1.0)]];
	[fade setFromValue:@(self.layer.opacity)];
	[fade setToValue:@1.0];
	[fade setDuration:kHeaderFadeInTime];
	//	[fade setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
	[fade setRemovedOnCompletion:NO];
	[fade setFillMode:kCAFillModeForwards];
	[self.layer addAnimation:fade forKey:@"fadeIn"];
}

/* ========================================================================== */
- (void)fadeOut {
	CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"opacity"];
	//	[scale setFromValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.85, 0.85, 1.0)]];
	[fade setFromValue:@(self.layer.opacity)];
	[fade setToValue:@0.0];
	[fade setDuration:kHeaderFadeOutTime];
//	[fade setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
	[fade setRemovedOnCompletion:NO];
	[fade setFillMode:kCAFillModeForwards];
	[self.layer addAnimation:fade forKey:@"fadeOut"];
}

/* ========================================================================== */

- (void)drawRect:(NSRect)dirtyRect {
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}


@end
