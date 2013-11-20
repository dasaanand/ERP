//
//  PurchaseInvoice.m
//
//  Created by Dasa Anand on 10/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PurchaseInvoice.h"

@implementation PurchaseInvoice

@synthesize  tableView1,  product_idColumn,  productColumn,  ModalColumn,  quantityColumn,  pricePerQuantityColumn,  totalPriceColumn,  date,  invoiceNumber,  totalSum,addButton,delButton, company_name,companyid,name,address,number,product_name,model,quantity,products,modals,companys,productids,sps,tps,price,cps,newproduct,newmodel,newpp,newsp,salesPriceColumn;

// initialize function
- (void)awakeFromNib
{
	quantity = [[NSMutableArray alloc] init];
	products = [[NSMutableArray alloc] init];
	modals = [[NSMutableArray alloc] init];
	companys = [[NSMutableArray alloc] init];
	productids = [[NSMutableArray alloc] init];
	sps = [[NSMutableArray alloc] init];
	tps = [[NSMutableArray alloc] init];
	cps = [[NSMutableArray alloc] init];
	
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select company_id,name from company;"]UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{	
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];			
			[company_name addItemWithTitle:nameTemp];
		}
	}
		
	[self.delButton setHidden:1];
}

// returns no. of rows in the table
- (int)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [quantity count];
}


// sets contents for the table
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
					if (tableColumn == salesPriceColumn)
					{
						return [cps objectAtIndex:row];
					}
					else
					{
						return [tps objectAtIndex:row];
					}
				}
			}
		}
	}
}


// unhide the delete button if any of the product is selected
- (void)tableViewSelectionDidChange:(NSNotification *)notification 
{
	[self.delButton setHidden:0];
}


// take care of the updation taking place in the table cells
- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex
{
	if (aTableColumn == quantityColumn)
	{
		[quantity replaceObjectAtIndex:rowIndex withObject:anObject];
		NSNumber *x = [[NSNumber alloc] initWithInt:[[quantity objectAtIndex:rowIndex] intValue] * [[sps objectAtIndex:rowIndex] intValue]];
		[tps replaceObjectAtIndex:rowIndex withObject:x];
	}
	if (aTableColumn == salesPriceColumn)
	{
		[cps replaceObjectAtIndex:rowIndex withObject:anObject];
	}
	if (aTableColumn == pricePerQuantityColumn)
	{
		[sps replaceObjectAtIndex:rowIndex withObject:anObject];
		NSNumber *x = [[NSNumber alloc] initWithInt:[[quantity objectAtIndex:rowIndex] intValue] * [[sps objectAtIndex:rowIndex] intValue]];
		[tps replaceObjectAtIndex:rowIndex withObject:x];
	}
	
}


// add product into the table
- (IBAction) addRow:(id)sender
{
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select p.product_id,p.sales_price from PriceList as p where p.product='%@' and p.model='%@' and p.company_id in ( select c.company_id from company as c where c.name = '%@');",[product_name titleOfSelectedItem],[model titleOfSelectedItem] ,[company_name titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{	
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 0))];
			NSString *name2Temp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];

			[productids addObject:nameTemp];
			[cps addObject:name2Temp];
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


// remove the selected product from the purchase invoice
- (IBAction) deleteRow:(id)sender
{
	[productids removeObjectAtIndex:[self.tableView1 selectedRow]];
	[products removeObjectAtIndex:[self.tableView1 selectedRow]];
	[modals removeObjectAtIndex:[self.tableView1 selectedRow]];
	[sps removeObjectAtIndex:[self.tableView1 selectedRow]];
	[tps removeObjectAtIndex:[self.tableView1 selectedRow]];
	[quantity removeObjectAtIndex:[self.tableView1 selectedRow]];
	[cps removeObjectAtIndex:[self.tableView1 selectedRow]];
	
	[self.tableView1 reloadData];
	[self.delButton setHidden:1];
}


// get the details of the selected company
- (IBAction) selectcompany:(id)sender
{
	[product_name removeAllItems];
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from company where name ='%@'",[company_name titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{	
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
			NSString *companyTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 0))];
			NSString *addressTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
			NSString *numberTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 3))];
			
			[companyid setStringValue:companyTemp];
			[name setStringValue:nameTemp];
			[address setStringValue:addressTemp];
			[number setStringValue:numberTemp];
		}
	}
	
	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from PriceList where company_id='%i';",[companyid intValue]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{	
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
			[product_name addItemWithTitle:nameTemp];
		}
	}
	
	sqlite3_close(db);
}


// get all the models available for the particular product and company
- (IBAction) selectModel:(id)sender
{
	[model removeAllItems];
	
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select p.model from PriceList as p where p.product='%@' and p.company_id in ( select c.company_id from company as c where c.name = '%@');",[product_name titleOfSelectedItem],[company_name titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{	
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 0))];
			[model addItemWithTitle:nameTemp];
		}
	}
	sqlite3_close(db);
}


// find the purchase price of the selected product
- (IBAction) findRate:(id)sender
{
	[price setStringValue:@""];
	
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select p.purchase_price from PriceList as p where p.product='%@' and p.model='%@' and p.company_id in ( select c.company_id from company as c where c.name = '%@');",[product_name titleOfSelectedItem],[model titleOfSelectedItem] ,[company_name titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{	
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 0))];
			[price setStringValue:nameTemp];
		}
	}
	sqlite3_close(db);
}


// make payement for the purchase invoice
- (IBAction) pay:(id)sender
{
	sqlite3_stmt *statement;
	NSMutableArray *q = [[NSMutableArray alloc] init];
	sqlite3_open([[self filePath] UTF8String], &db);
	sqlite3_exec(db, [[NSString stringWithFormat:@"insert into PurchaseInvoice values ('%i','%i','%@','%i');",[invoiceNumber intValue],[companyid intValue],[date stringValue],[totalSum intValue] ]UTF8String], NULL, NULL, NULL);
	
	
	for(int i=0;i<[tps count];i++)
	{
		sqlite3_exec(db, [[NSString stringWithFormat:@"insert into PurchaseInvoiceDetails values ('%i','%i','%i','%i');",[invoiceNumber intValue],[[productids objectAtIndex:i] intValue],[[tps objectAtIndex:i] intValue],[[quantity objectAtIndex:i]intValue] ]UTF8String], NULL, NULL, NULL);
		
		if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select quantity from Stock where product_id='%i';",[[productids objectAtIndex:i] intValue]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
		{	
			while (sqlite3_step(statement) == SQLITE_ROW) 
			{
				NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 0))];
				[q addObject:nameTemp];
			}
		}
		NSNumber *temp = [[NSNumber alloc] initWithInt:([[q objectAtIndex:i] intValue] + [[quantity objectAtIndex:i] intValue] -1)];
		[q replaceObjectAtIndex:i withObject:temp];
		
		sqlite3_exec(db, [[NSString stringWithFormat:@"update Stock set quantity='%i' where product_id='%i';",[[q objectAtIndex:i] intValue],[[productids objectAtIndex:i]intValue]]UTF8String], NULL, NULL, NULL);
	}
	
	sqlite3_close(db);
	
}


// find the total amount of the selected products 
- (IBAction) getDetails:(id)sender
{
	int amount=0,invoiceid;
	for(int i=0;i<[tps count];i++)
	{
		amount+=[[tps objectAtIndex:i] intValue];
	}
	
	[totalSum setIntValue:amount];
	
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select pin_no from PurchaseInvoice order by pin_no"]UTF8String], -1, &statement, NULL) == SQLITE_OK)
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


// create a new purchase invoice
- (IBAction)newInvoice:(id)sender
{
	[productids removeAllObjects];
	[products removeAllObjects];
	[modals removeAllObjects];
	[sps removeAllObjects];
	[tps removeAllObjects];
	[quantity removeAllObjects];
	[cps removeAllObjects];
	[self.tableView1 reloadData];
}


// create a new product for the company
- (IBAction) newProduct:(id)sender
{
	int prid;
	
	[products addObject:[newproduct stringValue]];
	[sps addObject:[newpp stringValue]];
	[cps addObject:[newsp stringValue]];
	[modals addObject:[newmodel stringValue]];
	[quantity addObject:@"1"];
	[tps addObject:[newpp stringValue]];

	
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select product_id from PriceList order by product_id"]UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{	
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 0))];
			prid = [nameTemp intValue];
		}
	}
	sqlite3_close(db);
	
	prid++;
	NSNumber *temp = [[NSNumber alloc] initWithInt:prid];
	[productids addObject:temp];
	
	[product_name addItemWithTitle:[newproduct stringValue]];
	[model addItemWithTitle:[newmodel stringValue]];
	
	sqlite3_open([[self filePath] UTF8String], &db);
	sqlite3_exec(db, [[NSString stringWithFormat:@"insert into PriceList values ('%i','%@','%@','%i','%i','%i');",prid,[newproduct stringValue],[newmodel stringValue],[newpp intValue],[newsp intValue],[companyid intValue] ]UTF8String], NULL, NULL, NULL);
	sqlite3_exec(db, [[NSString stringWithFormat:@"insert into Stock values ('%i','1');",prid]UTF8String], NULL, NULL, NULL);
	sqlite3_close(db);	
	[self.tableView1 reloadData];
}


// find the company 
- (IBAction) findCompany:(id)sender
{
	[company_name removeAllItems];
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select company_id,name from company;"]UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{	
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];			
			[company_name addItemWithTitle:nameTemp];
		}
	}
}


// returns the path of the database
- (NSString *)filePath 
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"erp"];
} 


@end
