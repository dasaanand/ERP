//
//  ServiceCentre.h
//	Service centres available for the products that we have 
//  Created by Dasa Anand on 08/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ServiceCentre : NSObject 
{
	IBOutlet NSPopUpButton *select1,*order1,*select2;
	IBOutlet NSPopUpButton *condition1,*condition2;
	IBOutlet NSPopUpButton *option1;
	IBOutlet NSTextField *where1,*where2;
	IBOutlet NSButton *addButton, *deleteButton;
	
	IBOutlet NSTableView *tableView1;
	IBOutlet NSTableColumn *serviceid,*name,*addressC,*number;
	
	NSMutableArray *serviceids,*names,*address,*numbers;
	
	sqlite3 *db;
}

@property (retain) NSMutableArray *serviceids,*names,*address,*numbers;
@property (nonatomic, assign) IBOutlet NSTextField *where1,*where2;
@property (nonatomic, assign) IBOutlet NSButton *addButton, *deleteButton;

@property (nonatomic, assign) IBOutlet NSTableView *tableView1;
@property (nonatomic, assign) IBOutlet NSTableColumn *serviceid,*name,*addressC,*number;

- (IBAction) addRow:(id)sender;
- (IBAction) deleteRow:(id)sender;
- (IBAction) showAllPressed:(id)sender;
- (IBAction) searchPressed:(id)sender;


- (void) reTrace;
- (void) defaultQuery;
- (NSString *)filePath;

@end
