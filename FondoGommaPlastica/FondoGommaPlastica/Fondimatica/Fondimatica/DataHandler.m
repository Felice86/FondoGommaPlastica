//
//  DataHandler.m
//  FondoGommaPlastica
//
//  Created by Felice on 03/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import "DataHandler.h"
#import "Configurations.h"

@implementation DataHandler
+ (instancetype)sharedData  {
    static dispatch_once_t p = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

#pragma mark - METODI PER IL RECUPERO DEI DATI
- (NSString*)authenticationValueFor:(NSString*)idUtente psw:(NSString*)psw {
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", idUtente, psw];
    NSData *authData = [authStr dataUsingEncoding:NSASCIIStringEncoding];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:80]];
    return authValue;
}

- (NSURLRequest*)createWebRequest:(NSURL*)url method:(NSString*)method body:(NSData*)bodyData {
    NSString *idUtente = [[Configurations sharedConfiguration] idUtenteInvocatore];
    NSString *psw = [[Configurations sharedConfiguration] pswInvocatore];
    NSString *authValue = [self authenticationValueFor:idUtente psw:psw];
    NSDictionary *httpHeaders = @{
                                  @"authorization":authValue,
                                  @"content-type":@"application/json"
                                  };
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setAllHTTPHeaderFields:httpHeaders];
    [request setHTTPMethod:method];
    if (bodyData) {
        [request setHTTPBody:bodyData];
    }
    
    return request;
}

- (NSURL*)creaUrlDaConfig:(NSString*)config codiceUtente:(NSString*)codiceUtente  {
    NSString *baseUrl = [[Configurations sharedConfiguration] baseUrl];
    NSString *metodoUrl = [baseUrl stringByAppendingPathComponent:config];
    if (!codiceUtente) {
        codiceUtente = @"";
    }
    NSString *urlCompleto = [NSString stringWithFormat:metodoUrl, codiceUtente];
    NSURL *url = [NSURL URLWithString:urlCompleto];
    return url;
}

@end
        