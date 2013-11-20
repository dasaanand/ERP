//
// Calendar.m
//
// Created by Dasa Anand on 02/11/10.
// Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Calendar.h"

@implementation Calendar

@synthesize d0, d1 , d2 , d3 , d4 , d5 , d6 , a29 , a30 , a31;
@synthesize month,year;

- (void)awakeFromNib
{
	m = 10;
	y = 2010;
	d = 30;
	daystart = 0;
	dayend = 6;
	changed = 1;
	[self setDate];
}


- (void) setDate
{
	if (changed == 1)
	{
		NSArray *months = [NSArray arrayWithObjects:@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December",nil];
		[month setStringValue:[months objectAtIndex:m]];
		[year setIntValue:y];
		
		if (m == 1)
		{
			d = 28;
			daystart = dayend+1;
			dayend = daystart-1;
			[a29 setHidden:1];
			[a30 setHidden:1];
			[a31 setHidden:1];
		}
		else
		{
			[a29 setHidden:0];
			[a30 setHidden:0];
			
			if (m<7)
			{
				d = 30;
				if (m%2 == 0)
				{
					d = 31;
				}
			}
			else
			{
				d = 30;
				if ((m-1)%2 == 0)
				{
					d = 31;
				}
			}
		}
		
		if (next == 1)
		{
			daystart = (dayend+1)%7;
			if (d <= 30)
			{
				[a31 setHidden:1];
				dayend = (daystart+1)%7;
			}
			else 
			{
				[a31 setHidden:0];
				dayend = (daystart+2)%7;
			}
		}
		else 
		{
			dayend = (daystart-1);
			if (dayend == -1)
			{
				dayend = 6;
			}
			
			if (d <= 30)
			{
				[a31 setHidden:1];
				daystart = dayend-1;
				if (daystart == -1)
				{
					daystart = 6;
				}
				
			}
			else 
			{
				[a31 setHidden:0];
				daystart = dayend-2;
				if (daystart == -1)
				{
					daystart = 6;
				}
				if (daystart == -2)
				{
					daystart = 5;
				}
			}
		}

		
		NSArray *days = [NSArray arrayWithObjects:@"Mon",@"Tue",@"Wed",@"Thur",@"Fri",@"Sat",@"Sun",nil];
		
		int i = daystart;
		[d0 setTitle:[days objectAtIndex:i]];i=(i+1)%7;
		[d1 setTitle:[days objectAtIndex:i]];i=(i+1)%7;
		[d2 setTitle:[days objectAtIndex:i]];i=(i+1)%7;
		[d3 setTitle:[days objectAtIndex:i]];i=(i+1)%7;
		[d4 setTitle:[days objectAtIndex:i]];i=(i+1)%7;
		[d5 setTitle:[days objectAtIndex:i]];i=(i+1)%7;
		[d6 setTitle:[days objectAtIndex:i]];

	}
}


- (IBAction)nextMonthPressed:(id)sender
{
	next = 1;
	m++;
	changed = 1;
	if (m>11)
	{
		if (y<=2010)
		{
			m = 0;
			y++;
		}
		else
		{
			m--;
			changed = 0;
		}
	}
	[self setDate];
}

- (IBAction)previousMonthPressed:(id)sender
{
	next = -1;
	m--;	
	changed = 1;
	if (m<0)
	{
		if (y>=2010)
		{
			m =11;
			y--;
		}
		else 
		{
			m++;
			changed = 0;
		}
	}
	[self setDate];
}

@end
