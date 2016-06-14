//
//  LoginView.m
//  FondoGommaPlastica
//
//  Created by Felice Vimercati on 01/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import "LoginView.h"
#import "NSString+MD5.h"
#import "Fondimatica/Aderente.h"
#import "Fondimatica/Configurations.h"

@implementation LoginView

- (IBAction)login:(UIButton*)loginButton {
    NSString *username = self.usernameTextField.text;
    NSString *passwordMD5 = [self.passwordTextField.text MD5];
    if (username.length > 0 && passwordMD5.length > 0) {
        Aderente *aderente = [Aderente sharedAderente];
        aderente.username = self.usernameTextField.text;
        aderente.password = [self.passwordTextField.text MD5];
        [self.delegate loginViewEsegueLogin:self];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Attenzione" message:@"Controllare i dati inseriti." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *chiudiAction = [UIAlertAction actionWithTitle:@"Chiudi" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:chiudiAction];
        if ([self.delegate respondsToSelector:@selector(presentViewController:animated:completion:)]) {
            [((UIViewController*)self.delegate) presentViewController:alertController animated:YES completion:nil];
        }
    }
}

- (void)resetInput {
    [self.usernameTextField setText:@""];
    [self.passwordTextField setText:@""];
}

- (void)impostaAdTest {
    [self.usernameTextField setText:[[Configurations sharedConfiguration] usernameAdTest]];
    [self.passwordTextField setText:[[Configurations sharedConfiguration] passwordAdTest]];
}

@end
