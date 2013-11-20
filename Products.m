//
//  Products.m
//
//  Created by Dasa Anand on 09/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Products.h"

@implementation Products

@synthesize where1,where2, where3,addButton, deleteButton,tableView1,productid,product,modal,companyname,servicename,stock,pp,sp,difference,productids,products,modals,companynames,servicenames,stocks,pps,sps,differences;

- (id) init
{
	productids = [[NSMutableArray alloc] init];
	products = [[NSMutableArray alloc] init];
	modals = [[NSMutableArray alloc] init];
	companynames = [[NSMutableArray alloc] init];
	servicenames = [[NSMutableArray alloc] init];
	stocks = [[NSMutableArray alloc] init];
	pps = [[NSMutableArray alloc] init];
	sps = [[NSMutableArray alloc] init];
	differences = [[NSMutableArray alloc] init];
	
	[self reTrace];
	
	self = [super init];
	return self;	
}

- (int)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [products count];
}


- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(int)row
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
					if (tableColumn == servicename)
					{
						return [servicenames objectAtIndex:row];
					}
					else
					{
						if (tableColumn == stock)
						{
							return [stocks objectAtIndex:row];
						}
						else
						{
							if (tableColumn == pp)
							{
								return [pps objectAtIndex:row];
							}
							else
							{
								if (tableColumn == sp)
								{
									return [sps objectAtIndex:row];
								}
								else
								{
									return [differences objectAtIndex:row];
								}
							}
						}
					}
				}
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
	int productidTemp = [[productids objectAtIndex:rowIndex] intValue] ;

	if (aTableColumn == sp) 
		return [sps replaceObjectAtIndex:rowIndex withObject:anObject];
		
	if (aTableColumn == sp)
	{
		sqlite3_open([[self filePath] UTF8String], &db);
		sqlite3_exec(db, [[NSString stringWithFormat:@"update PriceList set sales_price='%i' where product_id = '%i';", [sps objectAtIndex:rowIndex],productidTemp]UTF8String], NULL, NULL, NULL);
		sqlite3_close(db);
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
	[productids removeAllObjects];
	[products removeAllObjects];
	[modals removeAllObjects];
	[companynames removeAllObjects];
	[servicenames removeAllObjects];
	[stocks removeAllObjects];
	[pps removeAllObjects];
	[sps removeAllObjects];
	[differences removeAllObjects];
	
	
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from  PriceList as p natural join Stock, Company as s, ServiceCentre as a, Service as b where p.company_id = s.company_id and s.company_id = a.company_id and a.service_id = b.service_id order by p.product_id;"]UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{	
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSNumber *productidTemp= [NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
			NSString *productTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
			NSString *modalTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
			NSNumber *ppTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 3)];
			NSNumber *spTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 4)];
			NSNumber *stockTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 6)];
			NSString *companyTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 8))];
			NSString *serviceTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 14))];
			NSNumber *diffTemp = [NSNumber numberWithInt:[spTemp intValue] - [ppTemp intValue]];
			
			
			[productids addObject:productidTemp];
			[products addObject:productTemp];
			[modals addObject:modalTemp];
			[companynames addObject:companyTemp];
			[pps addObject:ppTemp];
			[sps addObject:spTemp];
			[stocks addObject:stockTemp];
			[differences addObject:diffTemp];
			[servicenames addObject:serviceTemp];
		}
	}
	sqlite3_close(db);
	
	
	[self.tableView1 reloadData];
	[self.deleteButton setHidden:1];
}

- (void)defaultQuery
{
	[productids removeAllObjects];
	[products removeAllObjects];
	[modals removeAllObjects];
	[companynames removeAllObjects];
	[servicenames removeAllObjects];
	[stocks removeAllObjects];
	[pps removeAllObjects];
	[sps removeAllObjects];
	[differences removeAllObjects];
	
	if ([[order1 titleOfSelectedItem] isEqualToString:@""])
	{
		[order1 selectItemWithTitle:@"product_id"];
	}
	
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if ([[where1 stringValue] isEqualToString:@""])
	{
		if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from PriceList as p natural join Stock, Company as s, ServiceCentre as a, Service as b where p.company_id = s.company_id and s.company_id = a.company_id and a.service_id = b.service_id order by p.%@;",[order1 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
		{	
			while (sqlite3_step(statement) == SQLITE_ROW) 
			{
				NSNumber *productidTemp= [NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
				NSString *productTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
				NSString *modalTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
				NSNumber *ppTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 3)];
				NSNumber *spTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 4)];
				NSNumber *stockTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 6)];
				NSString *companyTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 8))];
				NSString *serviceTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 14))];
				NSNumber *diffTemp = [NSNumber numberWithInt:[spTemp intValue] - [ppTemp intValue]];
				
				
				[productids addObject:productidTemp];
				[products addObject:productTemp];
				[modals addObject:modalTemp];
				[companynames addObject:companyTemp];
				[pps addObject:ppTemp];
				[sps addObject:spTemp];
				[stocks addObject:stockTemp];
				[differences addObject:diffTemp];
				[servicenames addObject:serviceTemp];				
			}
		}
	}
	else 
	{
		if ([[where2 stringValue] isEqualToString:@""])
		{
			
			
			if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from PriceList as p natural join Stock, Company as s, ServiceCentre as a, Service as b where p.company_id = s.company_id and s.company_id = a.company_id and a.service_id = b.service_id and p.%@ %@ '%@' order by p.%@",[select1 titleOfSelectedItem], [condition1 titleOfSelectedItem] , [where1 stringValue],[order1 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
			{	
				while (sqlite3_step(statement) == SQLITE_ROW) 
				{
					NSNumber *productidTemp= [NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
					NSString *productTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
					NSString *modalTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
					NSNumber *ppTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 3)];
					NSNumber *spTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 4)];
					NSNumber *stockTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 6)];
					NSString *companyTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 8))];
					NSString *serviceTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 14))];
					NSNumber *diffTemp = [NSNumber numberWithInt:[spTemp intValue] - [ppTemp intValue]];
					
					
					[productids addObject:productidTemp];
					[products addObject:productTemp];
					[modals addObject:modalTemp];
					[companynames addObject:companyTemp];
					[pps addObject:ppTemp];
					[sps addObject:spTemp];
					[stocks addObject:stockTemp];
					[differences addObject:diffTemp];
					[servicenames addObject:serviceTemp];
					
				}
			}
		}
		else 
		{
			if ([[where3 stringValue] isEqualToString:@""])
			{
				if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from PriceList as p natural join Stock, Company as s, ServiceCentre as a, Service as b where p.company_id = s.company_id and s.company_id = a.company_id and a.service_id = b.service_id and p.%@ %@ '%@' %@ p.%@ %@ '%@' order by p.%@",[select1 titleOfSelectedItem], [condition1 titleOfSelectedItem] , [where1 stringValue], [option1 titleOfSelectedItem] ,[select2 titleOfSelectedItem], [condition2 titleOfSelectedItem] , [where2 stringValue],[order1 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
				{	
					
					while (sqlite3_step(statement) == SQLITE_ROW) 
					{
						NSNumber *productidTemp= [NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
						NSString *productTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
						NSString *modalTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
						NSNumber *ppTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 3)];
						NSNumber *spTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 4)];
						NSNumber *stockTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 6)];
						NSString *companyTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 8))];
						NSString *serviceTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 14))];
						NSNumber *diffTemp = [NSNumber numberWithInt:[spTemp intValue] - [ppTemp intValue]];
						
						
						[productids addObject:productidTemp];
						[products addObject:productTemp];
						[modals addObject:modalTemp];
						[companynames addObject:companyTemp];
						[pps addObject:ppTemp];
						[sps addObject:spTemp];
						[stocks addObject:stockTemp];
						[differences addObject:diffTemp];
						[servicenames addObject:serviceTemp];						
					}
				}
			}
			else
			{
				if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from PriceList as p natural join Stock, Company as s, ServiceCentre as a, Service as b where p.company_id = s.company_id and s.company_id = a.company_id and a.service_id = b.service_id and p.%@ %@ '%@' %@ p.%@ %@ '%@' %@ p.%@ %@ '%@' order by p.%@",[select1 titleOfSelectedItem], [condition1 titleOfSelectedItem] , [where1 stringValue], [option1 titleOfSelectedItem] ,[select2 titleOfSelectedItem], [condition2 titleOfSelectedItem] , [where2 stringValue],[option2 titleOfSelectedItem],[select3 titleOfSelectedItem], [condition3 titleOfSelectedItem] , [where3 stringValue],[order1 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
				{	
					while (sqlite3_step(statement) == SQLITE_ROW) 
					{
						NSNumber *productidTemp= [NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
						NSString *productTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
						NSString *modalTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
						NSNumber *ppTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 3)];
						NSNumber *spTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 4)];
						NSNumber *stockTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 6)];
						NSString *companyTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 8))];
						NSString *serviceTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 14))];
						NSNumber *diffTemp = [NSNumber numberWithInt:[spTemp intValue] - [ppTemp intValue]];
						
						
						[productids addObject:productidTemp];
						[products addObject:productTemp];
						[modals addObject:modalTemp];
						[companynames addObject:companyTemp];
						[pps addObject:ppTemp];
						[sps addObject:spTemp];
						[stocks addObject:stockTemp];
						[differences addObject:diffTemp];
						[servicenames addObject:serviceTemp];						
					}
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
	sqlite3_exec(db, [[NSString stringWithFormat:@"insert into product (name,contact_number,address) values ('xxx',999,'yyy');"]UTF8String], NULL, NULL, NULL);
	sqlite3_close(db);
	[self reTrace];
}

- (IBAction) deleteRow:(id)sender
{
	NSString *question = NSLocalizedString(@"Product Details Delete", @"Let's verify that I see this question");
	NSString *info = NSLocalizedString(@"The slected product will be deleted", @"Here is an info");
	NSString *okButton = NSLocalizedString(@"Delete", @"Delete button title");
	NSString *cancelButton = NSLocalizedString(@"Cancel", @"Cancel button title");
	
	NSAlert *alert = [[NSAlert alloc] init];
	[alert setMessageText:question];
	[alert setInformativeText:info];
	[alert addButtonWithTitle:cancelButton];
	[alert addButtonWithTitle:okButton];
	
	NSInteger answer = [alert runModal];
	
	
	if (answer == 1000)
	{
		NSLog(@"Cancel");
	}
	else
	{		
		sqlite3_open([[self filePath] UTF8String], &db);
		sqlite3_exec(db, [[NSString stringWithFormat:@"delete from PriceList where product_id='%i';",[[products objectAtIndex:[self.tableView1 selectedRow]] intValue]]UTF8String], NULL, NULL, NULL);
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

