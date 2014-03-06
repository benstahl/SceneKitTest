//
//  AEModuleFFLView.m
//  DataCaster
//
//  Created by Ben Stahl on 2/27/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import "AEModuleFFLView.h"
#import <QuartzCore/QuartzCore.h>
#import "AEModuleFFLViewController.h"
#import "AEFFLHeaderView.h"
//#import "AEMenuView.h"

@implementation AEModuleFFLView

/* ========================================================================== */
- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

/* ========================================================================== */
- (void)awakeFromNib {
	NSLog(@"Module FFL View awakeFromNib:");
//	self.translatesAutoresizingMaskIntoConstraints = YES;
	self.layer.contentsGravity = kCAGravityCenter;
//	self.layer.backgroundColor = [[NSColor colorWithHue:0.0 saturation:1.0 brightness:0.0 alpha:1.0] CGColor];
	self.layer.backgroundColor = [[NSColor blackColor] CGColor];
//	self.layer.borderWidth = 0.5;
//	self.layer.borderColor = [[NSColor colorWithHue:0.0 saturation:0.0 brightness:1.0 alpha:1.0] CGColor];
}

/* ========================================================================== */
- (void)drawRect:(NSRect)dirtyRect {
	[super drawRect:dirtyRect];

	// Drawing code here.
}

///* ========================================================================== */
- (void)adjustHeaderLabels {
//	NSLog(@"Adjusting header labels...");
//
//	AEModuleFFLViewController *vc = _fflViewController;
//
//	CGFloat newTopFontSize = round(vc.headerView.frame.size.height * 0.35);
////	NSApplicationPresentationOptions currentOptions = [NSApp currentSystemPresentationOptions];
////	if (currentOptions &= NSApplicationPresentationFullScreen) {
////		NSLog(@"Full screen = YES");
////		newTopFontSize *= 2.0;
////	} else {
////		NSLog(@"Full screen = NO");
////	}
//
//	NSFont *topLabelFont = vc.headerView.topLabel.font;
//	CGFloat oldTopFontSize = topLabelFont.pointSize;
//
//	NSLog(@"  Header view frame = %@", NSStringFromRect(vc.headerView.frame));
//	NSLog(@"  Old top label font size = %@, new size = %@", @(oldTopFontSize), @(newTopFontSize));
//
//
////	if (newTopFontSize != oldTopFontSize) {
//		NSLog(@"  Resizing fonts...");
//
//		// Set the header view height to 20% of the scene view, and position it aligned witht he top of the scene frame.
//		CGFloat newHeaderHeight = self.frame.size.height * 0.2;
//		vc.headerView.layer.borderColor = [[NSColor whiteColor] CGColor];
//		vc.headerView.layer.borderWidth = 2.0;
////		vc.headerView.frame = NSMakeRect(0.0, self.frame.size.height - newHeaderHeight, self.frame.size.width, newHeaderHeight);
//
//		topLabelFont = [NSFont fontWithName:@"DIN-Bold" size:newTopFontSize];
//		CGFloat topLabelFontHeight = [vc.headerView heightOfLabelWithFont:topLabelFont];
//		CGFloat offsetY = topLabelFontHeight; //vc.headerView.frame.size.height * 0.6;
//		NSLog(@"  Top label height = %f", topLabelFontHeight);
////		vc.headerView.topLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(vc.headerView.frame.origin.x, vc.headerView.frame.origin.y, vc.headerView.frame.size.width, vc.headerView.frame.size.height * 0.65)];
//		[vc.headerView.topLabel setFont:topLabelFont];
//		NSLog(@"    New top label font size = %@", @(newTopFontSize));
////		[vc.headerView.topLabel setStringValue:[NSString stringWithFormat:@"[TOP NSTEXTFIELD SIZE = %@]", @(newTopFontSize)]];
//		NSLog(@"offsetY = %f", offsetY);
//		[vc.headerView.topLabel setFrameOrigin:NSMakePoint(vc.headerView.topLabel.frame.origin.x, vc.headerView.frame.size.height - offsetY)];
//		[vc.headerView.topLabel setNeedsDisplay];
////		[vc.headerView.topLabel display];
//
//		CGFloat newBottomFontSize = round(newTopFontSize * 0.75);
//		NSFont *bottomLabelFont = [NSFont fontWithName:@"DIN-Bold" size:newBottomFontSize];
//		CGFloat bottomLabelFontHeight = [vc.headerView heightOfLabelWithFont:bottomLabelFont];
//		NSLog(@"  Bottom label height = %f", [vc.headerView heightOfLabelWithFont:bottomLabelFont]);
////		CGFloat offsetY = 0.0; // newBottomFontSize * vc.headerView.frame.size.height * 0.0;
//		NSLog(@"New Y = %f", vc.headerView.bottomLabel.frame.origin.y);
////		vc.headerView.bottomLabel.frame = NSMakeRect(vc.headerView.bottomLabel.frame.origin.x, vc.headerView.bottomLabel.frame.origin.y + offsetY, vc.headerView.bottomLabel.frame.size.width, vc.headerView.bottomLabel.frame.size.height);
////		[vc.headerView.bottomLabel setStringValue:[NSString stringWithFormat:@"[BOTTOM NSTEXTFIELD SIZE = %@]", @(newBottomFontSize)]];
//		[vc.headerView.bottomLabel setFont:bottomLabelFont];
////		CGSize *bottomLabelRenderedSize = [vc.headerView.bottomLabel.stringValue sizeWithAttributes:];
//		[vc.headerView.bottomLabel setFrameOrigin:NSMakePoint(vc.headerView.bottomLabel.frame.origin.x, vc.headerView.topLabel.frame.origin.y - (bottomLabelFontHeight * 1.5))];
//		[vc.headerView.bottomLabel setNeedsDisplay];
//
////		[vc.headerView setNeedsDisplay:YES];
////	}
}

/* ========================================================================== */
- (void)adjustFrame {
	[super adjustFrame];

//	NSLog(@"Adjusting frames...");

	AEModuleFFLViewController *vc = _fflViewController;

	[vc.headerView adjustHeaderLabels];
//	vc.headerView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;

//	NSDictionary *newActions = @{@"contents" : [NSNull null], @"bounds" : [NSNull null], @"frame" : [NSNull null], @"position" : [NSNull null]};
//	vc.headerView.layer.actions = newActions;

//	CGFloat viewScale = round(kOutputPixelsV / self.frame.size.height);
//	CGFloat newHeaderWidth = round(self.frame.size.width * viewScale);
//	CGFloat newHeaderHeight = round(self.frame.size.height * viewScale);

//	vc.headerView.frame = self.frame;
//	NSLog(@"New frame size = %@", NSStringFromRect(vc.headerView.frame));
}

///* ========================================================================== */
//- (void)viewDidMoveToWindow {
//	[self adjustFrame];
//}

/* ========================================================================== */
- (void)viewDidMoveToSuperview {
	[self adjustFrame];
}

@end
