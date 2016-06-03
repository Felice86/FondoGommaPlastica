//
//  RootViewController.m
//  FondoGommaPlastica
//
//  Created by Felice on 31/05/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import "RootViewController.h"
#import "PageContentViewController.h"

#define kPageController @"PageController"
#define kInfoViewController @"InfoViewController"
#define kContattiViewController @"ContattiViewController"
#define kLoginViewController @"LoginViewController"

@interface RootViewController ()
@property (nonatomic, retain) UIPageViewController *pageViewController;
@property (nonatomic, retain) NSMutableArray *pagesArray;
@property (nonatomic, retain) PageContentViewController *currentPageVC;
@property (nonatomic, retain) PageContentViewController *nextVisiblePageVC;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pagesArray = [NSMutableArray array];
    [self creaPagesArray:@[kInfoViewController,kLoginViewController,kContattiViewController]];
    [self creaPageViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self caricaCurrentContentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - PAGE VIEW CONTROLLER DATA SOURCE

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger pageIndex = ((PageContentViewController*)viewController).pageIndex;
    pageIndex++;
    if (pageIndex > self.pagesArray.count-1) {
        pageIndex = 0;
    }
    
    return [self viewControllerAtIndex:pageIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger pageIndex = ((PageContentViewController*)viewController).pageIndex;
    pageIndex--;
    if (pageIndex == -1) {
        pageIndex = self.pagesArray.count-1;
    }
    
    return [self viewControllerAtIndex:pageIndex];;
}

#pragma mark - PAGE VIEW CONTROLLER DELEGATE
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    self.nextVisiblePageVC = (PageContentViewController*)[pendingViewControllers lastObject];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        NSLog(@"pageViewController didFinishAnimating:%@",self.nextVisiblePageVC);
        self.currentPageVC = self.nextVisiblePageVC;
        [self caricaCurrentContentView];
    }
}

#pragma mark - PAGE CONTENT PROTOCOL
- (IBAction)muoviVersoSinistra:(UIButton*)senderButton {
    NSUInteger pageIndex = self.currentPageVC.pageIndex;
    NSUInteger newPageIndex = pageIndex-1;
    if (newPageIndex == -1) {
        newPageIndex = self.pagesArray.count-1;
    }
    PageContentViewController *newPageVC = [self viewControllerAtIndex:newPageIndex];
    [self.pageViewController setViewControllers:@[newPageVC] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    self.currentPageVC = newPageVC;
    [self caricaCurrentContentView];
}

- (IBAction)muoviVersoDestra:(UIButton*)senderButton {
    NSUInteger pageIndex = self.currentPageVC.pageIndex;
    NSUInteger newPageIndex = pageIndex+1;
    if (newPageIndex > self.pagesArray.count-1) {
        newPageIndex = 0;
    }
    PageContentViewController *newPageVC = [self viewControllerAtIndex:newPageIndex];
    [self.pageViewController setViewControllers:@[newPageVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    self.currentPageVC = newPageVC;
    [self caricaCurrentContentView];
}

#pragma mark - ACCESSORI
-(void) setCustomView:(UIView *)customView {
    NSUInteger z = NSNotFound;
//    z = [self.contentView.subviews indexOfObject:customView];
//    if (z == NSNotFound) {
//        [self.contentView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
//        [self.contentView addSubview:customView];
//    }
    if (self.contentView) {
        z = [self.view.subviews indexOfObject:self.contentView];
    }
    if (z == NSNotFound) {
        // old view was not in hierarchy
        // you can insert subview at any index and any view you want by default
        [self.view addSubview:customView];
    } else {
        // you can save superview
        UIView *superview = self.contentView.superview;
        [self.contentView removeFromSuperview];
        //also you can copy some attributes of old view:
        //customView.center = _customView.center
        [superview insertSubview:customView atIndex:z];
    }
    //and save ivar
    self.contentView = customView;
}

- (void)caricaCurrentContentView {
    self.currentPageVC.contentView.frame = self.contentView.frame;
    [self setCustomView:self.currentPageVC.contentView];
}

- (void)creaPageViewController {
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:kPageController];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

    
    [self addChildViewController:_pageViewController];
    [self.view insertSubview:_pageViewController.view belowSubview:self.footerImageView];
    [self.pageViewController didMoveToParentViewController:self];

    self.currentPageVC = startingViewController;
}

- (void)creaPagesArray:(NSArray*)pagesIdentifiers {
    for (NSString *pageId in pagesIdentifiers) {
        PageContentViewController *pageContentVC = [self.storyboard instantiateViewControllerWithIdentifier:pageId];
        [self.pagesArray addObject:pageContentVC];
    }
}

- (PageContentViewController*)viewControllerAtIndex:(NSUInteger)pageIndex {
    PageContentViewController *pageContentViewController = (PageContentViewController*)[self.pagesArray objectAtIndex:pageIndex];
    pageContentViewController.pageIndex = pageIndex;
    return pageContentViewController;
}

@end
