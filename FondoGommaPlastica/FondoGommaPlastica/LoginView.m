//
//  LoginView.m
//  FondoGommaPlastica
//
//  Created by Felice Vimercati on 01/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

- (IBAction)login:(UIButton*)loginButton {
    [self.delegate loginView:self esegueLoginPer:nil];
}

@end
