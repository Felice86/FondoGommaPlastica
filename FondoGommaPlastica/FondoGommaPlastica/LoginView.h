//
//  LoginView.h
//  FondoGommaPlastica
//
//  Created by Felice Vimercati on 01/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fondimatica/Aderente.h"

@class LoginView;

@protocol LoginViewProtocol <NSObject>
@required
- (void)loginViewEsegueLogin:(LoginView*)loginView;
@end

@interface LoginView : UIView
@property (nonatomic, weak) IBOutlet UITextField *usernameTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;
@property (nonatomic, weak) NSObject<LoginViewProtocol> *delegate;

- (void)resetInput;
- (void)impostaAdTest;
@end
