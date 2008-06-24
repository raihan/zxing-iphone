//
//  ScanViewController.m
//  ZXing
//
//  Created by Christian Brunschen on 24/06/2008.
//  Copyright 2008 Google Inc. All rights reserved.
//

#import "ScanViewController.h"
#import "ResultAction.h"


#define TEXT_VIEW_TAG 0x17
#define TITLE_HEIGHT 60
#define BODY_HEIGHT 100

@implementation ScanViewController

@synthesize result;
@synthesize scan;

- (id)initWithResult:(ParsedResult *)r forScan:(Scan *)s {
	if (self = [super initWithStyle:UITableViewStyleGrouped]) {
    self.result = r;
    self.scan = s;
    self.title = NSLocalizedString(@"Scan", @"scan view controller title");
	}
	return self;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [[result actions] count] ? 2 : 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  switch (section) {
    case 0:
      return 2;
    case 1:
      return [[result actions] count];
    default:
      return 0;
  }
}

- (UITableViewCell *)cellWithIdentifier:(NSString *)identifier inTableView:(UITableView *)tableView {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:identifier] autorelease];
	}
  return cell;
}

- (UITableViewCell *)titleCellInTableView:(UITableView *)tableView {
	static NSString *TitleIdentifier = @"ScanViewTitleIdentifier";
  return [self cellWithIdentifier:TitleIdentifier inTableView:tableView];
}

- (UITableViewCell *)bodyCellInTableView:(UITableView *)tableView {
	static NSString *BodyIdentifier = @"ScanViewBodyIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BodyIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 320, BODY_HEIGHT) reuseIdentifier:BodyIdentifier] autorelease];
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectInset(cell.contentView.bounds, 6, 6)];
    [textView setTag:TEXT_VIEW_TAG];
    textView.editable = NO;
    [textView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    [cell.contentView addSubview:textView];
    [textView release];
	}
  return cell;
}

- (UITableViewCell *)buttonCellInTableView:(UITableView *)tableView {
	static NSString *ButtonIdentifier = @"ScanViewButtonIdentifier";
  return [self cellWithIdentifier:ButtonIdentifier inTableView:tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    if (indexPath.row == 0) {
      return TITLE_HEIGHT;
    } else if (indexPath.row == 1) {
      return BODY_HEIGHT;
    }
  }
  return tableView.rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
  UITableViewCell *cell;
  
  if (indexPath.section == 0) {
    if (indexPath.row == 0) {
      cell = [self titleCellInTableView:tableView];
      cell.image = [result icon];
      cell.text = [[result class] typeName];
    } else if (indexPath.row == 1) {
      cell = [self bodyCellInTableView:tableView];
      UITextView *textView = (UITextView *)[cell viewWithTag:TEXT_VIEW_TAG];
      textView.text = [result stringForDisplay];
    }
  } else if (indexPath.section == 1) {
    cell = [self buttonCellInTableView:tableView];
    ResultAction *action = [[result actions] objectAtIndex:indexPath.row];
    cell.text = [action title];
  }
	
	return cell;
}

- (void)performAction:(ResultAction *)action {
  [action performActionWithController:self shouldConfirm:NO];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 1) {
    ResultAction *action = [[result actions] objectAtIndex:indexPath.row];
    [self performSelector:@selector(performAction:) withObject:action afterDelay:0.0];
  }
}

/*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (editingStyle == UITableViewCellEditingStyleDelete) {
	}
	if (editingStyle == UITableViewCellEditingStyleInsert) {
	}
}
*/

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

/*
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section != 1) {
    return nil;
  }
  return indexPath;
}


- (void)dealloc {
  [result release];
  [scan release];
	[super dealloc];
}


- (void)viewDidLoad {
	[super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
}

- (void)viewDidDisappear:(BOOL)animated {
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}


@end

