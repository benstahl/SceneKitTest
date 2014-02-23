//
//  AEAppDelegate.m
//  SceneKitTest
//
//  Created by Ben Stahl on 2/11/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import "AEAppDelegate.h"

@implementation AEAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application
}

- (void)awakeFromNib {
	self.window.backgroundColor = [NSColor blackColor];
//	_infoView.layer = [CALayer layer];
//    _infoView.wantsLayer = YES;
//
//	CATextLayer *infoLayer = [CATextLayer layer];
//	infoLayer.font = CGFontCreateWithFontName((CFStringRef)@"DIN-Regular");
//	infoLayer.fontSize = 48.0;
//	infoLayer.backgroundColor = [[NSColor blueColor] CGColor];
//	infoLayer.string = [NSString stringWithFormat:@"%@ players\n%@ teams", @(1), @(1)];
//	[_infoView.layer addSublayer:infoLayer];
}

/* ========================================================================== */
- (IBAction)newSetButtonClicked:(id)sender {
//	NSLog(@"Button clicked.");
//	[_sceneView]
}

@end
