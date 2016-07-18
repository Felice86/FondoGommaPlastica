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
- (double)doubleValue:(NSDictionary*)dict forField:(NSString*)field {
    if (![dict objectForKey:field]) {
        return 0;
    }
    return [[dict objectForKey:field] doubleValue];
}

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
- (double)doubleValue:(NSDictionary*)dict forField:(NSString*)field {
    if (![dict objectForKey:field]) {
        return 0;
    }
    return [[dict objectForKey:field] doubleValue];
}

- (void)configuraAnagrafica:(NSDictionary *)anagraficaDict {
    self.nome = [[anagraficaDict objectForKey:kAnagraficaNome] description];
    self.cognome = [[anagraficaDict objectForKey:kAnagraficaCognome] description];
    self.codiceFiscale = [[anagraficaDict objectForKey:kAnagraficaCodiceFiscale] description];
    self.codiceAderente = [[anagraficaDict objectForKey:kAnagraficaCodiceAderente] description];
    self.dataIscrizione = [Aderente getJSONDate:[anagraficaDict objectForKey:kAnagraficaDataIscrizione]];
    self.dataPrimaAdesione = [Aderente getJSONDate:[anagraficaDict objectForKey:kAnagraficaDataPrimaAdesione]];
    self.ragSocAzienda = [[anagraficaDict objectForKey:kAnagraficaRagSocAzienda] description];
    self.designatiBeneficiari = [[anagraficaDict objectForKey:kAnagraficaDesignatiBeneficiari] boolValue] ? @"SI" : @"NO";
    self.esisteCessioneQuinto = [[anagraficaDict objectForKey:kAnagraficaEsisteCessioneQuinto] boolValue] ? @"SI" : @"NO";
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
- (double)doubleValue:(NSDictionary*)dict forField:(NSString*)field {
    if (![dict objectForKey:field]) {
        return 0;
    }
    return [[dict objectForKey:field] doubleValue];
}

- (void)configuraRecapiti:(NSDictionary *)recapitiDict {
    self.telefono = [[recapitiDict objectForKey:kRecapitiTelefono] description];
    self.fax = [[recapitiDict objectForKey:kRecapitiFax] description];
    self.cellulare = [[recapitiDict objectForKey:kRecapitiCellulare] description];
    self.email = [[recapitiDict objectForKey:kRecapitiEmail] description];
    self.esisteConsensoEcViaMail = [[recapitiDict objectForKey:kRecapitiEsisteConsensoEcViaMail] boolValue] ? @"SI" : @"NO";
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
- (double)doubleValue:(NSDictionary*)dict forField:(NSString*)field {
    if ([[dict objectForKey:field] isKindOfClass:[NSNull class]]) {
        return 0;
    }
    return [[dict objectForKey:field] doubleValue];
}

- (NSString*)meseDaPeriodo:(NSInteger)periodo {
    switch (periodo) {
        case 1:
            return @"Gennaio";
            break;
        case 2:
            return @"Febbraio";
            break;
        case 3:
            return @"Marzo";
            break;
        case 4:
            return @"Aprile";
            break;
        case 5:
            return @"Maggio";
            break;
        case 6:
            return @"Giugno";
            break;
        case 7:
            return @"Luglio";
            break;
        case 8:
            return @"Agosto";
            break;
        case 9:
            return @"Settembre";
            break;
        case 10:
            return @"Ottobre";
            break;
        case 11:
            return @"Novembre";
            break;
        case 12:
            return @"Dicembre";
            break;
        default:
            return @"";
            break;
    }
}

- (NSString*)aggiungiValuta:(NSNumber*)decimal {
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSLocale *itLocale = [NSLocale localeWithLocaleIdentifier:@"it_IT"];
    [currencyFormatter setLocale:itLocale];
    return [currencyFormatter stringFromNumber:decimal];
}

- (void)configuraContributo:(NSDictionary *)contributoDict {
    NSInteger periodoInt = [[contributoDict objectForKey:kContributiPeriodo] integerValue];
    self.periodo = [self meseDaPeriodo:periodoInt];
    self.anno = [[contributoDict objectForKey:kContributiAnno] description];
    self.nomeAzienda = [[contributoDict objectForKey:kContributiNomeAzienda] description];
    self.contributoAderente = [self aggiungiValuta:[NSNumber numberWithDouble:[self doubleValue:contributoDict forField:kContributiContributoAderente]]];
    self.contributoAzienda = [self aggiungiValuta:[NSNumber numberWithDouble:[self doubleValue:contributoDict forField:kContributiContributoAzienda]]];
    self.contributoTfr = [self aggiungiValuta:[NSNumber numberWithDouble:[self doubleValue:contributoDict forField:kContributiContributoTfr]]];
    self.contributoVolontario = [self aggiungiValuta:[NSNumber numberWithDouble:[self doubleValue:contributoDict forField:kContributiContributoVolontario]]];
    self.contributoVolontarioAzienda = [self aggiungiValuta:[NSNumber numberWithDouble:[self doubleValue:contributoDict forField:kContributiContributoVolontarioAzienda]]];
    self.contributoAssicurativo = [self aggiungiValuta:[NSNumber numberWithDouble:[self doubleValue:contributoDict forField:kContributiContributoAssicurativo]]];
    self.contributoIscrizione = [self aggiungiValuta:[NSNumber numberWithDouble:[self doubleValue:contributoDict forField:kContributiContributoIscrizione]]];
    self.contributoTfrSilente = [self aggiungiValuta:[NSNumber numberWithDouble:[self doubleValue:contributoDict forField:kContributiContributoTfrSilente]]];
    self.contributoRivalutazioneTFR = [self aggiungiValuta:[NSNumber numberWithDouble:[self doubleValue:contributoDict forField:kContributiContributoRivalutazioneTFR]]];
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
- (double)doubleValue:(NSDictionary*)dict forField:(NSString*)field {
    if (![dict objectForKey:field]) {
        return 0;
    }
    return [[dict objectForKey:field] doubleValue];
}

- (NSString*)aggiungiValuta:(NSNumber*)decimal {
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSLocale *itLocale = [NSLocale localeWithLocaleIdentifier:@"it_IT"];
    [currencyFormatter setLocale:itLocale];
    return [currencyFormatter stringFromNumber:decimal];
}

- (void)configuraRendimentoDettaglio:(NSDictionary *)rendimentoDettaglioDict {
    self.nomeComparto = [[rendimentoDettaglioDict objectForKey:kRendimentoNomeComparto] description]; 
    self.dataQuota = [Aderente getJSONDate:[rendimentoDettaglioDict objectForKey:kRendimentoDataQuota]];
    self.anniContribuzione = [[rendimentoDettaglioDict objectForKey:kRendimentoAnniContribuzione] description];
    self.mesiContribuzione = [[rendimentoDettaglioDict objectForKey:kRendimentoMesiContribuzione] description];
    self.quoteAcquistate = [[rendimentoDettaglioDict objectForKey:kRendimentoQuoteAcquistate] description];
    self.valoreQuota = [self aggiungiValuta:[NSNumber numberWithDouble:[self doubleValue:rendimentoDettaglioDict forField:kRendimentoValoreQuota]]];
    self.controvalore = [self aggiungiValuta:[NSNumber numberWithDouble:[self doubleValue:rendimentoDettaglioDict forField:kRendimentoControvalore]]];
    self.contributoAderente = [self aggiungiValuta:[NSNumber numberWithDouble:[self doubleValue:rendimentoDettaglioDict forField:kRendimentoContributoAderente]]];
    self.contributoTfr = [self aggiungiValuta:[NSNumber numberWithDouble:[self doubleValue:rendimentoDettaglioDict forField:kRendimentoContributoTfr]]];
    self.contributoAzienda = [self aggiungiValuta:[NSNumber numberWithDouble:[self doubleValue:rendimentoDettaglioDict forField:kRendimentoContributoAzienda]]];
    self.rendimentoFondo = [self aggiungiValuta:[NSNumber numberWithDouble:[self doubleValue:rendimentoDettaglioDict forField:kRendimentoRendimentoFondo]]];
}
@end

@interface Rendimento()
@property (nonatomic, retain, readwrite) NSString *nomeCompartoAttuale;
@property (nonatomic, retain, readwrite) NSMutableArray *dettagliRendimento;
@property (nonatomic, retain, readwrite) NSString *controvaloreTotale;
@property (nonatomic, retain, readwrite) NSString *rendimentoAnnuo;
@end
@implementation Rendimento
- (double)doubleValue:(NSDictionary*)dict forField:(NSString*)field {
    if (![dict objectForKey:field]) {
        return 0;
    }
    return [[dict objectForKey:field] doubleValue];
}

- (NSString*)aggiungiValuta:(NSNumber*)decimal {
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSLocale *itLocale = [NSLocale localeWithLocaleIdentifier:@"it_IT"];
    [currencyFormatter setLocale:itLocale];
    return [currencyFormatter stringFromNumber:decimal];
}

- (void)configuraRendimento:(NSDictionary *)rendimentoDict {
    self.nomeCompartoAttuale = [rendimentoDict objectForKey:kRendimentoNomeCompartoAttuale];
    NSArray *dettagli = [rendimentoDict objectForKey:kRendimentoDettaglio];
    self.dettagliRendimento = [NSMutableArray arrayWithCapacity:dettagli.count];
    for (NSDictionary *rendimentoDettaglioDict in dettagli) {
        RendimentoDettaglio *rendimentoDettaglio = [[RendimentoDettaglio alloc] init];
        [rendimentoDettaglio configuraRendimentoDettaglio:rendimentoDettaglioDict];
        [self.dettagliRendimento addObject:rendimentoDettaglio];
    }
    self.controvaloreTotale = [self aggiungiValuta:[NSNumber numberWithDouble:[self doubleValue:rendimentoDict forField:kRendimentoControvaloreTotale]]];
    self.rendimentoAnnuo = [self aggiungiValuta:[NSNumber numberWithDouble:[self doubleValue:rendimentoDict forField:kRendimentoRendimentoAnnuo]]];
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
- (double)doubleValue:(NSDictionary*)dict forField:(NSString*)field {
    if (![dict objectForKey:field]) {
        return 0;
    }
    return [[dict objectForKey:field] doubleValue];
}

- (NSString*)aggiungiValuta:(NSNumber*)decimal {
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSLocale *itLocale = [NSLocale localeWithLocaleIdentifier:@"it_IT"];
    [currencyFormatter setLocale:itLocale];
    return [currencyFormatter stringFromNumber:decimal];
}

- (void)configuraLiquidazione:(NSDictionary *)liquidazioneDict {
    self.tipo = [liquidazioneDict objectForKey:kLiquidazioneTipo];
    self.motivazione = [liquidazioneDict objectForKey:kLiquidazioneMotivazione];
    self.importoLordo = [self aggiungiValuta:[NSNumber numberWithDouble:[self doubleValue:liquidazioneDict forField:kLiquidazioneImportoLordo]]];
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

- (double)doubleValue:(NSDictionary*)dict forField:(NSString*)field {
    if (![dict objectForKey:field]) {
        return 0;
    }
    return [[dict objectForKey:field] doubleValue];
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