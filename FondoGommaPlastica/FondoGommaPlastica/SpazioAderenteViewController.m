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
    [self.contentScrollView setContentSize:CGSizeMake(self.contentScrollView.frame.size.width, CGRectGetMaxY(frameTitoloLabel))];
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

- (void)iniziaCreazioneLabel {
    [self.contentScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    larghezza = self.contentScrollView.frame.size.width - 20;
    frameTitoloLabel = CGRectMake(10, 0, (larghezza/2)+20, 20);
    frameValoreLabel = CGRectMake((larghezza/2)+20, 0, (larghezza/2)-20, 20);
}

- (void)creaLabelTitolo:(NSString*)titolo valore:(NSString*)valore {
//    NSLog(@"Titolo:%@ frame:%@",titolo,NSStringFromCGRect(frameTitoloLabel));
//    NSLog(@"Valore:%@ frame:%@",valore,NSStringFromCGRect(frameValoreLabel));
    
    UIFont *fontLabel = [UIFont fontWithName:@"Akkurat" size:12.0f];
    
    UILabel *titoloLabel = [[UILabel alloc] initWithFrame:frameTitoloLabel];
    [titoloLabel setText:titolo];
    
    UILabel *valoreLabel = [[UILabel alloc] initWithFrame:frameValoreLabel];
    [valoreLabel setText:valore];
    
    [titoloLabel setFont:fontLabel];
    [titoloLabel setTextColor:[UIColor whiteColor]];
    [valoreLabel setFont:fontLabel];
    [valoreLabel setTextColor:[UIColor whiteColor]];
    
    [self.contentScrollView addSubview:titoloLabel];
    [self.contentScrollView addSubview:valoreLabel];
    
    frameTitoloLabel.origin.y += 20;
    frameValoreLabel.origin.y += 20;
}

- (void)inserisciTutteLeProprietaInOggetto:(NSObject*)oggetto {
    if ([oggetto isKindOfClass:[NSArray class]]) {
        for (NSObject *oggettino in (NSArray*)oggetto) {
            [self inserisciTutteLeProprietaInOggetto:oggettino];
        }
    } else {
        NSArray *proprieta = [self propertiesForClass:oggetto.class];
        for (NSString *prop in proprieta) {
            NSObject *valore = [oggetto valueForKey:prop];
            if ([valore isKindOfClass:[NSString class]]) {
                [self creaLabelTitolo:prop.capitalizedString valore:(NSString*)valore];
            } else if ([valore isKindOfClass:[NSArray class]]) {
                NSArray *valori = (NSArray*)valore;
                for (NSObject *oggettoInArray in valori) {
                    [self inserisciTutteLeProprietaInOggetto:oggettoInArray];
                }
            } else {
                [self inserisciTutteLeProprietaInOggetto:valore];
            }
        }
    }
}

- (void)riempiConInformazioni:(NSObject*)oggettoInformazioni {
    [self inserisciTutteLeProprietaInOggetto:oggettoInformazioni];
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

@end
