//
//  AEModule.h
//  SceneKitTest
//
//  Created by Ben Stahl on 2/24/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AEModule : NSObject

@property (copy) NSString *moduleDisplayName;
@property (copy) NSString *moduleXibName;
@property (strong) NSImage *modulePreviewImage;

@end
