//
//  SalesDetails.h
//	Display sales invoice details
//  Created by Dasa Anand on 09/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SalesDetails : NSObject							
{
	IBOutlet NSPopUpButton *select1,*order1,*select2,*select3;
	IBOutlet NSPopUpButton *condition1,*condition2,*condition3;
	IBOutlet NSPopUpButton *option1,*option2;
	IBOutlet NSTextField *where1,*where2,*where3;
	
	IBOutlet NSPopUpButton *select21,*order21,*select22,*select23;
	IBOutlet NSPopUpButton *condition21,*condition22,*condition23;
	IBOutlet NSPopUpButton *option21,*option22;
	IBOutlet NSTextField *where21,*where22,*where23;
	
	IBOutlet NSTableView *tableView1,*tableView2;
	IBOutlet NSTableColumn *customerid, *customername, *date, *invoiceno, *amount,*productid,*product,*modal,*companyname,*qunatityC,*sp,*totalpriceC;
	
	NSMutableArray *customerids, *customernames, *dates, *invoicenos, *amounts,*productids,*products,*modals,*companynames,*qunatity,*sps,*totalprice;
	
	sqlite3 *db;
}

@property (retain) NSMutableArray *customerids, *customernames, *dates, *invoicenos, *amounts,*productids,*products,*modals,*companynames,*qunatity,*sps,*totalprice;
@property (nonatomic, assign) IBOutlet NSTextField *where1,*where2,*where3;
@property (nonatomic, assign) IBOutlet NSTextField *where21,*where22,*where23;

@property (nonatomic, assign) IBOutlet NSTableView *tableView1,*tableView2;
@property (nonatomic, assign) IBOutlet NSTableColumn *customerid, *customername, *date, *invoiceno, *amount,*productid,*product,*modal,*companyname,*qunatityC,*sp,*totalpriceC;

- (IBAction) showAllPressed:(id)sender;
- (IBAction) searchPressed:(id)sender;
- (IBAction) showAllPressed2:(id)sender;
- (IBAction) searchPressed2:(id)sender;

- (void) findDetails:(int)pin;
- (void) reTrace;
- (void) defaultQuery;
- (void) defaultQuery2:(int)pin;
- (NSString *)filePath;

@end
