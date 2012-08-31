//
//  ProjectileComponent.m
//  SpaceInvaders
//
//  Created by Fei Wang on 8/4/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import "ProjectileComponent.h"
#import "DrawComponent.h"
#import "Instance.h"
#import "SceneManager.h"
#import "InstanceManager.h"
#import "HealthComponent.h"

@implementation ProjectileComponent

@synthesize m_direction, m_attacker, m_speed, m_damage;

-(id) init
{
    if(! (self = [super init]))
        return nil;
    m_type = eComponent_Projectile;
    return self;
}

-(id)initWithData:(NSDictionary*)componentData
{
    self = [self init];
    
    m_data = componentData;
    return self;
}

-(void)update:(float)dt
{
    //update movement
    [self updateMovement];
    
    //update collision
    [self updateCollision];
}

-(void)updateMovement
{
    Instance* owner = m_owner;
    DrawComponent* drawComp = (DrawComponent*)[owner GetComponent:eComponent_Draw];
    if(!drawComp)
        return;
    CGPoint pos = [drawComp GetPosition];
    CGPoint fPos = CGPointMake(pos.x+m_speed*m_direction.x, pos.y+m_speed*m_direction.y);
    [drawComp SetPosition:fPos ];
}

-(void)updateCollision
{
    NSMutableDictionary* instances = [InstanceManager sharedInstanceManager].m_instances;
    for (id key in instances) 
    {
        Instance* instance = [instances objectForKey:key];
        
        bool shouldDamage = [self shouldDoDamage:instance];
            
        if(!shouldDamage)
            continue;
            
        CGRect projectileRect;
        DrawComponent* drawComp = (DrawComponent*)[m_owner GetComponent:eComponent_Draw];
        if(drawComp)
            projectileRect = drawComp.m_sprite.boundingBox;
        
        CGRect receiverRect;
        drawComp = (DrawComponent*)[instance GetComponent:eComponent_Draw];
        if(drawComp)
            receiverRect = drawComp.m_sprite.boundingBox;
        
        if (CGRectIntersectsRect(projectileRect, receiverRect)) 
        {
            HealthComponent* healthComp = (HealthComponent*)[instance GetComponent:eComponent_Health];
            if(healthComp)
            {
                [healthComp receiveDamage:m_damage];
                // also apply damage to the projectile instance
                HealthComponent* bullethealthComp = (HealthComponent*)[m_owner GetComponent:eComponent_Health];
                if(bullethealthComp)
                    [bullethealthComp receiveDamage:m_damage];
            }
        }
    }
}

-(bool)shouldDoDamage:(Instance*)instance
{
    if ([m_owner isEqual:instance] || [instance isEqual:m_attacker]) {
        return false;
    }else
    {
        if ([instance IsProjectile]) {
            // bullet v.s bullet
            return false;
        }else {
            // true if bullet v.s enemy/player
            if ([instance IsEnemy]) {
                if ([m_attacker IsPlayer]) {
                    return true;
                }
            }else if([instance IsPlayer]){
                if([m_attacker IsEnemy]){
                    return true;                
                }
            }
        }
    }
    return false;
}


@end
