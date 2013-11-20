//
//  ThingsToDo.m
//
//  Created by Dasa Anand on 06/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ThingsToDo.h"

@implementation ThingsToDo

@synthesize addButton, deleteButton, tableView1, date, thingsToDo, dates, things, invoiceno, invoicenos, where1;

 - (id)init
{
	dates = [[NSMutableArray alloc] init];
	things = [[NSMutableArray alloc] init];
	invoicenos = [[NSMutableArray alloc] init];
	
	return self;
}


- (int)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [dates count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(int)row
{	
	if (tableColumn == date)
	{
		return [dates objectAtIndex:row];
	}
	else
	{
		if (tableColumn == thingsToDo)
		{
			return [things objectAtIndex:row];
		}
		else
		{
			return [invoicenos objectAtIndex:row];
		}
	}
}


- (void)tableViewSelectionDidChange:(NSNotification *)notification 
{
	[self.deleteButton setHidden:0];
}


- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex
{
	NSNumber *invoicesTemp = [invoicenos objectAtIndex:rowIndex];
	NSString *datesTemp = [[NSString alloc] initWithString:[dates objectAtIndex:rowIndex]];
	NSString *thingsTemp = [[NSString alloc] initWithString:[things objectAtIndex:rowIndex]];
	
	if (aTableColumn == date)
	{
		[dates replaceObjectAtIndex:rowIndex withObject:anObject];
	}
	else
	{
		if (aTableColumn == invoiceno)
		{
			[invoicenos replaceObjectAtIndex:rowIndex withObject:anObject];
		}
		else
		{
			[things replaceObjectAtIndex:rowIndex withObject:anObject];
		}
	}
	
	sqlite3_open([[self filePath] UTF8String], &db);
	if (option == 1)
	{
		sqlite3_exec(db, [[NSString stringWithFormat:@"update SalesRemember set sin_no = '%@', dates = '%@', things_to_do = '%@' where sin_no = '%@' and dates = '%@' and things_to_do = '%@';",[invoicenos objectAtIndex:rowIndex], [dates objectAtIndex:rowIndex], [things objectAtIndex:rowIndex],invoicesTemp, datesTemp, thingsTemp]UTF8String], NULL, NULL, NULL);
	}
	else
	{
		sqlite3_exec(db, [[NSString stringWithFormat:@"update PurchaseRemember set sin_no = '%@', dates = '%@', things_to_do = '%@' where sin_no = '%@' and dates = '%@' and things_to_do = '%@';",[invoicenos objectAtIndex:rowIndex], [dates objectAtIndex:rowIndex], [things objectAtIndex:rowIndex],invoicesTemp, datesTemp, thingsTemp]UTF8String], NULL, NULL, NULL);
	}
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
	[invoicenos removeAllObjects];
	[dates removeAllObjects];
	[things removeAllObjects];
	
	if (option == 0)
	{
		sqlite3_stmt *statement;
		sqlite3_open([[self filePath] UTF8String], &db);
		
		if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from PurchaseRemember;"]UTF8String], -1, &statement, NULL) == SQLITE_OK)
		{	
			while (sqlite3_step(statement) == SQLITE_ROW) 
			{
				NSNumber *invoicesTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
				NSString *datesTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
				NSString *thingsTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
				
				[invoicenos addObject:invoicesTemp];
				[dates addObject:datesTemp];
				[things addObject:thingsTemp];
			}
		}
		sqlite3_close(db);
	}
	else
	{
		sqlite3_stmt *statement;
		sqlite3_open([[self filePath] UTF8String], &db);
		if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from SalesRemember;"]UTF8String], -1, &statement, NULL) == SQLITE_OK)
		{	
			while (sqlite3_step(statement) == SQLITE_ROW) 
			{
				NSNumber *invoicesTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
				NSString *datesTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
				NSString *thingsTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
				
				[invoicenos addObject:invoicesTemp];
				[dates addObject:datesTemp];
				[things addObject:thingsTemp];
			}
		}
		sqlite3_close(db);
	}
	[tableView1 reloadData];
	[self.deleteButton setHidden:1];
}


- (void)defaultQuery
{
	[invoicenos removeAllObjects];
	[dates removeAllObjects];
	[things removeAllObjects];
	[tableView1 reloadData];
	
	if ([[order1 titleOfSelectedItem] isEqualToString:@""])
	{
		[order1 selectItemWithTitle:@"dates"];
	}

	
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if ([[where1 stringValue] isEqualToString:@""])
	{
		if (option == 1)
		{
			if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from SalesRemember order by %@;",[order1 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
			{	
				while (sqlite3_step(statement) == SQLITE_ROW) 
				{
					NSNumber *invoicesTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
					NSString *datesTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
					NSString *thingsTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
					
					[invoicenos addObject:invoicesTemp];
					[dates addObject:datesTemp];
					[things addObject:thingsTemp];
				}
			}	
		}
		else
		{
			if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from PurchaseRemember order by %@;",[order1 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
			{	
				while (sqlite3_step(statement) == SQLITE_ROW) 
				{
					NSNumber *invoicesTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
					NSString *datesTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
					NSString *thingsTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
					
					[invoicenos addObject:invoicesTemp];
					[dates addObject:datesTemp];
					[things addObject:thingsTemp];
				}
			}
		}
	}
	else
	{
		if (![[select1 titleOfSelectedItem] isEqualToString:@""]) 
		{	
			if (option == 1)
			{
				if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from SalesRemember where %@ %@ '%@' order by %@;",[select1 titleOfSelectedItem], [condition1 titleOfSelectedItem] , [where1 stringValue],[order1 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
				{	
					while (sqlite3_step(statement) == SQLITE_ROW) 
					{
						NSNumber *invoicesTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
						NSString *datesTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
						NSString *thingsTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
						
						[invoicenos addObject:invoicesTemp];
						[dates addObject:datesTemp];
						[things addObject:thingsTemp];
					}
				}	
			}
			else
			{
				if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from PurchaseRemember where %@ %@ '%@' order by %@",[select1 titleOfSelectedItem], [condition1 titleOfSelectedItem] , [where1 stringValue],[order1 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
				{	
					while (sqlite3_step(statement) == SQLITE_ROW) 
					{
						NSNumber *invoicesTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
						NSString *datesTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
						NSString *thingsTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
						
						[invoicenos addObject:invoicesTemp];
						[dates addObject:datesTemp];
						[things addObject:thingsTemp];
					}
				}
			}
		}
	}
	sqlite3_close(db);
	[self.tableView1 reloadData];
}

// things to do wrt purchase invoices
- (IBAction) purchasedPressed:(id)sender
{
	option = 0;
	[self reTrace];
}

// things to do wrt sales invoice
- (IBAction) salesPressed:(id)sender
{
	option = 1;
	[self reTrace];
}

- (IBAction) addRow:(id)sender
{
	[invoicenos addObject:@"999"];
	[dates addObject:@"new"];
	[things addObject:@"new"];
	
	sqlite3_open([[self filePath] UTF8String], &db);
	if (option == 1)
	{
		sqlite3_exec(db, [[NSString stringWithFormat:@"insert into SalesRemember values('999','new','new');"]UTF8String], NULL, NULL, NULL);
	}
	else
	{
		sqlite3_exec(db, [[NSString stringWithFormat:@"insert into PurchaseRemember values('999','new','new');"]UTF8String], NULL, NULL, NULL);
	}

	sqlite3_close(db);
	[self.tableView1 reloadData];
}


- (IBAction) deleteRow:(id)sender
{
	sqlite3_open([[self filePath] UTF8String], &db);
	if (option == 1)
	{
			sqlite3_exec(db, [[NSString stringWithFormat:@"delete from SalesRemember where sin_no = '%@' and dates = '%@' and things_to_do = '%@';",[invoicenos objectAtIndex:[self.tableView1 selectedRow]], [dates objectAtIndex:[self.tableView1 selectedRow]], [things objectAtIndex:[self.tableView1 selectedRow]]]UTF8String], NULL, NULL, NULL);
	}
	else
	{
			sqlite3_exec(db, [[NSString stringWithFormat:@"delete from PurchaseRemember where sin_no = '%@' and dates = '%@' and things_to_do = '%@';",[invoicenos objectAtIndex:[self.tableView1 selectedRow]], [dates objectAtIndex:[self.tableView1 selectedRow]], [things objectAtIndex:[self.tableView1 selectedRow]]]UTF8String], NULL, NULL, NULL);
	}
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
