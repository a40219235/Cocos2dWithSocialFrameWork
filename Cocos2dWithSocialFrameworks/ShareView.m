//
//  ShareView.m
//  Cocos2dWithSocialFrameworks
//
//  Created by Shane Fu on 9/15/13.
//  Copyright (c) 2013 Shane Fu. All rights reserved.
//

#import "ShareView.h"

@interface ShareView ()

@property (weak, nonatomic)UIImage* postimage;
@end

@implementation ShareView

+(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil image:(UIImage *)image
{
	return [[self alloc] initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil image:(UIImage *)image];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil image:(UIImage *)image
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.postimage = image;
		if (!image) NSLog(@"image = nil");
		if (!self.postImageView) NSLog(@"image = nil");
		if (!self.postImageView.image) NSLog(@"image = nil");
		self.postText.text = @"nimasile";
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//	self.postImageView.image = self.postimage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
	[self setPostImageView:nil];
	[self setPostNameLabel:nil];
	[self setPostNameLabel:nil];
	[self setPostCaptionLabel:nil];
	[self setPostDescriptionLabel:nil];
    [super viewDidUnload];
}

#pragma Action Button 
- (IBAction)CancelButton:(UIBarButtonItem *)sender {
}

- (IBAction)ShareButton:(id)sender {
}
@end
