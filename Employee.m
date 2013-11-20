//
//  Employee.m
//
//  Created by Dasa Anand on 08/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Employee.h"

@implementation Employee

@synthesize addButton, deleteButton, tableView1, where1,where2, where3,empids,names,numbers,jobs,qualifications,leaves,salarys,shopids,compids, empid,name,number,job,qualification,leave,salary,shopid,compid,address,addressC;

- (id)init
{
	empids = [[NSMutableArray alloc] init];
	names = [[NSMutableArray alloc] init];
	numbers = [[NSMutableArray alloc] init];
	jobs = [[NSMutableArray alloc] init];
	qualifications = [[NSMutableArray alloc] init];
	leaves = [[NSMutableArray alloc] init];
	salarys = [[NSMutableArray alloc] init];
	shopids = [[NSMutableArray alloc] init];
	compids = [[NSMutableArray alloc] init];
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
	if (tableColumn == empid) 
		return [empids objectAtIndex:row];
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
				if (tableColumn == job) 
					return [jobs  objectAtIndex:row];
				else
				{
					if (tableColumn == qualification) 
						return [qualifications  objectAtIndex:row];
					else
					{
						if (tableColumn == leave) 
							return [leaves  objectAtIndex:row];
						else
						{
							if (tableColumn == salary) 
								return [salarys  objectAtIndex:row];
							else
							{
								if (tableColumn == shopid) 
									return [shopids  objectAtIndex:row];
								else
								{
									if (tableColumn == addressC)
										return [address objectAtIndex:row];
									else 
										return [compids objectAtIndex:row];
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
	int empidTemp = [[empids objectAtIndex:rowIndex] intValue] ;
	
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
			if (aTableColumn == job) 
			{
				[jobs replaceObjectAtIndex:rowIndex withObject:anObject];
			}
			else
			{
				if (aTableColumn == qualification) 
				{
					[qualifications replaceObjectAtIndex:rowIndex withObject:anObject];
				}
				else
				{
					if (aTableColumn == leave) 
					{
						[leaves replaceObjectAtIndex:rowIndex withObject:anObject];
					}
					else
					{
						if (aTableColumn == salary) 
						{
							[salarys replaceObjectAtIndex:rowIndex withObject:anObject];
						}
						else
						{
							if (aTableColumn == shopid) 
							{
								[shopids replaceObjectAtIndex:rowIndex withObject:anObject];
							}
							else
							{	
								if (aTableColumn == compid) 
								{
									[compids replaceObjectAtIndex:rowIndex withObject:anObject];
								}
								else 
								{
									[address replaceObjectAtIndex:rowIndex withObject:anObject];
								}
							}
						}
					}
				}
			}
		}
	}
	
	
	sqlite3_open([[self filePath] UTF8String], &db);
	sqlite3_exec(db, [[NSString stringWithFormat:@"update Employee set name = '%@', address = '%@',number = '%@', job = '%@', qualification = '%@', salary = '%@', leave = '%@', shop_id = '%@', company_id = '%@' where emp_id = '%i';",[names objectAtIndex:rowIndex], [address objectAtIndex:rowIndex] ,[numbers objectAtIndex:rowIndex], [jobs objectAtIndex:rowIndex], [qualifications objectAtIndex:rowIndex], [salarys objectAtIndex:rowIndex], [leaves objectAtIndex:rowIndex], [shopids objectAtIndex:rowIndex], [compids objectAtIndex:rowIndex],empidTemp]UTF8String], NULL, NULL, NULL);
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
	[empids removeAllObjects];
	[names removeAllObjects];
	[numbers removeAllObjects];
	[jobs removeAllObjects];
	[qualifications removeAllObjects];
	[leaves removeAllObjects];
	[salarys removeAllObjects];
	[shopids removeAllObjects];
	[compids removeAllObjects];
	[address removeAllObjects];
	
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from Employee;"]UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{	
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			NSNumber *empTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
			NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
			NSString *numberTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
			NSString *addressTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 3))];
			NSNumber *salaryTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 4)];
			NSNumber *leavesTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 5)];
			NSNumber *jobTemp=[[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 6))];
			NSString *qualificationTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 7))];
			NSNumber *compidTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 8)];
			NSNumber *shopidTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 9)];
			
			[empids addObject:empTemp];
			[names addObject:nameTemp];
			[numbers addObject:numberTemp];
			[jobs addObject:jobTemp];
			[qualifications addObject:qualificationTemp];
			[leaves addObject:leavesTemp];
			[salarys addObject:salaryTemp];
			[shopids addObject:shopidTemp];
			[compids addObject:compidTemp];
			[address addObject:addressTemp];
		}
	}
	sqlite3_close(db);
	
	[self.tableView1 reloadData];
	[self.deleteButton setHidden:1];
}


- (void)defaultQuery
{
	[empids removeAllObjects];
	[names removeAllObjects];
	[numbers removeAllObjects];
	[jobs removeAllObjects];
	[qualifications removeAllObjects];
	[leaves removeAllObjects];
	[salarys removeAllObjects];
	[shopids removeAllObjects];
	[compids removeAllObjects];
	[address removeAllObjects];
	
	if ([[order1 titleOfSelectedItem] isEqualToString:@""])
	{
		[order1 selectItemWithTitle:@"emp_id"];
	}
	
	sqlite3_stmt *statement;
	sqlite3_open([[self filePath] UTF8String], &db);
	
	if ([[where1 stringValue] isEqualToString:@""])
	{
		if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from Employee order by %@;",[order1 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
		{	
			while (sqlite3_step(statement) == SQLITE_ROW) 
			{
				NSNumber *empTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
				NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
				NSString *numberTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
				NSString *addressTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 3))];
				NSNumber *salaryTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 4)];
				NSNumber *leavesTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 5)];
				NSNumber *jobTemp=[[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 6))];
				NSString *qualificationTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 7))];
				NSNumber *compidTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 8)];
				NSNumber *shopidTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 9)];
				
				[empids addObject:empTemp];
				[names addObject:nameTemp];
				[numbers addObject:numberTemp];
				[jobs addObject:jobTemp];
				[qualifications addObject:qualificationTemp];
				[leaves addObject:leavesTemp];
				[salarys addObject:salaryTemp];
				[shopids addObject:shopidTemp];
				[compids addObject:compidTemp];
				[address addObject:addressTemp];
			}
		}
	}
	else 
	{
		if ([[where2 stringValue] isEqualToString:@""])
		{
			if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from Employee where %@ %@ '%@' order by %@",[select1 titleOfSelectedItem], [condition1 titleOfSelectedItem] , [where1 stringValue],[order1 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
			{	
				while (sqlite3_step(statement) == SQLITE_ROW) 
				{
					NSNumber *empTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
					NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
					NSString *numberTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
					NSString *addressTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 3))];
					NSNumber *salaryTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 4)];
					NSNumber *leavesTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 5)];
					NSNumber *jobTemp=[[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 6))];
					NSString *qualificationTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 7))];
					NSNumber *compidTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 8)];
					NSNumber *shopidTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 9)];
					
					[empids addObject:empTemp];
					[names addObject:nameTemp];
					[numbers addObject:numberTemp];
					[jobs addObject:jobTemp];
					[qualifications addObject:qualificationTemp];
					[leaves addObject:leavesTemp];
					[salarys addObject:salaryTemp];
					[shopids addObject:shopidTemp];
					[compids addObject:compidTemp];
					[address addObject:addressTemp];
				}
			}
		}
		else 
		{
			if ([[where3 stringValue] isEqualToString:@""])
			{				
				if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from Employee where %@ %@ '%@' %@ %@ %@ '%@' order by %@",[select1 titleOfSelectedItem], [condition1 titleOfSelectedItem] , [where1 stringValue], [option1 titleOfSelectedItem] ,[select2 titleOfSelectedItem], [condition2 titleOfSelectedItem] , [where2 stringValue],[order1 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
				{	
					
					while (sqlite3_step(statement) == SQLITE_ROW) 
					{
						NSNumber *empTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
						NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
						NSString *numberTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
						NSString *addressTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 3))];
						NSNumber *salaryTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 4)];
						NSNumber *leavesTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 5)];
						NSNumber *jobTemp=[[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 6))];
						NSString *qualificationTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 7))];
						NSNumber *compidTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 8)];
						NSNumber *shopidTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 9)];
						
						[empids addObject:empTemp];
						[names addObject:nameTemp];
						[numbers addObject:numberTemp];
						[jobs addObject:jobTemp];
						[qualifications addObject:qualificationTemp];
						[leaves addObject:leavesTemp];
						[salarys addObject:salaryTemp];
						[shopids addObject:shopidTemp];
						[compids addObject:compidTemp];
						[address addObject:addressTemp];
					}
				}
			}
			else
			{
				if (sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"select * from Employee where %@ %@ '%@' %@ %@ %@ '%@' %@ %@ %@ '%@' order by %@",[select1 titleOfSelectedItem], [condition1 titleOfSelectedItem] , [where1 stringValue], [option1 titleOfSelectedItem] ,[select2 titleOfSelectedItem], [condition2 titleOfSelectedItem] , [where2 stringValue],[option2 titleOfSelectedItem],[select3 titleOfSelectedItem], [condition3 titleOfSelectedItem] , [where3 stringValue],[order1 titleOfSelectedItem]]UTF8String], -1, &statement, NULL) == SQLITE_OK)
				{	
					while (sqlite3_step(statement) == SQLITE_ROW) 
					{
						NSNumber *empTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
						NSString *nameTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 1))];
						NSString *numberTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 2))];
						NSString *addressTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 3))];
						NSNumber *salaryTemp=[NSNumber numberWithInt:sqlite3_column_int(statement, 4)];
						NSNumber *leavesTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 5)];
						NSNumber *jobTemp=[[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 6))];
						NSString *qualificationTemp = [[NSString alloc] initWithUTF8String:(char *)(sqlite3_column_text(statement, 7))];
						NSNumber *compidTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 8)];
						NSNumber *shopidTemp = [NSNumber numberWithInt:sqlite3_column_int(statement, 9)];
						
						[empids addObject:empTemp];
						[names addObject:nameTemp];
						[numbers addObject:numberTemp];
						[jobs addObject:jobTemp];
						[qualifications addObject:qualificationTemp];
						[leaves addObject:leavesTemp];
						[salarys addObject:salaryTemp];
						[shopids addObject:shopidTemp];
						[compids addObject:compidTemp];
						[address addObject:addressTemp];
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
	sqlite3_exec(db, [[NSString stringWithFormat:@"insert into Employee (name,contact_number,address,salary,leave,job,qualification,company_id,shop_id,password) values ('xxx',999,'yyy',0,0,'Sales','xxx',0,1,'emp');"]UTF8String], NULL, NULL, NULL);
	sqlite3_close(db);
	
	[self reTrace];
}

- (IBAction) deleteRow:(id)sender
{
	sqlite3_open([[self filePath] UTF8String], &db);
	sqlite3_exec(db, [[NSString stringWithFormat:@"delete from Employee where emp_id = '%@';",[empids objectAtIndex:[self.tableView1 selectedRow]]] UTF8String], NULL, NULL, NULL);
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
