//
//  Calendar.h
//	Implements the calendar for next and before two years
//  Created by Dasa Anand on 02/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Calendar : NSObject
{
	int m,y,d,dayend,daystart,changed,next;
	IBOutlet NSButton *nextMonth;
	IBOutlet NSButton *previousMonth;
	IBOutlet NSButton *d0;
	IBOutlet NSButton *d1;
	IBOutlet NSButton *d2;
	IBOutlet NSButton *d3;
	IBOutlet NSButton *d4;
	IBOutlet NSButton *d5;
	IBOutlet NSButton *d6;
	IBOutlet NSButton *a29;
	IBOutlet NSButton *a30;
	IBOutlet NSButton *a31;
	IBOutlet NSTextField *month;
	IBOutlet NSTextField *year;
	
}

@property (nonatomic,assign)	 IBOutlet NSButton *d0;
@property (nonatomic,assign)	 IBOutlet NSButton *d1;
@property (nonatomic,assign) IBOutlet NSButton *d2;
@property (nonatomic,assign) IBOutlet NSButton *d3;
@property (nonatomic,assign) IBOutlet NSButton *d4;
@property (nonatomic,assign) IBOutlet NSButton *d5;
@property (nonatomic,assign) IBOutlet NSButton *d6;
@property (nonatomic,assign) IBOutlet NSButton *a29;
@property (nonatomic,assign) IBOutlet NSButton *a30;
@property (nonatomic,assign) IBOutlet NSButton *a31;
@property (nonatomic,assign) IBOutlet NSTextField *month;
@property (nonatomic,assign) IBOutlet NSTextField *year;


- (IBAction)nextMonthPressed:(id)sender;
- (IBAction)previousMonthPressed:(id)sender;

- (void) setDate;


@end
