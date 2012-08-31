//
//  MenuManager.h
//  SpaceInvaders
//
//  Created by Fei Wang on 8/5/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "World.h"
#import "CCMenu.h"
#import "CCLabelTTF.h"

@interface MenuManager : NSObject
{
    World* m_world;
    CCMenu* m_pauseMenu;
    CCLabelTTF* m_notificationLabel;
}

+(MenuManager*)sharedMenuManager;

-(void)initWithWorld:(World*)world;

-(void)showGameOver;
-(void)showGameWin;

@end
