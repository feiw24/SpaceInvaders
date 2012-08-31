//
//  SquadState.h
//  SpaceInvaders
//
//  Created by Fei Wang on 8/4/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import "State.h"
#import "Instance.h"

@interface SquadState : State
{
    Instance* m_owner;
}

-(void)enter;
-(void)update:(Instance*)owner;
-(void)exit;
-(id)initWithOwner:(Instance*)owner;

@end
