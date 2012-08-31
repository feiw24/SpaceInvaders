//
//  Instance.h
//  SpaceInvaders
//
//  Created by Fei Wang on 8/2/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Component.h"



@interface Instance : NSObject
{
    int m_id;
    
    NSMutableDictionary*  m_components;
}

@property (nonatomic) int m_id;
@property (nonatomic, retain) NSMutableDictionary* m_components;

-(id)initWithID:(int) ID;
-(Component*) GetComponent:(ComponentType)type;
-(Component*) SetComponent:(Component*)component;
-(void) ClearComponent;
-(CGPoint) GetPosition;
-(void)SetPosition:(CGPoint)pos;
-(CGPoint) GetSize;
-(void)Destroy;
-(bool)IsEnemy;
-(bool)IsProjectile;
-(bool)IsPlayer;
-(void)Update:(float)dt;
-(bool)OutOfBoundery;

@end
