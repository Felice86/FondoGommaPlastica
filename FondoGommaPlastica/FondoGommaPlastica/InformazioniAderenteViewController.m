//
//  InformazioniAderenteViewController.m
//  FondoGommaPlastica
//
//  Created by Felice Vimercati on 30/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import "InformazioniAderenteViewController.h"

@interface InformazioniAderenteViewController ()

@end

@implementation InformazioniAderenteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    Aderente *aderente = [Aderente sharedAderente];
    [self iniziaCreazioneLabel];
    [self riempiConInformazioni:aderente.anagrafica];
    frameTitoloLabel.origin.y += 40;
    frameValoreLabel.origin.y += 40;
    [self riempiConInformazioni:aderente.recapiti];
}

@end
