//
//  LoginView.h
//  FondoGommaPlastica
//
//  Created by Felice Vimercati on 01/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoginView;
@protocol LoginViewProtocol <NSObject>
@required
- (void)loginView:(LoginView*)loginView esegueLoginPer:(NSObject*)utente;
@end

@interface LoginView : UIView
@property (nonatomic, weak) IBOutlet UIImageView *spazioAderenteImageView;
@property (nonatomic, weak) IBOutlet UITextField *usernameTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;
@property (nonatomic, weak) NSObject<LoginViewProtocol> *delegate;
@end
