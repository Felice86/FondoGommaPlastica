//
//  DatiLiquidazioneDettaglioViewController.m
//  FondoGommaPlastica
//
//  Created by Felice on 03/07/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import "DatiLiquidazioneDettaglioViewController.h"

@interface DatiLiquidazioneDettaglioViewController ()
@property (nonatomic, retain) NSArray *arrayLiquidazioni;
@end
@implementation DatiLiquidazioneDettaglioViewController

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    
//    [self iniziaCreazioneLabelForScrollView:nil];
- (void)viewDidLoad
{
    [super viewDidLoad];
    Aderente *utente = [Aderente sharedAderente];
    switch (self.tipoPrestazione) {
        case TipoPrestazione_Anticipazione:{
            self.arrayLiquidazioni = utente.anticipi;
            break;
        }
        case TipoPrestazione_Riscatto:{
            self.arrayLiquidazioni = utente.riscatti;
            break;
        }
        case TipoPrestazione_RiscattoParziale:{
            self.arrayLiquidazioni = utente.riscattiParziali;
            break;
        }
        case TipoPrestazione_TranferimentoOut:{
            self.arrayLiquidazioni = utente.trasferimentiOut;
            break;
        }
        case TipoPrestazione_TrasferimentoIn:{
            self.arrayLiquidazioni = utente.trasferimentiIn;
            break;
        }
        default:
            break;
    }
    
    if (self.arrayLiquidazioni.count > 0) {
        self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        self.pageViewController.dataSource = self;
        
        PageContentViewController *startingViewController = [self pageContentViewControllerForIndex:0];
        NSArray *viewControllers = @[startingViewController];
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        
        [self addChildViewController:self.pageViewController];
        [self.view addSubview:self.pageViewController.view];
        [self.pageViewController didMoveToParentViewController:self];
    }
    
//    for (Liquidazione *oggettoLiquidazione in arrayLiquidazioni) {
//        [self inserisciTutteLeProprietaInOggetto:oggettoLiquidazione contentScrollViewController:nil];
//        
//        UIImage *separatore = [UIImage imageNamed:@"FILETTO.png"];
//        UIImageView *separatoreView = [[UIImageView alloc] initWithImage:separatore];
//        CGRect frame = separatoreView.frame;
//        frame.origin.y = frameTitoloLabel.origin.y - 4;
//        frame.origin.x = (self.contentScrollView.frame.size.width - frame.size.width) / 2;
//        separatoreView.frame = frame;
//        [self.contentScrollView addSubview:separatoreView];
//        frameTitoloLabel.origin.y = CGRectGetMaxY(separatoreView.frame) + 4;
//        frameValoreLabel.origin.y = CGRectGetMaxY(separatoreView.frame) + 4;
//    }
//    [self inserisciLegenda:arrayLiquidazioni.lastObject addTo:nil];
//    [self.contentScrollView setContentSize:CGSizeMake(self.contentScrollView.frame.size.width, CGRectGetMaxY(frameTitoloLabel))];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshUI];
}

- (void)iniziaCreazioneLabelForScrollView:(UIScrollView *)scrollView {
    [super iniziaCreazioneLabelForScrollView:scrollView];
    frameTitoloLabel.size.width += 20;
    frameValoreLabel.origin.x += 20;
    frameValoreLabel.size.width -= 20;
}

- (void)refreshUI {
    CGFloat y = CGRectGetMaxY(self.titoloLabel.frame) + 8;
    CGFloat height = (self.footerView.frame.origin.y - y);
    CGRect framePageViewController = CGRectMake(0, 0, self.view.frame.size.width, height);
    for (PageContentViewController *viewController in self.pageViewController.viewControllers) {
        viewController.contentScrollView.frame = framePageViewController;
    }
    framePageViewController.origin.y = y;
    self.pageViewController.view.frame = framePageViewController;
}

- (PageContentViewController*)pageContentViewControllerForIndex:(NSUInteger)index {
//    Contributo *contributo = [[[Aderente sharedAderente] contributi] objectAtIndex:index];
    Liquidazione *liquidazione = [self.arrayLiquidazioni objectAtIndex:index];
    CGFloat y = CGRectGetMaxY(self.titoloLabel.frame);
    CGFloat height = (self.footerView.frame.origin.y - y);
    CGRect framePageViewController = CGRectMake(0, 0, self.view.frame.size.width, height);
    PageContentViewController *pageContentViewController = [[PageContentViewController alloc] initWithFrame:framePageViewController];
    [self iniziaCreazioneLabelForScrollView:pageContentViewController.contentScrollView];
    [self inserisciTutteLeProprietaInOggetto:liquidazione contentScrollViewController:pageContentViewController.contentScrollView];
    [self inserisciLegenda:liquidazione addTo:pageContentViewController.contentScrollView];
    [pageContentViewController.contentScrollView setContentSize:CGSizeMake(pageContentViewController.contentScrollView.frame.size.width, CGRectGetMaxY(frameTitoloLabel))];
    pageContentViewController.index = index;
    return pageContentViewController;
}

#pragma mark UI page controller
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*)viewController).index;
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    
    index--;
    return [self pageContentViewControllerForIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*)viewController).index;
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index== self.arrayLiquidazioni.count) {
        return nil;
    }
    return [self pageContentViewControllerForIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.arrayLiquidazioni count] == 1?0:[self.arrayLiquidazioni count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

@end
