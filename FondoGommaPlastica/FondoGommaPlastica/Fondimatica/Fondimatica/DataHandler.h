//
//  DataHandler.h
//  FondoGommaPlastica
//
//  Created by Felice on 03/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataHandler : NSObject
+ (instancetype)sharedData;
- (NSURLRequest*)createWebRequest:(NSURL*)url method:(NSString*)method body:(NSData*)bodyData;
- (NSURL*)creaUrlDaConfig:(NSString*)config codiceUtente:(NSString*)codiceUtente;
@end
