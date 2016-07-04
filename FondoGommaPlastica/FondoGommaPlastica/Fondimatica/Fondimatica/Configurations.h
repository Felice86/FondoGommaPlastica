//
//  Configurations.h
//  FondoGommaPlastica
//
//  Created by Felice on 03/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    TipoPrestazione_Riscatto = 1,
    TipoPrestazione_TranferimentoOut = 2,
    TipoPrestazione_TrasferimentoIn = 3,
    TipoPrestazione_Anticipazione = 6,
    TipoPrestazione_RiscattoParziale = 8
} IdTipoPrestazione;

@interface Configurations : NSObject
+ (instancetype)sharedConfiguration;
- (NSString*)idUtenteInvocatore;
- (NSString*)pswInvocatore;
- (NSString*)baseUrl;
- (NSString*)recapiti;
- (NSString*)contributi;
- (NSString*)rendimento;
- (NSString*)anagrafica;
- (NSString*)liquidazioni:(IdTipoPrestazione)idTipoPrestazione;
- (NSString*)abilitaUtente;
- (NSString*)usernameAdTest;
- (NSString*)passwordAdTest;
@end
