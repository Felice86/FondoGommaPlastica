//
//  LoginViewController.m
//  FondoGommaPlastica
//
//  Created by Felice Vimercati on 01/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "SpazioAderenteViewController.h"

@interface LoginViewController() {
    CGRect posizioneContentView;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentView = [[[NSBundle mainBundle] loadNibNamed:@"LoginView" owner:self options:nil] lastObject];
    ((LoginView*)self.contentView).delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didShowKeyboard:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didHideKeyboard:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - TEXT FIELD PROTOCOL
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([((LoginView*)self.contentView).usernameTextField isFirstResponder]) {
        [((LoginView*)self.contentView).usernameTextField resignFirstResponder];
    }
    if ([((LoginView*)self.contentView).passwordTextField isFirstResponder]) {
        [((LoginView*)self.contentView).passwordTextField resignFirstResponder];
    }
    return YES;
}

- (void)willShowKeyboard:(NSNotification*)note {
    UITextField *textField = nil;
    if ([((LoginView*)self.contentView).usernameTextField isFirstResponder]) {
        textField = ((LoginView*)self.contentView).usernameTextField;
    }
    if ([((LoginView*)self.contentView).passwordTextField isFirstResponder]) {
        textField = ((LoginView*)self.contentView).passwordTextField;
    }
    
    CGRect keyboardFrameEnd = [[note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat minYKeyboard = CGRectGetMinY(keyboardFrameEnd);
    CGRect realFrameTextField = [self.view convertRect:textField.frame fromView:textField.superview];
    CGFloat maxYTextField = CGRectGetMaxY(realFrameTextField);
    
    if (maxYTextField > minYKeyboard) {
        [UIView animateWithDuration:.1 animations:^{
//            [[(LoginView*)self.contentView spazioAderenteImageView] setHidden:YES];
            CGFloat differenza = maxYTextField-minYKeyboard;
            posizioneContentView = self.contentView.frame;
            CGRect contentViewFrame = self.contentView.frame;
            contentViewFrame.origin.y -= differenza+5;
            self.contentView.frame = contentViewFrame;
        }];
    }
}

- (void)didShowKeyboard:(NSNotification*)note {
}

- (void)willHideKeyboard:(NSNotification*)note {
    CGRect frameTextField = CGRectZero;
    if ([((LoginView*)self.contentView).usernameTextField isFirstResponder]) {
        frameTextField = ((LoginView*)self.contentView).usernameTextField.frame;
    }
    if ([((LoginView*)self.contentView).passwordTextField isFirstResponder]) {
        frameTextField = ((LoginView*)self.contentView).passwordTextField.frame;
    }
    
    CGRect keyboardFrameEnd = [[note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat minYKeyboard = CGRectGetMinY(keyboardFrameEnd);
    CGFloat maxYTextField = CGRectGetMaxY(frameTextField);
    
    if (maxYTextField < minYKeyboard) {
        [UIView animateWithDuration:.1 animations:^{
//            [[(LoginView*)self.contentView spazioAderenteImageView] setHidden:NO];
            self.contentView.frame = posizioneContentView;
        }];
    }
}

- (void)didHideKeyboard:(NSNotification*)note {
}

#pragma mark - LOGIN VIEW PROTOCOL
- (void)loginView:(LoginView *)loginView esegueLoginPer:(NSObject *)utente {
    SpazioAderenteViewController *spazioAderenteViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SpazioAderenteViewController"];
    spazioAderenteViewController.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    [self presentViewController:spazioAderenteViewController animated:YES completion:nil];
}

@end
