//
//  AEModuleFFLView.h
//  DataCaster
//
//  Created by Ben Stahl on 2/27/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AEModuleView.h"

@class AEModuleFFLViewController;

@interface AEModuleFFLView : AEModuleView

// This MUST be a strong reference or this outlet will be nil!
@property (strong) IBOutlet AEModuleFFLViewController *fflViewController;

- (void)adjustHeaderLabels;

@end
