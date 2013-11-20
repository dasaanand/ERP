//
//  Company.h
//	Display the companys having deal with us
//  Created by Dasa Anand on 08/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Company : NSObject 
{
	IBOutlet NSPopUpButton *select1,*order1,*select2;
	IBOutlet NSPopUpButton *condition1,*condition2;
	IBOutlet NSPopUpButton *option1;
	IBOutlet NSTextField *where1,*where2;
	IBOutlet NSButton *addButton, *deleteButton;
	
	IBOutlet NSTableView *tableView1,*tableView2;
	IBOutlet NSTableColumn *companyid,*name,*addressC,*number,*serviceC,*serviceC2,*servicenameC2;
	
	NSMutableArray *companyids,*names,*address,*numbers,*servicenames2,*serviceids,*serviceids2;
	
	sqlite3 *db;
}

@property (retain) NSMutableArray *companyids,*names,*address,*numbers,*servicenames2,*serviceids,*serviceids2;
@property (nonatomic, assign) IBOutlet NSTextField *where1,*where2;
@property (nonatomic, assign) IBOutlet NSButton *addButton, *deleteButton;

@property (nonatomic, assign) IBOutlet NSTableView *tableView1,*tableView2;
@property (nonatomic, assign) IBOutlet NSTableColumn *companyid,*name,*addressC,*number,*serviceC,*serviceC2,*servicenameC2;

- (IBAction) addRow:(id)sender;
- (IBAction) deleteRow:(id)sender;
- (IBAction) showAllPressed:(id)sender;
- (IBAction) searchPressed:(id)sender;


- (void) reTrace;
- (void) defaultQuery;
- (NSString *)filePath;

@end
