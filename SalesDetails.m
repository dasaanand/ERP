//
//  SalesDetails.m
//
//  Created by Dasa Anand on 09/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SalesDetails.h"

@implementation SalesDetails
@synthesize customerids, customernames, dates, invoicenos, amounts,productids,products,modals,companynames,qunatityC,sps,totalpriceC,where1,where2,where3,where21,where22,where23,tableView1,tableView2,customerid, customername, date, invoiceno, amount,productid,product,modal,companyname,qunatity,sp,totalprice;

// intittialize function
- (id) init
{
	customerids = [[NSMutableArray alloc] init];
	dates = [[NSMutableArray alloc] init];
	invoicenos = [[NSMutableArray alloc] init];
	amounts = [[NSMutableArray alloc] init];
	qunatity = [[NSMutableArray alloc] init];
	totalprice = [[NSMutableArray alloc] init];	
	productids = [[NSMutableArray alloc] init];
	products = [[NSMutableArray alloc] init];
	modals = [[NSMutableArray alloc] init];
	customernames = [[NSMutableArray alloc] init];
	companynames = [[NSMutableArray alloc] init];
	sps = [[NSMutableArray alloc] init];
	
	[self reTrace];
	
	self = [super init];
	return self;	
}

// return no. of rows in the tables
- (int)numberOfRowsInTableView:(NSTableView *)tableView
{
	if (tableView == tableView1)
	{
		return [customernames count];
	}
	else
	{
		return [products count];
	}
}


// set cell content for the table
- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(int)row
{	
	if (tableView == tableView1) 
	{
		if (tableColumn == customerid) 
			return [customerids objectAtIndex:row];
		else
		{
			if (tableColumn == customername) 
				return [customernames objectAtIndex:row];
			else
			{
				if (tableColumn == date) 
					return [dates objectAtIndex:row];
				else
				{
					if (tableColumn == invoiceno)
					{
						return [invoicenos objectAtIndex:row];
					}
					else
					{
						return [amounts objectAtIndex:row];
					}
				}
			}
		}	
	}
	else
	{
		if (tableColumn == productid) 
			return [productids objectAtIndex:row];
		else
		{
			if (tableColumn == product) 
				return [products objectAtIndex:row];
			else
			{
				if (tableColumn == modal) 
					return [modals  objectAtIndex:row];
				else
				{
					if (tableColumn == companyname)
					{
						return [companynames objectAtIndex:row];
					}
					else
					{
						if (tableColumn == qunatityC)
						{
							return [qunatity objectAtIndex:row];
						}
						else
						{
							if (tableColumn == sp)
							{
								return [sps objectAtIndex:row];
							}
							else
							{
								return [totalprice objectAtIndex:row];
							}
						}
					}
				}
			}
		}
	}
}


// reform the sales products table
- (void)tableViewSelectionDidChange:(NSNotification *)notification 
{
	[self findDetails:[[invoicenos objectAtIndex:[tableView1 selectedRow]] intValue]];
}

- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex
{
	//[self findDetails:[[invoicenos objectAtIndex:rowIndex] intValue]];
	/*	
	 int productidTemp = [[productids objectAtIndex:rowIndex] intValue] ;
	 
	 if (aTableColumn == product) 
	 return [products replaceObjectAtIndex:rowIndex withObject:anObject];
	 else
	 {
	 if (aTableColumn == modal) 
	 return [modals  replaceObjectAtIndex:rowIndex withObject:anObject];
	 else
	 {
	 if (aTableColumn == customername)
	 {
	 return [customernames replaceObjectAtIndex:rowIndex withObject:anObject];
	 }
	 else
	 {
	 if (aTableColumn == companyname)
	 {
	 return [companynames replaceObjectAtIndex:rowIndex withObject:anObject];
	 }
	 else
	 {
	 if (aTableColumn == stock)
	 {
	 return [stocks replaceObjectAtIndex:rowIndex withObject:anObject];
	 }
	 else
	 {
	 if (aTableColumn == sp)
	 {
	 return [sps replaceObjectAtIndex:rowIndex withObject:anObject];
	 }
	 else
	 {
	 if (aTableColumn == sp)
	 {
	 return [sps replaceObjectAtIndex:rowIndex withObject:anObject];
	 }
	 else
	 {
	 return [differences replaceObjectAtIndex:rowIndex withObject:anObject];
	 }
	 }
	 }
	 }
	 }
	 }
	 }
	 
	 if (aTableColumn != stock && aTableColumn != customername && aTableColumn != companyname)
	 {
	 sqlite3_open([[self filePath] UTF8String], &db);
	 sqlite3_exec(db, [[NSString stringWithFormat:@"update PriceList set product='%@', modal='%@', purchase_price='%@', sales_price='%@' where product_id = '%i';", [productids objectAtIndex:rowIndex] ,[modals objectAtIndex:rowIndex],[sps objectAtIndex:rowIndex],[sps objectAtIndex:rowIndex],productidTemp]UTF8String], NULL, NULL, NULL);
	 sqlite3_close(db);
	 }
	 else
	 {
	 if (aTableColumn == stock) 
	 {
	 sqlite3_open([[self filePath] UTF8String], &db);
	 sqlite3_exec(db, [[NSString stringWithFormat:@"update product set type='%@' where product_id = '%i';", [type objectAtIndex:rowIndex],productidTemp]UTF8String], NULL, NULL, NULL);
	 sqlite3_exec(db, [[NSString stringWithFormat:@"update PersonalName set name = '%@' where product_id = '%i';",[names objectAtIndex:rowIndex],productidTemp]UTF8String], NULL, NULL, NULL);
	 sqlite3_close(db);
	 }
	 else
	 {
	 if (aTableColumn == customername)
	 {
	 sqlite3_open([[self filePath] UTF8String], &db);
	 sqlite3_exec(db, [[NSString stringWithFormat:@"update product set type='%@' where product_id = '%i';", [type objectAtIndex:rowIndex],productidTemp]UTF8String], NULL, NULL, NULL);
	 sqlite3_exec(db, [[NSString stringWithFormat:@"update GroupName set name = '%@' where product_id = '%i';",[names objectAtIndex:rowIndex],productidTemp]UTF8String], NULL, NULL, NULL);
	 sqlite3_close(db);
	 }
	 else
	 {
	 sqlite3_open([[self filePath] UTF8String], &db);
	 sqlite3_exec(db, [[NSString stringWithFormat:@"update product set type='%@' where product_id = '%i';", [type objectAtIndex:rowIndex],productidTemp]UTF8String], NULL, NULL, NULL);
	 sqlite3_exec(db, [[NSString stringWithFormat:@"update GroupName set name = '%@' where product_id = '%i';",[names objectAtIndex:rowIndex],productidTemp]UTF8String], NULL, NULL, NULL);
	 sqlite3_close(db);
	 }
	 }
	 }*/
}



// retrace the customers
- (IBAction) showAllPressed:(id)sender
{	
	[self reTrace];
}

// query search
- (IBAction) searchPressed:(id)sender
{
	[self defaultQuery];
}

// show all the products
- (IBAction) showAllPressed2:(id)sender
{	
	[self findDetails:[[invoicenos objectAtIndex:[tableView1 selectedRow]] intValue]];
}

// query search
- (IBAction) searchPressed2:(id)sender
{
	[self defaultQuery2:[[invoicenos objectAtIndex:[tableView1 selectedRow]] intValue]];
}

// default load
- (void) reTrace
{
	[productids removeAllObjects];
	[products removeAllObjects];
	[modals removeAllObjects];
	[customernames removeAllObjects];
	[companynames removeAllObjects];
	[customerids removeAllObjects];
	[dates removeAllObjects];
	[invoicenos removeAllObjects];
	[amounts removeAllObjects];
	[qunatity removeAllObjects];
	[totalprice removeAllObjects];
	[sps removeAllObjects];
	
	
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select b.sin_no,b.customer_id,b.date,b.amount,c.name from SalesInvoice as b, Customer as c where b.customer_id = c.customer_id"]UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{	
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSNumber *customerTemp= [NSNumber numberWithInt:sqlite3_column_int(statement, 1)];
			NSNumber *amountTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 3)];
			NSString *dateTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
			NSNumber *invoiceTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
			NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 4))];
			
			[customernames addObject:nameTemp];
			[customerids addObject:customerTemp];
			[amounts addObject:amountTemp];
			[dates addObject:dateTemp];
			[invoicenos addObject:invoiceTemp];
		}
	}
	sqlite3_close(db);	
	
	[self.tableView1 reloadData];
	[self.tableView2 reloadData];
}


// query implementation
- (void)defaultQuery
{
	[productids removeAllObjects];
	[products removeAllObjects];
	[modals removeAllObjects];
	[customernames removeAllObjects];
	[companynames removeAllObjects];
	[customerids removeAllObjects];
	[dates removeAllObjects];
	[invoicenos removeAllObjects];
	[amounts removeAllObjects];
	[qunatity removeAllObjects];
	[totalprice removeAllObjects];
	[sps removeAllObjects];
	
	
	
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if ([[where1 stringValue] isEqualToString:@""])
	{
		if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select b.sin_no,b.customer_id,b.date,b.amount,c.name from SalesInvoice as b, Customer as c where b.customer_id = c.customer_id order by b.%@;",[order1 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
		{	
			while (sqlite3_step(statement) == SQLITE_ROW) 
			{
				NSNumber *customerTemp= [NSNumber numberWithInt:sqlite3_column_int(statement, 1)];
				NSNumber *amountTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 3)];
				NSString *dateTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
				NSNumber *invoiceTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
				NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 4))];
				
				[customernames addObject:nameTemp];
				[customerids addObject:customerTemp];
				[amounts addObject:amountTemp];
				[dates addObject:dateTemp];
				[invoicenos addObject:invoiceTemp];			
			}
		}
	}
	else 
	{
		if ([[where2 stringValue] isEqualToString:@""])
		{
			if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select b.sin_no,b.customer_id,b.date,b.amount,c.name from SalesInvoice as b, Customer as c where b.customer_id = c.customer_id and b.%@ %@ '%@' order by b.%@;",[select1 titleOfSelectedItem], [condition1 titleOfSelectedItem] , [where1 stringValue],[order1 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
			{	
				while (sqlite3_step(statement) == SQLITE_ROW) 
				{
					NSNumber *customerTemp= [NSNumber numberWithInt:sqlite3_column_int(statement, 1)];
					NSNumber *amountTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 3)];
					NSString *dateTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
					NSNumber *invoiceTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
					NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 4))];
					
					[customernames addObject:nameTemp];
					[customerids addObject:customerTemp];
					[amounts addObject:amountTemp];
					[dates addObject:dateTemp];
					[invoicenos addObject:invoiceTemp];
				}
			}
		}
		else 
		{			
			if ([[where3 stringValue] isEqualToString:@""])
			{
				if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select b.sin_no,b.customer_id,b.date,b.amount,c.name from SalesInvoice as b, Customer as c where b.customer_id = c.customer_id and b.%@ %@ '%@' %@ b.%@ %@ '%@' order by b.%@;",[select1 titleOfSelectedItem], [condition1 titleOfSelectedItem] , [where1 stringValue], [option1 titleOfSelectedItem] ,[select2 titleOfSelectedItem], [condition2 titleOfSelectedItem] , [where2 stringValue],[order1 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
				{	
					
					while (sqlite3_step(statement) == SQLITE_ROW) 
					{
						NSNumber *customerTemp= [NSNumber numberWithInt:sqlite3_column_int(statement, 1)];
						NSNumber *amountTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 3)];
						NSString *dateTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
						NSNumber *invoiceTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
						NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 4))];
						
						[customernames addObject:nameTemp];
						[customerids addObject:customerTemp];
						[amounts addObject:amountTemp];
						[dates addObject:dateTemp];
						[invoicenos addObject:invoiceTemp];						
					}
				}
			}
			else
			{
				if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select b.sin_no,b.customer_id,b.date,b.amount,c.name from SalesInvoice as b, Customer as c where b.customer_id = c.customer_id and b.%@ %@ '%@' %@ b.%@ %@ '%@' %@ b.%@ %@ '%@' order byb. %@;",[select1 titleOfSelectedItem], [condition1 titleOfSelectedItem] , [where1 stringValue], [option1 titleOfSelectedItem] ,[select2 titleOfSelectedItem], [condition2 titleOfSelectedItem] , [where2 stringValue],[option2 titleOfSelectedItem],[select3 titleOfSelectedItem], [condition3 titleOfSelectedItem] , [where3 stringValue],[order1 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
				{	
					while (sqlite3_step(statement) == SQLITE_ROW) 
					{
						NSNumber *customerTemp= [NSNumber numberWithInt:sqlite3_column_int(statement, 1)];
						NSNumber *amountTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 3)];
						NSString *dateTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
						NSNumber *invoiceTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
						NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 4))];
						
						[customernames addObject:nameTemp];
						[customerids addObject:customerTemp];
						[amounts addObject:amountTemp];
						[dates addObject:dateTemp];
						[invoicenos addObject:invoiceTemp];						
					}
				}
			}
		}
	}
	
	sqlite3_close(db);
	[self.tableView1 reloadData];
	[self.tableView2 reloadData];
}


// query implementation 
- (void) defaultQuery2:(int)pin
{
	[productids removeAllObjects];
	[products removeAllObjects];
	[modals removeAllObjects];
	[companynames removeAllObjects];
	[qunatity removeAllObjects];
	[totalprice removeAllObjects];
	[sps removeAllObjects];
	
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if ([[where21 stringValue] isEqualToString:@""])
	{
		if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select a.sin_no, b.sales_price,b.product_id,c.product,c.model,c.sales_price,b.quantity,d.name from SalesInvoice as a, SalesInvoiceDetails as b ,PriceList as c, Company as d where a.sin_no='%i' and a.sin_no = b.sin_no and b.product_id = c.product_id and c.company_id = d.company_id order by %@;",pin,[order21 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
		{	
			while (sqlite3_step(statement) == SQLITE_ROW) 
			{
				NSNumber *productidTemp= [NSNumber numberWithInt:sqlite3_column_int(statement, 2)];
				NSNumber *totalPriceTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 1)];
				NSNumber *quantityTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 6)];
				NSString *productTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 3))];
				NSString *modalTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 4))];
				NSNumber *spTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 5)];
				NSString *companyTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 7))];
				
				
				[productids addObject:productidTemp];
				[products addObject:productTemp];
				[modals addObject:modalTemp];
				[sps addObject:spTemp];
				[qunatity addObject:quantityTemp];
				[totalprice addObject:totalPriceTemp];
				[companynames addObject:companyTemp];			
			}
		}
	}
	else 
	{
		if ([[where22 stringValue] isEqualToString:@""])
		{
			if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select a.sin_no, b.sales_price,b.product_id,c.product,c.model,c.sales_price,b.quantity,d.name from SalesInvoice as a, SalesInvoiceDetails as b ,PriceList as c, Company as d where a.sin_no='%i' and a.sin_no = b.sin_no and b.product_id = c.product_id and c.company_id = d.company_id and %@ %@ '%@' order by %@",pin,[select21 titleOfSelectedItem], [condition21 titleOfSelectedItem] , [where21 stringValue],[order21 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
			{	
				while (sqlite3_step(statement) == SQLITE_ROW) 
				{
					NSNumber *productidTemp= [NSNumber numberWithInt:sqlite3_column_int(statement, 2)];
					NSNumber *totalPriceTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 1)];
					NSNumber *quantityTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 6)];
					NSString *productTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 3))];
					NSString *modalTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 4))];
					NSNumber *spTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 5)];
					NSString *companyTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 7))];
					
					
					[productids addObject:productidTemp];
					[products addObject:productTemp];
					[modals addObject:modalTemp];
					[sps addObject:spTemp];
					[qunatity addObject:quantityTemp];
					[totalprice addObject:totalPriceTemp];
					[companynames addObject:companyTemp];
				}
			}
		}
		else 
		{
			if ([[where23 stringValue] isEqualToString:@""])
			{
				if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select a.sin_no, b.sales_price,b.product_id,c.product,c.model,c.sales_price,b.quantity,d.name from SalesInvoice as a, SalesInvoiceDetails as b ,PriceList as c, Company as d where a.sin_no='%i' and a.sin_no = b.sin_no and b.product_id = c.product_id and c.company_id = d.company_id and %@ %@ '%@' %@ %@ %@ '%@' order by %@",pin,[select21 titleOfSelectedItem], [condition21 titleOfSelectedItem] , [where21 stringValue], [option21 titleOfSelectedItem] ,[select22 titleOfSelectedItem], [condition22 titleOfSelectedItem] , [where22 stringValue],[order21 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
				{	
					
					while (sqlite3_step(statement) == SQLITE_ROW) 
					{
						NSNumber *productidTemp= [NSNumber numberWithInt:sqlite3_column_int(statement, 2)];
						NSNumber *totalPriceTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 1)];
						NSNumber *quantityTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 6)];
						NSString *productTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 3))];
						NSString *modalTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 4))];
						NSNumber *spTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 5)];
						NSString *companyTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 7))];
						
						
						[productids addObject:productidTemp];
						[products addObject:productTemp];
						[modals addObject:modalTemp];
						[sps addObject:spTemp];
						[qunatity addObject:quantityTemp];
						[totalprice addObject:totalPriceTemp];
						[companynames addObject:companyTemp];					
					}
				}
			}
			else
			{
				if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select a.sin_no, b.sales_price,b.product_id,c.product,c.model,c.sales_price,b.quantity,d.name from SalesInvoice as a, SalesInvoiceDetails as b ,PriceList as c, Company as d where a.sin_no='%i' and a.sin_no = b.sin_no and b.product_id = c.product_id and c.company_id = d.company_id and %@ %@ '%@' %@ %@ %@ '%@' %@ %@ %@ '%@' order by %@",pin,[select21 titleOfSelectedItem], [condition21 titleOfSelectedItem] , [where21 stringValue], [option21 titleOfSelectedItem] ,[select22 titleOfSelectedItem], [condition22 titleOfSelectedItem] , [where22 stringValue],[option22 titleOfSelectedItem],[select23 titleOfSelectedItem], [condition23 titleOfSelectedItem] , [where23 stringValue],[order21 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
				{	
					while (sqlite3_step(statement) == SQLITE_ROW) 
					{
						NSNumber *productidTemp= [NSNumber numberWithInt:sqlite3_column_int(statement, 2)];
						NSNumber *totalPriceTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 1)];
						NSNumber *quantityTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 6)];
						NSString *productTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 3))];
						NSString *modalTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 4))];
						NSNumber *spTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 5)];
						NSString *companyTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 7))];
						
						
						[productids addObject:productidTemp];
						[products addObject:productTemp];
						[modals addObject:modalTemp];
						[sps addObject:spTemp];
						[qunatity addObject:quantityTemp];
						[totalprice addObject:totalPriceTemp];
						[companynames addObject:companyTemp];					
					}
				}
			}
		}
	}
	
	sqlite3_close(db);
	[self.tableView2 reloadData];
}


// find the products
- (void) findDetails:(int)pin
{
	[productids removeAllObjects];
	[products removeAllObjects];
	[modals removeAllObjects];
	[companynames removeAllObjects];
	[qunatity removeAllObjects];
	[totalprice removeAllObjects];
	[sps removeAllObjects];
	
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select a.sin_no, b.sales_price,b.product_id,c.product,c.model,c.sales_price,b.quantity,d.name from SalesInvoice as a, SalesInvoiceDetails as b ,PriceList as c, Company as d where a.sin_no='%i' and a.sin_no = b.sin_no and b.product_id = c.product_id and c.company_id = d.company_id;",pin]UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{	
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSNumber *productidTemp= [NSNumber numberWithInt:sqlite3_column_int(statement, 2)];
			NSNumber *totalPriceTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 1)];
			NSNumber *quantityTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 6)];
			NSString *productTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 3))];
			NSString *modalTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 4))];
			NSNumber *spTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 5)];
			NSString *companyTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 7))];
			
			
			[productids addObject:productidTemp];
			[products addObject:productTemp];
			[modals addObject:modalTemp];
			[sps addObject:spTemp];
			[qunatity addObject:quantityTemp];
			[totalprice addObject:totalPriceTemp];
			[companynames addObject:companyTemp];
		}
	}
	sqlite3_close(db);
	[self.tableView2 reloadData];
}


// return the path of the database
- (NSString *)filePath 
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"erp"];
} 



@end