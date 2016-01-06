//
//  ViewController.m
//  六边形进度条demo
//
//  Created by asun on 15/11/10.
//  Copyright © 2015年 yinyi. All rights reserved.
//

#import "ViewController.h"
#import "SexangleProgress/SexangleProgess.h"

@interface ViewController ()
@property (nonatomic,weak)SexangleProgess *sex1;
@property (nonatomic,weak)SexangleProgess *sex2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundImage.contentMode = UIViewContentModeScaleToFill;
    backgroundImage.image = [UIImage imageNamed:@"test2.jpg"];
    [self.view addSubview:backgroundImage];
    
    SexangleProgess *sex1 = [[SexangleProgess alloc] initWithFrame:CGRectMake(100, 100, 200, 200) progressBackgroundColor:[UIColor grayColor] completeColor:[UIColor redColor] lineWidth:10];
    sex1.image = [UIImage imageNamed:@"test1.jpg"];
    self.sex1 = sex1;
    [self.view addSubview:sex1];
    
    SexangleProgess *sex2 = [[SexangleProgess alloc] initWithFrame:CGRectMake(100, 350, 200, 200) progressBackgroundColor:[UIColor grayColor] completeColor:[UIColor redColor] lineWidth:5];
    sex2.centerBackgroundColor = [UIColor blueColor];
    self.sex2 = sex2;
    [self.view addSubview:sex2];
    
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(50, 310, 200, 30)];
    [slider addTarget:self action:@selector(progressChanged:) forControlEvents:UIControlEventValueChanged];
    slider.maximumValue = 100;
    slider.minimumValue = 0;
    [self.view addSubview:slider];
    
}


- (void)progressChanged:(UISlider *)slider {
    self.sex1.progress = slider.value;
    self.sex2.progress = slider.value;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
