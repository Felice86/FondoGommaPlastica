//
//  Aderente.m
//  FondoGommaPlastica
//
//  Created by Felice on 03/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import "Aderente.h"
#import "Configurations.h"

@interface IndirizzoResidenza()
@property (nonatomic, retain, readwrite) NSString *viaECivico;
@property (nonatomic, retain, readwrite) NSString *luogo;
@property (nonatomic, retain, readwrite) NSString *cap;
@property (nonatomic, retain, readwrite) NSString *siglaProv;
@end
@implementation IndirizzoResidenza
- (void)configuraIndirizzoResidenza:(NSDictionary *)indirizzoDict {
    self.viaECivico = [[indirizzoDict objectForKey:kAnagraficaViaECivico] description];
    self.luogo = [[indirizzoDict objectForKey:kAnagraficaLuogo] description];
    self.cap = [[indirizzoDict objectForKey:kAnagraficaCap] description];
    self.siglaProv = [[indirizzoDict objectForKey:kAnagraficaSiglaProv] description];
}
@end

@interface Anagrafica()
@property (nonatomic, retain, readwrite) NSString *nome;
@property (nonatomic, retain, readwrite) NSString *cognome;
@property (nonatomic, retain, readwrite) NSString *codiceFiscale;
@property (nonatomic, retain, readwrite) NSString *codiceAderente;
@property (nonatomic, retain, readwrite) NSDate *dataIscrizione;
@property (nonatomic, retain, readwrite) NSDate *dataPrimaAdesione;
@property (nonatomic, retain, readwrite) NSString *ragSocAzienda;
@property (nonatomic, retain, readwrite) NSString *designatiBeneficiari;
@property (nonatomic, retain, readwrite) NSString *esisteCessioneQuinto;
@property (nonatomic, retain, readwrite) IndirizzoResidenza *indirizzoResidenza;
@end
@implementation Anagrafica
- (void)configuraAnagrafica:(NSDictionary *)anagraficaDict {
    self.nome = [[anagraficaDict objectForKey:kAnagraficaNome] description];
    self.cognome = [[anagraficaDict objectForKey:kAnagraficaCognome] description];
    self.codiceFiscale = [[anagraficaDict objectForKey:kAnagraficaCodiceFiscale] description];
    self.codiceAderente = [[anagraficaDict objectForKey:kAnagraficaCodiceAderente] description];
    self.dataIscrizione = [Aderente getJSONDate:[anagraficaDict objectForKey:kAnagraficaDataIscrizione]];
    self.dataPrimaAdesione = [Aderente getJSONDate:[anagraficaDict objectForKey:kAnagraficaDataPrimaAdesione]];
    self.ragSocAzienda = [[anagraficaDict objectForKey:kAnagraficaRagSocAzienda] description];
    self.designatiBeneficiari = [[anagraficaDict objectForKey:kAnagraficaDesignatiBeneficiari] description];
    self.esisteCessioneQuinto = [[anagraficaDict objectForKey:kAnagraficaEsisteCessioneQuinto] description];
    self.indirizzoResidenza = [[IndirizzoResidenza alloc] init];
    [self.indirizzoResidenza configuraIndirizzoResidenza:[anagraficaDict objectForKey:kAnagraficaIndirizzoResidenza]];
}
@end

@interface Recapiti()
@property (nonatomic, retain, readwrite) NSString *telefono;
@property (nonatomic, retain, readwrite) NSString *fax;
@property (nonatomic, retain, readwrite) NSString *cellulare;
@property (nonatomic, retain, readwrite) NSString *email;
@property (nonatomic, retain, readwrite) NSString *esisteConsensoEcViaMail;
@end
@implementation Recapiti
- (void)configuraRecapiti:(NSDictionary *)recapitiDict {
    self.telefono = [[recapitiDict objectForKey:kRecapitiTelefono] description];
    self.fax = [[recapitiDict objectForKey:kRecapitiFax] description];
    self.cellulare = [[recapitiDict objectForKey:kRecapitiCellulare] description];
    self.email = [[recapitiDict objectForKey:kRecapitiEmail] description];
    self.esisteConsensoEcViaMail = [[recapitiDict objectForKey:kRecapitiEsisteConsensoEcViaMail] description];
}
@end

@interface Contributo()
@property (nonatomic, retain, readwrite) NSString *periodo;
@property (nonatomic, retain, readwrite) NSString *anno;
@property (nonatomic, retain, readwrite) NSString *nomeAzienda;
@property (nonatomic, retain, readwrite) NSString *contributoAderente;
@property (nonatomic, retain, readwrite) NSString *contributoAzienda;
@property (nonatomic, retain, readwrite) NSString *contributoTfr;
@property (nonatomic, retain, readwrite) NSString *contributoVolontario;
@property (nonatomic, retain, readwrite) NSString *contributoVolontarioAzienda;
@property (nonatomic, retain, readwrite) NSString *contributoAssicurativo;
@property (nonatomic, retain, readwrite) NSString *contributoIscrizione;
@property (nonatomic, retain, readwrite) NSString *contributoTfrSilente;
@property (nonatomic, retain, readwrite) NSString *contributoRivalutazioneTFR;
@property (nonatomic, retain, readwrite) NSString *statoContributo;
@end
@implementation Contributo
- (NSString*)periodo {
    return [NSString stringWithFormat:@"%@° trimestre",_periodo];
}

- (void)configuraContributo:(NSDictionary *)contributoDict {
    self.periodo = [[contributoDict objectForKey:kContributiPeriodo] description];
    self.anno = [[contributoDict objectForKey:kContributiAnno] description];
    self.nomeAzienda = [[contributoDict objectForKey:kContributiNomeAzienda] description];
    self.contributoAderente = [[contributoDict objectForKey:kContributiContributoAderente] description];
    self.contributoAzienda = [[contributoDict objectForKey:kContributiContributoAzienda] description];
    self.contributoTfr = [[contributoDict objectForKey:kContributiContributoTfr] description];
    self.contributoVolontario = [[contributoDict objectForKey:kContributiContributoVolontario] description];
    self.contributoVolontarioAzienda = [[contributoDict objectForKey:kContributiContributoVolontarioAzienda] description];
    self.contributoAssicurativo = [[contributoDict objectForKey:kContributiContributoAssicurativo] description];
    self.contributoIscrizione = [[contributoDict objectForKey:kContributiContributoIscrizione] description];
    self.contributoTfrSilente = [[contributoDict objectForKey:kContributiContributoTfrSilente] description];
    self.contributoRivalutazioneTFR = [[contributoDict objectForKey:kContributiContributoRivalutazioneTFR] description];
    self.statoContributo = [[contributoDict objectForKey:kContributiStatoContributo] description];
}
@end

@interface RendimentoDettaglio()
@property (nonatomic, retain, readwrite) NSString *nomeComparto;
@property (nonatomic, retain, readwrite) NSDate *dataQuota;
@property (nonatomic, retain, readwrite) NSString *anniContribuzione;
@property (nonatomic, retain, readwrite) NSString *mesiContribuzione;
@property (nonatomic, retain, readwrite) NSString *quoteAcquistate;
@property (nonatomic, retain, readwrite) NSString *valoreQuota;
@property (nonatomic, retain, readwrite) NSString *controvalore;
@property (nonatomic, retain, readwrite) NSString *contributoAderente;
@property (nonatomic, retain, readwrite) NSString *contributoTfr;
@property (nonatomic, retain, readwrite) NSString *contributoAzienda;
@property (nonatomic, retain, readwrite) NSString *rendimentoFondo;
@end
@implementation RendimentoDettaglio
- (void)configuraRendimentoDettaglio:(NSDictionary *)rendimentoDettaglioDict {
    self.nomeComparto = [[rendimentoDettaglioDict objectForKey:kRendimentoNomeComparto] description]; 
    self.dataQuota = [Aderente getJSONDate:[rendimentoDettaglioDict objectForKey:kRendimentoDataQuota]];
    self.anniContribuzione = [[rendimentoDettaglioDict objectForKey:kRendimentoAnniContribuzione] description];
    self.mesiContribuzione = [[rendimentoDettaglioDict objectForKey:kRendimentoMesiContribuzione] description];
    self.quoteAcquistate = [[rendimentoDettaglioDict objectForKey:kRendimentoQuoteAcquistate] description];
    self.valoreQuota = [[rendimentoDettaglioDict objectForKey:kRendimentoValoreQuota] description];
    self.controvalore = [[rendimentoDettaglioDict objectForKey:kRendimentoControvalore] description];
    self.contributoAderente = [[rendimentoDettaglioDict objectForKey:kRendimentoContributoAderente] description];
    self.contributoTfr = [[rendimentoDettaglioDict objectForKey:kRendimentoContributoTfr] description];
    self.contributoAzienda = [[rendimentoDettaglioDict objectForKey:kRendimentoContributoAzienda] description];
    self.rendimentoFondo = [[rendimentoDettaglioDict objectForKey:kRendimentoRendimentoFondo] description];
}
@end

@interface Rendimento()
@property (nonatomic, retain, readwrite) NSString *nomeCompartoAttuale;
@property (nonatomic, retain, readwrite) NSMutableArray *dettagliRendimento;
@property (nonatomic, retain, readwrite) NSString *controvaloreTotale;
@property (nonatomic, retain, readwrite) NSString *rendimentoAnnuo;
@end
@implementation Rendimento
- (void)configuraRendimento:(NSDictionary *)rendimentoDict {
    self.nomeCompartoAttuale = [rendimentoDict objectForKey:kRendimentoNomeCompartoAttuale];
    NSArray *dettagli = [rendimentoDict objectForKey:kRendimentoDettaglio];
    self.dettagliRendimento = [NSMutableArray arrayWithCapacity:dettagli.count];
    for (NSDictionary *rendimentoDettaglioDict in dettagli) {
        RendimentoDettaglio *rendimentoDettaglio = [[RendimentoDettaglio alloc] init];
        [rendimentoDettaglio configuraRendimentoDettaglio:rendimentoDettaglioDict];
        [self.dettagliRendimento addObject:rendimentoDettaglio];
    }
    self.controvaloreTotale = [rendimentoDict objectForKey:kRendimentoControvaloreTotale];
    self.rendimentoAnnuo = [rendimentoDict objectForKey:kRendimentoRendimentoAnnuo];
}
@end

@interface Liquidazione()
@property (nonatomic, retain, readwrite) NSString *tipo;
@property (nonatomic, retain, readwrite) NSString *motivazione;
@property (nonatomic, retain, readwrite) NSString *importoLordo;
@property (nonatomic, retain, readwrite) NSDate *dataRicezione;
@property (nonatomic, retain, readwrite) NSString *stato;
@end
@implementation Liquidazione
- (void)configuraLiquidazione:(NSDictionary *)liquidazioneDict {
    self.tipo = [liquidazioneDict objectForKey:kLiquidazioneTipo];
    self.motivazione = [liquidazioneDict objectForKey:kLiquidazioneMotivazione];
    NSNumber *importoDecimal = [NSNumber numberWithDouble:[[liquidazioneDict objectForKey:kLiquidazioneImportoLordo] doubleValue]];
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    [nf setNumberStyle:NSNumberFormatterCurrencyStyle];
    self.importoLordo = [nf stringFromNumber:importoDecimal];
    self.dataRicezione = [Aderente getJSONDate:[liquidazioneDict objectForKey:kLiquidazioneDataRicezione]];
    self.stato = [liquidazioneDict objectForKey:kLiquidazioneStato];
}
@end

@interface Aderente()
@property (nonatomic, retain, readwrite) NSString *username;
@property (nonatomic, retain, readwrite) NSString *password;
@property (nonatomic, retain, readwrite) Anagrafica *anagrafica;
@property (nonatomic, retain, readwrite) Recapiti *recapiti;
@property (nonatomic, retain, readwrite) NSArray *contributi;
@property (nonatomic, retain, readwrite) Rendimento *rendimento;
@property (nonatomic, retain, readwrite) NSArray *riscatti;
@property (nonatomic, retain, readwrite) NSArray *trasferimentiOut;
@property (nonatomic, retain, readwrite) NSArray *trasferimentiIn;
@property (nonatomic, retain, readwrite) NSArray *anticipi;
@property (nonatomic, retain, readwrite) NSArray *riscattiParziali;
@end

@implementation Aderente

+ (instancetype)sharedAderente  {
    static dispatch_once_t p = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (void)eseguiLoginConUsername:(NSString *)username password:(NSString *)password {
    self.username = username;
    self.password = password;
}

- (void)configuraAnagrafica:(NSDictionary *)anagraficaDict {
    if (!self.anagrafica) {
        self.anagrafica = [[Anagrafica alloc] init];
    }
    [self.anagrafica configuraAnagrafica:anagraficaDict];
}

- (void)configuraRecapiti:(NSDictionary *)recapitiDict {
    if (!self.recapiti) {
        self.recapiti = [[Recapiti alloc] init];
    }
    [self.recapiti configuraRecapiti:recapitiDict];
}

- (void)configuraContributi:(NSArray *)contributiArray {
    NSMutableArray *contributiDaInserire = [NSMutableArray arrayWithCapacity:contributiArray.count];
    for (NSDictionary *contributoDict in contributiArray) {
        Contributo *contributo = [[Contributo alloc] init];
        [contributo configuraContributo:contributoDict];
        [contributiDaInserire addObject:contributo];
    }
    self.contributi = [NSArray arrayWithArray:contributiDaInserire];
}

- (void)configuraRendimento:(NSDictionary *)rendimentoDict {
    if (!self.rendimento) {
        self.rendimento = [[Rendimento alloc] init];
    }
    [self.rendimento configuraRendimento:rendimentoDict];
}

- (void)configuraRiscatti:(NSArray *)riscattiArray {
    NSMutableArray *riscattiDaInserire = [NSMutableArray array];
    for (NSDictionary *liquidazioneDict in riscattiArray) {
        Liquidazione *oggettoLiquidazione = [[Liquidazione alloc] init];
        [oggettoLiquidazione configuraLiquidazione:liquidazioneDict];
        [riscattiDaInserire addObject:oggettoLiquidazione];
    }
    self.riscatti = riscattiDaInserire;
}

- (void)configuraRiscattiParziali:(NSArray *)riscattiParzialiArray {
    NSMutableArray *riscattiParzialiDaInserire = [NSMutableArray array];
    for (NSDictionary *liquidazioneDict in riscattiParzialiArray) {
        Liquidazione *oggettoLiquidazione = [[Liquidazione alloc] init];
        [oggettoLiquidazione configuraLiquidazione:liquidazioneDict];
        [riscattiParzialiDaInserire addObject:oggettoLiquidazione];
    }
    self.riscattiParziali = riscattiParzialiDaInserire;
}

- (void)configuraTrasferimentiIn:(NSArray *)trasferimentiInArray {
    NSMutableArray *trasferimentiDaInserire = [NSMutableArray array];
    for (NSDictionary *liquidazioneDict in trasferimentiInArray) {
        Liquidazione *oggettoLiquidazione = [[Liquidazione alloc] init];
        [oggettoLiquidazione configuraLiquidazione:liquidazioneDict];
        [trasferimentiDaInserire addObject:oggettoLiquidazione];
    }
    self.trasferimentiIn = trasferimentiDaInserire;
}

- (void)configuraTrasferimentiOut:(NSArray *)trasferimentiOutArray {
    NSMutableArray *trasferimentiDaInserire = [NSMutableArray array];
    for (NSDictionary *liquidazioneDict in trasferimentiOutArray) {
        Liquidazione *oggettoLiquidazione = [[Liquidazione alloc] init];
        [oggettoLiquidazione configuraLiquidazione:liquidazioneDict];
        [trasferimentiDaInserire addObject:oggettoLiquidazione];
    }
    self.trasferimentiOut = trasferimentiDaInserire;
}

- (void)configuraAnticipi:(NSArray *)anticipiArray {
    NSMutableArray *anticipiDaInserire = [NSMutableArray array];
    for (NSDictionary *liquidazioneDict in anticipiArray) {
        Liquidazione *oggettoLiquidazione = [[Liquidazione alloc] init];
        [oggettoLiquidazione configuraLiquidazione:liquidazioneDict];
        [anticipiDaInserire addObject:oggettoLiquidazione];
    }
    self.anticipi = anticipiDaInserire;
}

- (void)resetAderente {
    self.anagrafica = nil;
    self.recapiti = nil;
    self.contributi = nil;
    self.rendimento = nil;
}

#pragma mark - ACCESSORI
+ (NSDate *) getJSONDate:(NSString*)dateFromJSON {
    NSString* header = @"/Date(";
    int headerLength = (int)[header length];
    
    NSString*  timestampString;
    
    NSScanner* scanner = [[NSScanner alloc] initWithString:dateFromJSON];
    [scanner setScanLocation:headerLength];
    [scanner scanUpToString:@")" intoString:&timestampString];
    
    NSCharacterSet* timezoneDelimiter = [NSCharacterSet characterSetWithCharactersInString:@"+-"];
    NSRange rangeOfTimezoneSymbol = [timestampString rangeOfCharacterFromSet:timezoneDelimiter];
    
    if (rangeOfTimezoneSymbol.length!=0) {
        scanner = [[NSScanner alloc] initWithString:timestampString];
        
        NSRange rangeOfFirstNumber;
        rangeOfFirstNumber.location = 0;
        rangeOfFirstNumber.length = rangeOfTimezoneSymbol.location;
        
        NSRange rangeOfSecondNumber;
        rangeOfSecondNumber.location = rangeOfTimezoneSymbol.location + 1;
        rangeOfSecondNumber.length = [timestampString length] - rangeOfSecondNumber.location;
        
        NSString* firstNumberString = [timestampString substringWithRange:rangeOfFirstNumber];
        
        unsigned long long firstNumber = [firstNumberString longLongValue];
        
        NSTimeInterval interval = firstNumber/1000;
        
        return [NSDate dateWithTimeIntervalSince1970:interval];
    }
    
    unsigned long long firstNumber = [timestampString longLongValue];
    NSTimeInterval interval = firstNumber/1000;
    
    return [NSDate dateWithTimeIntervalSince1970:interval];
}

@end