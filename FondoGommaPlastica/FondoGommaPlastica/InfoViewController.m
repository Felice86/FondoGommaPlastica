//
//  InfoViewController.m
//  FondoGommaPlastica
//
//  Created by Felice Vimercati on 01/06/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentView = [[[NSBundle mainBundle] loadNibNamed:@"InfoContentView" owner:self options:nil] lastObject];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
