//
//  SalesInvoice.h
//
//  Created by Dasa Anand on 03/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SalesInvoice : NSObject 
{	
	IBOutlet NSWindow *window;
	IBOutlet NSPopUpButton *customer_name,*product_id,*product_name,*model,*company;
	IBOutlet NSTextField *customerid,*name,*address,*number,*type,*price;
	
	
	IBOutlet NSTableView *tableView1;
	IBOutlet NSTableColumn *itemNoColumn;
	IBOutlet NSTableColumn *product_idColumn;
	IBOutlet NSTableColumn *productColumn;
	IBOutlet NSTableColumn *ModalColumn;	
	IBOutlet NSTableColumn *quantityColumn;
	IBOutlet NSTableColumn *pricePerQuantityColumn;
	IBOutlet NSTableColumn *totalPriceColumn;
	
	IBOutlet NSTextField *date;
	IBOutlet NSTextField *invoiceNumber;
	IBOutlet NSTextField *totalSum;
	
	
	IBOutlet NSButton *addButton;
	IBOutlet NSButton *delButton;
	
	NSMutableArray *quantity,*products,*modals,*companys,*productids,*sps,*tps;
	sqlite3 *db;

}

@property (nonatomic,assign) IBOutlet NSPopUpButton *customer_name,*product_id,*product_name,*model,*company;
@property (nonatomic,assign) IBOutlet NSTextField *customerid,*name,*address,*number,*type,*price;

@property (retain) NSMutableArray *quantity,*products,*modals,*companys,*productids,*sps,*tps;
@property (nonatomic,assign) IBOutlet NSTableView *tableView1;
@property (nonatomic,assign) IBOutlet NSButton *addButton;
@property (nonatomic,assign) IBOutlet NSButton *delButton;
@property (nonatomic,assign) IBOutlet NSTableColumn *itemNoColumn;
@property (nonatomic,assign) IBOutlet NSTableColumn *product_idColumn;
@property (nonatomic,assign) IBOutlet NSTableColumn *productColumn;
@property (nonatomic,assign) IBOutlet NSTableColumn *ModalColumn;	
@property (nonatomic,assign) IBOutlet NSTableColumn *quantityColumn;
@property (nonatomic,assign) IBOutlet NSTableColumn *pricePerQuantityColumn;
@property (nonatomic,assign) IBOutlet NSTableColumn *totalPriceColumn;

@property (nonatomic,assign) IBOutlet NSTextField *date;
@property (nonatomic,assign) IBOutlet NSTextField *invoiceNumber;
@property (nonatomic,assign) IBOutlet NSTextField *totalSum;


- (IBAction) selectCustomer:(id)sender;
- (IBAction) addRow:(id)sender;
- (IBAction) deleteRow:(id)sender;
- (IBAction) selectModel:(id)sender;
- (IBAction) selectCompany:(id)sender;
- (IBAction) findRate:(id)sender;
- (IBAction) pay:(id)sender;
- (IBAction) getDetails:(id)sender;
- (IBAction) newInvoice:(id)sender;
- (IBAction) findCustomers:(id)sender;

- (NSString *)filePath;

@end
