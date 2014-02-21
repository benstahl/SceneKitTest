//
//  AEUtility.m
//  SceneKitTest
//
//  Created by Ben Stahl on 2/19/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import "AEUtility.h"

@implementation AEUtility

/* --- Cast arc4random() result to double, then divide by this to get floating point number 0.0-1.0. --- */
#define ARC4RANDOM_MAX	0x100000000

/* ========================================================================== */
CGFloat AEClampFloat(CGFloat num, CGFloat min, CGFloat max) {
	return fminf(fmaxf(num, min), max);
}

/* ========================================================================== */
NSInteger AERandInt(NSInteger min, NSInteger max) {
	NSCAssert(max >= min, @"Max must be > min.");
	if (min == max) {
		return min;
	}
	return (NSInteger) ((arc4random() % ((max + 1) - min)) + min);
}

/* ========================================================================== */
CGFloat AERandFloat(CGFloat min, CGFloat max) {
	NSCAssert(max >= min, @"Max must be > min.");
	if (min == max) {
		return min;
	}
	return min + ((CGFloat)arc4random() / ARC4RANDOM_MAX) * (max - min);
}

#pragma mark - CSV file parsing

/* ========================================================================== */
+ (NSArray*)linesFromCSVFileNamed:(NSString*)csv skipHeaderLines:(NSUInteger)skipHeaderLines {
	NSString *csvPath = [[NSBundle mainBundle] pathForResource:csv ofType:@"csv"];
	NSAssert1(csvPath, @"CSV file invalid or not found for filename '%@'.", csvPath);
	NSError *error = nil;
	NSString *csvText = [NSString stringWithContentsOfFile:csvPath encoding:NSUTF8StringEncoding error:&error];
	NSArray *lines = [csvText componentsSeparatedByString:@"\n"];
	NSMutableArray *linesMinusHeader = [NSMutableArray arrayWithCapacity:[lines count] - skipHeaderLines];
	NSUInteger skippedHeaderLineCount = 0;
	for (NSString *line in lines) {
		if (skippedHeaderLineCount < skipHeaderLines) {
			skippedHeaderLineCount++;
			continue;
		}
		[linesMinusHeader addObject:line];
	}
	return [NSArray arrayWithArray:linesMinusHeader];
}

#pragma mark - JSON file parsing

/* =============================================================================
 Return an NSDictionary from a JSON file.
 ============================================================================ */
+ (NSDictionary*)dictionaryFromJSONFileNamed:(NSString*)filename {
	NSAssert1(filename, @"JSON base filename '%@' is invalid.", filename);
	NSString *jsonPath = [[NSBundle mainBundle] pathForResource:filename ofType:nil];
	NSAssert1(jsonPath, @"JSON file path invalid or not found for filename '%@'.", jsonPath);
	NSData *fileData = [NSData dataWithContentsOfFile:jsonPath];
	NSAssert1(fileData, @"JSON file data invalid or not found for filename '%@'.", fileData);

	//	NSAssert1([NSJSONSerialization isValidJSONObject:fileData], @"Invalid JSON object.", jsonPath);

	NSError *error = nil;
	NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingAllowFragments error:&error];
	//	NSLog(@"%@", [jsonDict description]);
	return jsonDict;

	return nil;
}

#pragma mark - material

/* ========================================================================== */
+ (void)configureMaterial:(SCNMaterial*)material {
	// Configure all the material properties
    void(^configureMaterialProperty)(SCNMaterialProperty *materialProperty) = ^(SCNMaterialProperty *materialProperty) {
        // Setup a trilinear filtering
        //   this is to reduce the aliasing when minimizing / maximizing the images
        materialProperty.minificationFilter  = SCNLinearFiltering;
        materialProperty.magnificationFilter = SCNLinearFiltering;
        materialProperty.mipFilter           = SCNLinearFiltering;

        // Repeat the texture if necessary
        materialProperty.wrapS = SCNRepeat;
        materialProperty.wrapT = SCNRepeat;
    };

    configureMaterialProperty(material.ambient);
    configureMaterialProperty(material.diffuse);
    configureMaterialProperty(material.specular);
    configureMaterialProperty(material.emission);
    configureMaterialProperty(material.transparent);
    configureMaterialProperty(material.reflective);
    configureMaterialProperty(material.multiply);
    configureMaterialProperty(material.normal);

    // Make the material visible from the two sides - front and back
//	material.doubleSided = YES;
}

#pragma mark - utility

/* ========================================================================== */
// Assumes input like "#00FF00" (#RRGGBB).
+ (NSColor*)colorFromHexString:(NSString*)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [NSColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end
