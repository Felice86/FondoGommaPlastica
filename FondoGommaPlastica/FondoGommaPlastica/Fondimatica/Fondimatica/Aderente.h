//
//  Aderente.h
//  FondoGommaPlastica
//
//  Created by Felice on 03/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

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
#define kRendimentoNomeComparto @"nomeComparto"
#define kRendimentoDataQuota @"dataQuota"
#define kRendimentoAnniContribuzione @"anniContribuzione"
#define kRendimentoMesiContribuzione @"mesiContribuzione"
#define kRendimentoQuoteAcquistate @"quoteAcquistate"
#define kRendimentoValoreQuota @"valoreQuota"
#define kRendimentoControvalore @"controvalore"
#define kRendimentoContributoAderente @"contributoAderente"
#define kRendimentoContributoTfr @"contributoTfr"
#define kRendimentoContributoAzienda @"contributoAzienda"
#define kRendimentoRendimentoFondo @"rendimentoFondo"
#define kRendimentoControvaloreTotale @"controvaloreTotale"
#define kRendimentoRendimentoAnnuo @"rendimentoAnnuo"

#define kLiquidazioneTipo @"tipo"
#define kLiquidazioneMotivazione @"motivazione"
#define kLiquidazioneImportoLordo @"importoLordo"
#define kLiquidazioneDataRicezione @"dataRicezione"
#define kLiquidazioneStato @"stato"

@class Aderente;

@interface InformazioneAderente : NSObject
- (NSArray*)valoriDaStampare;
- (NSString*)legenda;
@end

@interface IndirizzoResidenza : InformazioneAderente
@property (nonatomic, retain, readonly) NSString *viaECivico;
@property (nonatomic, retain, readonly) NSString *luogo;
@property (nonatomic, retain, readonly) NSString *cap;
@property (nonatomic, retain, readonly) NSString *siglaProv;
- (void)configuraIndirizzoResidenza:(NSDictionary*)indirizzoDict;
@end

@interface Anagrafica : InformazioneAderente
@property (nonatomic, retain, readonly) NSString *nome;
@property (nonatomic, retain, readonly) NSString *cognome;
@property (nonatomic, retain, readonly) NSString *codiceFiscale;
@property (nonatomic, retain, readonly) NSString *codiceAderente;
@property (nonatomic, retain, readonly) NSDate   *dataIscrizione;
@property (nonatomic, retain, readonly) NSDate   *dataPrimaAdesione;
@property (nonatomic, retain, readonly) NSString *ragSocAzienda;
@property (nonatomic, retain, readonly) NSString *designatiBeneficiari;
@property (nonatomic, retain, readonly) NSString *esisteCessioneQuinto;
@property (nonatomic, retain, readonly) IndirizzoResidenza *indirizzoResidenza;
- (void)configuraAnagrafica:(NSDictionary*)anagraficaDict;
@end

@interface Recapiti : InformazioneAderente
@property (nonatomic, retain, readonly) NSString *telefono;
@property (nonatomic, retain, readonly) NSString *fax;
@property (nonatomic, retain, readonly) NSString *cellulare;
@property (nonatomic, retain, readonly) NSString *email;
@property (nonatomic, retain, readonly) NSString *esisteConsensoEcViaMail;
- (void)configuraRecapiti:(NSDictionary*)recapitiDict;
@end

@interface Contributo : InformazioneAderente
@property (nonatomic, retain, readonly) NSString *periodo;
@property (nonatomic, retain, readonly) NSString *anno;
@property (nonatomic, retain, readonly) NSString *nomeAzienda;
@property (nonatomic, retain, readonly) NSString *contributoAderente;
@property (nonatomic, retain, readonly) NSString *contributoAzienda;
@property (nonatomic, retain, readonly) NSString *contributoTfr;
@property (nonatomic, retain, readonly) NSString *contributoVolontario;
@property (nonatomic, retain, readonly) NSString *contributoVolontarioAzienda;
@property (nonatomic, retain, readonly) NSString *contributoAssicurativo;
@property (nonatomic, retain, readonly) NSString *contributoIscrizione;
@property (nonatomic, retain, readonly) NSString *contributoTfrSilente;
@property (nonatomic, retain, readonly) NSString *contributoRivalutazioneTFR;
@property (nonatomic, retain, readonly) NSString *statoContributo;
- (void)configuraContributo:(NSDictionary*)contributoDict;
@end

@interface RendimentoDettaglio : InformazioneAderente
@property (nonatomic, retain, readonly) NSString *nomeComparto;
@property (nonatomic, retain, readonly) NSDate *dataQuota;
@property (nonatomic, retain, readonly) NSString *anniContribuzione;
@property (nonatomic, retain, readonly) NSString *mesiContribuzione;
@property (nonatomic, retain, readonly) NSString *quoteAcquistate;
@property (nonatomic, retain, readonly) NSString *valoreQuota;
@property (nonatomic, retain, readonly) NSString *controvalore;
@property (nonatomic, retain, readonly) NSString *contributoAderente;
@property (nonatomic, retain, readonly) NSString *contributoTfr;
@property (nonatomic, retain, readonly) NSString *contributoAzienda;
@property (nonatomic, retain, readonly) NSString *rendimentoFondo;
- (void)configuraRendimentoDettaglio:(NSDictionary*)rendimentoDettaglioDict;
@end

@interface Rendimento : InformazioneAderente
@property (nonatomic, retain, readonly) NSString *nomeCompartoAttuale;
@property (nonatomic, retain, readonly) NSMutableArray *dettagliRendimento;
@property (nonatomic, retain, readonly) NSString *controvaloreTotale;
@property (nonatomic, retain, readonly) NSString *rendimentoAnnuo;
- (void)configuraRendimento:(NSDictionary*)rendimentoDict;
@end

@interface Liquidazione : InformazioneAderente
@property (nonatomic, retain, readonly) NSString *tipo;
@property (nonatomic, retain, readonly) NSString *motivazione;
@property (nonatomic, retain, readonly) NSString *importoLordo;
@property (nonatomic, retain, readonly) NSDate *dataRicezione;
@property (nonatomic, retain, readonly) NSString *stato;
- (void)configuraLiquidazione:(NSDictionary*)liquidazioneDict;
@end

@interface Aderente : NSObject
@property (nonatomic, retain, readonly) NSString *username;
@property (nonatomic, retain, readonly) NSString *password;
@property (nonatomic, retain, readonly) Anagrafica *anagrafica;
@property (nonatomic, retain, readonly) Recapiti *recapiti;
@property (nonatomic, retain, readonly) NSArray *contributi;
@property (nonatomic, retain, readonly) Rendimento *rendimento;
@property (nonatomic, retain, readonly) NSArray *riscatti;
@property (nonatomic, retain, readonly) NSArray *trasferimentiOut;
@property (nonatomic, retain, readonly) NSArray *trasferimentiIn;
@property (nonatomic, retain, readonly) NSArray *anticipi;
@property (nonatomic, retain, readonly) NSArray *riscattiParziali;

+ (instancetype)sharedAderente;
+ (NSString*)recuperaValore:(NSString*)chiave daOggetto:(NSDictionary*)oggetto valuta:(BOOL)isValuta;
- (void)eseguiLoginConUsername:(NSString*)username password:(NSString*)password;
- (void)configuraAnagrafica:(NSDictionary*)anagraficaDict;
- (void)configuraRecapiti:(NSDictionary*)recapitiDict;
- (void)configuraContributi:(NSArray*)contributiArray;
- (void)configuraRendimento:(NSDictionary*)rendimentoDict;
- (void)configuraRiscatti:(NSArray*)riscattiArray;
- (void)configuraTrasferimentiOut:(NSArray*)trasferimentiOutArray;
- (void)configuraTrasferimentiIn:(NSArray*)trasferimentiInArray;
- (void)configuraAnticipi:(NSArray*)anticipiArray;
- (void)configuraRiscattiParziali:(NSArray*)riscattiParzialiArray;
- (void)resetAderente;
+ (NSDate*)getJSONDate:(NSString*)dateFromJSON;
+ (NSArray *)propertiesForClass:(Class)classe;
@end
