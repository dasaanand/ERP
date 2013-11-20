//
//  LoginScreen.h
//
//  Created by Dasa Anand on 16/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LoginScreen :  NSWindowController {
    IBOutlet NSTextField *employeeid;
    IBOutlet NSTextField *password;
	
	NSMutableArray *empid;
	NSMutableArray *emppassword;

	sqlite3 *db;
}

@property (nonatomic,assign) NSMutableArray *empid;
@property (nonatomic,assign) NSMutableArray *emppassword;

- (IBAction)CancelPressed:(id)sender;
- (IBAction)LoginPressed:(id)sender;
- (IBAction)ResetPressed:(id)sender;

- (NSString *)filePath;

@end
