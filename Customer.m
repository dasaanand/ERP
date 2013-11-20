//
//  Customer.m
//
//  Created by Dasa Anand on 09/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Customer.h"

@implementation Customer
@synthesize customerids,names,address,numbers, where1,where2, addButton, deleteButton,tableView1, customerid,name,addressC,number,type,typeC;

- (id) init
{
	customerids = [[NSMutableArray alloc] init];
	names = [[NSMutableArray alloc] init];
	numbers = [[NSMutableArray alloc] init];
	address = [[NSMutableArray alloc] init];
	type = [[NSMutableArray alloc] init];
	
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
	if (tableColumn == customerid) 
		return [customerids objectAtIndex:row];
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
				if (tableColumn == typeC)
				{
					return [type objectAtIndex:row];
				}
				else
					return [address objectAtIndex:row];
			}
		}
	}
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification 
{
	[self.deleteButton setHidden:0];
}

- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex
{
	int customeridTemp = [[customerids objectAtIndex:rowIndex] intValue] ;
	
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
				[type replaceObjectAtIndex:rowIndex withObject:anObject];
			}

		}
	}
	
	sqlite3_open([[self filePath] UTF8String], &db);
	sqlite3_exec(db, [[NSString stringWithFormat:@"update customer set address = '%@',number = '%@',name='%@',type='%@' where customer_id = '%i';", [address objectAtIndex:rowIndex] ,[numbers objectAtIndex:rowIndex],[names objectAtIndex:rowIndex],[type objectAtIndex:rowIndex] ,customeridTemp]UTF8String], NULL, NULL, NULL);
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
	[customerids removeAllObjects];
	[names removeAllObjects];
	[numbers removeAllObjects];
	[address removeAllObjects];
	[type removeAllObjects];
	
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from customer;"]UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{	
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSNumber *customerTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
			NSString *addressTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
			NSString *numberTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
			NSString *typeTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 3))];
			NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 4))];
		
			[names addObject:nameTemp];
			[customerids addObject:customerTemp];
			[numbers addObject:numberTemp];
			[address addObject:addressTemp];
			[type addObject:typeTemp];
		}
	}
	sqlite3_close(db);
	
	[self.tableView1 reloadData];
	[self.deleteButton setHidden:1];
}

- (void)defaultQuery
{
	[customerids removeAllObjects];
	[names removeAllObjects];
	[numbers removeAllObjects];
	[address removeAllObjects];
	[type removeAllObjects];
	
	if ([[order1 titleOfSelectedItem] isEqualToString:@""])
	{
		[order1 selectItemWithTitle:@"customer_id"];
	}
	
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if ([[where1 stringValue] isEqualToString:@""])
	{
		if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from customer order by %@;",[order1 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
		{	
			while (sqlite3_step(statement) == SQLITE_ROW) 
			{
				NSNumber *customerTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
				NSString *addressTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
				NSString *numberTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
				NSString *typeTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 3))];
				NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 4))];
				
				[names addObject:nameTemp];
				[customerids addObject:customerTemp];
				[numbers addObject:numberTemp];
				[address addObject:addressTemp];
				[type addObject:typeTemp];
			}
		}
	}
	else 
	{
		if([[where2 stringValue] isEqualToString:@""])
		{	
			if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from customer where %@ %@ '%@' order by %@",[select1 titleOfSelectedItem], [condition1 titleOfSelectedItem] , [where1 stringValue],[order1 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
			{	
				while (sqlite3_step(statement) == SQLITE_ROW) 
				{
					
					NSNumber *customerTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
					NSString *addressTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
					NSString *numberTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
					NSString *typeTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 3))];
					NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 4))];
					
					[names addObject:nameTemp];
					[customerids addObject:customerTemp];
					[numbers addObject:numberTemp];
					[address addObject:addressTemp];
					[type addObject:typeTemp];
				}
			}
		}
		else
		{
			if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from customer where %@ %@ '%@' %@ %@ %@ '%@' order by %@",[select1 titleOfSelectedItem], [condition1 titleOfSelectedItem] , [where1 stringValue], [option1 titleOfSelectedItem] ,[select2 titleOfSelectedItem], [condition2 titleOfSelectedItem] , [where2 stringValue],[order1 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
			{	
				while (sqlite3_step(statement) == SQLITE_ROW) 
				{
					NSNumber *customerTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
					NSString *addressTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
					NSString *numberTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
					NSString *typeTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 3))];
					NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 4))];
					
					[names addObject:nameTemp];
					[customerids addObject:customerTemp];
					[numbers addObject:numberTemp];
					[address addObject:addressTemp];
					[type addObject:typeTemp];
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
	
	sqlite3_exec(db, [[NSString stringWithFormat:@"insert into customer (name,contact_number,address,type) values ('xxx',999,'yyy','personal');"]UTF8String], NULL, NULL, NULL);
	sqlite3_close(db);
	
	[self reTrace];
}

- (IBAction) deleteRow:(id)sender
{
	NSString *question = NSLocalizedString(@"customer Details Delete", @"Let's verify that I see this question");
	NSString *info = NSLocalizedString(@"The corresponiding invoices will be deleted", @"Here is an info");
	NSString *okButton = NSLocalizedString(@"Delete", @"Delete button title");
	NSString *cancelButton = NSLocalizedString(@"Cancel", @"Cancel button title");
	
	NSAlert *alert = [[NSAlert alloc] init];
	[alert setMessageText:question];
	[alert setInformativeText:info];
	[alert addButtonWithTitle:cancelButton];
	[alert addButtonWithTitle:okButton];
	
	NSInteger answer = [alert runModal];
	
	// deleting the customer deletes all his details including his sales invoice
	if (answer == 1001)
	{
		NSInteger selectedid = [[customerids objectAtIndex:[self.tableView1 selectedRow]] intValue];
		
		NSLog(@"delete from SalesRemember where sin_no in ( select c.sin_no from Pricelist as a, SalesInvoiceDetails as b, SalesInvoice as c where c.customer_id='%i' and a.product_id = b.product_id and c.sin_no=b.sin_no);",selectedid);
		
		sqlite3_open([[self filePath] UTF8String], &db);
		sqlite3_exec(db, [[NSString stringWithFormat:@"delete from SalesRemember where sin_no in ( select c.sin_no from Pricelist as a, SalesInvoiceDetails as b, SalesInvoice as c where c.customer_id='%i' and a.product_id = b.product_id and c.sin_no=b.sin_no );",selectedid] UTF8String], NULL, NULL, NULL);
		
		sqlite3_exec(db, [[NSString stringWithFormat:@"delete from SalesInvoiceDetails where sin_no in ( select c.sin_no from Pricelist as a, SalesInvoiceDetails as b, SalesInvoice as c where c.customer_id='%i' and a.product_id = b.product_id and c.sin_no=b.sin_no );",selectedid] UTF8String], NULL, NULL, NULL);
		
		sqlite3_exec(db, [[NSString stringWithFormat:@"delete from SalesInvoice as a, Customer as b where a.customer_id=b.customer_id and b.customer_id='%i';",selectedid] UTF8String], NULL, NULL, NULL);
		
		sqlite3_exec(db, [[NSString stringWithFormat:@"delete from customer where customer_id = '%i';",selectedid] UTF8String], NULL, NULL, NULL);

		/*sqlite3_exec(db, [[NSString stringWithFormat:@"delete from PurchaseInvoiceDetails where product_id in ( select b.product_id from PurchaseInvoice as a, PurchaseInvoiceDetails as b where a.customer_id = '%@' and a.pin_no = b.pin_no);",selectedid] UTF8String], NULL, NULL, NULL);
		sqlite3_exec(db, [[NSString stringWithFormat:@"delete from PurchaseRemember where pin_no in ( select b.pin_no from PurchaseInvoice as a, PurchaseRemember as b where a.customer_id = '%@' and a.pin_no = b.pin_no);",selectedid] UTF8String], NULL, NULL, NULL);
		sqlite3_exec(db, [[NSString stringWithFormat:@"delete from PurchaseInvoice where customer_id = '%@';",selectedid] UTF8String], NULL, NULL, NULL);
		 sqlite3_exec(db, [[NSString stringWithFormat:@"delete from ServiceCentre where customer_id = '%@';",selectedid] UTF8String], NULL, NULL, NULL);
		 sqlite3_exec(db, [[NSString stringWithFormat:@"delete from PriceList where customer_id = '%@';",selectedid] UTF8String], NULL, NULL, NULL);
		 */
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
