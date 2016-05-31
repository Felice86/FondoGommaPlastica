//
//  PageContentViewController.m
//  FondoGommaPlastica
//
//  Created by Felice on 29/05/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import "PageContentViewController.h"

@interface PageContentViewController ()
@property (nonatomic, assign) NSInteger indiceScelto;
@property (nonatomic, retain) NSArray *immaginiDaScegliere;
@end

@implementation PageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad]; 
    self.pagine = @[@"omini",@"telefono",@"lente"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)aggiungiImmaginiAImageScrollView {
    NSString *immagineCompleta = @"";
    NSMutableArray *
    for (NSInteger i=0;i<self.immaginiDaScegliere.count;i++) {
        NSString *immagine = [self.immaginiDaScegliere objectAtIndex:i];
        if (i == self.indiceScelto) {
           immagineCompleta  = [NSString stringWithFormat:@"%@_grande"];
        } else {
            immagineCompleta = [NSString stringWithFormat:@"%@_piccolo"];
        }
        UIImage *immagineDaCaricare = [UIImage imageNamed:immagineCompleta];
    }
}

@end
