//
//  LoginViewController.h
//  FondoGommaPlastica
//
//  Created by Felice Vimercati on 01/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import "PageContentViewController.h"
#import "LoginView.h"

@interface LoginViewController : PageContentViewController <UITextFieldDelegate,NSURLSessionDelegate>
@property (nonatomic, weak) IBOutlet UITextField *usernameTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;
@end
