//
//  LoginScreen.m
//
//  Created by Dasa Anand on 16/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LoginScreen.h"

@implementation LoginScreen

@synthesize empid, emppassword;

- (id)init
{	
	empid = [[NSMutableArray alloc] init];
	emppassword = [[NSMutableArray alloc] init];
	
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from Employee;"]UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{	
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSNumber *emp_id=[NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
			NSString *emp_password = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 10))];
			[empid addObject:emp_id];
			[emppassword addObject:emp_password];
		}
	}
	
	sqlite3_close(db);	

	return self;
}

- (IBAction)CancelPressed:(id)sender 
{	
	[self close];
}

- (IBAction)LoginPressed:(id)sender 
{	
	if ([[emppassword objectAtIndex:[employeeid intValue]-1] isEqualToString:[password stringValue]]) 
	{
		[self close];
	}
	else
	{
		NSString *question = NSLocalizedString(@"Login Warning", @"Let's verify that I see this question");
		NSString *info = NSLocalizedString(@"Enter the correct password", @"Here is an info");
		NSString *cancelButton = NSLocalizedString(@"Cancel", @"Cancel button title");
		
		NSAlert *alert = [[NSAlert alloc] init];
		[alert setMessageText:question];
		[alert setInformativeText:info];
		[alert addButtonWithTitle:cancelButton];
		
		NSInteger answer = [alert runModal];
		[alert release];
		alert = nil;
	}
}




- (IBAction)ResetPressed:(id)sender 
{
	[employeeid setStringValue:@""];
	[password setStringValue:@""];
}


- (NSString *)filePath 
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"erp"];
} 

@end
