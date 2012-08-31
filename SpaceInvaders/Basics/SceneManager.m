//
//  SceneManager.m
//  SpaceInvaders
//
//  Created by Fei Wang on 8/4/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import "SceneManager.h"
#import "DataHelper.h"
#import "World.h"

@implementation SceneManager

@synthesize m_gameLayer;

static SceneManager* DefaultManager = nil;

+(SceneManager*) sharedSceneManager
{
    if (!DefaultManager) DefaultManager = [[self allocWithZone:NULL] init];
    
    return DefaultManager;
}


-(void)SetGameLayer:(CCLayer*)layer
{
    m_gameLayer = layer;
    
    [self loadBG];
}

-(void)loadBG
{
    NSDictionary* worldSetting = [DataHelper ReadPlist:WORLD_DATA_PATH];
    assert(worldSetting);
    NSString* bgPath = nil;
    if (worldSetting) {
        bgPath = [worldSetting objectForKey:@"BackgroundImage"];
    }
    CCSprite* bg = [[CCSprite alloc] initWithFile:bgPath];
    bg.scale = SCREEN_WIDTH/bg.boundingBox.size.width;
    bg.position = CGPointMake(SCREEN_WIDTH/2.0f, SCREEN_HEIGHT/2.0f);
    [m_gameLayer addChild:bg];
}

-(CCLayer*)GetGameLayer
{
    return m_gameLayer;
}

-(void)AddSprite:(CCSprite*) sprite
{
    [m_gameLayer addChild:sprite];

}

-(void)RemoveSpreite:(CCSprite*) sprite
{
    [m_gameLayer removeChild:sprite cleanup:YES];
}

@end
