//
//  PurchaseDetails.m
//
//  Created by Dasa Anand on 09/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PurchaseDetails.h"

@implementation PurchaseDetails

@synthesize companyids, companynames, dates, invoicenos, amounts,productids,products,modals,servicenames,qunatityC,pps,totalpriceC,where1,where2,where3,where21,where22,where23,tableView1,tableView2,companyid, companyname, date, invoiceno, amount,productid,product,modal,servicename,qunatity,pp,totalprice;

// intialize functions
- (id) init
{
	companyids = [[NSMutableArray alloc] init];
	dates = [[NSMutableArray alloc] init];
	invoicenos = [[NSMutableArray alloc] init];
	amounts = [[NSMutableArray alloc] init];
	qunatity = [[NSMutableArray alloc] init];
	totalprice = [[NSMutableArray alloc] init];	
	productids = [[NSMutableArray alloc] init];
	products = [[NSMutableArray alloc] init];
	modals = [[NSMutableArray alloc] init];
	companynames = [[NSMutableArray alloc] init];
	servicenames = [[NSMutableArray alloc] init];
	pps = [[NSMutableArray alloc] init];
	
	[self reTrace];
	
	self = [super init];
	return self;	
}


// no. of rows in the table
- (int)numberOfRowsInTableView:(NSTableView *)tableView
{
	if (tableView == tableView1)
	{
		return [companynames count];
	}
	else
	{
		return [products count];
	}
}

// cell content for the table
- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(int)row
{	
	if (tableView == tableView1) 
	{
		if (tableColumn == companyid) 
			return [companyids objectAtIndex:row];
		else
		{
			if (tableColumn == companyname) 
				return [companynames objectAtIndex:row];
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
					if (tableColumn == servicename)
					{
						return [servicenames objectAtIndex:row];
					}
					else
					{
						if (tableColumn == qunatityC)
						{
							return [qunatity objectAtIndex:row];
						}
						else
						{
							if (tableColumn == pp)
							{
								return [pps objectAtIndex:row];
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

// any row selected
- (void)tableViewSelectionDidChange:(NSNotification *)notification 
{
	[self findDetails:[[invoicenos objectAtIndex:[tableView1 selectedRow]] intValue]];
}

// updation done in any row
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
			if (aTableColumn == companyname)
			{
				return [companynames replaceObjectAtIndex:rowIndex withObject:anObject];
			}
			else
			{
				if (aTableColumn == servicename)
				{
					return [servicenames replaceObjectAtIndex:rowIndex withObject:anObject];
				}
				else
				{
					if (aTableColumn == stock)
					{
						return [stocks replaceObjectAtIndex:rowIndex withObject:anObject];
					}
					else
					{
						if (aTableColumn == pp)
						{
							return [pps replaceObjectAtIndex:rowIndex withObject:anObject];
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
	
	if (aTableColumn != stock && aTableColumn != companyname && aTableColumn != servicename)
	{
		sqlite3_open([[self filePath] UTF8String], &db);
		sqlite3_exec(db, [[NSString stringWithFormat:@"update PriceList set product='%@', modal='%@', purchase_price='%@', sales_price='%@' where product_id = '%i';", [productids objectAtIndex:rowIndex] ,[modals objectAtIndex:rowIndex],[pps objectAtIndex:rowIndex],[sps objectAtIndex:rowIndex],productidTemp]UTF8String], NULL, NULL, NULL);
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
	 if (aTableColumn == companyname)
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



// show all company
- (IBAction) showAllPressed:(id)sender
{	
	[self reTrace];
}

// query call
- (IBAction) searchPressed:(id)sender
{
	[self defaultQuery];
}

// show all products
- (IBAction) showAllPressed2:(id)sender
{	
	[self findDetails:[[invoicenos objectAtIndex:[tableView1 selectedRow]] intValue]];
}

// query call
- (IBAction) searchPressed2:(id)sender
{
	[self defaultQuery2:[[invoicenos objectAtIndex:[tableView1 selectedRow]] intValue]];
}

// view all company
- (void) reTrace
{
	[productids removeAllObjects];
	[products removeAllObjects];
	[modals removeAllObjects];
	[companynames removeAllObjects];
	[servicenames removeAllObjects];
	[companyids removeAllObjects];
	[dates removeAllObjects];
	[invoicenos removeAllObjects];
	[amounts removeAllObjects];
	[qunatity removeAllObjects];
	[totalprice removeAllObjects];
	[pps removeAllObjects];

	
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from PurchaseInvoice as b, Company as c where b.company_id = c.company_id;"]UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{	
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSNumber *companyTemp= [NSNumber numberWithInt:sqlite3_column_int(statement, 1)];
			NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 5))];
			NSNumber *amountTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 3)];
			NSString *dateTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
			NSNumber *invoiceTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
			
			[companyids addObject:companyTemp];
			[companynames addObject:nameTemp];
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
	[companynames removeAllObjects];
	[servicenames removeAllObjects];
	[companyids removeAllObjects];
	[dates removeAllObjects];
	[invoicenos removeAllObjects];
	[amounts removeAllObjects];
	[qunatity removeAllObjects];
	[totalprice removeAllObjects];
	[pps removeAllObjects];
	

	
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if ([[where1 stringValue] isEqualToString:@""])
	{
		if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from PurchaseInvoice as b, Company as c where b.company_id = c.company_id order by %@;",[order1 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
		{	
			while (sqlite3_step(statement) == SQLITE_ROW) 
			{
				NSNumber *companyTemp= [NSNumber numberWithInt:sqlite3_column_int(statement, 1)];
				NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 5))];
				NSNumber *amountTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 3)];
				NSString *dateTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
				NSNumber *invoiceTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
				
				[companyids addObject:companyTemp];
				[companynames addObject:nameTemp];
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
			NSLog(@"select * from PurchaseInvoice as b, Company as c where b.company_id = c.company_id and %@ %@ '%@' order by %@",[select1 titleOfSelectedItem], [condition1 titleOfSelectedItem] , [where1 stringValue],[order1 titleOfSelectedItem]);
			if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from PurchaseInvoice as b, Company as c where b.company_id = c.company_id and %@ %@ '%@' order by %@",[select1 titleOfSelectedItem], [condition1 titleOfSelectedItem] , [where1 stringValue],[order1 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
			{	
				while (sqlite3_step(statement) == SQLITE_ROW) 
				{
					NSNumber *companyTemp= [NSNumber numberWithInt:sqlite3_column_int(statement, 1)];
					NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 5))];
					NSNumber *amountTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 3)];
					NSString *dateTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
					NSNumber *invoiceTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
					
					[companyids addObject:companyTemp];
					[companynames addObject:nameTemp];
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
				if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from PurchaseInvoice as b, Company as c where b.company_id = c.company_id and %@ %@ '%@' %@ %@ %@ '%@' order by %@",[select1 titleOfSelectedItem], [condition1 titleOfSelectedItem] , [where1 stringValue], [option1 titleOfSelectedItem] ,[select2 titleOfSelectedItem], [condition2 titleOfSelectedItem] , [where2 stringValue],[order1 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
				{	
					
					while (sqlite3_step(statement) == SQLITE_ROW) 
					{
						NSNumber *companyTemp= [NSNumber numberWithInt:sqlite3_column_int(statement, 1)];
						NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 5))];
						NSNumber *amountTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 3)];
						NSString *dateTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
						NSNumber *invoiceTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
						
						[companyids addObject:companyTemp];
						[companynames addObject:nameTemp];
						[amounts addObject:amountTemp];
						[dates addObject:dateTemp];
						[invoicenos addObject:invoiceTemp];						
					}
				}
			}
			else
			{
				if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from PurchaseInvoice as b, Company as c where b.company_id = c.company_id and %@ %@ '%@' %@ %@ %@ '%@' %@ %@ %@ '%@' order by %@",[select1 titleOfSelectedItem], [condition1 titleOfSelectedItem] , [where1 stringValue], [option1 titleOfSelectedItem] ,[select2 titleOfSelectedItem], [condition2 titleOfSelectedItem] , [where2 stringValue],[option2 titleOfSelectedItem],[select3 titleOfSelectedItem], [condition3 titleOfSelectedItem] , [where3 stringValue],[order1 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
				{	
					while (sqlite3_step(statement) == SQLITE_ROW) 
					{
						NSNumber *companyTemp= [NSNumber numberWithInt:sqlite3_column_int(statement, 1)];
						NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 5))];
						NSNumber *amountTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 3)];
						NSString *dateTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
						NSNumber *invoiceTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
						
						[companyids addObject:companyTemp];
						[companynames addObject:nameTemp];
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
	[servicenames removeAllObjects];
	[qunatity removeAllObjects];
	[totalprice removeAllObjects];
	[pps removeAllObjects];
	
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if ([[where21 stringValue] isEqualToString:@""])
	{
		if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select a.purchase_price,b.product_id,b.product,b.model,b.purchase_price,e.name,a.quantity  from PurchaseInvoiceDetails as a, PriceList as b, Company as c, ServiceCentre as d, Service as e where a.pin_no = '%i' and a.product_id = b.product_id and b.company_id= c.company_id and c.company_id = d.company_id and d.service_id = e.service_id order by %@;",pin,[order21 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
		{	
			while (sqlite3_step(statement) == SQLITE_ROW) 
			{
				NSNumber *productidTemp= [NSNumber numberWithInt:sqlite3_column_int(statement, 1)];
				NSNumber *totalPriceTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
				NSNumber *quantityTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 6)];
				NSString *productTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
				NSString *modalTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 3))];
				NSNumber *ppTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 4)];
				NSString *serviceTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 5))];
				
				
				[productids addObject:productidTemp];
				[products addObject:productTemp];
				[modals addObject:modalTemp];
				[pps addObject:ppTemp];
				[qunatity addObject:quantityTemp];
				[totalprice addObject:totalPriceTemp];
				[servicenames addObject:serviceTemp];			
			}
		}
	}
	else 
	{
		if ([[where22 stringValue] isEqualToString:@""])
		{
			if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select a.purchase_price,b.product_id,b.product,b.model,b.purchase_price,e.name,a.quantity  from PurchaseInvoiceDetails as a, PriceList as b, Company as c, ServiceCentre as d, Service as e where a.pin_no = '%i' and a.product_id = b.product_id and b.company_id= c.company_id and c.company_id = d.company_id and d.service_id = e.service_id and %@ %@ '%@' order by %@",pin,[select21 titleOfSelectedItem], [condition21 titleOfSelectedItem] , [where21 stringValue],[order21 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
			{	
				while (sqlite3_step(statement) == SQLITE_ROW) 
				{
					NSNumber *productidTemp= [NSNumber numberWithInt:sqlite3_column_int(statement, 1)];
					NSNumber *totalPriceTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
					NSNumber *quantityTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 6)];
					NSString *productTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
					NSString *modalTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 3))];
					NSNumber *ppTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 4)];
					NSString *serviceTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 5))];
					
					
					[productids addObject:productidTemp];
					[products addObject:productTemp];
					[modals addObject:modalTemp];
					[pps addObject:ppTemp];
					[qunatity addObject:quantityTemp];
					[totalprice addObject:totalPriceTemp];
					[servicenames addObject:serviceTemp];
				}
			}
		}
		else 
		{
			if ([[where23 stringValue] isEqualToString:@""])
			{
				if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select a.purchase_price,b.product_id,b.product,b.model,b.purchase_price,e.name,a.quantity  from PurchaseInvoiceDetails as a, PriceList as b, Company as c, ServiceCentre as d, Service as e where a.pin_no = '%i' and a.product_id = b.product_id and b.company_id= c.company_id and c.company_id = d.company_id and d.service_id = e.service_id and %@ %@ '%@' %@ %@ %@ '%@' order by %@",pin,[select21 titleOfSelectedItem], [condition21 titleOfSelectedItem] , [where21 stringValue], [option21 titleOfSelectedItem] ,[select22 titleOfSelectedItem], [condition22 titleOfSelectedItem] , [where22 stringValue],[order21 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
				{	
					
					while (sqlite3_step(statement) == SQLITE_ROW) 
					{
						NSNumber *productidTemp= [NSNumber numberWithInt:sqlite3_column_int(statement, 1)];
						NSNumber *totalPriceTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
						NSNumber *quantityTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 6)];
						NSString *productTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
						NSString *modalTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 3))];
						NSNumber *ppTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 4)];
						NSString *serviceTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 5))];
						
						
						[productids addObject:productidTemp];
						[products addObject:productTemp];
						[modals addObject:modalTemp];
						[pps addObject:ppTemp];
						[qunatity addObject:quantityTemp];
						[totalprice addObject:totalPriceTemp];
						[servicenames addObject:serviceTemp];					
					}
				}
			}
			else
			{
				if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select a.purchase_price,b.product_id,b.product,b.model,b.purchase_price,e.name,a.quantity  from PurchaseInvoiceDetails as a, PriceList as b, Company as c, ServiceCentre as d, Service as e where a.pin_no = '%i' and a.product_id = b.product_id and b.company_id= c.company_id and c.company_id = d.company_id and d.service_id = e.service_id and %@ %@ '%@' %@ %@ %@ '%@' %@ %@ %@ '%@' order by %@",pin,[select21 titleOfSelectedItem], [condition21 titleOfSelectedItem] , [where21 stringValue], [option21 titleOfSelectedItem] ,[select22 titleOfSelectedItem], [condition22 titleOfSelectedItem] , [where22 stringValue],[option22 titleOfSelectedItem],[select23 titleOfSelectedItem], [condition23 titleOfSelectedItem] , [where23 stringValue],[order21 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
				{	
					while (sqlite3_step(statement) == SQLITE_ROW) 
					{
						NSNumber *productidTemp= [NSNumber numberWithInt:sqlite3_column_int(statement, 1)];
						NSNumber *totalPriceTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
						NSNumber *quantityTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 6)];
						NSString *productTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
						NSString *modalTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 3))];
						NSNumber *ppTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 4)];
						NSString *serviceTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 5))];
						
						
						[productids addObject:productidTemp];
						[products addObject:productTemp];
						[modals addObject:modalTemp];
						[pps addObject:ppTemp];
						[qunatity addObject:quantityTemp];
						[totalprice addObject:totalPriceTemp];
						[servicenames addObject:serviceTemp];					
					}
				}
			}
		}
	}
	
	sqlite3_close(db);
	[self.tableView2 reloadData];
}

// find details
- (void) findDetails:(int)pin
{
	[productids removeAllObjects];
	[products removeAllObjects];
	[modals removeAllObjects];
	[servicenames removeAllObjects];
	[qunatity removeAllObjects];
	[totalprice removeAllObjects];
	[pps removeAllObjects];
	
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select a.purchase_price,b.product_id,b.product,b.model,b.purchase_price,e.name,a.quantity  from PurchaseInvoiceDetails as a, PriceList as b, Company as c, ServiceCentre as d, Service as e where a.pin_no = '%i' and a.product_id = b.product_id and b.company_id= c.company_id and c.company_id = d.company_id and d.service_id = e.service_id;",pin]UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{	
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSNumber *productidTemp= [NSNumber numberWithInt:sqlite3_column_int(statement, 1)];
			NSNumber *totalPriceTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
			NSNumber *quantityTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 6)];
			NSString *productTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
			NSString *modalTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 3))];
			NSNumber *ppTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 4)];
			NSString *serviceTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 5))];
			
			
			[productids addObject:productidTemp];
			[products addObject:productTemp];
			[modals addObject:modalTemp];
			[pps addObject:ppTemp];
			[qunatity addObject:quantityTemp];
			[totalprice addObject:totalPriceTemp];
			[servicenames addObject:serviceTemp];
		}
	}
	sqlite3_close(db);
	[self.tableView2 reloadData];
}


// returns the path of the database
- (NSString *)filePath 
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"erp"];
} 



@end