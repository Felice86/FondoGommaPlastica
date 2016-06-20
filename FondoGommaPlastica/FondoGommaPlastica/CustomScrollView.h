//
//  CustomScrollView.h
//  FondoGommaPlastica
//
//  Created by Felice on 18/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomImage.h"

@class CustomScrollView;
@protocol CustomScrollViewDelegate <NSObject>
@required
- (void)customScrollView:(CustomScrollView*)customScrollView haFinitoDiSelezionareImmagineCentrale:(CustomImage*)immagineCentrale;
@end

@interface CustomScrollView : UIScrollView
@property (nonatomic, retain, readonly) CustomImage *immagineSinistra;
@property (nonatomic, retain, readonly) CustomImage *immagineCentrale;
@property (nonatomic, retain, readonly) CustomImage *immagineDestra;

- (void)scrollViewCon:(NSInteger)colonne colonneDiOggetti:(NSArray *)oggettiArray;
- (void)selezionaIndiceCorretto;
@end
