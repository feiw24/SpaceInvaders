//
//  HealthComponent.m
//  SpaceInvaders
//
//  Created by Fei Wang on 8/2/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import "HealthComponent.h"
#import "InstanceManager.h"
#import "DataHelper.h"

@implementation HealthComponent

@synthesize m_initHP, m_curHP, m_dead;


-(id)init{
    
    if(!(self = [super init]))
        return nil;
    m_type = eComponent_Health;
    return self;
}

-(id)initWithData:(NSDictionary*)componentData
{
    self = [self init];
    
    m_data = componentData;
    if( [componentData objectForKey:@"HP"])
    {
        m_initHP = [[componentData objectForKey:@"HP"] intValue];
    }else {
        NSDictionary* defaultSetting = [DataHelper ReadPlist:@"HealthComponent"];
        m_initHP = [[defaultSetting objectForKey:@"DefaultHP"] floatValue];
    }
    m_curHP = m_initHP;
    m_dead = false;
    
    return self;
}

-(void)dealloc{
    [super dealloc];
}

-(void)update:(float)dt{
     
    if (m_dead == false && m_curHP <= 0) {
        
        m_dead = true;
        [[InstanceManager sharedInstanceManager]removeInstance:m_owner];
    }

}

-(void)reset{
    
    m_dead = false;
    m_curHP = m_initHP;
}

-(void)receiveDamage:(float)damage;
{
    m_curHP -= damage;
}


@end
