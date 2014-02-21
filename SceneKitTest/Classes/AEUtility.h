//
//  AEUtility.h
//  SceneKitTest
//
//  Created by Ben Stahl on 2/19/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SceneKit/SceneKit.h>

@class SCNMaterial;

@interface AEUtility : NSObject

CGFloat AEClampFloat(CGFloat num, CGFloat min, CGFloat max);
NSInteger AERandInt(NSInteger min, NSInteger max);
CGFloat AERandFloat(CGFloat minimum, CGFloat maximum);

+ (NSArray*)linesFromCSVFileNamed:(NSString*)csv skipHeaderLines:(NSUInteger)skipHeaderLines;
+ (NSDictionary*)dictionaryFromJSONFileNamed:(NSString*)filename;
+ (void)configureMaterial:(SCNMaterial*)material;
+ (NSColor*)colorFromHexString:(NSString*)hexString;

@end
