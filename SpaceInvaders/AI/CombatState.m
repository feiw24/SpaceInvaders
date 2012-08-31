//
//  CombatState.m
//  SpaceInvaders
//
//  Created by Fei Wang on 8/5/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import "CombatState.h"
#import "AttackComponent.h"
#include <stdlib.h>
#include "MathHelper.h"

@implementation CombatState


-(void)update:(Instance *)owner
{
    [super update:owner];
    
    AttackComponent* attComp = (AttackComponent*)[owner GetComponent:eComponent_Attack];
    if (attComp) {
        float percentage = [MathHelper GetRandomPercentage];
        float attackChance = attComp.m_attackChance;
        if (percentage < attackChance) {
            //NSLog(@"enemy shoot");
            [attComp requestShoot];
        }else {
            [attComp ResetCoolDown];
        }
    }
    
}
-(void)enter
{
    
}
-(void)exit
{
    
}

@end
