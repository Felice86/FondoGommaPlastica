//
//  Configurations.m
//  FondoGommaPlastica
//
//  Created by Felice on 03/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import "Configurations.h"

@interface Configurations() 
@property (nonatomic, retain) NSDictionary *config;
@end

@implementation Configurations
+ (instancetype)sharedConfiguration  {
    static dispatch_once_t p = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (instancetype)init {
    if (self = [super init]) {
        NSString *configPlist = [[NSBundle mainBundle] pathForResource:NSStringFromClass(self.class) ofType:@"plist"];
        self.config = [NSDictionary dictionaryWithContentsOfFile:configPlist];
        NSAssert(self.config, @"Configurazione fallita. Chiudo");
    }
    return self;
}

- (NSString *)idUtenteInvocatore {
    return [self.config objectForKey:@"idUtenteInvocatore"];
}

- (NSString *)pswInvocatore {
    return [self.config objectForKey:@"pswInvocatore"];
}

- (NSString *)baseUrl {
    return [self.config objectForKey:@"baseUrl"];
}

- (NSString *)recapiti {
    return [self.config objectForKey:@"recapiti"];
}

- (NSString *)contributi {
    return [self.config objectForKey:@"contributi"];
}

- (NSString *)rendimento {
    return [self.config objectForKey:@"rendimento"];
}

- (NSString *)anagrafica {
    return [self.config objectForKey:@"anagrafica"];
}

- (NSString *)liquidazioni:(IdTipoPrestazione)idTipoPrestazione {
    return [NSString stringWithFormat:[self.config objectForKey:@"liquidazioni"],idTipoPrestazione];
}

- (NSString *)abilitaUtente {
    return [self.config objectForKey:@"abilitaUtente"];
}

- (NSString *)usernameAdTest {
    return [self.config objectForKey:@"usernameAdTest"];
}

- (NSString *)passwordAdTest {
    return [self.config objectForKey:@"passwordAdTest"];
}

@end
