//
//  AEModuleFFLViewController.m
//  SceneKitTest
//
//  Created by Ben Stahl on 2/24/14.
//  Copyright (c) 2014 App Easel. All rights reserved.
//

#import "AEModuleFFLViewController.h"
#import "AEModuleFFLView.h"
#import "AEFFLSceneView.h"
#import "AEHeaderView.h"
#import "AEPlayer.h"
#import "AETeam.h"
#import "AEUtility.h"
#import "CHCSVParser.h"

#define kMasterKey	@"ID"

@interface AEModuleFFLViewController ()

@end

@implementation AEModuleFFLViewController

/* ========================================================================== */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	NSLog(@"FFL View Controller initWithNibName:%@ bundle:", nibNameOrNil);

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

/* ========================================================================== */
- (id)initWithCoder:(NSCoder *)aDecoder {
	NSLog(@"FFL View Controller initWithCoder:");
	if (self = [super initWithCoder:aDecoder]) {
		_currentParserLine = 0;

		_validPlayerPositions = @[@"QB", @"WR", @"RB", @"TE", @"K"];
		_playerIDPool = @[@"nfl.p.2914", @"nfl.p.3116", @"nfl.p.3511", @"nfl.p.3664", @"nfl.p.4262", @"nfl.p.4269", @"nfl.p.4653", @"nfl.p.4659", @"nfl.p.4878", @"nfl.p.4695", @"nfl.p.5034", @"nfl.p.5036", @"nfl.p.5104", @"nfl.p.5228", @"nfl.p.5388", @"nfl.p.5474", @"nfl.p.5482", @"nfl.p.5521", @"nfl.p.5652", @"nfl.p.5557", @"nfl.p.5900", @"nfl.p.5919", @"nfl.p.5922", @"nfl.p.6046", @"nfl.p.6103", @"nfl.p.6119", @"nfl.p.6142", @"nfl.p.6169", @"nfl.p.6353", @"nfl.p.6355", @"nfl.p.6359", @"nfl.p.6410", @"nfl.p.6427", @"nfl.p.6475", @"nfl.p.6479", @"nfl.p.6492", @"nfl.p.6591", @"nfl.p.6669", @"nfl.p.6752", @"nfl.p.6788", @"nfl.p.6802", @"nfl.p.6824", @"nfl.p.6827", @"nfl.p.6837", @"nfl.p.6840", @"nfl.p.6845", @"nfl.p.6867", @"nfl.p.6913", @"nfl.p.6994", @"nfl.p.7073", @"nfl.p.7108", @"nfl.p.7149", @"nfl.p.7178", @"nfl.p.7179", @"nfl.p.7200", @"nfl.p.7203", @"nfl.p.7215", @"nfl.p.7237", @"nfl.p.7241", @"nfl.p.7247", @"nfl.p.7253", @"nfl.p.7259", @"nfl.p.7282", @"nfl.p.7306", @"nfl.p.7406", @"nfl.p.7426", @"nfl.p.7434", @"nfl.p.7492", @"nfl.p.7527", @"nfl.p.7544", @"nfl.p.7635", @"nfl.p.7657", @"nfl.p.7776", @"nfl.p.7777", @"nfl.p.7802", @"nfl.p.7809", @"nfl.p.7810", @"nfl.p.7821", @"nfl.p.7858", @"nfl.p.7860", @"nfl.p.7868", @"nfl.p.7879", @"nfl.p.7894", @"nfl.p.7904", @"nfl.p.8021", @"nfl.p.8063", @"nfl.p.8177", @"nfl.p.8255", @"nfl.p.8256", @"nfl.p.8261", @"nfl.p.8263", @"nfl.p.8266", @"nfl.p.8276", @"nfl.p.8277", @"nfl.p.8281", @"nfl.p.8285", @"nfl.p.8286", @"nfl.p.8292", @"nfl.p.8298", @"nfl.p.8306", @"nfl.p.8317", @"nfl.p.8327", @"nfl.p.8330", @"nfl.p.8331", @"nfl.p.8346", @"nfl.p.8354", @"nfl.p.8391", @"nfl.p.8396", @"nfl.p.8407", @"nfl.p.8409", @"nfl.p.8416", @"nfl.p.8432", @"nfl.p.8447", @"nfl.p.8471", @"nfl.p.8482", @"nfl.p.8504", @"nfl.p.8561", @"nfl.p.8780", @"nfl.p.8781", @"nfl.p.8790", @"nfl.p.8795", @"nfl.p.8800", @"nfl.p.8801", @"nfl.p.8807", @"nfl.p.8810", @"nfl.p.8813", @"nfl.p.8815", @"nfl.p.8819", @"nfl.p.8821", @"nfl.p.8826", @"nfl.p.8850", @"nfl.p.8866", @"nfl.p.8868", @"nfl.p.8872", @"nfl.p.8926", @"nfl.p.8935", @"nfl.p.8951", @"nfl.p.8979", @"nfl.p.8981", @"nfl.p.8982", @"nfl.p.9004", @"nfl.p.9030", @"nfl.p.9037", @"nfl.p.9039", @"nfl.p.9126", @"nfl.p.9265", @"nfl.p.9271", @"nfl.p.9274", @"nfl.p.9284", @"nfl.p.9293", @"nfl.p.9294", @"nfl.p.9295", @"nfl.p.9314", @"nfl.p.9348", @"nfl.p.9404", @"nfl.p.9496", @"nfl.p.9497"];

		_players = [NSMutableDictionary dictionary];
		_teams = [NSMutableDictionary dictionary];
		[self initPlayersFromCSVFileWithBaseFilenames:@[@"ffl_2009_players"]];
		[self initTeamsFromCSVFileWithBaseFilenames:@[@"ffl_2009_teams", @"ffl_2009_teams_supplemental"]];

//		[self deleteImagesNotInDatabase];
	}
	return self;
}

/* ========================================================================== */
- (void)awakeFromNib {
	NSLog(@"FFL Module View Controller awakeFromNib:");
//	_headerView = [[AEHeaderView alloc] init];
//	[self.view addSubview:_headerView];
//	_headerView.frame = self.view.frame;
	[((AEModuleFFLView*)self.view) adjustHeaderLabels];
//	[_headerView adjustHeaderLabels];
}

/* ========================================================================== */
- (void)deleteImagesNotInDatabase {
	NSString *path = [[@"~/Dropbox/Ben Dropbox/Developer/Code/SceneKitTest/SceneKitTest/Resources/PC Headshots" stringByExpandingTildeInPath] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

	NSLog(@"Path = %@", path);
	NSURL *headshotsFolderURL = [NSURL URLWithString:path];
//	NSArray *imageURLs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath: error:&error];

	NSError *error = nil;
	NSArray *imageURLs = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:headshotsFolderURL includingPropertiesForKeys:@[NSURLLocalizedNameKey] options:NSDirectoryEnumerationSkipsHiddenFiles | NSDirectoryEnumerationSkipsPackageDescendants | NSDirectoryEnumerationSkipsSubdirectoryDescendants error:&error];

	if (!error) {
		NSLog(@"Found %@ files to check.", @(imageURLs.count));
		NSLog(@"URLs = %@", imageURLs);

		NSUInteger notFoundCount = 0;
		NSUInteger foundCount = 0;
		for (NSURL *url in imageURLs) {
			if (![[url lastPathComponent] hasPrefix:@"nfl.p."]) { continue; }

			NSString *baseFilename = [[url lastPathComponent] stringByDeletingPathExtension];
			NSLog(@"Player image found: %@", baseFilename);
			NSString *utiValue;
			[url getResourceValue:&utiValue forKey:NSURLTypeIdentifierKey error:nil];

			if ([_playerIDPool containsObject:baseFilename]) {
				NSLog(@"-----> Found matching player pool entry for %@", baseFilename);
				foundCount++;
			} else {
				NSLog(@"Did not find matching player pool entry for %@ ***REMOVING***", baseFilename);
				NSError *removeError = nil;
				[[NSFileManager defaultManager] removeItemAtURL:url error:&removeError];
				if (error) {
					NSLog(@"  Error removing file %@", [url path]);
				} else {
					NSLog(@"  Successfully removed file %@", [url path]);
					notFoundCount++;
				}
				//		if (UTTypeConformsTo((__bridge CFStringRef)(utiValue), kUTTypeImage)) {
				//			NSImage *image = [[NSImage alloc] initWithContentsOfURL:url];
				//			[self.images addObject:image];
			}
		}
		NSLog(@"Found %@/%@ player images not in player pool (matching = %@).", @(notFoundCount), @(_playerIDPool.count), @(foundCount));
	}
}

#pragma mark - controls

/* ========================================================================== */
- (IBAction)showCardsButtonClicked:(id)sender {
//	NSLog(@"Button clicked (view controller).");
	[_sceneView showCardsButtonClicked:sender];
}

/* ========================================================================== */
- (IBAction)exitButtonClicked:(id)sender {
//	NSLog(@"Exit button clicked (view controller).");

//	[self launchModuleNamed:@"AEModuleSelect"];

	[[NSApp delegate] performSelector:@selector(launchModuleNamed:) withObject:@"AEModuleSelect"];
}

#pragma mark - convenience

/* ========================================================================== */
- (AEPlayer*)playerWithID:(NSString*)playerID {
	return _players[playerID];
}

/* ========================================================================== */
- (AETeam*)teamWithID:(NSString*)teamID {
	return _teams[teamID];
}

#pragma mark - data files

/* ========================================================================== */
- (void)initPlayersFromCSVFileWithBaseFilenames:(NSArray*)filenames {
	for (NSString *filename in filenames) {
		NSString *filePath = [[[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"Data/%@", filename] withExtension:@"csv"] path];
		//		NSLog(@"Player CSV file path = %@", filePath);
		CHCSVParser *parser = [[CHCSVParser alloc] initWithContentsOfCSVFile:filePath];
		_playerParser = parser;
		parser.sanitizesFields = YES;
		parser.stripsLeadingAndTrailingWhitespace = YES;
		parser.delegate = self;
		[parser parse];
	}

	NSLog(@"%@ players found.", @(_players.allKeys.count));

	//	for (NSString *key in [_players allKeys]) {
	//		AEPlayer *p = _players[key];
	////		NSLog(@"Player with key %@ = %@", key, p.data);
	//		NSString *headshotFilePath = [[[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"PC Headshots/%@", p.data[@"ID"]] withExtension:@"png"] path];
	//		//	NSLog(@"Attempting to load image %@", filePath);
	////		NSImage *headshotImage = [[NSImage alloc] initWithContentsOfFile:headshotFilePath];
	//		if (![[NSFileManager defaultManager] fileExistsAtPath:headshotFilePath]) {
	//			NSLog(@"*** Player headshot image for %@ not found.", p.data[@"ID"]);
	//		}
	//	}
}

/* ========================================================================== */
- (void)initTeamsFromCSVFileWithBaseFilenames:(NSArray*)filenames {
	for (NSString *filename in filenames) {
		//		NSString *filePath = [[[NSBundle mainBundle] URLForResource:filename withExtension:@"csv"] path];
		NSString *filePath = [[[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"Data/%@", filename] withExtension:@"csv"] path];
		//		NSLog(@"File path = %@", filePath);
		CHCSVParser *parser = [[CHCSVParser alloc] initWithContentsOfCSVFile:filePath];
		_teamParser = parser;
		parser.sanitizesFields = YES;
		parser.stripsLeadingAndTrailingWhitespace = YES;
		parser.delegate = self;
		[parser parse];
	}

	NSLog(@"%@ teams found.", @(_teams.allKeys.count));

	//	for (NSString *key in [_teams allKeys]) {
	//		AEPlayer *t = _teams[key];
	//		NSLog(@"%@", t.data);
	//	}
}

#pragma mark- CHCSVParserDelegate

/* ========================================================================== */
- (void)parser:(CHCSVParser *)parser didBeginLine:(NSUInteger)recordNumber {
	//	NSLog(@"parser:DidBeginLine: %@", @(recordNumber));
	if (parser == _playerParser) {
		_currentParsingPlayerData = [NSMutableDictionary dictionary];
	} else if (parser == _teamParser) {
		_currentParsingTeamData = [NSMutableDictionary dictionary];
	}
	_currentParserLine = recordNumber;
}

/* ========================================================================== */
- (void)parser:(CHCSVParser *)parser didEndLine:(NSUInteger)recordNumber {
	//	NSLog(@"parser:DidEndLine: %@", @(recordNumber));

	if (_currentParserLine == 1) {
		//		NSLog(@"Player keys = %@", _playerKeys);
		return;
	}

	if (parser == _playerParser) {
		NSString *playerID = _currentParsingPlayerData[kMasterKey];
		AEPlayer *player = _players[playerID];
		if (player) {
			NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:player.data];
			[d addEntriesFromDictionary:_currentParsingPlayerData];
			player.data = [NSDictionary dictionaryWithDictionary:d];
		} else {
			player = [[AEPlayer alloc] init];
			player.data = [NSDictionary dictionaryWithDictionary:_currentParsingPlayerData];
			//			NSLog(@"Set player data %@", player.data);
			[_players setObject:player forKey:playerID];
		}
		_currentParsingPlayerData = nil;
	} else if (parser == _teamParser) {
		NSString *teamID = _currentParsingTeamData[kMasterKey];
		AETeam *team = _teams[teamID];
		if (team) {
			NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:team.data];
			[d addEntriesFromDictionary:_currentParsingTeamData];
			team.data = [NSDictionary dictionaryWithDictionary:d];
		} else {
			team = [[AETeam alloc] init];
			team.data = [NSDictionary dictionaryWithDictionary:_currentParsingTeamData];
			//			NSLog(@"Set team data %@", team.data);
			[_teams setObject:team forKey:teamID];
		}
		_currentParsingTeamData = nil;
	}
}

/* ========================================================================== */
- (void)parserDidBeginDocument:(CHCSVParser *)parser {
	//	NSLog(@"parserDidBeginDocument:");
	_currentParserLine = 0;
	if (parser == _playerParser) {
		_playerKeys = [NSMutableArray array];
	} else if (parser == _teamParser) {
		_teamKeys = [NSMutableArray array];
	}
}

/* ========================================================================== */
- (void)parserDidEndDocument:(CHCSVParser *)parser {
	//	NSLog(@"parserDidEndDocument:");
	if (parser == _playerParser) {
		_playerKeys = nil;
	} else if (parser == _teamParser) {
		_teamKeys = nil;
	}
}

/* ========================================================================== */
- (void)parser:(CHCSVParser *)parser didReadField:(NSString *)field atIndex:(NSInteger)fieldIndex {
	//	NSLog(@"parser:didReadField: %@ atIndex: %@", field, @(fieldIndex));
	// Skip over header (CHCSVParser line numbers are 1-based).
	if (_currentParserLine == 1) {
		if (parser == _playerParser) {
			[_playerKeys addObject:field];
		} else if (parser == _teamParser) {
			[_teamKeys addObject:field];
		}
		//		NSLog(@"Adding field %@, %@ player keys found.", field, @(_playerKeys.count));
		return;
	}

	if (parser == _playerParser) {
		[_currentParsingPlayerData setValue:field forKey:_playerKeys[fieldIndex]];
	} else if (parser == _teamParser) {
		[_currentParsingTeamData setValue:field forKey:_teamKeys[fieldIndex]];
	}
}

/* ========================================================================== */
- (void)parser:(CHCSVParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	//	NSLog(@"parser:didStartElement: %@ namespaceURI: %@ qualifiedName: %@ attributes: %@", elementName, namespaceURI, qName, attributeDict);
}

/* ========================================================================== */
- (void)parser:(CHCSVParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	//	NSLog(@"parser:didEndElement: %@ namespaceURI: %@ qualifiedName: %@", elementName, namespaceURI, qName);
}

@end
