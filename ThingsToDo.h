//
//  ThingsToDo.h
//	Things to perform wrt sales and purchase invoice
//  Created by Dasa Anand on 06/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ThingsToDo : NSObject
{
	IBOutlet NSPopUpButton *select1,*order1;
	IBOutlet NSPopUpButton *condition1;
	IBOutlet NSTextField *where1;
	IBOutlet NSButton *addButton, *deleteButton, *salesButton, *purchaseButton;
	
	IBOutlet NSTableView *tableView1;
	IBOutlet NSTableColumn *date,*thingsToDo,*invoiceno;
	
	NSMutableArray *dates,*things,*invoicenos;
	
	sqlite3 *db;
	int option;
	
}

@property (retain) NSMutableArray *dates,*things,*invoicenos;
@property (nonatomic, assign) IBOutlet NSTextField *where1;
@property (nonatomic, assign) IBOutlet NSButton *addButton, *deleteButton;

@property (nonatomic, assign) IBOutlet NSTableView *tableView1;
@property (nonatomic, assign) IBOutlet NSTableColumn *date,*thingsToDo,*invoiceno;

- (IBAction) addRow:(id)sender;
- (IBAction) deleteRow:(id)sender;
- (IBAction) salesPressed:(id)sender;
- (IBAction) purchasedPressed:(id)sender;
- (IBAction) showAllPressed:(id)sender;
- (IBAction) searchPressed:(id)sender;


- (void) reTrace;
- (void) defaultQuery;
- (NSString *)filePath;

@end
