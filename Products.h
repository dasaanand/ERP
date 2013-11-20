//
//  Products.h
//	Products that we deal with
//  Created by Dasa Anand on 09/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Products : NSObject 
{
	IBOutlet NSPopUpButton *select1,*order1,*select2,*select3;
	IBOutlet NSPopUpButton *condition1,*condition2,*condition3;
	IBOutlet NSPopUpButton *option1,*option2;
	IBOutlet NSTextField *where1,*where2,*where3;
	IBOutlet NSButton *addButton, *deleteButton;
	
	IBOutlet NSTableView *tableView1;
	IBOutlet NSTableColumn *productid,*product,*modal,*companyname,*servicename,*stock,*pp,*sp,*difference;
	
	NSMutableArray *productids,*products,*modals,*companynames,*servicenames,*stocks,*pps,*sps,*differences;
	
	sqlite3 *db;
}

@property (retain) NSMutableArray *productids,*products,*modals,*companynames,*servicenames,*stocks,*pps,*sps,*differences;
@property (nonatomic, assign) IBOutlet NSTextField *where1,*where2,*where3;
@property (nonatomic, assign) IBOutlet NSButton *addButton, *deleteButton;

@property (nonatomic, assign) IBOutlet NSTableView *tableView1;
@property (nonatomic, assign) IBOutlet NSTableColumn *productid,*product,*modal,*companyname,*servicename,*stock,*pp,*sp,*difference;

- (IBAction) addRow:(id)sender;
- (IBAction) deleteRow:(id)sender;
- (IBAction) showAllPressed:(id)sender;
- (IBAction) searchPressed:(id)sender;


- (void) reTrace;
- (void) defaultQuery;
- (NSString *)filePath;

@end
