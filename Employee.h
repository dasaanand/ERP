//
//  Employee.h
//	Display the employee in the organization
//  Created by Dasa Anand on 08/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Employee : NSObject
{
	IBOutlet NSPopUpButton *select1,*order1,*select2,*select3;
	IBOutlet NSPopUpButton *condition1,*condition2,*condition3;
	IBOutlet NSPopUpButton *option1,*option2;
	IBOutlet NSTextField *where1,*where2,*where3;
	IBOutlet NSButton *addButton, *deleteButton;
	
	IBOutlet NSTableView *tableView1;
	IBOutlet NSTableColumn *empid,*name,*number,*job,*qualification,*leave,*salary,*shopid,*compid,*addressC;
	
	NSMutableArray *empids,*names,*numbers,*jobs,*qualifications,*leaves,*salarys,*shopids,*compids,*address;
	
	sqlite3 *db;
}

@property (retain) NSMutableArray *empids,*names,*numbers,*jobs,*qualifications,*leaves,*salarys,*shopids,*compids,*address;
@property (nonatomic, assign) IBOutlet NSTextField *where1,*where2,*where3;
@property (nonatomic, assign) IBOutlet NSButton *addButton, *deleteButton;

@property (nonatomic, assign) IBOutlet NSTableView *tableView1;
@property (nonatomic, assign) IBOutlet NSTableColumn *empid,*name,*number,*job,*qualification,*leave,*salary,*shopid,*compid,*addressC;

- (IBAction) addRow:(id)sender;
- (IBAction) deleteRow:(id)sender;
- (IBAction) showAllPressed:(id)sender;
- (IBAction) searchPressed:(id)sender;


- (void) reTrace;
- (void) defaultQuery;
- (NSString *)filePath;


@end
