//
//  ShareView.m
//  Cocos2dWithSocialFrameworks
//
//  Created by Shane Fu on 9/15/13.
//  Copyright (c) 2013 Shane Fu. All rights reserved.
//

#import "ShareView.h"
#import <FacebookSDK/FacebookSDK.h>

@interface ShareView () <UITextViewDelegate>

@property (nonatomic, weak)UIImage* postimage;
@property (nonatomic, strong) NSMutableDictionary *postParams;
@property (nonatomic, strong) NSString *postImageURL;

@end

#define kPLACE_HOLDER_STRING @"I Love Cocos2d"

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
		self.postParams = [@{
						   @"picture" : @"",
						   @"name" : @"",
						   } mutableCopy];
		
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	if (self.postimage) {
		self.postImageView.image = self.postimage;
	}
	[self.postParams setObject:UIImagePNGRepresentation(self.postImageView.image) forKey:@"picture"];
	[self resetPostMessage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
	[self setPostImageView:nil];
	[self setShareButtonOutlet:nil];
	[self setPhotoDescriptionLabel:nil];
    [super viewDidUnload];
}

#pragma Action Button
- (IBAction)CancelButton:(UIBarButtonItem *)sender {
	[[self presentingViewController] dismissModalViewControllerAnimated:YES];
}

- (IBAction)ShareButton:(UIBarButtonItem *)sender {
	if ([self.photoDescriptionLabel isFirstResponder]) {
		[self.photoDescriptionLabel resignFirstResponder];
	}
	
	sender.enabled = NO;

	self.postParams[@"name"] = self.photoDescriptionLabel.text;

	if([[FBSession activeSession].permissions indexOfObject:@"publish_actions"] == NSNotFound){
		[[FBSession activeSession] requestNewPublishPermissions:@[@"publish_actions"] defaultAudience:FBSessionDefaultAudienceFriends completionHandler:^(FBSession *session, NSError *error) {
			if (!error){
				[self publishStory:sender];
			}
		}];
	}else{
		[self publishStory:sender];
	}
}

#pragma mark - fbPosting Methods

-(void)publishStory:(UIBarButtonItem *)shareButton
{
//	NSLog(@"Params = %@", [self.postParams description]);
	[FBRequestConnection startWithGraphPath:@"me/photos" parameters:self.postParams HTTPMethod:@"POST" completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
		if (!error) {
			NSString *alertText;
			if (error) {
				alertText = [NSString stringWithFormat:
							 @"error: domain = %@, code = %d",
							 error.domain, error.code];
			} else {
				alertText = @"Post Success";
			}
			// Show the result in an alert
			[[[UIAlertView alloc] initWithTitle:@"Result"
										message:alertText
									   delegate:self
							  cancelButtonTitle:@"OK!"
							  otherButtonTitles:nil]
			 show];
		}else{
			NSLog(@"error = %@", [error localizedDescription]);
		}
		shareButton.enabled = YES;
	}];
}

#pragma mark - UITextViewDelegate methods
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    // Clear the message text when the user starts editing
    if ([textView.text isEqualToString:kPLACE_HOLDER_STRING]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        [self resetPostMessage];
    }
}

- (void)resetPostMessage
{
    self.photoDescriptionLabel.text = kPLACE_HOLDER_STRING;
    self.photoDescriptionLabel.textColor = [UIColor lightGrayColor];
}

#pragma mark - rotation
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
	if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
		return YES;
	}
	return NO;
}

#pragma mark - touch event
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *) event
{
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.photoDescriptionLabel isFirstResponder] &&
        (self.photoDescriptionLabel != touch.view))
    {
        [self.photoDescriptionLabel resignFirstResponder];
    }
}


@end
