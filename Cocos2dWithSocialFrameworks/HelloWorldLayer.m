//
//  HelloWorldLayer.m
//  Cocos2dWithSocialFrameworks
//
//  Created by Shane Fu on 9/14/13.
//  Copyright Shane Fu 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation

#define FB_LOGOUT @"log out"

@interface HelloWorldLayer()<UIActionSheetDelegate>
{
	
}

@property(nonatomic, strong) CCMenuItemFont *fbLogin;
@property(nonatomic, weak) UIActionSheet *actionSheet;

@end

@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		// ask director for the window size
		CGSize winSize = [[CCDirector sharedDirector] winSize];
		
		[CCMenuItemFont setFontSize:28];
		
		// to avoid a retain-cycle with the menuitem and blocks
		__block id copy_self = self;
		
		self.fbLogin = [CCMenuItemFont itemWithString:@"fbLogin" block:^(CCMenuItemFont *sender) {
            NSLog(@"open1 = %s",[[FBSession activeSession] isOpen] ? "Yes":"No" );
            if ([[FBSession activeSession] isOpen]) {
				if (!self.actionSheet) {
					UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"FB log out" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:FB_LOGOUT ,nil];
					[actionSheet showInView:[[CCDirector sharedDirector] view]];
					self.actionSheet = actionSheet;
				}
            }else{
				//avoid mutiple click
                sender.isEnabled = NO;
                [FBSession openActiveSessionWithReadPermissions:nil allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error){
                    NSLog(@"session = %@", [session description]);
                    NSLog(@"error = %@", [error description]);
                    if (session.isOpen) {
                        [copy_self updateButtons];
                    }else{
                        [copy_self updateButtons];
                    }
                    sender.isEnabled = YES;
                }];
            }
            
		}];
		
        NSLog(@"accessTokenData = %@", [[FBSession activeSession].accessTokenData description]);
        NSLog(@"111111 = %f", [[FBSession activeSession].accessTokenData.expirationDate timeIntervalSinceNow]);
        NSLog(@"222222 = %f", [[FBSession activeSession].accessTokenData.expirationDate timeIntervalSince1970]);
        NSLog(@"333333 = %f", [[FBSession activeSession].accessTokenData.expirationDate timeIntervalSinceReferenceDate]);
        NSLog(@"111111 = %f", CACurrentMediaTime());
        
        if (![[FBSession activeSession] isOpen]&&[FBSession activeSession].accessTokenData && [[FBSession activeSession].accessTokenData.expirationDate timeIntervalSinceNow] > 0) {
            [FBSession openActiveSessionWithReadPermissions:nil allowLoginUI:NO completionHandler:^(FBSession *session, FBSessionState status, NSError *error){
                NSLog(@"session = %@", [session description]);
                NSLog(@"error = %@", [error description]);
                if (session.isOpen) {
                    [copy_self updateButtons];
                }else{
                    [copy_self updateButtons];
                }
            }];
        }
        
		// Leaderboard Menu Item using blocks
		CCMenuItem *shareSheet = [CCMenuItemFont itemWithString:@"iOS shareSheet" block:^(id sender) {
			[FBDialogs presentOSIntegratedShareDialogModallyFrom:[CCDirector sharedDirector] initialText:@"init text" image:nil url:nil handler:^(FBOSIntegratedShareDialogResult result, NSError *error) {
				NSString *alertText = @"";
				if ([[error userInfo][FBErrorDialogReasonKey] isEqualToString:FBErrorDialogNotSupported]) {
					alertText = @"iOS Share Sheet not supported.";
				}else if (error) {
					alertText = [NSString stringWithFormat:@"error: domain = %@, code = %d", error.domain, error.code];
				}else if (result == FBNativeDialogResultSucceeded){
					[[[UIAlertView alloc] initWithTitle:@"Result" message:alertText delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
				}
			}];
		}];
		
		CCMenuItem *feedDialogShare = [CCMenuItemFont itemWithString:@"feed Dialog Share" block:^(id sender) {
		}];
		
		
		
		CCMenu *menu = [CCMenu menuWithItems:self.fbLogin, shareSheet, feedDialogShare, nil];
		
		[menu alignItemsHorizontallyWithPadding:20];
		[menu setPosition:ccp(winSize.width/2, winSize.height/2 - 50)];
		
		// Add the menu to the layer
		[self addChild:menu];
        [self updateButtons];
		
	}
	return self;
}

-(void)updateButtons
{
    NSLog(@"open2 = %s",[[FBSession activeSession] isOpen] ? "Yes":"No" );
    
    if ([[FBSession activeSession] isOpen]) {
        [self.fbLogin setString:@"fbLogout"];
    }else{
        [self.fbLogin setString:@"fbLogin"];
    }
    
}

#pragma mark Action Sheet Delegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSString *choice = [actionSheet buttonTitleAtIndex:buttonIndex];
	if ([choice isEqualToString:FB_LOGOUT]) {
		[[FBSession activeSession] closeAndClearTokenInformation];
	}
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
