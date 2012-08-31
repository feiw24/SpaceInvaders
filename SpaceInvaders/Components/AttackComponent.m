//
//  AttackComponent.m
//  SpaceInvaders
//
//  Created by Fei Wang on 8/4/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import "AttackComponent.h"
#import "Instance.h"
#import "InstanceManager.h"
#import "ProjectileComponent.h"
#import "DrawComponent.h"
#import "SceneManager.h"
#import "HealthComponent.h"
#import "DataHelper.h"
#import "InstanceTemplateManager.h"


@implementation AttackComponent

@synthesize m_shootThree, m_shootThrough, m_projectileSpeed, m_attackChance;

-(id)init
{
    if(!(self = [super init]))
        return nil;
    
    m_type = eComponent_Attack;
    return self;
}

-(id)initWithData:(NSDictionary*)componentData
{
    self = [self init];
    m_coolDownTimer = 0;
    m_data = componentData;
    
    NSDictionary* defaultAttackComponent = [DataHelper ReadPlist:@"AttackComponent"];
    if ([componentData objectForKey:@"CoolDown"]) {
         m_coolDownDefault = [[componentData objectForKey:@"CoolDown"] floatValue];
    }else {
        m_coolDownDefault = [[defaultAttackComponent objectForKey:@"DefaultCoolDown"] floatValue];
    }
   
    if ([componentData objectForKey:@"ProjectileSpeed"]) {
        m_projectileSpeed = [[componentData objectForKey:@"ProjectileSpeed"] floatValue];
    }else{
        m_projectileSpeed = [[defaultAttackComponent objectForKey:@"DefaultProjectileSpeed"] floatValue];
    }
    
    if( [componentData objectForKey:@"ProjectileDamage"])
        m_projectileDamage = [[componentData objectForKey:@"ProjectileDamage"] floatValue];
    else {
        m_projectileDamage = [[defaultAttackComponent objectForKey:@"DefaultProjectileDamage"] floatValue];
    }
    
    if([componentData objectForKey:@"AttackChance"]){
        m_attackChance = [[componentData objectForKey:@"AttackChance"] floatValue];
    }else {
        m_attackChance = [[defaultAttackComponent objectForKey:@"DefaultAttackChance"] floatValue];
    }
   
    float directionX = 0;
    float directionY = 0;
    if([componentData objectForKey:@"DirectionX"]){
        directionX = [[componentData objectForKey:@"DirectionX"] floatValue];
    }else {
        directionX = [[defaultAttackComponent objectForKey:@"DefaultDirectionX"] floatValue];
    }
    if([componentData objectForKey:@"DirectionY"]){
        directionY = [[componentData objectForKey:@"DirectionY"] floatValue];
    }else {
        directionY = [[defaultAttackComponent objectForKey:@"DefaultDirectionY"] floatValue];
    }
    m_direction = CGPointMake(directionX, directionY);
     
    if ([componentData objectForKey:@"ShootThree"]) {
        m_shootThree = [[componentData objectForKey:@"ShootThree"] boolValue];
    }else {
        m_shootThree = [[defaultAttackComponent objectForKey:@"DefaultShootThree"] boolValue];
    }
    
    if([componentData objectForKey:@"ShootThrough"]){
        m_shootThrough = [[componentData objectForKey:@"ShootThrough"] boolValue];
    }else {
        m_shootThrough = [[defaultAttackComponent objectForKey:@"DefaultShootThrough"] boolValue];
    }
    
    if([componentData objectForKey:@"BulletPath"]){
        m_bulletPath = [[NSString alloc] initWithFormat:@"%@", [componentData objectForKey:@"BulletPath"]];
    }else {
        m_bulletPath = [[NSString alloc] initWithFormat:@"%@", [defaultAttackComponent objectForKey:@"DefaultBulletPath"]];
    }
    
    if([componentData objectForKey:@"ShootThroughBulletPath"]){
        m_shootThroughBulletPath = [[NSString alloc] initWithFormat:@"%@", [componentData objectForKey:@"ShootThroughBulletPath"]];
    }else {
        m_shootThroughBulletPath = [[NSString alloc] initWithFormat:@"%@", [defaultAttackComponent objectForKey:@"DefaultShootThroughBulletPath"]];}
    
    return self;
}

-(void)dealloc
{
    m_bulletPath = nil;
    m_shootThroughBulletPath = nil;
    [super dealloc];
}
-(void)shoot
{
    if (m_coolDownTimer<=0) {
        m_coolDownTimer = m_coolDownDefault;
        
        [self shootBulletWithDirection:m_direction];
    
        if(m_shootThree)
        {
            CGPoint direction = CGPointMake(m_direction.x +1, m_direction.y);
            [self shootBulletWithDirection:direction];
            direction = CGPointMake(m_direction.x - 1, m_direction.y);
            [self shootBulletWithDirection:direction];
        }       
    }
}

-(void)shootBulletWithDirection:(CGPoint)direction
{
    Instance* bullet = nil;
    if (!m_shootThrough) {
        bullet = [[InstanceTemplateManager sharedInstanceTemplateManager] LoadInstanceFromTemplatePath:m_bulletPath];
    }else {
        bullet = [[InstanceTemplateManager sharedInstanceTemplateManager] LoadInstanceFromTemplatePath:m_shootThroughBulletPath];
    }
    ProjectileComponent* projComp = (ProjectileComponent*)[bullet GetComponent:eComponent_Projectile];
    projComp.m_direction = direction;
    projComp.m_speed = m_projectileSpeed;
    projComp.m_damage = m_projectileDamage;
    projComp.m_attacker = m_owner;
    
    DrawComponent* drawComp = (DrawComponent*) [bullet GetComponent:eComponent_Draw];
    if (drawComp) {
        
        CGPoint ownerPos = [m_owner GetPosition];
        CGPoint size = [m_owner GetSize];
        float posY = ownerPos.y + m_direction.y*size.y/2.0f+ m_direction.y*drawComp.m_height/2.0;
        [drawComp SetPosition:CGPointMake(ownerPos.x, posY)];
    }
}

-(void)update:(float)dt
{
    if (m_coolDownTimer>0) {
        m_coolDownTimer -= dt;
    }else {
        m_coolDownTimer = 0.0f;
        
        if (m_requestShoot) {
            [self shoot];
            m_requestShoot = false;
        }
    }
}

-(void)requestShoot
{
    m_requestShoot  = true;
}

-(void)ResetCoolDown
{
    m_coolDownTimer = m_coolDownDefault;
}

@end
