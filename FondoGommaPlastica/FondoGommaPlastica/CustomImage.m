//
//  CustomImage.m
//  FondoGommaPlastica
//
//  Created by Felice on 18/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import "CustomImage.h"

@interface CustomImage()
@property (nonatomic, retain, readwrite) UIImage *immaginePiccola;
@property (nonatomic, retain, readwrite) UIImage *immagineGrande;
@end

@implementation CustomImage

- (instancetype)initWithFrame:(CGRect)frame immaginePiccola:(UIImage*)immaginePiccola immagineGrande:(UIImage*)immagineGrande {
    self = [super initWithFrame:frame];
    if (self) {
        self.immaginePiccola = immaginePiccola;
        self.immagineGrande = immagineGrande;
        self.image = immaginePiccola;
        self.contentMode = UIViewContentModeCenter;
    }
    return self;
}

- (void)zoomSuImmagineGrande {
    self.image = self.immagineGrande;
}

- (void)zoomSuImmaginePiccola {
    self.image = self.immaginePiccola;
}

@end
