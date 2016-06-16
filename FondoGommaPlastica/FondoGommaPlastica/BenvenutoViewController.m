//
//  BenvenutoViewController.m
//  FondoGommaPlastica
//
//  Created by Felice Vimercati on 16/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import "BenvenutoViewController.h"

@interface BenvenutoViewController ()

@end

@implementation BenvenutoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controllaLoginUtente) name:UIApplicationDidBecomeActiveNotification object:nil];
    Aderente *aderente = [Aderente sharedAderente];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@ %@",aderente.nome,aderente.cognome] forKey:@"UtenteLoggato"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    Aderente *aderente = [Aderente sharedAderente];
    [self.dataIscrizioneLabel setText:[NSString stringWithFormat:@"Iscritto dal %ld",(long)aderente.annoIscrizioneAderente]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
