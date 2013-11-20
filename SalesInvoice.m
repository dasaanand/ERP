//
//  SalesInvoice.m
//	To create a sales invoice
//  Created by Dasa Anand on 03/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SalesInvoice.h"

@implementation SalesInvoice

@synthesize  tableView1, itemNoColumn,  product_idColumn,  productColumn,  ModalColumn,  quantityColumn,  pricePerQuantityColumn,  totalPriceColumn,  date,  invoiceNumber,  totalSum,addButton,delButton, customer_name, customerid,name,address,number,type,product_id,product_name,model,company,quantity,products,modals,companys,productids,sps,tps,price;

//initialize function
- (void)awakeFromNib
{
	quantity = [[NSMutableArray alloc] init];
	products = [[NSMutableArray alloc] init];
	modals = [[NSMutableArray alloc] init];
	companys = [[NSMutableArray alloc] init];
	productids = [[NSMutableArray alloc] init];
	sps = [[NSMutableArray alloc] init];
	tps = [[NSMutableArray alloc] init];;
	
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select customer_id,name from Customer"]UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{	
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
			
			[customer_name addItemWithTitle:nameTemp];
		}
	}
	
	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from PriceList"]UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{	
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
			NSString *idTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 0))];
			
			[product_name addItemWithTitle:nameTemp];
			[product_id addItemWithTitle:idTemp];
		}
	}
	
	sqlite3_close(db);
	
	[self.delButton setHidden:1];
}


//number of rows in the table
- (int)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [quantity count];
}

//value for the cells present in the table
- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(int)row
{
	if (tableColumn == quantityColumn)
	{
		return [quantity objectAtIndex:row];
	}
	else
	{
		if (tableColumn == product_idColumn) 
		{
			return [productids objectAtIndex:row];
		}
		else
		{
			if (tableColumn == productColumn)
			{
				return [products objectAtIndex:row];
			}
			if (tableColumn == ModalColumn)
			{
				return [modals objectAtIndex:row];
			}
			else
			{
				if (tableColumn == pricePerQuantityColumn)
				{
					return [sps objectAtIndex:row];
				}
				else
				{
					return [tps objectAtIndex:row];
				}
			}
		}
	}
}


// unhide the delete button if one of the row in the table is selected
- (void)tableViewSelectionDidChange:(NSNotification *)notification 
{
	[self.delButton setHidden:0];
}


// updation of any cells happening in the table
- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex
{
	if (aTableColumn == quantityColumn)
	{
		[quantity replaceObjectAtIndex:rowIndex withObject:anObject];
		NSNumber *x = [[NSNumber alloc] initWithInt:[[quantity objectAtIndex:rowIndex] intValue] * [[sps objectAtIndex:rowIndex] intValue]];
		[tps replaceObjectAtIndex:rowIndex withObject:x];
	}
}


//new product added to the sales invoice
- (IBAction) addRow:(id)sender
{
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select p.product_id from PriceList as p where p.product='%@' and p.model='%@' and p.company_id in ( select c.company_id from company as c where c.name = '%@');",[product_name titleOfSelectedItem],[model titleOfSelectedItem] ,[company titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{	
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 0))];
			[productids addObject:nameTemp];
		}
	}
	sqlite3_close(db);
	
	
	[products addObject:[product_name titleOfSelectedItem]];
	[modals addObject:[model titleOfSelectedItem]];
	[quantity addObject:@"1"];
	[sps addObject:[price stringValue]];
	[tps addObject:[price stringValue]];
	
	[self.tableView1 reloadData];
}


// remove the selected product from the sales invoice
- (IBAction) deleteRow:(id)sender
{
	
	[productids removeObjectAtIndex:[self.tableView1 selectedRow]];
	[products removeObjectAtIndex:[self.tableView1 selectedRow]];
	[modals removeObjectAtIndex:[self.tableView1 selectedRow]];
	[sps removeObjectAtIndex:[self.tableView1 selectedRow]];
	[tps removeObjectAtIndex:[self.tableView1 selectedRow]];
	[quantity removeObjectAtIndex:[self.tableView1 selectedRow]];
	
	[self.tableView1 reloadData];
	[self.delButton setHidden:1];
}


// select the customer from the pop up box to view his details
- (IBAction) selectCustomer:(id)sender
{
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from Customer where name ='%@'",[customer_name titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{	
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 4))];
			NSString *customerTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 0))];
			NSString *typeTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 3))];
			NSString *addressTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
			NSString *numberTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
			
			[customerid setStringValue:customerTemp];
			[name setStringValue:nameTemp];
			[type setStringValue:typeTemp];
			[address setStringValue:addressTemp];
			[number setStringValue:numberTemp];
		}
	}
	sqlite3_close(db);
}


// select the models of the given product and company
- (IBAction) selectModel:(id)sender
{
	[model removeAllItems];
	
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);

	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select p.model from PriceList as p where p.product='%@' and p.company_id in ( select c.company_id from company as c where c.name = '%@');",[product_name titleOfSelectedItem],[company titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{	
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 0))];
			
			[model addItemWithTitle:nameTemp];
		}
	}
	sqlite3_close(db);
}


// select the company of the given product
- (IBAction) selectCompany:(id)sender
{
	[company removeAllItems];
	
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select b.name from PriceList as a, Company as b where a.product='%@' and a.company_id = b.company_id;",[product_name titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{	
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 0))];
			
			[company addItemWithTitle:nameTemp];
		}
	}
	sqlite3_close(db);
}


// display the rate of the selected product
- (IBAction) findRate:(id)sender
{
	[price setStringValue:@""];
	
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select p.sales_price from PriceList as p where p.product='%@' and p.model='%@' and p.company_id in ( select c.company_id from company as c where c.name = '%@');",[product_name titleOfSelectedItem],[model titleOfSelectedItem] ,[company titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{	
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 0))];
			[price setStringValue:nameTemp];
		}
	}
	sqlite3_close(db);
}


// pay for the sales invoice
- (IBAction) pay:(id)sender
{
	NSMutableArray *q = [[NSMutableArray alloc] init];

	sqlite3_open([[self filePath] UTF8String], &db);
	sqlite3_exec(db, [[NSString stringWithFormat:@"insert into SalesInvoice values ('%i','%i','%@','%i');",[invoiceNumber intValue],[customerid intValue],[date stringValue],[totalSum intValue] ]UTF8String], NULL, NULL, NULL);

	
	sqlite3_stmt *statement;

	for(int i=0;i<[tps count];i++)
	{
		sqlite3_exec(db, [[NSString stringWithFormat:@"insert into SalesInvoiceDetails values ('%i','%i','%i','%i');",[invoiceNumber intValue],[[productids objectAtIndex:i] intValue],[[tps objectAtIndex:i] intValue],[[quantity objectAtIndex:i]intValue] ]UTF8String], NULL, NULL, NULL);
	
		if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select quantity from Stock where product_id='%i';",[[productids objectAtIndex:i] intValue]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
		{	
			while (sqlite3_step(statement) == SQLITE_ROW) 
			{
				NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 0))];
				[q addObject:nameTemp];
			}
		}
		NSNumber *temp = [[NSNumber alloc] initWithInt:([[q objectAtIndex:i] intValue] - [[quantity objectAtIndex:i] intValue])];
		[q replaceObjectAtIndex:i withObject:temp];
		
		sqlite3_exec(db, [[NSString stringWithFormat:@"update Stock set quantity='%i' where product_id='%i';",[[q objectAtIndex:i] intValue],[[productids objectAtIndex:i]intValue]]UTF8String], NULL, NULL, NULL);
	}
	
	sqlite3_close(db);
	
}


// display the total amount of the selected products and taking care if we have not enough of stocks
- (IBAction) getDetails:(id)sender
{
	NSMutableArray *q = [[NSMutableArray alloc] init];
	
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	for(int i=0;i<[tps count];i++)
	{
		if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select quantity from Stock where product_id='%i';",[[productids objectAtIndex:i] intValue]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
		{	
			while (sqlite3_step(statement) == SQLITE_ROW) 
			{
				NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 0))];
				[q addObject:nameTemp];
			}
		}
	}
	sqlite3_close(db);
	
	for(int i=0;i<[quantity count];i++)
	{
		if ([[quantity objectAtIndex:i] intValue] > [[q objectAtIndex:i] intValue]) 
		{
			NSString *a = [[NSString alloc] initWithFormat:@"We have less stock of Product:'%@' Model:'%@'",[products objectAtIndex:i],[modals objectAtIndex:i]];
			NSString *question = NSLocalizedString(a, @"Here is an info");
			NSString *info = NSLocalizedString(@"You want to purchase for the stock available", @"Here is an info");
			NSString *okButton = NSLocalizedString(@"Yes", @"Delete button title");
			NSString *cancelButton = NSLocalizedString(@"No", @"Cancel button title");
			
			NSAlert *alert = [[NSAlert alloc] init];
			[alert setMessageText:question];
			[alert setInformativeText:info];
			[alert addButtonWithTitle:cancelButton];
			[alert addButtonWithTitle:okButton];
			
			NSInteger answer = [alert runModal];
			if (answer == 1001)
			{
				[quantity replaceObjectAtIndex:i withObject:[q objectAtIndex:i]];
				NSNumber *x = [[NSNumber alloc] initWithInt:[[quantity objectAtIndex:i] intValue] * [[sps objectAtIndex:i] intValue]];
				[tps replaceObjectAtIndex:i withObject:x];
			}
			else
			{
				[productids removeObjectAtIndex:i];
				[products removeObjectAtIndex:i];
				[modals removeObjectAtIndex:i];
				[sps removeObjectAtIndex:i];
				[tps removeObjectAtIndex:i];
				[quantity removeObjectAtIndex:i];
				break;
			}
		}
	}
	
	
	
	int amount=0,invoiceid;
	for(int i=0;i<[tps count];i++)
	{
		amount+=[[tps objectAtIndex:i] intValue];
	}
	
	[totalSum setIntValue:amount];
	
	sqlite3_open([[self filePath] UTF8String], &db);
	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select sin_no from SalesInvoice order by sin_no"]UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{	
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 0))];
			invoiceid = [nameTemp intValue];
		}
	}
	sqlite3_close(db);
	
	invoiceid ++;
	[invoiceNumber setIntValue:invoiceid];
	
	NSDateFormatter *formatter;
	NSString        *dateString;
	formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd"];	
	dateString = [formatter stringFromDate:[NSDate date]];
	[date setStringValue:dateString];
}


// start creating a new sales invoice
- (IBAction)newInvoice:(id)sender
{
	[productids removeAllObjects];
	[products removeAllObjects];
	[modals removeAllObjects];
	[sps removeAllObjects];
	[tps removeAllObjects];
	[quantity removeAllObjects];
	[self.tableView1 reloadData];
}


// find the details of the customers
- (IBAction) findCustomers:(id)sender
{
	[customer_name removeAllItems];
	[product_name removeAllItems];
	 
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select customer_id,name from Customer"]UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{	
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
			
			[customer_name addItemWithTitle:nameTemp];
		}
	}
	
	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from PriceList"]UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{	
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
			NSString *idTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 0))];
			
			[product_name addItemWithTitle:nameTemp];
			[product_id addItemWithTitle:idTemp];
		}
	}
	sqlite3_close(db);
}


// returns the path of the database
- (NSString *)filePath 
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"erp"];
} 


@end
