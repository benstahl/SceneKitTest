//
//  AEHeaderView.h
//  SceneKitTest
//
//  Created by Ben Stahl on 2/24/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AEHeaderView : NSView

@property (strong) IBOutlet NSTextField *topLabel;
@property (strong) IBOutlet NSTextField *bottomLabel;

- (void)fadeIn;
- (void)fadeOut;

@end
