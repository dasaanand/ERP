//
//  Company.m
//
//  Created by Dasa Anand on 08/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Company.h"

@implementation Company
@synthesize companyids,names,address,numbers, where1,where2, addButton, deleteButton,tableView1, companyid,name,addressC,number,serviceC, servicenames2,serviceids,serviceids2,serviceC2,servicenameC2,tableView2;


- (id) init
{
	companyids = [[NSMutableArray alloc] init];
	names = [[NSMutableArray alloc] init];
	numbers = [[NSMutableArray alloc] init];
	address = [[NSMutableArray alloc] init];
	serviceids = [[NSMutableArray alloc] init];
	servicenames2 = [[NSMutableArray alloc] init];
	serviceids2 = [[NSMutableArray alloc] init];
	
	
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select service_id,name from Service;"]UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{	
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSNumber *idTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
			NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
			
			[serviceids2 addObject:idTemp];
			[servicenames2 addObject:nameTemp];
		}
	}
	sqlite3_close(db);
	
	[self reTrace];
	
	self = [super init];
	return self;	
}

- (int)numberOfRowsInTableView:(NSTableView *)tableView
{
	if (tableView == tableView1)
	{
		return [names count];
	}
	else
	{
		return [serviceids2 count];
	}
}


- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(int)row
{	
	if (tableView == tableView1)
	{
		if (tableColumn == companyid) 
			return [companyids objectAtIndex:row];
		else
		{
			if (tableColumn == name) 
				return [names objectAtIndex:row];
			else
			{
				if (tableColumn == number) 
					return [numbers  objectAtIndex:row];
				else
				{
					if (tableColumn == serviceC)
					{
						return [serviceids objectAtIndex:row];
					}
					else
					{
						return [address objectAtIndex:row];
					}
				}			
			}
		}
	}
	else
	{
		if (tableColumn == serviceC2) 
			return [serviceids2 objectAtIndex:row];
		else
		{
			return [servicenames2 objectAtIndex:row];
		}
	}
}


- (void)tableViewSelectionDidChange:(NSNotification *)notification 
{
	[self.deleteButton setHidden:0];
}

- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex
{
	if (aTableView == tableView1)
	{
		int companyidTemp = [[companyids objectAtIndex:rowIndex] intValue] ;
		
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
				else
				{
					if (aTableColumn == serviceC)
					{
						[serviceids replaceObjectAtIndex:rowIndex withObject:anObject];
					}
				}

			}
		}
		
		if (aTableColumn != serviceC)
		{
			sqlite3_open([[self filePath] UTF8String], &db);
			sqlite3_exec(db, [[NSString stringWithFormat:@"update Company set name = '%@', address = '%@',number = '%@' where company_id = '%i';",[names objectAtIndex:rowIndex], [address objectAtIndex:rowIndex] ,[numbers objectAtIndex:rowIndex],companyidTemp]UTF8String], NULL, NULL, NULL);
			sqlite3_close(db);
		}
		else
		{
			sqlite3_open([[self filePath] UTF8String], &db);
			sqlite3_exec(db, [[NSString stringWithFormat:@"update ServiceCentre set service_id = '%i' where company_id = '%i';",[[serviceids objectAtIndex:rowIndex] intValue] ,companyidTemp]UTF8String], NULL, NULL, NULL);
			sqlite3_close(db);
		}
	}
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
	[companyids removeAllObjects];
	[names removeAllObjects];
	[numbers removeAllObjects];
	[address removeAllObjects];
	[serviceids removeAllObjects];
	
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from Company as a, ServiceCentre as b where a.company_id=b.company_id;"]UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{	
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSNumber *companyTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
			NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
			NSString *numberTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 3))];
			NSString *addressTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
			NSString *idTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 5))];
			
			[companyids addObject:companyTemp];
			[names addObject:nameTemp];
			[numbers addObject:numberTemp];
			[address addObject:addressTemp];
			[serviceids addObject:idTemp];
		}
	}
	sqlite3_close(db);
	
	[self.tableView1 reloadData];
	[self.deleteButton setHidden:1];
}

- (void)defaultQuery
{
	[companyids removeAllObjects];
	[names removeAllObjects];
	[numbers removeAllObjects];
	[address removeAllObjects];
	
	if ([[order1 titleOfSelectedItem] isEqualToString:@""])
	{
		[order1 selectItemWithTitle:@"company_id"];
	}
	
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if ([[where1 stringValue] isEqualToString:@""])
	{
		if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from Company as a, ServiceCentre as b where a.company_id=b.company_id order by a.%@;",[order1 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
		{	
			while (sqlite3_step(statement) == SQLITE_ROW) 
			{
				NSNumber *companyTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
				NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
				NSString *numberTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 3))];
				NSString *addressTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
				
				[companyids addObject:companyTemp];
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
			if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from Company as a, ServiceCentre as b where a.company_id=b.company_id and a.%@ %@ '%@' order by a.%@",[select1 titleOfSelectedItem], [condition1 titleOfSelectedItem] , [where1 stringValue],[order1 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
			{	
				while (sqlite3_step(statement) == SQLITE_ROW) 
				{
					NSNumber *companyTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
					NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
					NSString *numberTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 3))];
					NSString *addressTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
					
					[companyids addObject:companyTemp];
					[names addObject:nameTemp];
					[numbers addObject:numberTemp];
					[address addObject:addressTemp];
				}
			}
		}
		else
		{
			if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from Company as a, ServiceCentre as b where a.company_id=b.company_id and  a.%@ %@ '%@' %@ a.%@ %@ '%@' order by a.%@",[select1 titleOfSelectedItem], [condition1 titleOfSelectedItem] , [where1 stringValue], [option1 titleOfSelectedItem] ,[select2 titleOfSelectedItem], [condition2 titleOfSelectedItem] , [where2 stringValue],[order1 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
			{	
				while (sqlite3_step(statement) == SQLITE_ROW) 
				{
					NSNumber *companyTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
					NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
					NSString *numberTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 3))];
					NSString *addressTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
					
					[companyids addObject:companyTemp];
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
	int idComp;
	sqlite3_open([[self filePath] UTF8String], &db);
	sqlite3_exec(db, [[NSString stringWithFormat:@"insert into Company (name,contact_no,address) values ('xxx',999,'yyy');"]UTF8String], NULL, NULL, NULL);
	sqlite3_stmt *statement;
	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from Company order by company_id;"]UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{	
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSNumber *companyTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
			idComp = [companyTemp intValue];
		}
	}
	sqlite3_exec(db, [[NSString stringWithFormat:@"insert into ServiceCentre values ('%i','1');",idComp]UTF8String], NULL, NULL, NULL);	
	sqlite3_close(db);
	[self reTrace];
}


- (IBAction) deleteRow:(id)sender
{
	NSString *question = NSLocalizedString(@"Company Details Delete", @"Let's verify that I see this question");
	NSString *info = NSLocalizedString(@"The corresponiding products and invoices will be deleted", @"Here is an info");
	NSString *okButton = NSLocalizedString(@"Delete", @"Delete button title");
	NSString *cancelButton = NSLocalizedString(@"Cancel", @"Cancel button title");
	
	NSAlert *alert = [[NSAlert alloc] init];
	[alert setMessageText:question];
	[alert setInformativeText:info];
	[alert addButtonWithTitle:cancelButton];
	[alert addButtonWithTitle:okButton];
	
	NSInteger answer = [alert runModal];
	
	// deleting a company deletes all his details cooresponding to it
	if (answer == 1001)
	{
		NSInteger selectedid = [[companyids objectAtIndex:[self.tableView1 selectedRow]] intValue];
		
		sqlite3_open([[self filePath] UTF8String], &db);
		sqlite3_exec(db, [[NSString stringWithFormat:@"delete from PurchaseRemember where pin_no in ( select a.pin_no from PurchaseInvoice as a where a.company_id = '%i');",selectedid] UTF8String], NULL, NULL, NULL);
		
		sqlite3_exec(db, [[NSString stringWithFormat:@"delete from PurchaseInvoiceDetails where product_id in ( select b.product_id from PurchaseInvoice as a, PurchaseInvoiceDetails as b where a.company_id = '%i' and a.pin_no = b.pin_no);",selectedid] UTF8String], NULL, NULL, NULL);
		
		sqlite3_exec(db, [[NSString stringWithFormat:@"delete from PurchaseInvoice where company_id = '%i';",selectedid] UTF8String], NULL, NULL, NULL);
		
		sqlite3_exec(db, [[NSString stringWithFormat:@"delete from PriceList where company_id = '%i';",selectedid] UTF8String], NULL, NULL, NULL);
		sqlite3_exec(db, [[NSString stringWithFormat:@"delete from ServiceCentre where company_id = '%i';",selectedid] UTF8String], NULL, NULL, NULL);
		sqlite3_exec(db, [[NSString stringWithFormat:@"delete from Company where company_id = '%i';",selectedid] UTF8String], NULL, NULL, NULL);
		sqlite3_close(db);		
	}
	[alert release];
	alert = nil;
	[self reTrace];
}

- (NSString *)filePath 
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"erp"];
} 



@end
