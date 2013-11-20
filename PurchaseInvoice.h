//
//  PurchaseInvoice.h
//
//  Created by Dasa Anand on 10/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PurchaseInvoice : NSObject 
{	
	IBOutlet NSPopUpButton *company_name,*product_name,*model;
	IBOutlet NSTextField *companyid,*name,*address,*number,*price;
	IBOutlet NSTextField *newproduct,*newmodel,*newpp,*newsp;
	
	IBOutlet NSTableView *tableView1;
	IBOutlet NSTableColumn *product_idColumn;
	IBOutlet NSTableColumn *productColumn;
	IBOutlet NSTableColumn *ModalColumn;	
	IBOutlet NSTableColumn *quantityColumn;
	IBOutlet NSTableColumn *pricePerQuantityColumn;
	IBOutlet NSTableColumn *totalPriceColumn;
	IBOutlet NSTableColumn *salesPriceColumn;
	
	IBOutlet NSTextField *date;
	IBOutlet NSTextField *invoiceNumber;
	IBOutlet NSTextField *totalSum;
	
	
	IBOutlet NSButton *addButton;
	IBOutlet NSButton *delButton,*newProductButton;
	
	NSMutableArray *quantity,*products,*modals,*companys,*productids,*sps,*tps,*cps;
	sqlite3 *db;
	
}

@property (nonatomic,assign) IBOutlet NSPopUpButton *company_name,*product_name,*model;
@property (nonatomic,assign) IBOutlet NSTextField *companyid,*name,*address,*number,*price,*newproduct,*newmodel,*newpp,*newsp;

@property (retain) NSMutableArray *quantity,*products,*modals,*companys,*productids,*sps,*tps,*cps;
@property (nonatomic,assign) IBOutlet NSTableView *tableView1;
@property (nonatomic,assign) IBOutlet NSButton *addButton;
@property (nonatomic,assign) IBOutlet NSButton *delButton;
@property (nonatomic,assign) IBOutlet NSTableColumn *product_idColumn;
@property (nonatomic,assign) IBOutlet NSTableColumn *productColumn;
@property (nonatomic,assign) IBOutlet NSTableColumn *ModalColumn;	
@property (nonatomic,assign) IBOutlet NSTableColumn *quantityColumn;
@property (nonatomic,assign) IBOutlet NSTableColumn *pricePerQuantityColumn;
@property (nonatomic,assign) IBOutlet NSTableColumn *totalPriceColumn,*salesPriceColumn;

@property (nonatomic,assign) IBOutlet NSTextField *date;
@property (nonatomic,assign) IBOutlet NSTextField *invoiceNumber;
@property (nonatomic,assign) IBOutlet NSTextField *totalSum;


- (IBAction) selectcompany:(id)sender;
- (IBAction) addRow:(id)sender;
- (IBAction) deleteRow:(id)sender;
- (IBAction) selectModel:(id)sender;
- (IBAction) findRate:(id)sender;
- (IBAction) pay:(id)sender;
- (IBAction) getDetails:(id)sender;
- (IBAction) newInvoice:(id)sender;
- (IBAction) newProduct:(id)sender;
- (IBAction) findCompany:(id)sender;

- (NSString *)filePath;

@end
