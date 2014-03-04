//
//  AEHeaderView.h
//  SceneKitTest
//
//  Created by Ben Stahl on 2/24/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>

@interface AEHeaderView : NSView {
	CALayer *_baseLayer;
}

//@property (strong) IBOutlet NSTextField *topLabel;
//@property (strong) IBOutlet NSTextField *bottomLabel;

@property (strong) NSDictionary *topLabelAttributes;

@property (strong) CATextLayer *topLabel;
@property (strong) CATextLayer *bottomLabel;

- (void)adjustHeaderLabels;
- (CGFloat)heightOfLabelWithFont:(NSFont*)font;
- (void)fadeIn;
- (void)fadeOut;

@end
