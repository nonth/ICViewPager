//
//  HostViewController.m
//  ICViewPager
//
//  Created by Ilter Cengiz on 28/08/2013.
//  Copyright (c) 2013 Ilter Cengiz. All rights reserved.
//

#import "HostViewController.h"
#import "ContentViewController.h"

@interface HostViewController () <ViewPagerDataSource, ViewPagerDelegate>

@property (nonatomic) NSUInteger numberOfTabs;

@end

@implementation HostViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.dataSource = self;
    self.delegate = self;
    
    self.title = @"View Pager";
    
    // Keeps tab bar below navigation bar on iOS 7.0+
//     if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//         self.edgesForExtendedLayout = UIRectEdgeNone;
//     }
    
    self.navigationItem.rightBarButtonItem = ({
        
        UIBarButtonItem *button;
        button = [[UIBarButtonItem alloc] initWithTitle:@"Tab #2" style:UIBarButtonItemStylePlain target:self action:@selector(selectTabWithNumberFive)];
        
        button;
    });
    
    [self loadContent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setters

- (void)setNumberOfTabs:(NSUInteger)numberOfTabs {
    // Set numberOfTabs
    _numberOfTabs = numberOfTabs;
    
    // Reload data
    [self reloadData];
}

#pragma mark - Helpers
- (void)selectTabWithNumberFive {
    [self selectTabAtIndex:2];
}

- (void)loadContent {
    self.numberOfTabs = 3;
}

#pragma mark - Interface Orientation Changes

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    // Update changes after screen rotates
    [self performSelector:@selector(setNeedsReloadOptions) withObject:nil afterDelay:duration];
}

#pragma mark - ViewPagerDataSource

- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return self.numberOfTabs;
}

- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:12.0];
    label.text = [NSString stringWithFormat:@"Tab #%lu", (unsigned long)index];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    
    return label;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    
    ContentViewController *cvc = [self.storyboard instantiateViewControllerWithIdentifier:@"contentViewController"];
    
    cvc.labelString = [NSString stringWithFormat:@"Content View #%lu", (unsigned long)index];
    
    return cvc;
}

- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    switch (option) {
        case ViewPagerOptionStartFromSecondTab:
            return 0.0;
        case ViewPagerOptionCenterCurrentTab:
            return 0.0;
        case ViewPagerOptionTabLocation:
            return 1.0;
        case ViewPagerOptionTabIndicatorLocation:
            return 1.0;
        case ViewPagerOptionTabAlignmentCenter:
            return 1.0;
        case ViewPagerOptionTabHeight:
            return 33.0;
        case ViewPagerOptionTabOffset:
            return 36.0;
        case ViewPagerOptionTabWidth:
            return UIInterfaceOrientationIsLandscape(self.interfaceOrientation) ? 128.0 : 96.0;
        case ViewPagerOptionFixFormerTabsPositions:
            return 0.0;
        case ViewPagerOptionFixLatterTabsPositions:
            return 0.0;
        case ViewPagerOptionEnableSwipeContentView:
            return 1.0;
//        case ViewPagerOptionTabYOffset:
//            return 30.0;
        default:
            return value;
    }
}

- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    switch (component) {
        case ViewPagerIndicator:
            return [[UIColor redColor] colorWithAlphaComponent:0.64];
        case ViewPagerTabsView:
            return [[UIColor lightGrayColor] colorWithAlphaComponent:0.32];
        case ViewPagerContent:
            return [[UIColor darkGrayColor] colorWithAlphaComponent:0.32];
        default:
            return color;
    }
}

#pragma mark - ViewPagerDelegate

- (void)viewPager:(ViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index {
//    NSLog(@"ViewPager change tab to index: %lu", (unsigned long)index);
}

@end
