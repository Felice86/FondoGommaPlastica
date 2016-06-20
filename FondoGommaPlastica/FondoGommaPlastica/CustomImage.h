//
//  CustomImage.h
//  FondoGommaPlastica
//
//  Created by Felice on 18/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomImage : UIImageView
@property (nonatomic, retain, readonly) UIImage *immaginePiccola;
@property (nonatomic, retain, readonly) UIImage *immagineGrande;
- (instancetype)initWithFrame:(CGRect)frame immaginePiccola:(UIImage*)immaginePiccola immagineGrande:(UIImage*)immagineGrande;
- (void)zoomSuImmaginePiccola;
- (void)zoomSuImmagineGrande;
@end
