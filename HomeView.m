//
//  HomeView.m
//	Select the required tab from the home page
//  Created by Dasa Anand on 16/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HomeView.h"

@implementation HomeView

-(id)init
{
	self = [super init];
	return self;
}

//wait till the entire nib is loaded
-(void)awakeFromNib
{
	[self Checktab];
}



- (IBAction)BusinessAnalysisPressed:(id)sender 
{
	[tabView selectTabViewItem:[tabView tabViewItemAtIndex:7]];
	[self Checktab];
}


- (IBAction)CalendarPressed:(id)sender 
{
	[tabView selectTabViewItem:[tabView tabViewItemAtIndex:8]];
	[self Checktab];
}


- (IBAction)CompanyPressed:(id)sender 
{
	[tabView selectTabViewItem:[tabView tabViewItemAtIndex:4]];
	[self Checktab];
}


- (IBAction)CustomerPressed:(id)sender 
{
	[tabView selectTabViewItem:[tabView tabViewItemAtIndex:3]];
	[self Checktab];
}


- (IBAction)EmployeePressed:(id)sender 
{
	[tabView selectTabViewItem:[tabView tabViewItemAtIndex:6]];
	[self Checktab];
}


- (IBAction)InvoicePressed:(id)sender
{
	[tabView selectTabViewItem:[tabView tabViewItemAtIndex:1]];
	[self Checktab];
}


- (IBAction)ProductListPressed:(id)sender 
{
   	[tabView selectTabViewItem:[tabView tabViewItemAtIndex:2]];
	[self Checktab];
}


- (IBAction)StickiesPressed:(id)sender 
{
	[NSBundle loadNibNamed:@"Notes.nib" owner:self];
	[self Checktab];
}


- (IBAction)ServicePressed:(id)sender 
{
	[tabView selectTabViewItem:[tabView tabViewItemAtIndex:5]];
	[self Checktab];
}



- (IBAction)HomePressed:(id)sender
{
	[tabView selectTabViewItem:[tabView tabViewItemAtIndex:0]];
	[self Checktab];
}


// Hide the below icons if the home tab is active
- (void)Checktab
{	
	if ([tabView indexOfTabViewItem:[tabView selectedTabViewItem]] != 0 ) 
	{
		[HomeButton setHidden:0];
		[BusinessAnalysisButton1 setHidden:0];
		[CalendarButton1 setHidden:0];
		[CompanyButton1 setHidden:0];
		[CustomerButton1 setHidden:0];
		[EmployeeButton1 setHidden:0];
		[InvoiceButton1 setHidden:0];
		[ProductListButton1 setHidden:0];
		[StickiesButton1 setHidden:0];
		[ServiceButton1 setHidden:0];
	}
	else 
	{
		[HomeButton setHidden:1];
		[BusinessAnalysisButton1 setHidden:1];
		[CalendarButton1 setHidden:1];
		[CompanyButton1 setHidden:1];
		[CustomerButton1 setHidden:1];
		[EmployeeButton1 setHidden:1];
		[InvoiceButton1 setHidden:1];
		[ProductListButton1 setHidden:1];
		[StickiesButton1 setHidden:1];
		[ServiceButton1 setHidden:1];
	}
}

@end
