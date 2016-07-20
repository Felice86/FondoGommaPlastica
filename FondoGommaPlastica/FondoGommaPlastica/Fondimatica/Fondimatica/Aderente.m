//
//  Aderente.m
//  FondoGommaPlastica
//
//  Created by Felice on 03/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import "Aderente.h"
#import "Configurations.h"

@interface InformazioneAderente()
@end
@implementation InformazioneAderente
- (NSString *)legenda {
    return @"";
}

- (NSArray *)valoriDaStampare {
    return [Aderente propertiesForClass:self.class];
}

@end

@interface IndirizzoResidenza()
@property (nonatomic, retain, readwrite) NSString *viaECivico;
@property (nonatomic, retain, readwrite) NSString *luogo;
@property (nonatomic, retain, readwrite) NSString *cap;
@property (nonatomic, retain, readwrite) NSString *siglaProv;
@end
@implementation IndirizzoResidenza
- (void)configuraIndirizzoResidenza:(NSDictionary *)indirizzoDict {
    self.viaECivico = [Aderente recuperaValore:kAnagraficaViaECivico daOggetto:indirizzoDict valuta:NO];
    self.luogo = [Aderente recuperaValore:kAnagraficaLuogo daOggetto:indirizzoDict valuta:NO];
    self.cap = [Aderente recuperaValore:kAnagraficaCap daOggetto:indirizzoDict valuta:NO];
    self.siglaProv = [Aderente recuperaValore:kAnagraficaSiglaProv daOggetto:indirizzoDict valuta:NO];
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
    self.nome = [Aderente recuperaValore:kAnagraficaNome daOggetto:anagraficaDict valuta:NO];
    self.cognome = [Aderente recuperaValore:kAnagraficaCognome daOggetto:anagraficaDict valuta:NO];
    self.codiceFiscale = [Aderente recuperaValore:kAnagraficaCodiceFiscale daOggetto:anagraficaDict valuta:NO];
    self.codiceAderente = [Aderente recuperaValore:kAnagraficaCodiceAderente daOggetto:anagraficaDict valuta:NO];
    self.dataIscrizione = [Aderente getJSONDate:[anagraficaDict objectForKey:kAnagraficaDataIscrizione]];
    self.dataPrimaAdesione = [Aderente getJSONDate:[anagraficaDict objectForKey:kAnagraficaDataPrimaAdesione]];
    self.ragSocAzienda = [Aderente recuperaValore:kAnagraficaRagSocAzienda daOggetto:anagraficaDict valuta:NO];
    self.designatiBeneficiari = [Aderente recuperaValore:kAnagraficaDesignatiBeneficiari daOggetto:anagraficaDict valuta:NO];
    self.esisteCessioneQuinto = [Aderente recuperaValore:kAnagraficaEsisteCessioneQuinto daOggetto:anagraficaDict valuta:NO];
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
    self.telefono = [Aderente recuperaValore:kRecapitiTelefono daOggetto:recapitiDict valuta:NO];
    self.fax = [Aderente recuperaValore:kRecapitiFax daOggetto:recapitiDict valuta:NO];
    self.cellulare = [Aderente recuperaValore:kRecapitiCellulare daOggetto:recapitiDict valuta:NO];
    self.email = [Aderente recuperaValore:kRecapitiEmail daOggetto:recapitiDict valuta:NO];
    self.esisteConsensoEcViaMail = [Aderente recuperaValore:kRecapitiEsisteConsensoEcViaMail daOggetto:recapitiDict valuta:NO];
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
- (NSArray *)valoriDaStampare {
    return @[kContributiPeriodo,kContributiAnno,kContributiNomeAzienda,kContributiContributoAderente,kContributiContributoAzienda,kContributiContributoTfr,kContributiStatoContributo];
}

- (NSString *)legenda {
    return @"Legenda:\nAttribuito=segnalato dall'azienda senza versamento\nSpesato=importo appena incassato\nQuotato=incassato e investito";
}

- (void)configuraContributo:(NSDictionary *)contributoDict {
    self.periodo = [Aderente recuperaValore:kContributiPeriodo daOggetto:contributoDict valuta:NO];
    self.anno = [Aderente recuperaValore:kContributiAnno daOggetto:contributoDict valuta:NO];
    self.nomeAzienda = [Aderente recuperaValore:kContributiNomeAzienda daOggetto:contributoDict valuta:NO];
    self.contributoAderente = [Aderente recuperaValore:kContributiContributoAderente daOggetto:contributoDict valuta:YES];
    self.contributoAzienda = [Aderente recuperaValore:kContributiContributoAzienda daOggetto:contributoDict valuta:YES];
    self.contributoTfr = [Aderente recuperaValore:kContributiContributoTfr daOggetto:contributoDict valuta:YES];
    self.contributoVolontario = [Aderente recuperaValore:kContributiContributoVolontario daOggetto:contributoDict valuta:YES];
    self.contributoVolontarioAzienda = [Aderente recuperaValore:kContributiContributoVolontarioAzienda daOggetto:contributoDict valuta:YES];
    self.contributoAssicurativo = [Aderente recuperaValore:kContributiContributoAssicurativo daOggetto:contributoDict valuta:YES];
    self.contributoIscrizione = [Aderente recuperaValore:kContributiContributoIscrizione daOggetto:contributoDict valuta:YES];
    self.contributoTfrSilente = [Aderente recuperaValore:kContributiContributoTfrSilente daOggetto:contributoDict valuta:YES];
    self.contributoRivalutazioneTFR = [Aderente recuperaValore:kContributiContributoRivalutazioneTFR daOggetto:contributoDict valuta:YES];
    self.statoContributo = [Aderente recuperaValore:kContributiStatoContributo daOggetto:contributoDict valuta:NO];
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
- (NSArray *)valoriDaStampare {
    return @[kRendimentoQuoteAcquistate,kRendimentoValoreQuota,kRendimentoControvalore,kRendimentoContributoAderente,kRendimentoContributoAzienda,kRendimentoContributoTfr];
}
- (void)configuraRendimentoDettaglio:(NSDictionary *)rendimentoDettaglioDict {
    self.nomeComparto = [Aderente recuperaValore:kRendimentoNomeComparto daOggetto:rendimentoDettaglioDict valuta:NO];
    self.dataQuota = [Aderente getJSONDate:[rendimentoDettaglioDict objectForKey:kRendimentoDataQuota]];
    self.anniContribuzione = [Aderente recuperaValore:kRendimentoAnniContribuzione daOggetto:rendimentoDettaglioDict valuta:NO];
    self.mesiContribuzione = [Aderente recuperaValore:kRendimentoMesiContribuzione daOggetto:rendimentoDettaglioDict valuta:NO];
    self.quoteAcquistate = [Aderente recuperaValore:kRendimentoQuoteAcquistate daOggetto:rendimentoDettaglioDict valuta:NO];
    self.valoreQuota = [Aderente recuperaValore:kRendimentoValoreQuota daOggetto:rendimentoDettaglioDict valuta:YES];
    self.controvalore = [Aderente recuperaValore:kRendimentoControvalore daOggetto:rendimentoDettaglioDict valuta:YES];
    self.contributoAderente = [Aderente recuperaValore:kRendimentoContributoAderente daOggetto:rendimentoDettaglioDict valuta:YES];
    self.contributoTfr = [Aderente recuperaValore:kRendimentoContributoTfr daOggetto:rendimentoDettaglioDict valuta:YES];
    self.contributoAzienda = [Aderente recuperaValore:kRendimentoContributoAzienda daOggetto:rendimentoDettaglioDict valuta:YES];
    self.rendimentoFondo = [Aderente recuperaValore:kRendimentoRendimentoFondo daOggetto:rendimentoDettaglioDict valuta:YES];
}
@end

@interface Rendimento()
@property (nonatomic, retain, readwrite) NSString *nomeCompartoAttuale;
@property (nonatomic, retain, readwrite) NSMutableArray *dettagliRendimento;
@property (nonatomic, retain, readwrite) NSString *controvaloreTotale;
@property (nonatomic, retain, readwrite) NSString *rendimentoAnnuo;
@end
@implementation Rendimento
- (NSArray *)valoriDaStampare {
    return @[kRendimentoNomeCompartoAttuale,@"dettagliRendimento"];
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
    self.controvaloreTotale = [Aderente recuperaValore:kRendimentoControvaloreTotale daOggetto:rendimentoDict valuta:YES];
    self.rendimentoAnnuo = [Aderente recuperaValore:kRendimentoRendimentoAnnuo daOggetto:rendimentoDict valuta:YES];
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
- (NSString *)legenda {
    return @"Legenda:\n- da elaborare=accettata\n- elaborata=inserita a sistema\n- valorizzata=quote vendute con stima tassazione\n- da validare= pronta per la lista pagamenti\n- liquidabile=inserita nella prossima lista pagamenti\n- liquidata=pagamento effettuato (sarà disponibile con i tempi della banca)";
}

- (void)configuraLiquidazione:(NSDictionary *)liquidazioneDict {
    self.tipo = [Aderente recuperaValore:kLiquidazioneTipo daOggetto:liquidazioneDict valuta:NO];
    self.motivazione = [Aderente recuperaValore:kLiquidazioneMotivazione daOggetto:liquidazioneDict valuta:NO];
    self.importoLordo = [Aderente recuperaValore:kLiquidazioneImportoLordo daOggetto:liquidazioneDict valuta:YES];
    self.dataRicezione = [Aderente getJSONDate:[liquidazioneDict objectForKey:kLiquidazioneDataRicezione]];
    self.stato = [Aderente recuperaValore:kLiquidazioneStato daOggetto:liquidazioneDict valuta:NO];
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
+ (NSString*)aggiungiValuta:(NSNumber*)decimal {
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSLocale *itLocale = [NSLocale localeWithLocaleIdentifier:@"it_IT"];
    [currencyFormatter setLocale:itLocale];
    return [currencyFormatter stringFromNumber:decimal];
}

+ (NSString *)recuperaValore:(NSString *)chiave daOggetto:(NSDictionary *)oggetto valuta:(BOOL)isValuta{
    NSObject *valoreObject = [oggetto objectForKey:chiave];
    if ([valoreObject isKindOfClass:[NSNull class]]) {
        return @"n.d.";
    }
//    if (valoreObject isKindOfClass:[ns])
    if ([NSStringFromClass(valoreObject.class) isEqualToString:@"__NSCFBoolean"]) {
        BOOL valoreBool = [(NSNumber*)valoreObject boolValue];
        return valoreBool?@"SI":@"NO";
    }
    if ([chiave isEqualToString:kContributiPeriodo]) {
        NSInteger meseInt = [(NSString*)valoreObject integerValue];
        return [self meseDaPeriodo:meseInt];
    }
    if (isValuta) {
        double valoreDouble = [(NSString*)valoreObject doubleValue];
        NSNumber *valoreNumber = [NSNumber numberWithDouble:valoreDouble];
        return [self aggiungiValuta:valoreNumber];
    }
    return [valoreObject description];
}

+ (NSDate *) getJSONDate:(NSString*)dateFromJSON {
    if ([dateFromJSON isKindOfClass:[NSNull class]]) {
        return nil;
    }
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

+ (NSString*)meseDaPeriodo:(NSInteger)periodo {
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

+ (NSArray *)propertiesForClass:(Class)classe
{
    unsigned count;
    objc_property_t *properties = class_copyPropertyList(classe, &count);
    
    NSMutableArray *rv = [NSMutableArray array];
    
    unsigned i;
    for (i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        [rv addObject:name];
    }
    
    free(properties);
    
    return rv;
}

@end