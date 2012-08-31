//
//  Component.h
//  SpaceInvaders
//
//  Created by Fei Wang on 8/2/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Instance;

typedef enum {
    eComponent_Null = 0,
    eComponent_Health,
    eComponent_Draw,
    eComponent_AI,
    eComponent_Player,
    eComponent_Attack,
    eComponent_Projectile
} ComponentType;


@interface Component : NSObject
{
    Instance* m_owner;
    ComponentType m_type;
    NSDictionary* m_data;
}

@property (nonatomic, weak) Instance* m_owner;
@property (nonatomic) ComponentType m_type;
@property (nonatomic, retain)NSDictionary* m_data; 

-(void) update:(float)dt;
-(ComponentType) GetComponentType;
-(void) Destroy;


@end
