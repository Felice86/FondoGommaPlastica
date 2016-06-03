//
//  SpazioAderenteViewController.m
//  FondoGommaPlastica
//
//  Created by Felice Vimercati on 01/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import "SpazioAderenteViewController.h"
#import "Aderente.h"

@interface SpazioAderenteViewController ()

@end

@implementation SpazioAderenteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    Aderente *aderente = [Aderente sharedAderente];
    [self.dataIscrizioneLabel setText:[NSString stringWithFormat:@"Iscritto dal %@",aderente.dataIscrizioneAderente]];
    [self.nomeCognomeLabel setText:[NSString stringWithFormat:@"%@ %@",aderente.nome,aderente.cognome]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tornaIndietro:(UIButton*)tornaIndietroButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
