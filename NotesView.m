//
//  NotesView.m
//
//  Created by Dasa Anand on 06/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NotesView.h"

@implementation NotesView

@synthesize notes,window,note;

- (id)init
{
	self = [super init];
	return self;
}

- (IBAction) savePressed:(id)sender
{
	sqlite3_open([[self filePath] UTF8String], &db);
	sqlite3_exec(db, [[NSString stringWithFormat:@"update Notes set TextValue='%@';",[notes stringValue]]UTF8String], NULL, NULL, NULL);	
	sqlite3_close(db);
}

- (IBAction) revertPressed:(id)sender
{
	[self revertToSaved];
}

- (IBAction) loadPressed:(id)sender
{
	int i;
	
	NSOpenPanel* openDlg = [NSOpenPanel openPanel];
	
	[openDlg setCanChooseFiles:YES];
	[openDlg setCanChooseDirectories:YES];
	
	if ( [openDlg runModalForDirectory:nil file:nil] == NSOKButton )
	{
		NSArray* files = [openDlg filenames];
		
		for( i = 0; i < [files count]; i++ )
		{
			NSString* fileName = [files objectAtIndex:i];
			NSData *data;
			NSAttributedString *content;
			
			data = [NSData dataWithContentsOfFile:fileName];
			
			if (!data)
			{
				return;
			}			
			content = [[[NSAttributedString alloc] initWithRTF:data documentAttributes:NULL] autorelease];
			[[note textStorage] setAttributedString: content];
		}
	}
}

- (void) revertToSaved
{
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from Notes;"]UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{	
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSString *notesText = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 0))];
			[notes setStringValue:notesText];
		}
	}
	sqlite3_close(db);
}

- (IBAction) closePressed:(id)sender
{
	[window close];
}


- (NSString *)filePath 
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"erp"];
} 


@end
