//
//  EnemyStates.h
//  SpaceInvaders
//
//  Created by Fei Wang on 8/5/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import "SquadState.h"
#import "CombatState.h"
#import "StateMachine.h"
#import "DashState.h"

@interface EnemyStates : StateMachine
{
    SquadState* m_squadState;
    CombatState* m_combatState;
    DashState* m_dashState;
}

@property (nonatomic, retain)SquadState* m_squadState;
@property (nonatomic, retain)CombatState* m_combatState;
@property (nonatomic, retain)DashState* m_dashState;

-(id)initWithOwner:(Instance *)owner;
-(bool)shouldTransiteToCombatState;

@end
