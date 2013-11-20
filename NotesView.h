//
//  NotesView.h
//	Quick Notes display from the file and sticky
//  Created by Dasa Anand on 06/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NotesView : NSWindowController
{
	IBOutlet NSTextField *notes;
	IBOutlet NSTextView *note;
	IBOutlet NSButton *save,*close,*revert;
	IBOutlet NSWindow *window;
	sqlite3 *db;
}

@property (nonatomic,assign) IBOutlet NSTextField *notes;
@property (nonatomic,assign) IBOutlet NSTextView *note;
@property (assign) IBOutlet NSWindow *window;

- (IBAction) savePressed:(id)sender;
- (IBAction) revertPressed:(id)sender;
- (IBAction) loadPressed:(id)sender;
- (IBAction) closePressed:(id)sender;

- (NSString *)filePath;
- (void) revertToSaved;

@end
