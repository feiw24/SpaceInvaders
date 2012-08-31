//
//  World.m
//  SpaceInvaders
//
//  Created by Fei Wang on 8/3/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import "World.h"
#import "InstanceManager.h"
#import "DrawComponent.h"
#import "EnemyStates.h"
#import "SceneManager.h"
#import "MenuManager.h"
#import "InstanceTemplateManager.h"
#import "DataHelper.h"

@implementation World

@synthesize m_paused;

static const float START_LEVEL = 1;

-(id)init
{
    if(!(self = [super init]))
        return nil;
    
    m_paused = false;
    m_gameFinished = false;
    m_level = START_LEVEL;
    NSDictionary* worldSetting = [DataHelper ReadPlist:WORLD_DATA_PATH];
    assert(worldSetting);
    if (worldSetting) {
        m_numLevels = [[worldSetting objectForKey:@"Levels"] count];
    }
    return self;
}

-(void)dealloc
{
    [super dealloc];
}

-(void)initLevel
{
    //add player, enemies to the world
    [self initPlayer];   
    
    [self loadLevel:m_level];
}

-(void)initPlayer
{
    NSDictionary* worldSetting = [DataHelper ReadPlist:WORLD_DATA_PATH];
    assert(worldSetting);
    NSString* playerDataPath = nil;
    float posX = 0;
    float posY = 0;
    if (worldSetting) {
        playerDataPath = [worldSetting objectForKey:@"PlayerDataPath"];
        posX = [[worldSetting objectForKey:@"PlayerInitPosX"] floatValue];
        posY = [[worldSetting objectForKey:@"PlayerInitPosY"] floatValue];
        
    }
    Instance* player = [[InstanceTemplateManager sharedInstanceTemplateManager] LoadInstanceFromTemplatePath:playerDataPath];
    
    DrawComponent* drawComponent = (DrawComponent*)[player GetComponent:eComponent_Draw];
    [drawComponent SetPosition:CGPointMake(posX, posY)];
    [InstanceManager sharedInstanceManager].m_playerInstance = player;
    
}

-(void)loadLevel:(int)level
{
    //load level
    int levelIndex = level -1;
    NSDictionary* worldSetting = [DataHelper ReadPlist:@"WorldSetting"];
    assert(worldSetting);
    NSString* levelPath = nil;
    if (worldSetting) {
        levelPath = [[worldSetting objectForKey:@"Levels"] objectAtIndex:levelIndex ];
        
    }
    NSDictionary* levelData = [DataHelper ReadPlist:levelPath];
    if (!levelData) {
        levelData = [DataHelper ReadPlist:@"Level_Default"];
    }
     NSLog(@"level path name:%@", levelPath);
    if (levelData) {
        NSArray* instances = [NSMutableArray arrayWithArray:[levelData objectForKey:@"Instances"]];
        for (NSDictionary* instanceData in instances) {
            
            Instance* instance = [[InstanceTemplateManager sharedInstanceTemplateManager] LoadInstanceFromTemplatePath:[instanceData objectForKey:@"DataPath"]];
        
            if(instance)
            {
                //set position
                float initPosX = [[instanceData objectForKey:@"PosX"] floatValue];
                float initPosY = [[instanceData objectForKey:@"PosY"] floatValue];
                DrawComponent* drawComponent = (DrawComponent*)[instance GetComponent:eComponent_Draw];
                if (drawComponent) {
                    [drawComponent SetPosition:CGPointMake(initPosX, initPosY)];
                }
            }else {
                NSLog(@"instance not created with data path:%@", [instanceData objectForKey:@"DataPath"]);
            }
        }
    }
  
}

-(void)update:(ccTime)dt;
{
    if (m_paused) {
        return;
    }
   
    [[InstanceManager sharedInstanceManager] update:dt];
    
    Instance* player =[[InstanceManager sharedInstanceManager] GetPlayer];
    if(!player)
    {
        //game over
        NSLog(@"game over");
        [self pause];
        [self gameOver];
        return;
    }
    
    if ([[InstanceManager sharedInstanceManager] GetNumEnemies] <=0) {
        // win
        NSLog(@"win");
        if (m_level == m_numLevels) {
            [self pause];
            [self gameWin];
        }else {
            m_level ++;
            [self loadLevel: m_level];
        }
      
        return;
    }
  
}

-(void)gameWin
{
    [[InstanceManager sharedInstanceManager] destroyAll];
    
    m_level = START_LEVEL;
    
    [[MenuManager sharedMenuManager] showGameWin];
    
}

-(void)gameOver
{
    [[InstanceManager sharedInstanceManager] destroyAll];
    [[MenuManager sharedMenuManager] showGameOver];

}
-(void)pause
{
    m_paused = true;
}
-(void)unpause
{
    m_paused = false;
}
-(void)restart
{
    m_paused = false;
    m_gameFinished = false;
    
    [self initLevel];
    
}



@end
