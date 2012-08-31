//
//  World.h
//  SpaceInvaders
//
//  Created by Fei Wang on 8/3/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Instance.h"
#import "CCLayer.h"

static NSString* WORLD_DATA_PATH = @"WorldSetting.plist";

@interface World : NSObject
{
    bool m_paused;
    bool m_gameFinished;
    int  m_level;
    int  m_numLevels;
}

@property (nonatomic) bool m_paused;

-(void)update:(ccTime)dt;
-(void)pause;
-(void)unpause;
-(void)restart;
-(void)initLevel;
-(void)initPlayer;

@end
