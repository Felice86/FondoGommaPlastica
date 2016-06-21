//
//  CustomScrollView.m
//  FondoGommaPlastica
//
//  Created by Felice on 18/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import "CustomScrollView.h"

#define kImmagineChiSiamo @"omino"
#define kImmagineLogin @"lente"
#define kImmagineContatti @"telefono"

@interface CustomScrollView()
@property (nonatomic, retain, readwrite) NSMutableArray *immaginiScrollabili;
@property (nonatomic, retain, readwrite) CustomImage *immagineCentrale;
@property (nonatomic, assign) NSInteger indiceSelezionato;
@property (nonatomic, assign) CGFloat larghezzaImmagine;
@end

@implementation CustomScrollView

//Inserisce una serie di immagini in colonne
- (void)riempiCustomScrollViewConImmagini {
    NSArray *immaginiDaCaricare = @[kImmagineContatti,kImmagineChiSiamo,kImmagineLogin,kImmagineContatti,kImmagineChiSiamo];
    if (!self.immaginiScrollabili) {
        self.immaginiScrollabili =[NSMutableArray arrayWithCapacity:immaginiDaCaricare.count]; 
    } else {
        [self.immaginiScrollabili removeAllObjects];
    }
    self.larghezzaImmagine = self.frame.size.width/3;
    CGRect frameImmagine = CGRectMake(0, 0, self.larghezzaImmagine, self.frame.size.height);
    for (NSInteger i=0;i<immaginiDaCaricare.count;i++) {
        NSString *titoloImmagine = [immaginiDaCaricare objectAtIndex:i];
        NSString *titoloGrande = [NSString stringWithFormat:@"%@_grande.png",titoloImmagine];
        NSString *titoloPiccolo = [NSString stringWithFormat:@"%@_piccolo.png",titoloImmagine];
        UIImage *immagineGrande = [UIImage imageNamed:titoloGrande];
        UIImage *immaginePiccolo = [UIImage imageNamed:titoloPiccolo];
        CustomImage *imageView = [[CustomImage alloc] initWithFrame:frameImmagine immaginePiccola:immaginePiccolo immagineGrande:immagineGrande];
        //        imageView.contentMode = UIViewContentModeCenter;
        //        imageView.image = immagine;
        [self.immaginiScrollabili addObject:imageView];
        [self addSubview:imageView];
        frameImmagine.origin.x = CGRectGetMaxX(imageView.frame);
    }
    [self primaImpostazioneScrollView];
//    [self ricavaImmagini];
}

- (void)primaImpostazioneScrollView {
    self.clipsToBounds = NO;
    self.contentInset = UIEdgeInsetsZero;
    self.pagingEnabled = YES;
    CGFloat lunghezzaScroll = self.larghezzaImmagine * self.immaginiScrollabili.count;
    self.contentSize = CGSizeMake(lunghezzaScroll,self.frame.size.height);
    
//    [self selezionaIndiceCorretto];
}

- (void)selezionaIndiceCorretto {
//    NSInteger indiceDaSelezionare = self.contentOffset.x / self.larghezzaImmagine;
//    // Vecchia immagine centrale
//    [self.immagineCentrale zoomSuImmaginePiccola];
//    
//    // Nuova immagine
//    self.indiceSelezionato = indiceDaSelezionare;
//    self.immagineCentrale = [self.immaginiScrollabili objectAtIndex:self.indiceSelezionato];
//    [self.immagineCentrale zoomSuImmagineGrande];
}

@end
