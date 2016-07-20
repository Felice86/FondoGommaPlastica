//
//  SpazioAderenteViewController.h
//  FondoGommaPlastica
//
//  Created by Felice Vimercati on 01/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fondimatica/Aderente.h"
#import "Fondimatica/Configurations.h"

@interface PageContentViewController : UIViewController
@property (nonatomic, retain) UIScrollView *contentScrollView;
@property (nonatomic, assign) NSUInteger index;
- (instancetype)initWithFrame:(CGRect)frame;
@end

@interface SpazioAderenteViewController : UIViewController <UIPageViewControllerDataSource> {
    CGFloat larghezza;
    CGRect frameTitoloLabel;
    CGRect frameValoreLabel;
}
@property (weak, nonatomic) IBOutlet UILabel *nomeCognomeLabel;
@property (weak, nonatomic, readonly) IBOutlet UIScrollView *contentScrollView;
@property (weak, nonatomic) IBOutlet UILabel *titoloLabel;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (nonatomic, retain) UIPageViewController *pageViewController;
- (IBAction)tornaIndietro:(UIButton*)tornaIndietroButton;
- (void)iniziaCreazioneLabelForScrollView:(UIScrollView*)scrollView;
- (void)inserisciLegenda:(NSObject*)oggetto addTo:(UIScrollView*)scrollView;
- (void)creaLabelTitolo:(NSString*)titolo valore:(NSString*)valore scrollView:(UIScrollView*)scrollView;
- (void)inserisciTutteLeProprietaInOggetto:(NSObject*)oggetto contentScrollViewController:(UIScrollView*)scrollView;
@end
