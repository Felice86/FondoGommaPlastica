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

#pragma mark - DATI
- (NSInteger)annoIscrizioneAderente {
    NSDate *dataRecuperata = [self getJSONDate:[self.anagraficaDict objectForKey:kAnagraficaDataIscrizione]];
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dc = [calendar components:NSCalendarUnitYear fromDate:dataRecuperata];
    return dc.year;
}

- (NSString *)nominativoAderente {
    NSString *nome = [self.anagraficaDict objectForKey:kAnagraficaNome];
    NSString *cognome = [self.anagraficaDict objectForKey:kAnagraficaCognome];
    return [NSString stringWithFormat:@"%@ %@",nome,cognome];
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
        
        unsigned long long firstNumber = [firstNumberString longLongValue];
        
        NSTimeInterval interval = firstNumber/1000;
        
        return [NSDate dateWithTimeIntervalSince1970:interval];
    }
    
    unsigned long long firstNumber = [timestampString longLongValue];
    NSTimeInterval interval = firstNumber/1000;
    
    return [NSDate dateWithTimeIntervalSince1970:interval];
}

@end