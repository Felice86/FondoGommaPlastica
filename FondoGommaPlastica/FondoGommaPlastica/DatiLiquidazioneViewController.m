//
//  DatiLiquidazioneViewController.m
//  FondoGommaPlastica
//
//  Created by Felice on 02/07/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import "DatiLiquidazioneViewController.h"
#import "DatiLiquidazioneDettaglioViewController.h"

@implementation DatiLiquidazioneViewController
- (void)apriDettaglioLiquidazione:(UIButton *)button {
    DatiLiquidazioneDettaglioViewController *dettagli = [self.storyboard instantiateViewControllerWithIdentifier:@"DatiLiquidazioneDettaglio"];
    dettagli.tipoPrestazione = button.tag;
    [self showViewController:dettagli sender:nil];
}

@end
