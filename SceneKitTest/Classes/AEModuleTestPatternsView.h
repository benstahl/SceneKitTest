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

@property (weak) IBOutlet AEModuleTestPatternsViewController *controller;
@property (strong) CALayer *picLayer;

@end
