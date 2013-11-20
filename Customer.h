//
//  Customer.h
//	display all the customers having account with us
//  Created by Dasa Anand on 09/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Customer  : NSObject 
{
	IBOutlet NSPopUpButton *select1,*order1,*select2;
	IBOutlet NSPopUpButton *condition1,*condition2;
	IBOutlet NSPopUpButton *option1;
	IBOutlet NSTextField *where1,*where2;
	IBOutlet NSButton *addButton, *deleteButton;
	
	IBOutlet NSTableView *tableView1;
	IBOutlet NSTableColumn *customerid,*name,*addressC,*number,*typeC;
	
	NSMutableArray *customerids,*names,*address,*numbers,*type;
	
	sqlite3 *db;
}

@property (retain) NSMutableArray *customerids,*names,*address,*numbers,*type;
@property (nonatomic, assign) IBOutlet NSTextField *where1,*where2;
@property (nonatomic, assign) IBOutlet NSButton *addButton, *deleteButton;

@property (nonatomic, assign) IBOutlet NSTableView *tableView1;
@property (nonatomic, assign) IBOutlet NSTableColumn *customerid,*name,*addressC,*number,*typeC;

- (IBAction) addRow:(id)sender;
- (IBAction) deleteRow:(id)sender;
- (IBAction) showAllPressed:(id)sender;
- (IBAction) searchPressed:(id)sender;


- (void) reTrace;
- (void) defaultQuery;
- (NSString *)filePath;

@end
