//
//  AIComponent.h
//  SpaceInvaders
//
//  Created by Fei Wang on 8/4/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import "Component.h"
#import "StateMachine.h"

@interface AIComponent : Component
{
    StateMachine* m_stateMachine;
    
    CGPoint m_direction;
    float m_speed;
    float m_stepDownDist;
    CGPoint m_dashDirection;
    float m_dashSpeed;
    float m_dashRange;
    
    bool m_canDash;
}

@property (nonatomic, retain) StateMachine* m_stateMachine;
@property (nonatomic) CGPoint m_direction;
@property (nonatomic) float m_speed;
@property (nonatomic) float m_stepDownDist;
@property (nonatomic) CGPoint m_dashDirection;
@property (nonatomic) float m_dashSpeed;
@property (nonatomic) bool m_canDash;
@property (nonatomic) float m_dashRange;

-(id)initWithData:(NSDictionary*)componentData;
-(void)update:(float)dt;
-(void)enemyChangeDirection:(NSNotification *)notification;

@end
