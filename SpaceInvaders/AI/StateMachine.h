//
//  StateMachine.h
//  SpaceInvaders
//
//  Created by Fei Wang on 8/4/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "State.h"
#import "Instance.h"

@interface StateMachine : NSObject
{
    Instance* m_owner;
    State* m_currentState;
    State* m_previousState;
}

@property (nonatomic, retain) Instance* m_owner;
@property (nonatomic, retain) State* m_currentState;
@property (nonatomic, retain) State* m_previousState;

-(id)initWithOwner:(Instance*)owner;
-(void)update;
-(bool)isInState:(State*)state;
-(void)changeState:(State*)state;

@end
