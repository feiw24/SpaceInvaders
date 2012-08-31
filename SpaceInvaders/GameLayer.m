//
//  HelloWorldLayer.m
//  SpaceInvaders
//
//  Created by Fei Wang on 8/1/12.
//  Copyright Crystal Dynamics, Square Enix 2012. All rights reserved.
//


// Import the interfaces
#import "GameLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "World.h"
#import "InputManager.h"
#import "SceneManager.h"
#import "MenuManager.h"


#pragma mark - GameLayer

// HelloWorldLayer implementation
@implementation GameLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        
        [[CCDirector sharedDirector] setAnimationInterval:1.0f/30.0f];
        
        [self setIsTouchEnabled:TRUE];
       
        [self initgame];
        
        
	}
	return self;
}

-(void)initgame
{
    [[SceneManager sharedSceneManager] SetGameLayer:self];
    m_world = [[World alloc] init];
    [m_world initLevel];
    
    [[MenuManager sharedMenuManager] initWithWorld:m_world];
    [[InputManager sharedInputManager] InitInput:self];

    [self schedule:@selector(update:)];
    
}

-(void) update: (ccTime) dt
{
    [m_world update:dt];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
    
    m_world = nil;

	// don't forget to call "super dealloc"
	[super dealloc];
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
