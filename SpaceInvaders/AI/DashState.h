//
//  DashState.h
//  SpaceInvaders
//
//  Created by Fei Wang on 8/5/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import "State.h"

@interface DashState : State
{
    Instance* m_owner;
}

-(void)enter;
-(void)update:(Instance*)owner;
-(void)exit;
-(id)initWithOwner:(Instance*)owner;

@end
