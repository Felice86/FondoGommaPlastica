//
//  RootViewController.m
//  FondoGommaPlastica
//
//  Created by Felice on 31/05/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import "RootViewController.h"

#define kPageController @"PageController"

@interface RootViewController ()
@property (nonatomic, retain) UIPageViewController *pageViewController;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)creaPageViewController {
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:kPageController];
    self.pageViewController.dataSource = self;
}

@end
