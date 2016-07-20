//
//  InformazioniAderenteViewController.m
//  FondoGommaPlastica
//
//  Created by Felice on 02/07/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import "InformazioniAderenteViewController.h"

@implementation InformazioniAderenteViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    Aderente *aderente = [Aderente sharedAderente];
    
    [self iniziaCreazioneLabelForScrollView:nil];
    [self inserisciTutteLeProprietaInOggetto:aderente.anagrafica contentScrollViewController:nil];
    [self inserisciLegenda:aderente.anagrafica addTo:nil];
    [self.contentScrollView setContentSize:CGSizeMake(self.contentScrollView.frame.size.width, CGRectGetMaxY(frameTitoloLabel))];
}

@end
