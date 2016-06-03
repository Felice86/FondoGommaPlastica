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
#import "DataHandler.h"
#import "Configurations.h"
#import "MBProgressHUD.h"

@interface LoginViewController() {
    CGRect posizioneContentView;
}
@property (nonatomic, retain) NSArray *erroriRiscontrati;
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [(LoginView*)self.contentView resetInput];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
#ifdef DEBUG
    [(LoginView*)self.contentView impostaAdTest];
#endif
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
- (void)loginViewEsegueLogin:(LoginView *)loginView {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    Aderente *aderente = [Aderente sharedAderente];
    NSURL *abilitaUtenteUrl = [[DataHandler sharedData] creaUrlDaConfig:[[Configurations sharedConfiguration] abilitaUtente] codiceUtente:aderente.username];
    NSData *passwordData = [aderente.password dataUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [[DataHandler sharedData] createWebRequest:abilitaUtenteUrl method:@"POST" body:passwordData];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:self delegateQueue:nil];
    NSURLSessionDataTask *dataStack = [defaultSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Errore:%@",error);
        } else {
            BOOL abilitaUtenteResponse = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] boolValue];
            NSLog(@"Abilitazione utente: %d",abilitaUtenteResponse);
#ifdef DEBUG
            if (!abilitaUtenteResponse) {
                abilitaUtenteResponse = YES;
            }
#endif
            if (abilitaUtenteResponse) {
                [self continuaRecuperoInfoAderenteAbilitato];
            }
        }
    }];
    [dataStack resume];
}

#pragma mark - ACCESSORI
- (void)continuaRecuperoInfoAderenteAbilitato {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        [self eseguiRecuperoInformazioni:[[Configurations sharedConfiguration] anagrafica] gruppoDispatch:group];
    });
    
//    dispatch_group_async(group, queue, ^{
//        
//    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (self.erroriRiscontrati.count > 0) {
            
        } else {
            [self puoiMostrareVistaAderente];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
}

- (void)eseguiRecuperoInformazioni:(NSString*)configUrl gruppoDispatch:(dispatch_group_t)group {
    Aderente *aderente = [Aderente sharedAderente];
    NSURL *metodoUrl = [[DataHandler sharedData] creaUrlDaConfig:configUrl codiceUtente:aderente.username];
    NSURLRequest *request = [[DataHandler sharedData] createWebRequest:metodoUrl method:@"GET" body:nil];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:self delegateQueue:nil];
    NSURLSessionDataTask *dataStack = [defaultSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"errore:%@",configUrl);
        } else {
            NSError *error = nil;
            NSDictionary *datiRecuperati = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            if (!error) {
                [aderente sistemaDatiRecuperati:datiRecuperati perOperazione:configUrl];
            }
            dispatch_group_leave(group);
        }
    }];
    [dataStack resume];
}

- (void)puoiMostrareVistaAderente {
    SpazioAderenteViewController *spazioAderenteViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SpazioAderenteViewController"];
    spazioAderenteViewController.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    [self presentViewController:spazioAderenteViewController animated:YES completion:nil];
}

#pragma mark - URL SESSION DELEGATE
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    NSLog(@"didReceiveChallenge");
    completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]);
}

@end
