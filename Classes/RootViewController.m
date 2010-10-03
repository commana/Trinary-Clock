//
//  RootViewController.m
//  trinary-clock
//
//  Created by Christoph Thelen on 01.08.10.
//  Copyright (c) 2010 Christoph Thelen. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "RootViewController.h"


@implementation RootViewController

@synthesize infoButton;
@synthesize flipsideNavigationBar;
@synthesize mainViewController;
@synthesize flipsideViewController;

- (NSDateComponents *)dayComponents {
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *components = [gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:dateTime];
	[gregorian release];
	return components;
}

- (CGFloat)getHour {
	return [[self dayComponents] hour] / 24.0;
}

- (CGFloat)getMinute {
	return [[self dayComponents] minute] / 60.0;
}

- (CGFloat)getSecond {
	return [[self dayComponents] second] / 60.0;
}

- (CGFloat)getMillisecond {
	NSTimeInterval interval = [NSDate timeIntervalSinceReferenceDate];
	NSString *intervalString = [NSString stringWithFormat:@"%f", interval];
	NSArray *components = [intervalString componentsSeparatedByString:@"."];
	CGFloat milliseconds = [[components objectAtIndex:1] floatValue] / (1000.0 * 1000.0);
	
	return milliseconds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
    UIViewController *viewController = [[UIViewController alloc] initWithNibName:@"MainView" bundle:nil];
    self.mainViewController = viewController;
    [viewController release];
    
    [self.view insertSubview:mainViewController.view belowSubview:infoButton];
	
	CGRect frame = mainViewController.view.frame;
	dateTime = [[NSDate date] retain];
	
	hour = [[Sinus alloc] initWithFrame:frame color:[UIColor redColor] amplitude:0.8 thickness:3 startValue:[self getHour]];
	minute = [[Sinus alloc] initWithFrame:frame color:[UIColor greenColor] amplitude:0.5 thickness:2 startValue:[self getMinute]];
	second = [[Sinus alloc] initWithFrame:frame color:[UIColor blueColor] amplitude:0.2 thickness:1.5 startValue:[self getSecond]];
	millisecond = [[Sinus alloc] initWithFrame:frame color:[UIColor grayColor] amplitude:0.1 thickness:1 startValue:[self getMillisecond]];
	
	[mainViewController.view addSubview:hour];
	[mainViewController.view addSubview:minute];
	[mainViewController.view addSubview:second];
	[mainViewController.view addSubview:millisecond];
	
	[NSTimer scheduledTimerWithTimeInterval:0.0001 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
}

- (void)tick:(NSTimer *)timer {
	[dateTime release];
	dateTime = [[NSDate date] retain];
	
	[hour update:[self getHour]];
	[minute update:[self getMinute]];
	[second update:[self getSecond]];
	[millisecond update:[self getMillisecond]];
}


- (void)loadFlipsideViewController {
    UIViewController *viewController = [[UIViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
    self.flipsideViewController = viewController;
    [viewController release];
    
    // Set up the navigation bar
    UINavigationBar *aNavigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0)];
    aNavigationBar.barStyle = UIBarStyleBlackOpaque;
    self.flipsideNavigationBar = aNavigationBar;
    [aNavigationBar release];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(toggleView)];
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:@"Trinary Clock"];
    navigationItem.rightBarButtonItem = buttonItem;
    [flipsideNavigationBar pushNavigationItem:navigationItem animated:NO];
    [navigationItem release];
    [buttonItem release];
}


- (IBAction)toggleView {    
    /*
     This method is called when the info or Done button is pressed.
     It flips the displayed view from the main view to the flipside view and vice-versa.
     */
    if (flipsideViewController == nil) {
        [self loadFlipsideViewController];
    }
    
    UIView *mainView = mainViewController.view;
    UIView *flipsideView = flipsideViewController.view;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:([mainView superview] ? UIViewAnimationTransitionFlipFromRight : UIViewAnimationTransitionFlipFromLeft) forView:self.view cache:YES];
    
    if ([mainView superview] != nil) {
        [flipsideViewController viewWillAppear:YES];
        [mainViewController viewWillDisappear:YES];
        [mainView removeFromSuperview];
        [infoButton removeFromSuperview];
        [self.view addSubview:flipsideView];
        [self.view insertSubview:flipsideNavigationBar aboveSubview:flipsideView];
        [mainViewController viewDidDisappear:YES];
        [flipsideViewController viewDidAppear:YES];
    } else {
        [mainViewController viewWillAppear:YES];
        [flipsideViewController viewWillDisappear:YES];
        [flipsideView removeFromSuperview];
        [flipsideNavigationBar removeFromSuperview];
        [self.view addSubview:mainView];
        [self.view insertSubview:infoButton aboveSubview:mainViewController.view];
        [flipsideViewController viewDidDisappear:YES];
        [mainViewController viewDidAppear:YES];
    }
    [UIView commitAnimations];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [infoButton release];
    [flipsideNavigationBar release];
    [mainViewController release];
    [flipsideViewController release];
	
	[dateTime release];
	
	[hour release];
	[minute release];
	[second release];
	[millisecond release];
	
    [super dealloc];
}


@end
