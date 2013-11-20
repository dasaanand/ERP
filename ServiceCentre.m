//
//  ServiceCentre.m
//
//  Created by Dasa Anand on 08/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ServiceCentre.h"

@implementation ServiceCentre

@synthesize serviceids,names,address,numbers, where1,where2, addButton, deleteButton,tableView1, serviceid,name,addressC,number;

- (id) init
{
	serviceids = [[NSMutableArray alloc] init];
	names = [[NSMutableArray alloc] init];
	numbers = [[NSMutableArray alloc] init];
	address = [[NSMutableArray alloc] init];
	
	[self reTrace];
	self = [super init];
	return self;	
}

- (int)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [names count];
}


- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(int)row
{	
	if (tableColumn == serviceid) 
		return [serviceids objectAtIndex:row];
	else
	{
		if (tableColumn == name) 
			return [names objectAtIndex:row];
		else
		{
			if (tableColumn == number) 
				return [numbers  objectAtIndex:row];
			else
				return [address objectAtIndex:row];
		}
	}
}
	
- (void)tableViewSelectionDidChange:(NSNotification *)notification 
{
	[self.deleteButton setHidden:0];
}

- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex
{
	int serviceidTemp = [[serviceids objectAtIndex:rowIndex] intValue] ;
	
	if (aTableColumn == name) 
	{
		[names replaceObjectAtIndex:rowIndex withObject:anObject];
	}
	else
	{
		if (aTableColumn == number) 
		{
			[numbers replaceObjectAtIndex:rowIndex withObject:anObject];
		}
		else
		{
			if (aTableColumn == addressC) 
			{
				[address replaceObjectAtIndex:rowIndex withObject:anObject];
			}
		}
	}
	sqlite3_open([[self filePath] UTF8String], &db);
	sqlite3_exec(db, [[NSString stringWithFormat:@"update Service set name = '%@', address = '%@',number = '%@' where service_id = '%i';",[names objectAtIndex:rowIndex], [address objectAtIndex:rowIndex] ,[numbers objectAtIndex:rowIndex],serviceidTemp]UTF8String], NULL, NULL, NULL);
	sqlite3_close(db);
}


- (IBAction) showAllPressed:(id)sender
{	
	[self reTrace];
}

- (IBAction) searchPressed:(id)sender
{
	[self defaultQuery];
}

- (void) reTrace
{
	[serviceids removeAllObjects];
	[names removeAllObjects];
	[numbers removeAllObjects];
	[address removeAllObjects];
	
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from Service;"]UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{	
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSNumber *serviceTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
			NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
			NSString *numberTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 3))];
			NSString *addressTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
			
			[serviceids addObject:serviceTemp];
			[names addObject:nameTemp];
			[numbers addObject:numberTemp];
			[address addObject:addressTemp];
		}
	}
	sqlite3_close(db);
	
	[self.tableView1 reloadData];
	[self.deleteButton setHidden:1];
}

- (void)defaultQuery
{
	[serviceids removeAllObjects];
	[names removeAllObjects];
	[numbers removeAllObjects];
	[address removeAllObjects];
	
	if ([[order1 titleOfSelectedItem] isEqualToString:@""])
	{
		[order1 selectItemWithTitle:@"service_id"];
	}
	
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if ([[where1 stringValue] isEqualToString:@""])
	{
		if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from Service order by %@;",[order1 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
		{	
			while (sqlite3_step(statement) == SQLITE_ROW) 
			{
				NSNumber *serviceTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
				NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
				NSString *numberTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 3))];
				NSString *addressTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
				
				[serviceids addObject:serviceTemp];
				[names addObject:nameTemp];
				[numbers addObject:numberTemp];
				[address addObject:addressTemp];
			}
		}
	}
	else 
	{
		if([[where2 stringValue] isEqualToString:@""])
		{	
			if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from Service where %@ %@ '%@' order by %@",[select1 titleOfSelectedItem], [condition1 titleOfSelectedItem] , [where1 stringValue],[order1 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
			{	
				while (sqlite3_step(statement) == SQLITE_ROW) 
				{
					NSNumber *serviceTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
					NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
					NSString *numberTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 3))];
					NSString *addressTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
					
					[serviceids addObject:serviceTemp];
					[names addObject:nameTemp];
					[numbers addObject:numberTemp];
					[address addObject:addressTemp];
				}
			}
		}
		else
		{
			if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from Service where %@ %@ '%@' %@ %@ %@ '%@' order by %@",[select1 titleOfSelectedItem], [condition1 titleOfSelectedItem] , [where1 stringValue], [option1 titleOfSelectedItem] ,[select2 titleOfSelectedItem], [condition2 titleOfSelectedItem] , [where2 stringValue],[order1 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
			{	
				while (sqlite3_step(statement) == SQLITE_ROW) 
				{
					NSNumber *serviceTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
					NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
					NSString *numberTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 3))];
					NSString *addressTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
					
					[serviceids addObject:serviceTemp];
					[names addObject:nameTemp];
					[numbers addObject:numberTemp];
					[address addObject:addressTemp];
				}
			}			
		}
	}
	sqlite3_close(db);
	[self.tableView1 reloadData];
}
		

- (IBAction) addRow:(id)sender
{		
	sqlite3_open([[self filePath] UTF8String], &db);
	sqlite3_exec(db, [[NSString stringWithFormat:@"insert into Service (name,contact_number,address) values ('xxx',999,'yyy');"]UTF8String], NULL, NULL, NULL);
	sqlite3_close(db);
	[self reTrace];
}

- (IBAction) deleteRow:(id)sender
{
	sqlite3_open([[self filePath] UTF8String], &db);
	sqlite3_exec(db, [[NSString stringWithFormat:@"delete from Service where service_id = '%@';",[serviceids objectAtIndex:[self.tableView1 selectedRow]]] UTF8String], NULL, NULL, NULL);
	sqlite3_close(db);
	[self reTrace];
}


- (NSString *)filePath 
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"erp"];
} 

@end
