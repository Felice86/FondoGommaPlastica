//
//  DatiLiquidazioneDettaglioViewController.m
//  FondoGommaPlastica
//
//  Created by Felice on 03/07/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import "DatiLiquidazioneDettaglioViewController.h"

@implementation DatiLiquidazioneDettaglioViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self iniziaCreazioneLabelForScrollView:nil];
    
    Aderente *utente = [Aderente sharedAderente];
    NSArray *arrayLiquidazioni = nil;
    switch (self.tipoPrestazione) {
        case TipoPrestazione_Anticipazione:{
            arrayLiquidazioni = utente.anticipi;
            break;
        }
        case TipoPrestazione_Riscatto:{
            arrayLiquidazioni = utente.riscatti;
            break;
        }
        case TipoPrestazione_RiscattoParziale:{
            arrayLiquidazioni = utente.riscattiParziali;
            break;
        }
        case TipoPrestazione_TranferimentoOut:{
            arrayLiquidazioni = utente.trasferimentiOut;
            break;
        }
        case TipoPrestazione_TrasferimentoIn:{
            arrayLiquidazioni = utente.trasferimentiIn;
            break;
        }
        default:
            break;
    }
    
    for (Liquidazione *oggettoLiquidazione in arrayLiquidazioni) {
        [self inserisciTutteLeProprietaInOggetto:oggettoLiquidazione contentScrollViewController:nil];
        
//        UIImage *separatore = [UIImage imageNamed:@"FILETTO.png"];
//        UIImageView *separatoreView = [[UIImageView alloc] initWithImage:separatore];
//        CGRect frame = separatoreView.frame;
//        frame.origin.y = frameTitoloLabel.origin.y - 4;
//        frame.origin.x = (self.contentScrollView.frame.size.width - frame.size.width) / 2;
//        separatoreView.frame = frame;
//        [self.contentScrollView addSubview:separatoreView];
//        frameTitoloLabel.origin.y = CGRectGetMaxY(separatoreView.frame) + 4;
//        frameValoreLabel.origin.y = CGRectGetMaxY(separatoreView.frame) + 4;
    }
    [self inserisciLegenda:arrayLiquidazioni.lastObject addTo:nil];
    [self.contentScrollView setContentSize:CGSizeMake(self.contentScrollView.frame.size.width, CGRectGetMaxY(frameTitoloLabel))];
}

@end
