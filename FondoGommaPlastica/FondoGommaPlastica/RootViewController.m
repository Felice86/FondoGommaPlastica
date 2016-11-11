
//
//  RootViewController.m
//  FondoGommaPlastica
//
//  Created by Felice on 31/05/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import "RootViewController.h"
#import "MBProgressHUD.h"
#import "Fondimatica/DataHandler.h"
#import "Fondimatica/Configurations.h"
#import "SpazioAderenteViewController.h"
#import "BenvenutoViewController.h"
#import "CustomImage.h"
#import "AppDelegate.h"

@interface RootViewController() {
    NSUInteger counter;
    NSUInteger numeroOperazioni;
    BOOL keyboardIsShown;
}
@property (nonatomic, retain) NSArray *erroriRiscontrati;
@property (nonatomic, retain) MBProgressHUD *hud;
@property (nonatomic, retain) LoginView *loginView;
@property (nonatomic, retain) UIView *contattaciView;
@property (nonatomic, retain) UIView *informazioniView;
@property (nonatomic, weak) IBOutlet UIButton *ominiButton;
@property (nonatomic, weak) IBOutlet UIButton *lenteButton;
@property (nonatomic, weak) IBOutlet UIButton *telefonoButton;
@property (nonatomic, retain) UIButton *selectedButton;
@property (nonatomic, retain) UIView *selectedView;
- (IBAction)ominiClicked:(UIButton *)sender;
- (IBAction)lenteClicked:(UIButton *)sender;
- (IBAction)telefonoClicked:(UIButton *)sender;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];
    
    self.loginView = (LoginView*)[[[NSBundle mainBundle] loadNibNamed:@"LoginView" owner:self options:nil] lastObject];
    self.loginView.delegate = self;
    self.loginView.usernameTextField.delegate = self;
    self.loginView.passwordTextField.delegate = self;
    self.informazioniView = [[[NSBundle mainBundle] loadNibNamed:@"InfoContentView" owner:self options:nil] lastObject];
    self.contattaciView = [[[NSBundle mainBundle] loadNibNamed:@"ContattiView" owner:self options:nil] lastObject];
    
//    self.ominiButton.selected = NO;
//    self.lenteButton.selected = NO;
//    self.telefonoButton.selected = NO;
    self.selectedButton = self.ominiButton;
    self.selectedView = self.informazioniView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.selectedButton.selected = YES;
    
    if (self.selectedView) {
        if ([self.selectedView isEqual:self.loginView]) {
            if (![self.loginView.switchButton isOn]) {
                [self.loginView resetInput];
            }
        }
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setContentView:self.selectedView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - CUSTOM SCROLL DELEGATE
- (void)customScrollView:(id)customScrollView haFinitoDiSelezionareImmagineCentrale:(CustomImage *)immagineCentrale {
    
}

#pragma mark - CONTENT VIEW
- (void)setContentView:(UIView*)contentView {
    CGFloat heightContentView = self.contentScrollView.frame.size.height > contentView.frame.size.height ? self.contentScrollView.frame.size.height : contentView.frame.size.height;
    contentView.frame = CGRectMake(contentView.frame.origin.x, contentView.frame.origin.y, self.contentScrollView.frame.size.width, heightContentView);
    [self.contentScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.contentScrollView addSubview:contentView];
    CGSize contentSize = contentView.frame.size;
    contentSize.height -= 20;
    [self.contentScrollView setContentSize:contentSize];
    self.contentScrollView.contentOffset = CGPointMake(0, 0);
    self.selectedView = contentView;
}

- (void)facebookButtonClicked:(id)sender {
    NSURL *urlFB = [NSURL URLWithString:@"https://www.facebook.com/Fondo-Gomma-Plastica-949956355080192/"];
    [[UIApplication sharedApplication] openURL:urlFB];
}

//-(void) setCustomView:(UIView *)customView {
//    NSUInteger z = NSNotFound;
////    z = [self.contentView.subviews indexOfObject:customView];
////    if (z == NSNotFound) {
////        [self.contentView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
////        [self.contentView addSubview:customView];
////    }
//    if (self.contentView) {
//        z = [self.view.subviews indexOfObject:self.contentView];
//    }
//    if (z == NSNotFound) {
//        // old view was not in hierarchy
//        // you can insert subview at any index and any view you want by default
//        [self.view addSubview:customView];
//    } else {
//        // you can save superview
//        UIView *superview = self.contentView.superview;
//        [self.contentView removeFromSuperview];
//        //also you can copy some attributes of old view:
//        //customView.center = _customView.center
//        [superview insertSubview:customView atIndex:z];
//    }
//    //and save ivar
//    self.contentView = customView;
//}

- (void)ominiClicked:(UIButton *)sender {
    if (!self.ominiButton.selected) {
        self.selectedButton.selected = NO;
        self.ominiButton.selected = YES;
        self.selectedButton = self.ominiButton;
        [self setContentView:self.informazioniView];
    }
}

- (void)lenteClicked:(UIButton *)sender {
    if (!self.lenteButton.selected) {
        self.selectedButton.selected = NO;
        self.lenteButton.selected = YES;
        self.selectedButton = self.lenteButton;
        [self setContentView:self.loginView];
        [self.loginView checkAndSetSavedUsernameAndPassword];
//#ifdef DEBUG
//        [self.loginView impostaAdTest];
//#endif
    }
}

- (void)telefonoClicked:(UIButton *)sender {
    if (!self.telefonoButton.selected) {
        self.selectedButton.selected = NO;
        self.telefonoButton.selected = YES;
        self.selectedButton = self.telefonoButton;
        [self setContentView:self.contattaciView];
    }
}

#pragma mark - LOGIN DELEGATE
- (void)loginViewEsegueLogin:(LoginView *)loginView {
    [self chiudiTastiera];
    Aderente *aderente = [Aderente sharedAderente];
    if (aderente.username.length > 0 && aderente.password.length > 0) {
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        //        self.hud.mode = MBProgressHUDModeAnnularDeterminate;
        [self.hud setRemoveFromSuperViewOnHide:YES];
        //        [self.hud.backgroundView setColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.5]];
        //        [self.hud setContentColor:[UIColor whiteColor]];
        self.hud.label.text = @"Recupero informazioni...";
        
        NSURL *abilitaUtenteUrl = [[DataHandler sharedData] creaUrlDaConfig:[[Configurations sharedConfiguration] abilitaUtente] codiceUtente:aderente.username];
        NSData *passwordData = [aderente.password dataUsingEncoding:NSUTF8StringEncoding];
        NSURLRequest *request = [[DataHandler sharedData] createWebRequest:abilitaUtenteUrl method:@"POST" body:passwordData];
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:self delegateQueue:nil];
        NSURLSessionDataTask *dataStack = [defaultSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                NSLog(@"Errore:%@",error);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.hud hideAnimated:YES];
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                });
                UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"Attenzione" message:@"Si è verificato un errore. Riprovare." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *chiudiAction = [UIAlertAction actionWithTitle:@"Chiudi" style:UIAlertActionStyleCancel handler:nil];
                [alertViewController addAction:chiudiAction];
                [self presentViewController:alertViewController animated:YES completion:nil];
            } else {
                NSInteger httpStatusCode = [(NSHTTPURLResponse*)response statusCode];
                if (httpStatusCode != 200) {
                    NSString *message = [[NSHTTPURLResponse localizedStringForStatusCode:httpStatusCode] capitalizedString];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.hud hideAnimated:YES];
                        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                    });
                    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"Attenzione" message:message preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *chiudiAction = [UIAlertAction actionWithTitle:@"Chiudi" style:UIAlertActionStyleCancel handler:nil];
                    [alertViewController addAction:chiudiAction];
                    [self presentViewController:alertViewController animated:YES completion:nil];
                } else {
                    BOOL abilitaUtenteResponse = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] boolValue];
                    NSLog(@"Abilitazione utente: %d",abilitaUtenteResponse);
    #ifdef DEBUG
                    if (!abilitaUtenteResponse) {
                        abilitaUtenteResponse = NO;
                    }
    #endif
                    if (abilitaUtenteResponse) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.hud.mode = MBProgressHUDModeAnnularDeterminate;
                        });
                        [self continuaRecuperoInfoAderenteAbilitato];
                    } else {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.hud hideAnimated:YES];
                            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                        });
                        UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"Attenzione" message:@"Utente non abilitato." preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *chiudiAction = [UIAlertAction actionWithTitle:@"Chiudi" style:UIAlertActionStyleCancel handler:nil];
                        [alertViewController addAction:chiudiAction];
                        [self presentViewController:alertViewController animated:YES completion:nil];
                    }
                }
            }
        }];
        [dataStack resume];
    }
}

- (void)continuaRecuperoInfoAderenteAbilitato {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();

    counter = 0;
    numeroOperazioni = 0;
    
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        [self eseguiRecuperoInformazioni:[[Configurations sharedConfiguration] anagrafica] gruppoDispatch:group];
        numeroOperazioni++;
    });
    
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        [self eseguiRecuperoInformazioni:[[Configurations sharedConfiguration] recapiti] gruppoDispatch:group];
        numeroOperazioni++;
    });
    
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        [self eseguiRecuperoInformazioni:[[Configurations sharedConfiguration] rendimento] gruppoDispatch:group];
        numeroOperazioni++;
    });
    
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        [self eseguiRecuperoInformazioni:[[Configurations sharedConfiguration] contributi] gruppoDispatch:group];
        numeroOperazioni++;
    });
    
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        [self eseguiRecuperoInformazioni:[[Configurations sharedConfiguration] liquidazioni:TipoPrestazione_Anticipazione] gruppoDispatch:group];
        numeroOperazioni++;
    });
    
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        [self eseguiRecuperoInformazioni:[[Configurations sharedConfiguration] liquidazioni:TipoPrestazione_Riscatto] gruppoDispatch:group];
        numeroOperazioni++;
    });
    
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        [self eseguiRecuperoInformazioni:[[Configurations sharedConfiguration] liquidazioni:TipoPrestazione_RiscattoParziale] gruppoDispatch:group];
        numeroOperazioni++;
    });
    
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        [self eseguiRecuperoInformazioni:[[Configurations sharedConfiguration] liquidazioni:TipoPrestazione_TranferimentoOut] gruppoDispatch:group];
        numeroOperazioni++;
    });
    
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        [self eseguiRecuperoInformazioni:[[Configurations sharedConfiguration] liquidazioni:TipoPrestazione_TrasferimentoIn] gruppoDispatch:group];
        numeroOperazioni++;
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self.hud hideAnimated:YES];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (self.erroriRiscontrati.count > 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Attenzione" message:@"Si sono verificati alcuni errori nel recupero delle informazioni. Riprovare." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *riprovaAction = [UIAlertAction actionWithTitle:@"Riprova" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self loginViewEsegueLogin:self.loginView];
            }];
            UIAlertAction *cancellaAction = [UIAlertAction actionWithTitle:@"Annulla" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:riprovaAction];
            [alert addAction:cancellaAction];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            [self puoiMostrareVistaAderente];
        }
    });
}

- (void)eseguiRecuperoInformazioni:(NSString*)configUrl gruppoDispatch:(dispatch_group_t)group {
    Configurations *config = [Configurations sharedConfiguration];
    Aderente *aderente = [Aderente sharedAderente];
    NSURL *metodoUrl = [[DataHandler sharedData] creaUrlDaConfig:configUrl codiceUtente:aderente.username];
    NSURLRequest *request = [[DataHandler sharedData] createWebRequest:metodoUrl method:@"GET" body:nil];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:self delegateQueue:nil];
    NSURLSessionDataTask *dataStack = [defaultSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"errore:%@",configUrl);
        } else {
            NSError *errorJSON = nil;
            NSObject *datiRecuperati = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            if (!errorJSON) {
                NSLog(@"Recuperati dati: %@",configUrl);
                counter++;
                if ([datiRecuperati isKindOfClass:[NSDictionary class]]) {
                    if ([configUrl isEqualToString:[config anagrafica]]) {
                        [aderente configuraAnagrafica:(NSDictionary*)datiRecuperati];
//                        aderente.anagraficaDict = (NSDictionary*)datiRecuperati;
                    }
                    if ([configUrl isEqualToString:[config recapiti]]) {
                        [aderente configuraRecapiti:(NSDictionary*)datiRecuperati];
//                        aderente.recapitiDict = (NSDictionary*)datiRecuperati;
                    }
                    if ([configUrl isEqualToString:[config rendimento]]) {
                        [aderente configuraRendimento:(NSDictionary*)datiRecuperati];
//                        aderente.rendimentoDict = (NSDictionary*)datiRecuperati;
                    }
                } else if ([datiRecuperati isKindOfClass:[NSArray class]]) {
                    if ([configUrl isEqualToString:[config contributi]]) {
                        [aderente configuraContributi:(NSArray*)datiRecuperati];
//                        aderente.contributiArray = (NSArray*)datiRecuperati;
                    }
                    if ([configUrl isEqualToString:[config liquidazioni:TipoPrestazione_Anticipazione]]) {
                        [aderente configuraAnticipi:(NSArray*)datiRecuperati];
                    }
                    if ([configUrl isEqualToString:[config liquidazioni:TipoPrestazione_Riscatto]]) {
                        [aderente configuraRiscatti:(NSArray*)datiRecuperati];
                    }
                    if ([configUrl isEqualToString:[config liquidazioni:TipoPrestazione_RiscattoParziale]]) {
                        [aderente configuraRiscattiParziali:(NSArray*)datiRecuperati];
                    }
                    if ([configUrl isEqualToString:[config liquidazioni:TipoPrestazione_TranferimentoOut]]) {
                        [aderente configuraTrasferimentiOut:(NSArray*)datiRecuperati];
                    }
                    if ([configUrl isEqualToString:[config liquidazioni:TipoPrestazione_TrasferimentoIn]]) {
                        [aderente configuraTrasferimentiIn:(NSArray*)datiRecuperati];
                    }
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    float progress = (float)1/numeroOperazioni * counter;
                    self.hud.progress = progress;
                });
            }
            dispatch_group_leave(group);
        }
    }];
    [dataStack resume];
}

- (void)puoiMostrareVistaAderente {
    BenvenutoViewController *benvenutoViewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([BenvenutoViewController class])];
    [self.navigationController pushViewController:benvenutoViewController animated:YES];
}

#pragma mark - URL SESSION DELEGATE
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    //    NSLog(@"didReceiveChallenge");
    completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]);
}

#pragma mark - TEXT FIELD PROTOCOL
- (void)chiudiTastiera {
    if ([self.loginView.usernameTextField isFirstResponder]) {
        [self.loginView.usernameTextField resignFirstResponder];
    }
    if ([self.loginView.passwordTextField isFirstResponder]) {
        [self.loginView.passwordTextField resignFirstResponder];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self chiudiTastiera];
    return YES;
}

- (void)keyboardWillHide:(NSNotification *)n
{
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    // resize the scrollview
    CGRect viewFrame = self.contentScrollView.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height += (keyboardSize.height);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.contentScrollView setFrame:viewFrame];
    [UIView commitAnimations];
    
    keyboardIsShown = NO;
}

- (void)keyboardWillShow:(NSNotification *)n
{
    // This is an ivar I'm using to ensure that we do not do the frame size adjustment on the `UIScrollView` if the keyboard is already shown.  This can happen if the user, after fixing editing a `UITextField`, scrolls the resized `UIScrollView` to another `UITextField` and attempts to edit the next `UITextField`.  If we were to resize the `UIScrollView` again, it would be disastrous.  NOTE: The keyboard notification will fire even when the keyboard is already shown.
    if (keyboardIsShown) {
        return;
    }
    
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // resize the noteView
    CGRect viewFrame = self.contentScrollView.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height -= (keyboardSize.height);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.contentScrollView setFrame:viewFrame];
    [UIView commitAnimations];
    keyboardIsShown = YES;
}

//- (void)resetInput {
//    [self.loginView.usernameTextField setText:@""];
//    [self.loginView.passwordTextField setText:@""];
//}
//
//- (void)impostaAdTest {
//    [self.loginView.usernameTextField setText:[[Configurations sharedConfiguration] usernameAdTest]];
//    [self.loginView.passwordTextField setText:[[Configurations sharedConfiguration] passwordAdTest]];
//}
//
//- (void)checkAndSetSavedUsernameAndPassword
//{
//    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:kUsernameSaved];
//    NSString* passwordMD5 = [[NSUserDefaults standardUserDefaults] objectForKey:kPasswordSaved];
//    if (username.length > 0) {
//        [self.loginView.usernameTextField setText:username];
//    }
//    if (passwordMD5.length > 0) {
//        [self.loginView.passwordTextField setText:passwordMD5];
//    }
//}

//- (IBAction)selezionaPrecedente:(UIButton *)sender {
//    self.selectedButton.selected = NO;
//    if (self.selectedButton == self.telefonoButton) {
//        [self lenteClicked:self.lenteButton];
//        self.frecciaDestraButton.enabled = YES;
//    } else if (self.selectedButton == self.lenteButton) {
//        [self ominiClicked:self.ominiButton];
//    }
//    if (self.selectedButton == self.ominiButton) {
//        sender.enabled = NO;
//    }
//}
//
//- (IBAction)selezionaSuccessivo:(UIButton *)sender {
//    self.selectedButton.selected = NO;
//    if (self.selectedButton == self.ominiButton) {
//        [self lenteClicked:self.lenteButton];
//        self.frecciaSinistraButton.enabled = YES;
//    } else if (self.selectedButton == self.lenteButton) {
//        [self telefonoClicked:self.telefonoButton];
//    }
//    if (self.selectedButton == self.telefonoButton) {
//        sender.enabled = NO;
//    }
//}

#pragma mark - ScrollViewDelegate
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    if ([scrollView isEqual:self.topScrollView]) {
////        [self.topScrollView selezionaIndiceCorretto];
//    }
//}
@end
