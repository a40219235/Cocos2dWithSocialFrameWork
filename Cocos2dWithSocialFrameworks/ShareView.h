//
//  ShareView.h
//  Cocos2dWithSocialFrameworks
//
//  Created by Shane Fu on 9/15/13.
//  Copyright (c) 2013 Shane Fu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareView : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UIToolbar *shareButtonOutlet;
@property (weak, nonatomic) IBOutlet UILabel *photoDescriptionLabel;

- (IBAction)CancelButton:(UIBarButtonItem *)sender;
- (IBAction)ShareButton:(UIBarButtonItem *)sender;

+(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil image:(UIImage *)image;

@end
