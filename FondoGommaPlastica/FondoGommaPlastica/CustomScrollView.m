//
//  CustomScrollView.m
//  FondoGommaPlastica
//
//  Created by Felice on 18/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import "CustomScrollView.h"

@interface CustomScrollView()
@property (nonatomic, retain, readwrite) NSMutableArray *immaginiScrollabili;
@property (nonatomic, retain, readwrite) CustomImage *immagineSinistra;
@property (nonatomic, retain, readwrite) CustomImage *immagineCentrale;
@property (nonatomic, retain, readwrite) CustomImage *immagineDestra;
@property (nonatomic, assign) NSInteger indiceSelezionato;
@property (nonatomic, assign) CGFloat larghezzaImmagine;
@end

@implementation CustomScrollView

//Inserisce una serie di immagini in colonne
- (void)scrollViewCon:(NSInteger)colonne colonneDiOggetti:(NSArray *)oggettiArray {
    if (!self.immaginiScrollabili) {
        self.immaginiScrollabili =[NSMutableArray arrayWithCapacity:oggettiArray.count]; 
    } else {
        [self.immaginiScrollabili removeAllObjects];
    }
    self.larghezzaImmagine = self.frame.size.width/colonne;
    CGRect frameImmagine = CGRectMake(0, 0, self.larghezzaImmagine, self.frame.size.height);
    for (NSInteger i=0;i<oggettiArray.count;i++) {
        NSString *titoloImmagine = [oggettiArray objectAtIndex:i];
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
    [self ricavaImmagini];
}

- (void)primaImpostazioneScrollView {
    CGFloat lunghezzaScroll = self.larghezzaImmagine * self.immaginiScrollabili.count;
    self.contentSize = CGSizeMake(lunghezzaScroll,self.frame.size.height);
    self.contentOffset = CGPointMake((lunghezzaScroll/2), 0);
    [self selezionaIndiceCorretto];
}

- (void)selezionaIndiceCorretto {
    NSInteger indiceDaSelezionare = self.contentOffset.x / self.larghezzaImmagine;
    //vecchia immagine centrale
    [self.immagineCentrale zoomSuImmaginePiccola];
    self.indiceSelezionato = indiceDaSelezionare;
    [self ricavaImmagini];
    // nuova immagine centrale
    [self.immagineCentrale zoomSuImmagineGrande];
}

- (void)ricavaImmagini {
    self.immagineCentrale = [self.immaginiScrollabili objectAtIndex:self.indiceSelezionato];
//    self.immagineSinistra = [self.immaginiScrollabili objectAtIndex:self.indiceSelezionato-1];
//    self.immagineDestra = [self.immaginiScrollabili objectAtIndex:self.indiceSelezionato+1];
}

@end
