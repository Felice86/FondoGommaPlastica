//
//  Aderente.m
//  FondoGommaPlastica
//
//  Created by Felice on 03/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import "Aderente.h"
#import "Configurations.h"

@implementation Aderente
+ (instancetype)sharedAderente  {
    static dispatch_once_t p = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (void)sistemaDatiRecuperati:(NSDictionary *)datiRecuperati perOperazione:(NSString *)operazione {
    if ([operazione isEqualToString:[[Configurations sharedConfiguration] anagrafica]]) {
        self.nome = [datiRecuperati objectForKey:knome];
        self.cognome = [datiRecuperati objectForKey:kcognome];
        self.codiceFiscale = [datiRecuperati objectForKey:kcodiceFiscale];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        NSString *dataIscrizioneJson = [datiRecuperati objectForKey:kdataIscrizione];
        self.dataIscrizioneAderente = [dateFormatter stringFromDate:[self getJSONDate:dataIscrizioneJson]];
    }
}

#pragma mark - ACCESSORI

- (NSDate *) getJSONDate:(NSString*)dateFromJSON {
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
        NSString* secondNumberString = [timestampString substringWithRange:rangeOfSecondNumber];
        
        unsigned long long firstNumber = [firstNumberString longLongValue];
        int secondNumber = [secondNumberString intValue];
        
        NSTimeInterval interval = firstNumber/1000;
        
        return [NSDate dateWithTimeIntervalSince1970:interval];
    }
    
    unsigned long long firstNumber = [timestampString longLongValue];
    NSTimeInterval interval = firstNumber/1000;
    
    return [NSDate dateWithTimeIntervalSince1970:interval];
}

@end