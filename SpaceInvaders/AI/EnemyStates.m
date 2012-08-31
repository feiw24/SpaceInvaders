//
//  EnemyStates.m
//  SpaceInvaders
//
//  Created by Fei Wang on 8/5/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import "EnemyStates.h"
#import "InstanceManager.h"
#import "AIComponent.h"

@implementation EnemyStates

@synthesize m_combatState, m_squadState, m_dashState;


-(id)initWithOwner:(Instance*)owner
{
    if(!(self = [super init]))
        return nil;
    m_owner = owner;
    m_squadState = [[SquadState alloc] initWithOwner:owner];
    m_combatState = [[CombatState alloc] initWithOwner:owner];
    m_dashState = [[DashState alloc] initWithOwner:owner];
    m_currentState = m_squadState;
    m_previousState = nil;
    
    return self;
}

-(void)update
{
    [super update];
    
    if ([m_currentState isEqual:m_squadState])
    {
        if([self shouldTransiteToCombatState])
        {
            [self changeState:m_combatState];
        }
    }else if([m_currentState isEqual:m_combatState])
    {
        if(![self shouldTransiteToCombatState])
        {
            [self changeState:m_squadState];
        }
    }
    
    if ((![m_currentState isEqual:m_dashState]) && [self shouldTransiteToDashState]) {
        [self changeState:m_dashState];
    }
   
    
}

-(bool)shouldTransiteToDashState
{
    
    Instance* player = [[InstanceManager sharedInstanceManager] GetPlayer];
    AIComponent* aiComp = (AIComponent*) [m_owner GetComponent:eComponent_AI];
    if (!aiComp.m_canDash) {
        return NO;
    }
    float posXDif = [player GetPosition].x - [m_owner GetPosition].x;
    float playerWidth = [player GetSize].x;
    float posYDif = [player GetPosition].y - [m_owner GetPosition].y;
    float dashRange = aiComp.m_dashRange;
    if( abs( posXDif) <  playerWidth*2 && abs(posYDif) < dashRange)
    {
        return YES;
    }
    else 
        return NO;
}

-(bool)shouldTransiteToCombatState
{
    Instance* player = [[InstanceManager sharedInstanceManager] GetPlayer];
    float posXDif = [player GetPosition].x - [m_owner GetPosition].x;
    float playerWidth = [player GetSize].x;
    if( abs( posXDif) <  playerWidth*1.5)
      return YES;
    else 
        return NO;
}
@end
