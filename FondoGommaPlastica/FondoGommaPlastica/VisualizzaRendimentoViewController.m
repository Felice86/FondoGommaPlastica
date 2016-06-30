//
//  VisualizzaRendimentoViewController.m
//  FondoGommaPlastica
//
//  Created by Felice Vimercati on 30/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import "VisualizzaRendimentoViewController.h"

@interface VisualizzaRendimentoViewController ()

@end

@implementation VisualizzaRendimentoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    Aderente *aderente = [Aderente sharedAderente];
    [self iniziaCreazioneLabel];
    [self riempiConInformazioni:aderente.rendimento];
}

@end
