//
//  Aderente.h
//  FondoGommaPlastica
//
//  Created by Felice on 03/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RendimentoDettaglio.h"

#define kanniContribuzione @"anniContribuzione"
#define kcontrovalore @"controvalore"
#define kdataQuota @"dataQuota"
#define kmesiContribuzione @"mesiContribuzione"
#define knomeComparto @"nomeComparto"
#define kquoteAcquistate @"quoteAcquistate"
#define kvaloreQuota @"valoreQuota"
#define kanno @"anno"
#define kcontributoAderente @"contributoAderente"
#define kcontributoAssicurativo @"contributoAssicurativo"
#define kcontributoAzienda @"contributoAzienda"
#define kcontributoIscrizione @"contributoIscrizione"
#define kcontributoRivalutazioneTFR @"contributoRivalutazioneTFR"
#define kcontributoTfr @"contributoTfr"
#define kcontributoTfrSilente @"contributoTfrSilente"
#define kcontributoVolontario @"contributoVolontario"
#define kcontributoVolontarioAzienda @"contributoVolontarioAzienda"
#define knomeAzienda @"nomeAzienda"
#define kperiodo @"periodo"
#define kstatoContributo @"statoContributo"
#define kcodiceAderente @"codiceAderente"
#define kdataIscrizione @"dataIscrizione"
#define kpassword @"password"
#define knome @"nome"
#define kcognome @"cognome"
#define kcodiceFiscale @"codiceFiscale"
#define kcellulare @"cellulare"
#define kemail @"eMail"
#define kesisteConsensoEcViaMail @"esisteConsensoEcViaMail"
#define kfax @"fax"
#define ktelefono @"telefono"
#define kcontrovaloreTotale @"controvaloreTotale"
#define knomeCompartoAttuale @"nomeCompartoAttuale"
#define krendimentoAnnuo @"rendimentoAnnuo"
#define krendimentoDettaglio @"rendimentoDettaglio"
#define kRecapiti @"recapiti"
#define kRilevazioni @"rilevazioni"
#define kSuccesso @"successo"

@interface Aderente : NSObject
+(instancetype)sharedAderente;

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;

//Anagrafica
@property (nonatomic, retain) NSString *nome;
@property (nonatomic, retain) NSString *cognome;
@property (nonatomic, retain) NSString *codiceFiscale;
@property (nonatomic, retain) NSString *dataIscrizioneAderente;

//Recapiti
@property (nonatomic, retain) NSMutableDictionary *recapitiDict;
@property (nonatomic, retain) NSString *cellulare;
@property (nonatomic, retain) NSString *email;
@property (nonatomic) BOOL esisteConsensoEcViaMail;
@property (nonatomic, retain) NSString *fax;
@property (nonatomic, retain) NSString *telefono;

//Rendimento
@property (nonatomic, retain) NSString *controvaloreTotale;
@property (nonatomic, retain) NSString *nomeCompartoAttuale;
@property (nonatomic, retain) NSString *rendimentoAnnuo;
@property (nonatomic, retain) RendimentoDettaglio *rendimentoDettaglio;

//Contributi
@property (nonatomic, retain) NSMutableArray *contributi;


- (void)sistemaDatiRecuperati:(NSDictionary*)datiRecuperati perOperazione:(NSString*)operazione;

@end
