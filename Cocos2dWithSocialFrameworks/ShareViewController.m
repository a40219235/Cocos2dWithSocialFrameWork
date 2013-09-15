//
//  ShareViewController.m
//  Cocos2dWithSocialFrameworks
//
//  Created by Shane Fu on 9/15/13.
//  Copyright (c) 2013 Shane Fu. All rights reserved.
//

#import "ShareViewController.h"

@interface ShareViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *postNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *postCaptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *postDescriptionLabel;

@end

@implementation ShareViewController

+(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil image:(UIImage *)image
{
	
	return [[self alloc] initWithNibName:nibNameOrNil bundle:nibBundleOrNil image:image];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil image:(UIImage *)image
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.imageView.image = image;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Buttons
- (IBAction)CancelButton:(UIBarButtonItem *)sender {
}

- (IBAction)ShareButton:(UIBarButtonItem *)sender {
}

- (void)viewDidUnload {
	[self setImageView:nil];
	[self setPostNameLabel:nil];
	[self setPostCaptionLabel:nil];
	[self setPostCaptionLabel:nil];
	[super viewDidUnload];
}
@end
