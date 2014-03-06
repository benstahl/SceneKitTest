//
//  AEFFLMenuView.h
//  DataCaster
//
//  Created by Ben Stahl on 3/5/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class AEButton;

@interface AEFFLMenuView : NSView

@property (weak) IBOutlet AEButton *showCardsButton;
@property (weak) IBOutlet AEButton *exitButton;

@end
