//
//  VC_Story.m
//  ATT_Hack_2015
//
//  Created by Aaron Crawfis on 10/3/15.
//  Copyright © 2015 Aaron Crawfis. All rights reserved.
//

#import "VC_Story.h"

@interface VC_Story ()

@end

@implementation VC_Story

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleLabel.text = self.story.title;
    self.body.text = self.story.text;
    UIImageView *imgv = [[UIImageView alloc]
                         initWithFrame:CGRectMake(100, 100, 200, 200)];
    imgv.image = [UIImage imageWithData:self.story.image];
    self.image.image = imgv.image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backButtonPressed:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
