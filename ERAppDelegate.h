//
//  ERAppDelegate.h
//  ER
//
//  Created by Dasa Anand on 16/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ERAppDelegate : NSObject  {
    NSWindow *window;
	sqlite3 *db;
	NSString *databaseName;
	NSString *databasePath;
	
}

@property (assign) IBOutlet NSWindow *window;

- (void) checkAndCreateDatabase;
- (NSString *)filePath;

@end
