//
//  Configurations.h
//  FondoGommaPlastica
//
//  Created by Felice on 03/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Configurations : NSObject
+ (instancetype)sharedConfiguration;
- (NSString*)idUtenteInvocatore;
- (NSString*)pswInvocatore;
- (NSString*)baseUrl;
- (NSString*)recapiti;
- (NSString*)contributi;
- (NSString*)rendimento;
- (NSString*)anagrafica;
- (NSString*)liquidazioni;
- (NSString*)abilitaUtente;
- (NSString*)usernameAdTest;
- (NSString*)passwordAdTest;
@end
