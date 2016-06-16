//
//  SpazioAderenteViewController.m
//  FondoGommaPlastica
//
//  Created by Felice Vimercati on 01/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import "SpazioAderenteViewController.h"
#import "BenvenutoViewController.h"

@interface SpazioAderenteViewController ()

@end

@implementation SpazioAderenteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (![self isKindOfClass:[BenvenutoViewController class]]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(riportaAlBenvenuto:) name:@"RiportaSpazioAderenteAlBenvenuto" object:nil];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self controllaLoginUtente];
}

- (void)controllaLoginUtente {
    NSString *utenteLoggato = [[NSUserDefaults standardUserDefaults] objectForKey:@"UtenteLoggato"];
    if (!utenteLoggato) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        Aderente *aderente = [Aderente sharedAderente];
        [self.nomeCognomeLabel setText:[NSString stringWithFormat:@"%@ %@",aderente.nome.uppercaseString,aderente.cognome.uppercaseString]];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)riportaAlBenvenuto:(NSNotification*)notification {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tornaIndietro:(UIButton*)tornaIndietroButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
