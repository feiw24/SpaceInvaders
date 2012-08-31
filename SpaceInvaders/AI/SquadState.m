//
//  SquadState.m
//  SpaceInvaders
//
//  Created by Fei Wang on 8/4/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import "SquadState.h"
#import "SceneManager.h"
#import "events.h"
#import "AIComponent.h"
#import "EnemyStates.h"

@implementation SquadState


-(id)init
{
    if(!(self =[super init]))
        return nil;
    
    return self;
}

-(id)initWithOwner:(Instance*)owner
{
    if(!(self =[super init]))
        return nil;
    
    m_owner = owner;
    
    return self;
}

-(void)enter
{
    
}
-(void)update:(Instance*)owner
{
    CGPoint curPos = [owner GetPosition];
    AIComponent* aiComp =  (AIComponent*)[owner GetComponent:eComponent_AI];
    assert(aiComp);
    CGPoint direction = aiComp.m_direction;
    float speed =aiComp.m_speed;
    CGPoint fPos = CGPointMake(curPos.x + speed*direction.x, curPos.y+ speed* direction.y);
    
    [owner SetPosition:fPos];
    
    if (fPos.x <0 || fPos.x>SCREEN_WIDTH) {
        
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:eEnemyChangeDirection object:self]]; 
        
    }
    
}
-(void)exit
{
    
}



@end
