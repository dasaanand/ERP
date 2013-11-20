//
//  HomeView.h
//
//  Created by Dasa Anand on 16/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface HomeView : NSView
{
    IBOutlet NSButton *BusinessAnalysisButton;
    IBOutlet NSButton *CalendarButton;
    IBOutlet NSButton *CompanyButton;
    IBOutlet NSButton *CustomerButton;
    IBOutlet NSButton *EmployeeButton;
    IBOutlet NSButton *InvoiceButton;
    IBOutlet NSButton *ProductListButton;
    IBOutlet NSButton *StickiesButton;
    IBOutlet NSButton *ServiceButton;
	IBOutlet NSButton *HomeButton;
	IBOutlet NSTabView *tabView;
	
	IBOutlet NSButton *BusinessAnalysisButton1;
    IBOutlet NSButton *CalendarButton1;
    IBOutlet NSButton *CompanyButton1;
    IBOutlet NSButton *CustomerButton1;
    IBOutlet NSButton *EmployeeButton1;
    IBOutlet NSButton *InvoiceButton1;
    IBOutlet NSButton *ProductListButton1;
    IBOutlet NSButton *StickiesButton1;
    IBOutlet NSButton *ServiceButton1;
	
}

- (IBAction)BusinessAnalysisPressed:(id)sender;
- (IBAction)CalendarPressed:(id)sender;
- (IBAction)CompanyPressed:(id)sender;
- (IBAction)CustomerPressed:(id)sender;
- (IBAction)EmployeePressed:(id)sender;
- (IBAction)InvoicePressed:(id)sender;
- (IBAction)ProductListPressed:(id)sender;
- (IBAction)StickiesPressed:(id)sender;
- (IBAction)ServicePressed:(id)sender;
- (IBAction)HomePressed:(id)sender;
- (void)Checktab;

@end
