//
//  Profit.m
//
//  Created by Dasa Anand on 08/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Profit.h"

@implementation Profit

@synthesize tableView1, profit,quantityC,product_id, profits, where1, quantity ,product_ids;

- (id)init
{
	profits = [[NSMutableArray alloc] init];
	quantity = [[NSMutableArray alloc] init];
	product_ids = [[NSMutableArray alloc] init];
	
	[self reTrace];
	self = [super init];
	return self;
}


- (void) reTrace
{
	[profits removeAllObjects];
	[quantity removeAllObjects];
	[product_ids removeAllObjects];

	[tableView1 reloadData];
	
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select p.purchase_price, p.sales_price,s.quantity,s.product_id from PriceList as p , SalesInvoiceDetails as s where p.product_id = s.product_id;"]UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{	
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSNumber *purchaseTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
			NSNumber *salesTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 1)];
			NSNumber *quantityTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 2)];
			NSNumber *productTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 3)];
			
			[quantity addObject:quantityTemp];
			[product_ids addObject:productTemp];
			int profitTemp = [quantityTemp intValue] * ([salesTemp intValue] - [purchaseTemp intValue]); 
			NSNumber *profitTemp2 = [NSNumber numberWithInt:profitTemp];
			[profits addObject:profitTemp2];
		}
	}
	sqlite3_close(db);
	[tableView1 reloadData];
}


- (int)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [product_ids count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(int)row
{	
	if (tableColumn == profit)
	{
		return [profits objectAtIndex:row];
	}
	else
	{
		if (tableColumn == quantityC)
		{
			return [quantity objectAtIndex:row];
		}
		else
		{
			return [product_ids objectAtIndex:row];
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

- (void) defaultQuery
{
	[profits removeAllObjects];
	[quantity removeAllObjects];
	[product_ids removeAllObjects];
	
	[tableView1 reloadData];
	
	if ([[order1 titleOfSelectedItem] isEqualToString:@""])
	{
		[order1 selectItemWithTitle:@"product_id"];
	}
	
	
	
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if ([[where1 stringValue] isEqualToString:@""])
	{
		if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select p.purchase_price, p.sales_price,s.quantity,s.product_id from PriceList as p , SalesInvoiceDetails as s where p.product_id = s.product_id order by s.%@;",[order1 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
		{	
			while (sqlite3_step(statement) == SQLITE_ROW) 
			{
				NSNumber *purchaseTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
				NSNumber *salesTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 1)];
				NSNumber *quantityTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 2)];
				NSNumber *productTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 3)];
				
				[quantity addObject:quantityTemp];
				[product_ids addObject:productTemp];
				int profitTemp = [quantityTemp intValue] * ([salesTemp intValue] - [purchaseTemp intValue]); 
				NSNumber *profitTemp2 = [NSNumber numberWithInt:profitTemp];
				[profits addObject:profitTemp2];
			}
		}
	}
	else
	{
		if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select p.purchase_price, p.sales_price,s.quantity,s.product_id from PriceList as p , SalesInvoiceDetails as s where p.product_id = s.product_id and s.%@ %@ '%@' order by s.%@;",[select1 titleOfSelectedItem], [condition1 titleOfSelectedItem] , [where1 stringValue], [order1 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
		{	
			while (sqlite3_step(statement) == SQLITE_ROW) 
			{
				NSNumber *purchaseTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
				NSNumber *salesTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 1)];
				NSNumber *quantityTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 2)];
				NSNumber *productTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 3)];
				
				[quantity addObject:quantityTemp];
				[product_ids addObject:productTemp];
				int profitTemp = [quantityTemp intValue] * ([salesTemp intValue] - [purchaseTemp intValue]); 
				NSNumber *profitTemp2 = [NSNumber numberWithInt:profitTemp];
				[profits addObject:profitTemp2];
			}
		}
	}

	sqlite3_close(db);
	[tableView1 reloadData];
}

- (NSString *)filePath 
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"erp"];
} 


// intialize the opengl view
- (void)drawRect: (NSRect)rect
{
    glClearColor(0, 0, 0, 0);
    glClear(GL_COLOR_BUFFER_BIT);
 
	glBegin(GL_LINES);
	{
		glColor3f(1, 1, 1);
		glVertex3f(-0.95, -0.95, 0.0);
		glVertex3f(0.95, -0.95, 0.0);
	}
	glEnd();
	
	glBegin(GL_LINES);
	{
		glColor3f(1, 1, 1);
		glVertex3f(-0.95, 0.95, 0.0);
		glVertex3f(-0.95, -0.95, 0.0);
	}
	glEnd();
    glFlush();
	//[self constructGraph];
}

// plot graph
- (IBAction) constructGraph:(id)sender
{
	float oldx1,oldy1,oldx2,oldy2;
	int count = 0;
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select p.purchase_price, p.sales_price,s.quantity,s.product_id from PriceList as p , SalesInvoiceDetails as s where p.product_id = s.product_id order by s.product_id;"]UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{	
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSNumber *purchaseTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
			NSNumber *salesTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 1)];
			NSNumber *quantityTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 2)];
			NSNumber *productTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 3)];
			
			int profitTemp = [quantityTemp intValue] * ([salesTemp intValue] - [purchaseTemp intValue]); 
			
			float x_axis = [productTemp intValue] * 0.01;
			float y_axis = profitTemp *0.0001;
			float y_axis2 = [quantityTemp intValue] * 0.1;
			
			if (x_axis < 0.3)
			{
				x_axis -=0.4;
			}
			
			if (y_axis < 0.5)
			{
				y_axis -=0.09;
			}
			
			if (y_axis > 1)
			{
				y_axis = 0.9;
			}

			if (count == 0)
			{
				oldx1 = x_axis;
				oldy1 = y_axis;
				
				oldx2 = x_axis;
				oldy2 = y_axis2;
			}
			
			glColor3f(0, 0, 0.5);
			glBegin(GL_LINES);
			glVertex3f(x_axis, y_axis, 0.0);
			glVertex3f(x_axis, -0.95, 0.0);
			glEnd();
			glBegin(GL_LINES);
			glVertex3f(x_axis, y_axis, 0.0);
			glVertex3f(-0.95, y_axis, 0.0);
			glEnd();
			
			glColor3f(0, 1, 0);
			glBegin(GL_LINES);
			glVertex3f(x_axis, y_axis2, 0.0);
			glVertex3f(oldx2,oldy2,0.0);
			glEnd();
			oldx2 = x_axis;
			oldy2 = y_axis2;
			
			
			glColor3f(1, 0, 0);
			glBegin(GL_LINES);
			glVertex3f(x_axis, y_axis, 0.0);
			glVertex3f(oldx1,oldy1,0.0);
			glEnd();
			oldx1 = x_axis;
			oldy1 = y_axis;
			count++;

		}
	}
	sqlite3_close(db);
	

	glFlush();
}


@end
