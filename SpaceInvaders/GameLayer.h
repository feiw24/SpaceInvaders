//
//  HelloWorldLayer.h
//  SpaceInvaders
//
//  Created by Fei Wang on 8/1/12.
//  Copyright Crystal Dynamics, Square Enix 2012. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "World.h"

// HelloWorldLayer
@interface GameLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    World* m_world;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
