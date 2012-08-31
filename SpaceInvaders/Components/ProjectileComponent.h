//
//  ProjectileComponent.h
//  SpaceInvaders
//
//  Created by Fei Wang on 8/4/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import "Component.h"

@interface ProjectileComponent : Component
{
    CGPoint m_direction;
    float  m_speed;
    float  m_damage;
    Instance* m_attacker;
}

@property (nonatomic) CGPoint m_direction;
@property (nonatomic) float m_speed;
@property (nonatomic) float m_damage;
@property (nonatomic, retain) Instance* m_attacker; 

-(id)initWithData:(NSDictionary*)componentData;

-(void)update:(float)dt;
-(void)updateMovement;
-(void)updateCollision;
-(bool)shouldDoDamage:(Instance*)instance;


@end
