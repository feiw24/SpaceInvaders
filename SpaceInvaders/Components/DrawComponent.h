//
//  DrawComponent.h
//  SpaceInvaders
//
//  Created by Fei Wang on 8/3/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import "Component.h"
#import "CCSprite.h"
#import "CCLayer.h"

@interface DrawComponent : Component
{
    CCSprite* m_sprite;
    float m_x;
    float m_y;
    float m_width;
    float m_height;
}

@property (nonatomic, retain) CCSprite* m_sprite; 
@property (nonatomic) float m_width;
@property (nonatomic) float m_height;

-(id)initWithData:(NSDictionary*)componentData;
-(void)update:(float)dt;
-(void)draw;
-(CGPoint) GetPosition;
-(void)SetPosition:(CGPoint)pos;

@end
