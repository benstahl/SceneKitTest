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
//		self.layer.backgroundColor = [[NSColor colorWithHue:0.0 saturation:1.0 brightness:1.0 alpha:0.5] CGColor];
//		self.layer.contentsGravity = kCAGravityResizeAspect;
//		self.layer.cornerRadius = 12.0;

		[self setWantsLayer:YES];
		self.layer.opacity = 0.0;
//		self.layer.anchorPoint = CGPointMake(0.5, 0.5);
//		self.layer.frame = CGRectMake(0.0, 0.0, self.superview.frame.size.width, self.superview.frame.size.height);
		self.layer.contentsGravity = kCAGravityResize;

//		NSLog(@"Self frame = %@", NSStringFromRect(self.frame));
//		NSLog(@"Header frame = %@", NSStringFromRect(self.layer.frame));
//		NSLog(@"Header position = %@", NSStringFromRect(self.layer.frame));

//		self.layer.borderColor = [[NSColor whiteColor] CGColor];
//		self.layer.borderWidth = 1.0;

		_baseLayer = [CALayer layer];
//		_baseLayer.anchorPoint = CGPointMake(0.5, 0.5);
		_baseLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//		_baseLayer.borderColor = [[NSColor whiteColor] CGColor];
//		_baseLayer.borderWidth = 2.5;
//		_baseLayer.backgroundColor = [[NSColor colorWithHue:0.62 saturation:0.0 brightness:0.0 alpha:0.50] CGColor];
		_baseLayer.contentsGravity = kCAGravityResize;

		CGFloat fontSize = self.frame.size.height * 0.45;
		CFTypeRef labelFont = CGFontCreateWithFontName((CFStringRef)@"DIN-Bold");
		//		CFTypeRef labelFont = CGFontCreateWithFontName((CFStringRef)@"DIN-Bold");
		//		CGSize labelTextSize = [buttonLabel sizeWithAttributes:@{NSFontNameAttribute:@"DIN-Bold", NSFontSizeAttribute:@(fontSize)}];
		//		NSLog(@"Label text size = %@", NSStringFromSize(labelTextSize));

		_topLabel = [CATextLayer layer];
		_topLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height / 2.0);
		_topLabel.alignmentMode = kCAAlignmentCenter;
		_topLabel.contentsGravity = kCAGravityTop;
		_topLabel.font = labelFont;
		_topLabel.fontSize = fontSize;
		_topLabel.truncationMode = kCATruncationMiddle;
		_topLabel.string = @"";
//		_topLabel.shadowColor = [[NSColor blackColor] CGColor];
//		_topLabel.shadowOpacity = 0.65;
//		_topLabel.shadowOffset = CGSizeMake(3.0, -3.0);
//		_topLabel.shadowRadius = 2.0;
//		_topLabel.shouldRasterize = YES;
		_topLabel.foregroundColor = [[NSColor colorWithHue:0.125 saturation:1.0 brightness:1.0 alpha:1.0] CGColor];
//		_topLabel.borderColor = [[NSColor greenColor] CGColor];
//		_topLabel.borderWidth = 2.0;
		_topLabel.position = CGPointMake(self.layer.frame.size.width / 2.0, 450.0);
		[_baseLayer addSublayer:_topLabel];

		fontSize = self.frame.size.height * 0.325;

		_bottomLabel = [CATextLayer layer];
		_bottomLabel.alignmentMode = kCAAlignmentCenter;
		_bottomLabel.contentsGravity = kCAGravityTop;
		_bottomLabel.font = labelFont;
		_bottomLabel.fontSize = fontSize;
		_topLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height / 2.0);
//		_bottomLabel.bounds = CGRectMake(0, 0, frame.size.width, frame.size.height);
		_bottomLabel.truncationMode = kCATruncationMiddle;
		_bottomLabel.string = @"";
//		_bottomLabel.shadowColor = [[NSColor blackColor] CGColor];
//		_bottomLabel.shadowOpacity = 0.65;
//		_bottomLabel.shadowOffset = CGSizeMake(3.0, -3.0);
//		_bottomLabel.shadowRadius = 2.0;
//		_bottomLabel.shouldRasterize = YES;
//		_bottomLabel.borderColor = [[NSColor magentaColor] CGColor];
//		_bottomLabel.borderWidth = 2.0;
		[_baseLayer addSublayer:_bottomLabel];
		
		[self.layer addSublayer:_baseLayer];

    }
    return self;
}

/* ========================================================================== */
- (CGFloat)heightOfLabelWithFont:(NSFont*)font {
	NSMutableDictionary *attr = [NSMutableDictionary dictionary];
	[attr setValue:font forKey:NSFontAttributeName];
//	[attr setValue:@(fontSize) forKey:NSFontSizeAttribute];

	NSString *sampleString = @"X";
	CGSize sampleSize = [sampleString sizeWithAttributes:[NSDictionary dictionaryWithDictionary:attr]];
	return sampleSize.height;
}

///* ========================================================================== */
- (void)adjustHeaderLabels {
//	NSLog(@"Adjusting header labels...");

//	CGFloat scalingBasis = 0.0;
	CGFloat scale = 1.0;
//	NSApplicationPresentationOptions currentOptions = [NSApp currentSystemPresentationOptions];
//	if (currentOptions &= NSApplicationPresentationFullScreen) {
//		NSLog(@"Full screen = YES");
//		scale *= 2.0;
//		scalingBasis = [NSScreen mainScreen].frame.size.height;
//	} else {
//		NSLog(@"Full screen = NO");
//		NSView *windowContentView = [self.superview window].contentView;
//		scalingBasis = windowContentView.frame.size.height;
//	}

	NSView *windowContentView = [self.superview window].contentView;
	CGFloat scalingBasis = windowContentView.frame.size.height;

//	NSLog(@"Scaling basis = %f", scalingBasis);
	CGFloat topFontSize = scalingBasis * 0.085;
	CGFloat bottomFontSize = scalingBasis * 0.07;
	CGFloat leading = scalingBasis * 0.045;

//	CGFloat scalingBasis = self.superview.frame.size.height;
//	CGFloat topFontSize = scalingBasis * 0.4 * scale;
//	CGFloat bottomFontSize = scalingBasis * 0.3 * scale;
//	CGFloat leading = scalingBasis * 0.21;

//	NSLog(@"frame size (before) = %@ | scale = %f", NSStringFromRect(self.layer.frame), scale);

	self.layer.frame = CGRectMake(0.0, 0.0, self.superview.frame.size.width, self.superview.frame.size.height);
//	self.frame = self.superview.frame;
//	NSLog(@"frame size (after) = %@", NSStringFromRect(self.layer.frame));
	_baseLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
	_baseLayer.position = CGPointMake(self.layer.frame.size.width / 2.0, self.superview.frame.size.height * 0.875);

	_topLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height / 2.0);
//	_topLabel.position = CGPointMake(self.layer.frame.size.width / 2.0, self.superview.frame.size.height * 0.93);
	_topLabel.position = CGPointMake(self.layer.frame.size.width / 2.0, self.frame.size.height * 0.5 + leading);

	_bottomLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height / 2.0);
//	_bottomLabel.position = CGPointMake(self.layer.frame.size.width / 2.0, self.superview.frame.size.height * 0.84);
	_bottomLabel.position = CGPointMake(self.layer.frame.size.width / 2.0, self.frame.size.height * 0.5 - leading);

//	NSLog(@"Top font size (before) = %f", _topLabel.fontSize);
	_topLabel.fontSize = topFontSize;
	_bottomLabel.fontSize = bottomFontSize;
//	NSLog(@"Top font size (after) = %f", _topLabel.fontSize);

//	[_topLabel displayIfNeeded];
//	[_bottomLabel displayIfNeeded];

//	CGFloat labelFontSize = round(vc.headerView.frame.size.height * 0.35);
//	//	NSApplicationPresentationOptions currentOptions = [NSApp currentSystemPresentationOptions];
//	//	if (currentOptions &= NSApplicationPresentationFullScreen) {
//	//		NSLog(@"Full screen = YES");
//	//		newTopFontSize *= 2.0;
//	//	} else {
//	//		NSLog(@"Full screen = NO");
//	//	}
//
//	NSFont *labelFont = vc.headerView.topLabel.font;
//	CGFloat oldFontSize = labelFont.pointSize;
//
//	NSLog(@"  Header view frame = %@", NSStringFromRect(vc.headerView.frame));
//	NSLog(@"  Old top label font size = %@, new size = %@", @(oldTopFontSize), @(newTopFontSize));
//
//
//	//	if (newTopFontSize != oldTopFontSize) {
//	NSLog(@"  Resizing fonts...");
//
//	// Set the header view height to 20% of the scene view, and position it aligned witht he top of the scene frame.
//	CGFloat newHeaderHeight = self.frame.size.height * 0.2;
//	vc.headerView.layer.borderColor = [[NSColor whiteColor] CGColor];
//	vc.headerView.layer.borderWidth = 2.0;
//	//		vc.headerView.frame = NSMakeRect(0.0, self.frame.size.height - newHeaderHeight, self.frame.size.width, newHeaderHeight);
//
//	topLabelFont = [NSFont fontWithName:@"DIN-Bold" size:newTopFontSize];
//	CGFloat topLabelFontHeight = [vc.headerView heightOfLabelWithFont:topLabelFont];
//	CGFloat offsetY = topLabelFontHeight; //vc.headerView.frame.size.height * 0.6;
//	NSLog(@"  Top label height = %f", topLabelFontHeight);
//	//		vc.headerView.topLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(vc.headerView.frame.origin.x, vc.headerView.frame.origin.y, vc.headerView.frame.size.width, vc.headerView.frame.size.height * 0.65)];
//	[vc.headerView.topLabel setFont:topLabelFont];
//	NSLog(@"    New top label font size = %@", @(newTopFontSize));
//	//		[vc.headerView.topLabel setStringValue:[NSString stringWithFormat:@"[TOP NSTEXTFIELD SIZE = %@]", @(newTopFontSize)]];
//	NSLog(@"offsetY = %f", offsetY);
//	[vc.headerView.topLabel setFrameOrigin:NSMakePoint(vc.headerView.topLabel.frame.origin.x, vc.headerView.frame.size.height - offsetY)];
//	[vc.headerView.topLabel setNeedsDisplay];
//	//		[vc.headerView.topLabel display];
//
//	CGFloat newBottomFontSize = round(newTopFontSize * 0.75);
//	NSFont *bottomLabelFont = [NSFont fontWithName:@"DIN-Bold" size:newBottomFontSize];
//	CGFloat bottomLabelFontHeight = [vc.headerView heightOfLabelWithFont:bottomLabelFont];
//	NSLog(@"  Bottom label height = %f", [vc.headerView heightOfLabelWithFont:bottomLabelFont]);
//	//		CGFloat offsetY = 0.0; // newBottomFontSize * vc.headerView.frame.size.height * 0.0;
//	NSLog(@"New Y = %f", vc.headerView.bottomLabel.frame.origin.y);
//	//		vc.headerView.bottomLabel.frame = NSMakeRect(vc.headerView.bottomLabel.frame.origin.x, vc.headerView.bottomLabel.frame.origin.y + offsetY, vc.headerView.bottomLabel.frame.size.width, vc.headerView.bottomLabel.frame.size.height);
//	//		[vc.headerView.bottomLabel setStringValue:[NSString stringWithFormat:@"[BOTTOM NSTEXTFIELD SIZE = %@]", @(newBottomFontSize)]];
//	[vc.headerView.bottomLabel setFont:bottomLabelFont];
//	//		CGSize *bottomLabelRenderedSize = [vc.headerView.bottomLabel.stringValue sizeWithAttributes:];
//	[vc.headerView.bottomLabel setFrameOrigin:NSMakePoint(vc.headerView.bottomLabel.frame.origin.x, vc.headerView.topLabel.frame.origin.y - (bottomLabelFontHeight * 1.5))];
//	[vc.headerView.bottomLabel setNeedsDisplay];
//
//	//		[vc.headerView setNeedsDisplay:YES];
//	//	}
}

/* ========================================================================== */
- (void)viewDidMoveToSuperview {
	[self adjustHeaderLabels];
}

///* ========================================================================== */
//- (void)viewWillDraw {
//	[self adjustHeaderLabels];
//}

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
