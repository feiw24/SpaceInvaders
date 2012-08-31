//
//  DashState.m
//  SpaceInvaders
//
//  Created by Fei Wang on 8/5/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import "DashState.h"
#import "AIComponent.h"
#import "SceneManager.h"

@implementation DashState

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
    
    CGPoint direction = aiComp.m_dashDirection;
    float speed =aiComp.m_dashSpeed;
    CGPoint fPos = CGPointMake(curPos.x + speed*direction.x, curPos.y+ speed* direction.y);
    
    [owner SetPosition:fPos];
    
    
}
-(void)exit
{
    
}



@end
