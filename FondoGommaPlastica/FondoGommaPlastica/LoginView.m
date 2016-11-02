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
        NSString *username = self.usernameTextField.text;
        NSString* passwordMD5 = [self.passwordTextField.text MD5];
        [aderente eseguiLoginConUsername:username password:passwordMD5];
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

- (void)checkAndSetSavedUsernameAndPassword
{
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:kUsernameSaved];
    NSString* passwordMD5 = [[NSUserDefaults standardUserDefaults] objectForKey:kPasswordSaved];
    if (username.length > 0) {
        [self.usernameTextField setText:username];
        [self.switchButton setOn:YES];
    } else {
        [self.switchButton setOn:NO];
    }
    if (passwordMD5.length > 0) {
        [self.passwordTextField setText:passwordMD5];
        [self.switchButton setOn:YES];
    } else {
        [self.switchButton setOn:NO];
    }
}

- (IBAction)switchButtonChangeSettings:(UISwitch*)switchSender
{
    if ([switchSender isOn]) {
        NSString *username = self.usernameTextField.text;
        NSString* passwordMD5 = self.passwordTextField.text;
        [[NSUserDefaults standardUserDefaults] setObject:username forKey:kUsernameSaved];
        [[NSUserDefaults standardUserDefaults] setObject:passwordMD5 forKey:kPasswordSaved];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUsernameSaved];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPasswordSaved];
    }
}

@end
