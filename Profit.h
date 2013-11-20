//
//  Profit.h
//	Business analysis details and graph drawing
//  Created by Dasa Anand on 08/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Profit : NSOpenGLView
{
	IBOutlet NSPopUpButton *select1,*order1;
	IBOutlet NSPopUpButton *condition1;
	IBOutlet NSTextField *where1;
	
	IBOutlet NSTableView *tableView1;
	IBOutlet NSTableColumn *profit,*quantityC,*product_id;
	
	NSMutableArray *profits,*quantity,*product_ids;
	
	sqlite3 *db;
}

@property (retain) NSMutableArray *profits,*quantity,*product_ids;
@property (nonatomic, assign) IBOutlet NSTextField *where1;

@property (nonatomic, assign) IBOutlet NSTableView *tableView1;
@property (nonatomic, assign) IBOutlet IBOutlet NSTableColumn *profit,*quantityC,*product_id;

- (IBAction) showAllPressed:(id)sender;
- (IBAction) searchPressed:(id)sender;
- (IBAction) constructGraph:(id)sender;

- (void) reTrace;
- (void) defaultQuery;
- (NSString *)filePath;

@end
