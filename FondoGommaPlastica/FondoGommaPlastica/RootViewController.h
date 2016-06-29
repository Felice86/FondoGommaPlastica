//
//  RootViewController.h
//  FondoGommaPlastica
//
//  Created by Felice on 31/05/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginView.h"
#import "CustomScrollView.h"

@interface RootViewController : UIViewController <UITextFieldDelegate,NSURLSessionDelegate,LoginViewProtocol>
//@property (weak, nonatomic) IBOutlet CustomScrollView *topScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
//@property (weak, nonatomic) IBOutlet UIButton *frecciaSinistraButton;
//@property (weak, nonatomic) IBOutlet UIButton *frecciaDestraButton;
//- (IBAction)selezionaPrecedente:(UIButton *)sender;
//- (IBAction)selezionaSuccessivo:(UIButton *)sender;

@end
