//
//  Aderente.h
//  FondoGommaPlastica
//
//  Created by Felice on 03/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kAnagraficaNome @"nome"
#define kAnagraficaCognome @"cognome"
#define kAnagraficaCodiceFiscale @"codiceFiscale"
#define kAnagraficaCodiceAderente @"codiceAderente"
#define kAnagraficaDataIscrizione @"dataIscrizione"
#define kAnagraficaDataPrimaAdesione @"dataPrimaAdesione"
#define kAnagraficaRagSocAzienda @"ragSocAzienda"
#define kAnagraficaDesignatiBeneficiari @"designatiBeneficiari"
#define kAnagraficaEsisteCessioneQuinto @"esisteCessioneQuinto"
#define kAnagraficaIndirizzoResidenza @"indirizzoResidenza"
#define kAnagraficaViaECivico @"viaECivico"
#define kAnagraficaLuogo @"luogo"
#define kAnagraficaCap @"cap"
#define kAnagraficaSiglaProv @"siglaProv"

#define kRecapitiCellulare @"cellulare"
#define kRecapitiEmail @"eMail"
#define kRecapitiEsisteConsensoEcViaMail @"esisteConsensoEcViaMail"
#define kRecapitiFax @"fax"
#define kRecapitiTelefono @"telefono"

#define kContributiPeriodo @"periodo"
#define kContributiAnno @"anno"
#define kContributiNomeAzienda @"nomeAzienda"
#define kContributiContributoAderente @"contributoAderente"
#define kContributiContributoAssicurativo @"contributoAssicurativo"
#define kContributiContributoAzienda @"contributoAzienda"
#define kContributiContributoIscrizione @"contributoIscrizione"
#define kContributiContributoRivalutazioneTFR @"contributoRivalutazioneTFR"
#define kContributiContributoTfr @"contributoTfr"
#define kContributiContributoTfrSilente @"contributoTfrSilente"
#define kContributiContributoVolontario @"contributoVolontario"
#define kContributiContributoVolontarioAzienda @"contributoVolontarioAzienda"
#define kContributiStatoContributo @"statoContributo"

#define kRendimentoNomeCompartoAttuale @"nomeCompartoAttuale"
#define kRendimentoDettaglio @"rendimentoDettaglio"

#define kRendimentoAnniContribuzione @"anniContribuzione"
#define kRendimentoControvalore @"controvalore"
#define kRendimentoDataQuota @"dataQuota"
#define kRendimentoMesiContribuzione @"mesiContribuzione"
#define kRendimentoNomeComparto @"nomeComparto"
#define kRendimentoQuoteAcquistate @"quoteAcquistate"
#define kRendimentoValoreQuota @"valoreQuota"
#define kRendimentoControvaloreTotale @"controvaloreTotale"
#define kRendimentoCendimentoAnnuo @"rendimentoAnnuo"

@interface Aderente : NSObject
+(instancetype)sharedAderente;

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;

@property (nonatomic, retain) NSDictionary *anagraficaDict;
@property (nonatomic, retain) NSDictionary *recapitiDict;
@property (nonatomic, retain) NSArray *contributiArray;
@property (nonatomic, retain) NSDictionary *rendimentoDict;

- (NSInteger)annoIscrizioneAderente;
- (NSString*)nominativoAderente;
@end
