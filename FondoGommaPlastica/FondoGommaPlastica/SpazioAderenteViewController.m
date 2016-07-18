//
//  SpazioAderenteViewController.m
//  FondoGommaPlastica
//
//  Created by Felice Vimercati on 01/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import "SpazioAderenteViewController.h"
#import "BenvenutoViewController.h"
#import <objc/runtime.h>

@implementation PageContentViewController
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        self.view.frame = frame;
        self.contentScrollView = [[UIScrollView alloc] initWithFrame:frame]; 
        [self.view addSubview:self.contentScrollView];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

@end

@interface SpazioAderenteViewController ()
@property (nonatomic, weak, readwrite) IBOutlet UIScrollView *contentScrollView;
@end

@implementation SpazioAderenteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    Aderente *aderente = [Aderente sharedAderente];
    [self.nomeCognomeLabel setText:[NSString stringWithFormat:@"%@ %@",aderente.anagrafica.nome.uppercaseString,aderente.anagrafica.cognome.uppercaseString]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tornaIndietro:(UIButton*)tornaIndietroButton {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)iniziaCreazioneLabelForScrollView:(UIScrollView*)scrollView {
    if (!scrollView) {
        scrollView = self.contentScrollView;
    }
    [scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    larghezza = self.view.frame.size.width - 20;
    frameTitoloLabel = CGRectMake(10, 0, (larghezza/2), 20);
    frameValoreLabel = CGRectMake((larghezza/2), 0, (larghezza/2), 20);
}

- (void)creaLabelTitolo:(NSString*)titolo valore:(NSString*)valore scrollView:(UIScrollView*)scrollView {
    if (!scrollView) {
        scrollView = self.contentScrollView;
    }
    
    UIFont *fontLabel = [UIFont fontWithName:@"Akkurat" size:12.0f];
    
    UILabel *titoloLabel = [[UILabel alloc] initWithFrame:frameTitoloLabel];
    [titoloLabel setText:NSLocalizedString(titolo, nil)];
    
    UILabel *valoreLabel = [[UILabel alloc] initWithFrame:frameValoreLabel];
    [valoreLabel setText:valore];
    
    [titoloLabel setFont:fontLabel];
    [titoloLabel setTextColor:[UIColor whiteColor]];
    [titoloLabel setMinimumScaleFactor:0.5];
    [titoloLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [titoloLabel setNumberOfLines:0];
    [titoloLabel sizeToFit];
    
    [valoreLabel setFont:fontLabel];
    [valoreLabel setTextColor:[UIColor whiteColor]];
    [valoreLabel setMinimumScaleFactor:0.5];
    [valoreLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [valoreLabel setNumberOfLines:0];
    [valoreLabel sizeToFit];
    
    [scrollView addSubview:titoloLabel];
    [scrollView addSubview:valoreLabel];
    
    CGFloat maxY = MAX(titoloLabel.frame.origin.y, valoreLabel.frame.origin.y);
    frameTitoloLabel.origin.y = maxY + 24;
    frameValoreLabel.origin.y = maxY + 24;
}

- (void)inserisciTutteLeProprietaInOggetto:(NSObject*)oggetto contentScrollViewController:(UIScrollView*)scrollView {
    if (!scrollView) {
        scrollView = self.contentScrollView;
    }
    if ([oggetto isKindOfClass:[NSArray class]]) {
        for (NSObject *oggettino in (NSArray*)oggetto) {
            [self inserisciTutteLeProprietaInOggetto:oggettino contentScrollViewController:scrollView];
        }
    } else {
        NSArray *proprieta = [self propertiesForClass:oggetto.class];
        for (NSString *prop in proprieta) {
            NSObject *valore = [oggetto valueForKey:prop];
            if ([valore isKindOfClass:[NSString class]]) {
                [self creaLabelTitolo:prop valore:(NSString*)valore scrollView:scrollView];
            } else if ([valore isKindOfClass:[NSArray class]]) {
                NSArray *valori = (NSArray*)valore;
                for (NSObject *oggettoInArray in valori) {
                    [self inserisciTutteLeProprietaInOggetto:oggettoInArray contentScrollViewController:scrollView];
                }
            } else {
                [self inserisciTutteLeProprietaInOggetto:valore contentScrollViewController:scrollView];
            }
        }
    }
    [scrollView setContentSize:CGSizeMake(self.contentScrollView.frame.size.width, CGRectGetMaxY(frameTitoloLabel))];
}

#pragma mark Recupero properties name
- (NSArray *)propertiesForClass:(Class)class
{
    unsigned count;
    objc_property_t *properties = class_copyPropertyList(class, &count);
    
    NSMutableArray *rv = [NSMutableArray array];
    
    unsigned i;
    for (i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        [rv addObject:name];
    }
    
    free(properties);
    
    return rv;
}


#pragma mark UIPageController
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    return nil;
}

@end
