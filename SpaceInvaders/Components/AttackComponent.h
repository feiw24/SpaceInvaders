//
//  AttackComponent.h
//  SpaceInvaders
//
//  Created by Fei Wang on 8/4/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import "Component.h"

@interface AttackComponent : Component
{
    CGPoint m_direction;
    float m_coolDownDefault;
    float m_coolDownTimer;
    bool m_requestShoot;
    float m_attackChance;
    float m_projectileDamage;
    
    bool m_shootThree;
    bool m_shootThrough;
    float m_projectileSpeed;
    NSString* m_bulletPath;
    NSString* m_shootThroughBulletPath;
}

@property (nonatomic) bool m_shootThree;
@property (nonatomic) bool m_shootThrough;
@property (nonatomic) float m_projectileSpeed;
@property (nonatomic) float m_attackChance;

-(id)initWithData:(NSDictionary*)componentData;
-(void)shoot;
-(void)update:(float)dt;
-(void)requestShoot;
-(void)ResetCoolDown;
-(void)shootBulletWithDirection:(CGPoint)direction;

@end
