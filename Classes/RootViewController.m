//
//  RootViewController.m
//  trinary-clock
//
//  Created by Christoph Thelen on 01.08.10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "RootViewController.h"
#import "MainViewController.h"
#import "FlipsideViewController.h"


@implementation RootViewController

@synthesize infoButton;
@synthesize flipsideNavigationBar;
@synthesize mainViewController;
@synthesize flipsideViewController;

- (NSDateComponents *)dayComponents {
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	return [gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:dateTime];
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
	return [dateTime timeIntervalSinceReferenceDate] * -1000.0;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    MainViewController *viewController = [[MainViewController alloc] initWithNibName:@"MainView" bundle:nil];
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
	NSTimeInterval interval = [dateTime timeIntervalSinceNow] * -1000.0;
	[dateTime release];
	dateTime = [[NSDate date] retain];
	
	[hour update:[self getHour]];
	[minute update:[self getMinute]];
	[second update:[self getSecond]];
	[millisecond update:interval];
}


- (void)loadFlipsideViewController {
    
    FlipsideViewController *viewController = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
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
