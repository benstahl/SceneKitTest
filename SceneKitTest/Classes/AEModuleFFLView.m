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
#import "AEHeaderView.h"
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
	self.layer.backgroundColor = [[NSColor colorWithHue:0.0 saturation:1.0 brightness:0.0 alpha:1.0] CGColor];
	self.layer.borderWidth = 0.5;
	self.layer.borderColor = [[NSColor colorWithHue:0.0 saturation:0.0 brightness:1.0 alpha:1.0] CGColor];
}

/* ========================================================================== */
- (void)drawRect:(NSRect)dirtyRect {
	[super drawRect:dirtyRect];

	// Drawing code here.
}

/* ========================================================================== */
- (void)adjustHeaderLabels {
	NSLog(@"Adjusting header labels...");

	AEModuleFFLViewController *vc = _fflViewController;

	CGFloat newTopFontSize = round(vc.headerView.frame.size.height * 0.35);
//	NSApplicationPresentationOptions currentOptions = [NSApp currentSystemPresentationOptions];
//	if (currentOptions &= NSApplicationPresentationFullScreen) {
//		NSLog(@"Full screen = YES");
//		newTopFontSize *= 2.0;
//	} else {
//		NSLog(@"Full screen = NO");
//	}

	NSLog(@"  Header view frame = %@", NSStringFromRect(vc.headerView.frame));
	NSLog(@"  Old top label font size = %@, new size = %@", @(vc.headerView.topLabel.font.pointSize), @(newTopFontSize));

	if (newTopFontSize != vc.headerView.topLabel.font.pointSize) {
		NSLog(@"  Resizing fonts...");
		//		vc.headerView.topLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(vc.headerView.frame.origin.x, vc.headerView.frame.origin.y, vc.headerView.frame.size.width, vc.headerView.frame.size.height * 0.65)];
		NSFont *topLabelFont = [NSFont fontWithName:@"DIN-Bold" size:newTopFontSize];
		[vc.headerView.topLabel setFont:topLabelFont];
		NSLog(@"    New top label font size = %@", @(vc.headerView.topLabel.font.pointSize));
		//		[vc.headerView.topLabel setStringValue:[NSString stringWithFormat:@"[TOP NSTEXTFIELD SIZE = %@]", @(newTopFontSize)]];
		[vc.headerView.topLabel setNeedsDisplay];
		//		[vc.headerView.topLabel display];

		CGFloat newBottomFontSize = round(newTopFontSize * 0.75);
//		CGFloat offsetY = newBottomFontSize * 1.0;
		NSFont *bottomLabelFont = [NSFont fontWithName:@"DIN-Bold" size:newBottomFontSize];
//		vc.headerView.bottomLabel.frame = NSMakeRect(vc.headerView.bottomLabel.frame.origin.x, vc.headerView.topLabel.frame.origin.y - offsetY, vc.headerView.bottomLabel.frame.size.width, vc.headerView.bottomLabel.frame.size.height);
		//		[vc.headerView.bottomLabel setStringValue:[NSString stringWithFormat:@"[BOTTOM NSTEXTFIELD SIZE = %@]", @(newBottomFontSize)]];
		[vc.headerView.bottomLabel setFont:bottomLabelFont];
		[vc.headerView.bottomLabel setNeedsDisplay];

		[vc.headerView setNeedsDisplay:YES];
	}
}

/* ========================================================================== */
- (void)adjustFrame {
	[super adjustFrame];

//	NSLog(@"Adjusting frames...");

//	AEModuleFFLViewController *vc = _fflViewController;

	[self adjustHeaderLabels];
//	vc.headerView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;

//	NSDictionary *newActions = @{@"contents" : [NSNull null], @"bounds" : [NSNull null], @"frame" : [NSNull null], @"position" : [NSNull null]};
//	vc.headerView.layer.actions = newActions;

//	CGFloat viewScale = round(kOutputPixelsV / self.frame.size.height);
//	CGFloat newHeaderWidth = round(self.frame.size.width * viewScale);
//	CGFloat newHeaderHeight = round(self.frame.size.height * viewScale);

}

///* ========================================================================== */
//- (void)viewDidMoveToWindow {
//	[self adjustFrame];
//}

/* ========================================================================== */
- (void)viewDidMoveToSuperview {
	[self adjustFrame];
}

///* ========================================================================== */
//- (void)viewWillDraw {
//	[self adjustFrame];
//}

@end
