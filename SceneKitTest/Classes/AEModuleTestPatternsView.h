//
//  AETestPatternsView.h
//  DataCaster
//
//  Created by Ben Stahl on 2/27/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import "AEModuleView.h"
#import <QuartzCore/QuartzCore.h>

@class AEModuleTestPatternsViewController;

@interface AEModuleTestPatternsView : AEModuleView

// This MUST be a strong reference or this outlet will be nil!
@property (strong) IBOutlet AEModuleTestPatternsViewController *testPatternsController;

@end
