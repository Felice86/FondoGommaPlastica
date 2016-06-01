//
//  ContattiViewController.m
//  FondoGommaPlastica
//
//  Created by Felice Vimercati on 01/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import "ContattiViewController.h"

@interface ContattiViewController ()

@end

@implementation ContattiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentView = [[[NSBundle mainBundle] loadNibNamed:@"ContattiView" owner:self options:nil] lastObject];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
