//
//  InputManager.h
//  SpaceInvaders
//
//  Created by Fei Wang on 8/3/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SneakyJoystick.h"
#import "CCLayer.h"
#import "SneakyButton.h"

@interface InputManager : NSObject
{
    SneakyJoystick* m_leftJoystick;
    SneakyButton* m_rightButton;
    
}

@property (nonatomic, retain) SneakyJoystick* m_leftJoystick;
@property (nonatomic, retain) SneakyButton* m_rightButton;

+(InputManager*) sharedInputManager;

-(void)InitInput:(CCLayer*)layer;

@end
