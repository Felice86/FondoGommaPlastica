//
//  SpazioAderenteViewController.h
//  FondoGommaPlastica
//
//  Created by Felice Vimercati on 01/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+DeviceSpecificMedia.h"
#import "Fondimatica/Aderente.h"

@interface SpazioAderenteViewController : UIViewController {
    CGFloat larghezza;
    CGRect frameTitoloLabel;
    CGRect frameValoreLabel;
}
@property (weak, nonatomic) IBOutlet UILabel *nomeCognomeLabel;
@property (weak, nonatomic, readonly) IBOutlet UIScrollView *contentScrollView;
- (IBAction)tornaIndietro:(UIButton*)tornaIndietroButton;
- (void)iniziaCreazioneLabel;
- (void)creaLabelTitolo:(NSString*)titolo valore:(NSString*)valore;
- (void)inserisciTutteLeProprietaInOggetto:(NSObject*)oggetto;
- (void)riempiConInformazioni:(NSObject*)oggettoInformazioni;
@end
