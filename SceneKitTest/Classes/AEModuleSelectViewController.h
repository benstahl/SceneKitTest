//
//  AEModuleSelectViewController.h
//  DataCaster
//
//  Created by Ben Stahl on 2/26/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class AEModule;

@interface AEModuleSelectViewController : NSViewController

@property (strong) NSMutableArray *modules;
@property (assign) IBOutlet NSArrayController *modulesArrayController;

-(void)insertObject:(AEModule*)module inModulesAtIndex:(NSUInteger)index;
-(void)removeObjectFromModulesAtIndex:(NSUInteger)index;
-(void)setModules:(NSMutableArray*)a;
-(NSMutableArray*)modules;

- (IBAction)launchModuleButtonClicked:(id)sender;

@end
