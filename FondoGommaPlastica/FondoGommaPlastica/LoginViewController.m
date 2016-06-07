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
#import "Aderente.h"
#import "NSString+MD5.h"

@interface LoginViewController() {
    CGRect posizioneContentView;
    NSUInteger counter;
}
@property (nonatomic, retain) NSArray *erroriRiscontrati;
@property (nonatomic, retain) MBProgressHUD *hud;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.contentView = [[[NSBundle mainBundle] loadNibNamed:@"LoginView" owner:self options:nil] lastObject];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didShowKeyboard:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didHideKeyboard:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [(LoginView*)self.contentView resetInput];
    [self resetInput];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
#ifdef DEBUG
//    [(LoginView*)self.contentView impostaAdTest];
    [self impostaAdTest];
#endif
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - TEXT FIELD PROTOCOL
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.usernameTextField isFirstResponder]) {
        [self.usernameTextField resignFirstResponder];
    }
    if ([self.passwordTextField isFirstResponder]) {
        [self.passwordTextField resignFirstResponder];
    }
    return YES;
}

- (void)willShowKeyboard:(NSNotification*)note {
    UITextField *textField = nil;
    if ([self.usernameTextField isFirstResponder]) {
        textField = self.usernameTextField;
    }
    if ([self.passwordTextField isFirstResponder]) {
        textField = self.passwordTextField;
    }
    
    CGRect keyboardFrameEnd = [[note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat minYKeyboard = CGRectGetMinY(keyboardFrameEnd);
    CGRect realFrameTextField = [self.view convertRect:textField.frame fromView:textField.superview];
    CGFloat maxYTextField = CGRectGetMaxY(realFrameTextField);
    
    if (maxYTextField > minYKeyboard) {
        [UIView animateWithDuration:.1 animations:^{
//            [[(LoginView*)self.contentView spazioAderenteImageView] setHidden:YES];
            CGFloat differenza = maxYTextField-minYKeyboard;
            posizioneContentView = self.view.frame;
            CGRect contentViewFrame = self.view.frame;
            contentViewFrame.origin.y -= differenza+5;
            self.view.frame = contentViewFrame;
        }];
    }
}

- (void)didShowKeyboard:(NSNotification*)note {
}

- (void)willHideKeyboard:(NSNotification*)note {
    CGRect frameTextField = CGRectZero;
    if ([self.usernameTextField isFirstResponder]) {
        frameTextField = self.usernameTextField.frame;
    }
    if ([self.passwordTextField isFirstResponder]) {
        frameTextField = self.passwordTextField.frame;
    }
    
    CGRect keyboardFrameEnd = [[note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat minYKeyboard = CGRectGetMinY(keyboardFrameEnd);
    CGFloat maxYTextField = CGRectGetMaxY(frameTextField);
    
    if (maxYTextField < minYKeyboard) {
        [UIView animateWithDuration:.1 animations:^{
//            [[(LoginView*)self.contentView spazioAderenteImageView] setHidden:NO];
            self.view.frame = posizioneContentView;
        }];
    }
}

- (void)didHideKeyboard:(NSNotification*)note {
}

- (void)resetInput {
    [self.usernameTextField setText:@""];
    [self.passwordTextField setText:@""];
}

- (void)impostaAdTest {
    [self.usernameTextField setText:[[Configurations sharedConfiguration] usernameAdTest]];
    [self.passwordTextField setText:[[Configurations sharedConfiguration] passwordAdTest]];
}

#pragma mark - ACCESSORI
- (IBAction)login:(UIButton*)loginButton {
    NSString *username = self.usernameTextField.text;
    NSString *passwordMD5 = [self.passwordTextField.text MD5];
    if (username.length > 0 && passwordMD5.length > 0) {
        Aderente *aderente = [Aderente sharedAderente];
        aderente.username = self.usernameTextField.text;
        aderente.password = [self.passwordTextField.text MD5];
        
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.mode = MBProgressHUDModeAnnularDeterminate;
        [self.hud setRemoveFromSuperViewOnHide:YES];
        [self.hud.backgroundView setColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.5]];
        [self.hud setContentColor:[UIColor whiteColor]];
        self.hud.label.text = @"Recupero informazioni...";
        
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
        
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Attenzione" message:@"Controllare i dati inseriti." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *chiudiAction = [UIAlertAction actionWithTitle:@"Chiudi" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:chiudiAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)continuaRecuperoInfoAderenteAbilitato {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    counter = 0;
    
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        [self eseguiRecuperoInformazioni:[[Configurations sharedConfiguration] anagrafica] gruppoDispatch:group];
        [NSThread sleepForTimeInterval:1];
    });
    
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        [self eseguiRecuperoInformazioni:[[Configurations sharedConfiguration] recapiti] gruppoDispatch:group];
        [NSThread sleepForTimeInterval:1];
    });
    
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        [self eseguiRecuperoInformazioni:[[Configurations sharedConfiguration] rendimento] gruppoDispatch:group];
        [NSThread sleepForTimeInterval:1];
    });
    
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        [self eseguiRecuperoInformazioni:[[Configurations sharedConfiguration] contributi] gruppoDispatch:group];
        [NSThread sleepForTimeInterval:1];
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (self.erroriRiscontrati.count > 0) {
            
        } else {
            [self puoiMostrareVistaAderente];
        }
        [self.hud hideAnimated:YES];
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
                NSLog(@"Recuperati dati: %@",configUrl);
                counter++;
                [aderente sistemaDatiRecuperati:datiRecuperati perOperazione:configUrl];
                dispatch_async(dispatch_get_main_queue(), ^{
                    float progress = (float)1/4 * counter;
                    self.hud.progress = progress;
                });
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
//    NSLog(@"didReceiveChallenge");
    completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]);
}

@end
