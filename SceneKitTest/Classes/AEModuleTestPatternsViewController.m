//
//  AEModuleTestPatternsViewController.m
//  imagesCaster
//
//  Created by Ben Stahl on 2/27/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import "AEModuleTestPatternsViewController.h"

@implementation AEModuleTestPatternsViewController

/* ========================================================================== */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

/* ========================================================================== */
- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		self.images = [[NSMutableArray alloc] initWithCapacity:1];

		NSArray *imageURLs = [[NSBundle mainBundle] URLsForResourcesWithExtension:@"png" subdirectory:@"Images"];
		//	NSLog(@"IMAGE URLS = %@", imageURLs);

		//	NSURL *dirURL = [[NSBundle mainBundle] URLForResource:@"Resources/Images" withExtension:nil];
		//
		//    NSDirectoryEnumerator *itr = [[NSFileManager defaultManager] enumeratorAtURL:dirURL includingPropertiesForKeys:[NSArray arrayWithObjects:NSURLLocalizedNameKey, NSURLEffectiveIconKey, NSURLIsDirectoryKey, NSURLTypeIdentifierKey, nil] options:NSDirectoryEnumerationSkipsHiddenFiles | NSDirectoryEnumerationSkipsPackageDescendants | NSDirectoryEnumerationSkipsSubdirectoryDescendants errorHandler:nil];

		for (NSURL *url in imageURLs) {
			if (![[url lastPathComponent] hasPrefix:@"test_pattern"]) { continue; }

			NSLog(@"test pattern found: %@", [url lastPathComponent]);
			NSString *utiValue;
			[url getResourceValue:&utiValue forKey:NSURLTypeIdentifierKey error:nil];

			if (UTTypeConformsTo((__bridge CFStringRef)(utiValue), kUTTypeImage)) {
				NSImage *image = [[NSImage alloc] initWithContentsOfURL:url];
				//			NSLog(@"  Adding image.");
				[self.images addObject:image];
			}
		}

		_imageIndex = 0;
	}
	return self;
}

/* ========================================================================== */
- (void)awakeFromNib {
//	NSLog(@"Images array = %@", _controller.images);
	_picLayer = [CALayer layer];
	_picLayer.contentsGravity = kCAGravityResizeAspectFill;
	_picLayer.frame = self.view.layer.frame;
	if (_images && _images.count > 0) {
		_picLayer.contents = _images[1];
	}
	[self.view.layer insertSublayer:_picLayer atIndex:1];
}

/* ========================================================================== */
- (IBAction)nextPicture:(id)sender {
	NSLog(@"Next picture.");
	if (_imageIndex < _images.count - 1) {
		_picLayer.contents = _images[_imageIndex++];
	}
}

/* ========================================================================== */
- (IBAction)previousPicture:(id)sender {
	NSLog(@"Previous picture.");
	if (_imageIndex > 0) {
		_picLayer.contents = _images[_imageIndex--];
	}
}

@end