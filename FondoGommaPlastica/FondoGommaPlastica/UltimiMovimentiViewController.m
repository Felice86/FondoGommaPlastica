//
//  UltimiMovimentiViewController.m
//  FondoGommaPlastica
//
//  Created by Felice on 02/07/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import "UltimiMovimentiViewController.h"

@implementation UltimiMovimentiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.dataSource = self;
    
    PageContentViewController *startingViewController = [self pageContentViewControllerForIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshUI];
}
         
- (void)refreshUI {
    CGFloat y = CGRectGetMaxY(self.titoloLabel.frame) + 8;
    CGFloat height = (self.footerView.frame.origin.y - y);
    CGRect framePageViewController = CGRectMake(0, 0, self.view.frame.size.width, height);
    for (PageContentViewController *viewController in self.pageViewController.viewControllers) {
        viewController.contentScrollView.frame = framePageViewController;
    }
    framePageViewController.origin.y = y;
    self.pageViewController.view.frame = framePageViewController;
}

- (PageContentViewController*)pageContentViewControllerForIndex:(NSUInteger)index {
    Contributo *contributo = [[[Aderente sharedAderente] contributi] objectAtIndex:index];
    CGFloat y = CGRectGetMaxY(self.titoloLabel.frame);
    CGFloat height = (self.footerView.frame.origin.y - y);
    CGRect framePageViewController = CGRectMake(0, 0, self.view.frame.size.width, height);
    PageContentViewController *pageContentViewController = [[PageContentViewController alloc] initWithFrame:framePageViewController];
    [self iniziaCreazioneLabelForScrollView:pageContentViewController.contentScrollView];
    [self inserisciTutteLeProprietaInOggetto:contributo contentScrollViewController:pageContentViewController.contentScrollView];
    pageContentViewController.index = index;
    return pageContentViewController;
}

#pragma mark UI page controller
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController 
{
    NSUInteger index = ((PageContentViewController*)viewController).index;
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    
    index--;
    return [self pageContentViewControllerForIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController 
{
    NSUInteger index = ((PageContentViewController*)viewController).index;
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index== [[Aderente sharedAderente] contributi].count) {
        return nil;
    }
    return [self pageContentViewControllerForIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [[[Aderente sharedAderente] contributi] count] == 1?0:[[[Aderente sharedAderente] contributi] count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

@end
