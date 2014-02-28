//
//  AEModuleTestPatternsViewController.h
//  DataCaster
//
//  Created by Ben Stahl on 2/27/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AEModuleTestPatternsViewController : NSViewController {
	CALayer *_picLayer;
}

@property (strong) NSMutableArray *images;
@property NSUInteger imageIndex;
@property (weak) IBOutlet NSButton *nextButton;
@property (weak) IBOutlet NSButton *previousButton;

- (IBAction)nextPicture:(id)sender;
- (IBAction)previousPicture:(id)sender;

@end
