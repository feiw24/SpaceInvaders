//
//  MenuManager.m
//  SpaceInvaders
//
//  Created by Fei Wang on 8/5/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import "MenuManager.h"
#import "CCLayer.h"
#import "SceneManager.h"

#import "InputManager.h"

@implementation MenuManager

static MenuManager* DefaultManager = 0;

+(MenuManager*)sharedMenuManager
{
    if (!DefaultManager) {
        DefaultManager = [[MenuManager allocWithZone:NULL] init] ;
    }
    return DefaultManager;
}


-(void)initWithWorld:(World*)world
{
    m_world = world;
}

-(void)showGameOver
{
    // create and initialize a Label
    m_notificationLabel = [CCLabelTTF labelWithString:@"Game Over!" fontName:@"Marker Felt" fontSize:64];
    
    // ask director for the window size
    CGSize size = [[CCDirector sharedDirector] winSize];
	
    // position the label on the center of the screen
    m_notificationLabel.position =  ccp( size.width /2 , size.height/2 );
    
    // add the label as a child to this Layer
    [[SceneManager sharedSceneManager].m_gameLayer addChild:m_notificationLabel];
    
	[CCMenuItemFont setFontSize:28];
    
    // Achievement Menu Item using blocks
    CCMenuItem *restartButton = [CCMenuItemFont itemWithString:@"Try Again" block:^(id sender) {
        
        [m_world restart];
        [m_world unpause];
        [[SceneManager sharedSceneManager].m_gameLayer removeChild:m_pauseMenu cleanup:YES];
        [[SceneManager sharedSceneManager].m_gameLayer removeChild:m_notificationLabel cleanup:YES];
        
    }
                                 ];
    m_pauseMenu = [CCMenu menuWithItems:restartButton, nil];
    
    [m_pauseMenu alignItemsHorizontallyWithPadding:20];
    [m_pauseMenu setPosition:ccp( size.width/2, size.height/2 - 50)];
    
    // Add the menu to the layer
    [[SceneManager sharedSceneManager].m_gameLayer addChild:m_pauseMenu]; 
    
}

-(void)showGameWin
{
    // create and initialize a Label
    m_notificationLabel = [CCLabelTTF labelWithString:@"You Win!" fontName:@"Marker Felt" fontSize:64];
    
    // ask director for the window size
    CGSize size = [[CCDirector sharedDirector] winSize];
	
    // position the label on the center of the screen
    m_notificationLabel.position =  ccp( size.width /2 , size.height/2 );
    
    // add the label as a child to this Layer
    [[SceneManager sharedSceneManager].m_gameLayer addChild:m_notificationLabel];
    
	[CCMenuItemFont setFontSize:28];
    
    // Achievement Menu Item using blocks
    CCMenuItem *restartButton = [CCMenuItemFont itemWithString:@"Restart" block:^(id sender) {
        
        [m_world restart];
        [m_world unpause];
        [[SceneManager sharedSceneManager].m_gameLayer removeChild:m_pauseMenu cleanup:YES];
        [[SceneManager sharedSceneManager].m_gameLayer removeChild:m_notificationLabel cleanup:YES];
        
    }
                                 ];
    m_pauseMenu = [CCMenu menuWithItems:restartButton, nil];
    
    [m_pauseMenu alignItemsHorizontallyWithPadding:20];
    [m_pauseMenu setPosition:ccp( size.width/2, size.height/2 - 50)];
    
    // Add the menu to the layer
    [[SceneManager sharedSceneManager].m_gameLayer addChild:m_pauseMenu];
    
}

@end
