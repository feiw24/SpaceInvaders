//
//  HealthComponent.h
//  SpaceInvaders
//
//  Created by Fei Wang on 8/2/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import "Component.h"

@interface HealthComponent : Component
{
    int m_initHP;
    int m_curHP;
    bool m_dead;
}

@property (nonatomic) int m_initHP;
@property (nonatomic) int m_curHP;
@property (nonatomic) bool m_dead;

-(id)initWithData:(NSDictionary*)componentData;
-(void)update:(float)dt;
-(void)reset;
-(void)receiveDamage:(float)damage;

@end
