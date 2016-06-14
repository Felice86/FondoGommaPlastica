//
//  Configurations.h
//  FondoGommaPlastica
//
//  Created by Felice on 03/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    IdTipoPrestazione_riscatto = 1,
    IdTipoPrestazione_trasferimentoOut = 2,
    IdTipoPrestazione_trasfetimentoIn = 3,
    IdTipoPrestazione_anticipazione = 6,
    IdTipoPrestazione_riscattoParziale = 8
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
