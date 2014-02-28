//
//  AEModuleCollectionViewItem.m
//  DataCaster
//
//  Created by Ben Stahl on 2/28/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import "AEModuleCollectionViewItem.h"

@interface AEModuleCollectionViewItem ()

@end

@implementation AEModuleCollectionViewItem

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

/* ========================================================================== */
- (void)awakeFromNib {
//	self.layer.backgroundColor = [[NSColor darkGrayColor] CGColor];
//	// [[NSColor colorWithHue:0.825 saturation:1.0 brightness:1.0 alpha:1.0] CGColor];
//	self.layer.borderWidth = 2.0;
//	self.layer.borderColor = [[NSColor colorWithHue:0.0 saturation:0.0 brightness:0.75 alpha:1.0] CGColor];
}

/* ========================================================================== */
- (void)setSelected:(BOOL)selected {
//	NSLog(@"X");
	[super setSelected:selected];
//	[(NSView*)[self view] setSelected:selected];
//	[(AEModuleCollectionViewItem*)[self view] setNeedsDisplay:YES];
	//	_selected = selected;
}

///* ========================================================================== */
//- (BOOL)selected {
//	return [super isSelected];
//}

@end
