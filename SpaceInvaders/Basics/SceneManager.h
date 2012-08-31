//
//  SceneManager.h
//  SpaceInvaders
//
//  Created by Fei Wang on 8/4/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCLayer.h"
#import "CCSprite.h"

const static float SCREEN_WIDTH = 480;
const static float SCREEN_HEIGHT = 320;

@interface SceneManager : NSObject
{
    CCLayer* m_gameLayer;
}

@property (nonatomic, retain) CCLayer* m_gameLayer;

+(SceneManager*) sharedSceneManager;
-(void)SetGameLayer:(CCLayer*)layer;
-(CCLayer*)GetGameLayer;
-(void)AddSprite:(CCSprite*) sprite;
-(void)RemoveSpreite:(CCSprite*) sprite;

@end
