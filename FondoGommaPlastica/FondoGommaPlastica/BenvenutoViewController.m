//
//  BenvenutoViewController.m
//  FondoGommaPlastica
//
//  Created by Felice Vimercati on 16/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import "BenvenutoViewController.h"
#import "AppDelegate.h"

@interface BenvenutoViewController ()

@end

@implementation BenvenutoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    Aderente *aderente = [Aderente sharedAderente];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy"];
    [self.dataIscrizioneLabel setText:[NSString stringWithFormat:@"Iscritto dal %@",[df stringFromDate:aderente.anagrafica.dataIscrizione]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)logout:(id)sender {
//    [super tornaIndietro:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
