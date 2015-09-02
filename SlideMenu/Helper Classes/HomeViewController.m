//
//  HomeViewController.m
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "HomeViewController.h"
#import "LeftMenuViewController.h"

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 503);
	self.portraitSlideOffsetSegment.selectedSegmentIndex = [self indexFromPixels:self.slideNavigationController.portraitSlideOffset];
	self.landscapeSlideOffsetSegment.selectedSegmentIndex = [self indexFromPixels:self.slideNavigationController.landscapeSlideOffset];
	self.panGestureSwitch.on = self.slideNavigationController.enableSwipeGesture;
	self.shadowSwitch.on = self.slideNavigationController.enableShadow;
	self.limitPanGestureSwitch.on = (self.slideNavigationController.panGestureSideOffset == 0) ? NO : YES;
	self.slideOutAnimationSwitch.on = ((LeftMenuViewController *)self.slideNavigationController.leftMenu).slideOutAnimationEnabled;
}

#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
	return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
	return YES;
}

#pragma mark - IBActions -

- (IBAction)bounceMenu:(id)sender
{
	static Menu menu = MenuLeft;
	
	[self.slideNavigationController bounceMenu:menu withCompletion:nil];
	
	menu = (menu == MenuLeft) ? MenuRight : MenuLeft;
}

- (IBAction)slideOutAnimationSwitchChanged:(UISwitch *)sender
{
	((LeftMenuViewController *)self.slideNavigationController.leftMenu).slideOutAnimationEnabled = sender.isOn;
}

- (IBAction)limitPanGestureSwitchChanged:(UISwitch *)sender
{
	self.slideNavigationController.panGestureSideOffset = (sender.isOn) ? 50 : 0;
}

- (IBAction)changeAnimationSelected:(id)sender
{
	[self.slideNavigationController openMenu:MenuRight withCompletion:nil];
}

- (IBAction)shadowSwitchSelected:(UISwitch *)sender
{
	self.slideNavigationController.enableShadow = sender.isOn;
}

- (IBAction)enablePanGestureSelected:(UISwitch *)sender
{
	self.slideNavigationController.enableSwipeGesture = sender.isOn;
}

- (IBAction)portraitSlideOffsetChanged:(UISegmentedControl *)sender
{
	self.slideNavigationController.portraitSlideOffset = [self pixelsFromIndex:sender.selectedSegmentIndex];
}

- (IBAction)landscapeSlideOffsetChanged:(UISegmentedControl *)sender
{
	self.slideNavigationController.landscapeSlideOffset = [self pixelsFromIndex:sender.selectedSegmentIndex];
}

#pragma mark - Helpers -

- (NSInteger)indexFromPixels:(NSInteger)pixels
{
	if (pixels == 60)
		return 0;
	else if (pixels == 120)
		return 1;
	else
		return 2;
}

- (NSInteger)pixelsFromIndex:(NSInteger)index
{
	switch (index)
	{
		case 0:
			return 60;
			
		case 1:
			return 120;
			
		case 2:
			return 200;
			
		default:
			return 0;
	}
}

@end
