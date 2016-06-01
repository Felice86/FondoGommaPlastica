//
//  RootViewController.h
//  FondoGommaPlastica
//
//  Created by Felice on 31/05/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"

@interface RootViewController : UIViewController <UIPageViewControllerDataSource,UIPageViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *footerImageView;
@property (nonatomic, weak) IBOutlet UIView *contentView;

@end
