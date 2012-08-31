//
//  StateMachine.m
//  SpaceInvaders
//
//  Created by Fei Wang on 8/4/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import "StateMachine.h"

@implementation StateMachine

@synthesize m_owner, m_currentState, m_previousState;


-(id)initWithOwner:(Instance*)owner
{
    if(!(self = [super init]))
        return nil;
    m_owner = owner;
    m_currentState = nil;
    m_previousState = nil;
    
    return self;
}

-(void)update
{
    if (m_currentState) {
        [m_currentState update:m_owner];
    }
}

-(bool)isInState:(State*)state
{
    return ([m_currentState isEqual:state]);
}

-(void)changeState:(State*)state
{
    assert(state);
    m_previousState = m_currentState;
    if (m_currentState) 
        [m_currentState exit];
    m_currentState = state;
    [m_currentState enter];
}

@end
