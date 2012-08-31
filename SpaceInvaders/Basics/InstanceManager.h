//
//  InstanceManager.h
//  SpaceInvaders
//
//  Created by Fei Wang on 8/3/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Instance.h"

@interface InstanceManager : NSObject
{
    NSMutableDictionary* m_instances;
    bool updating;
    NSMutableArray* m_toInsert;
    NSMutableArray* m_toRemove;
    Instance* m_playerInstance;
}

@property (retain, nonatomic) NSMutableDictionary* m_instances;
@property (retain, nonatomic) Instance* m_playerInstance;


+ (InstanceManager *) sharedInstanceManager; 


-(void)registerInstance:(Instance*)instance;
-(Instance*) getInstance:(int)ID;
-(bool)removeInstance:(Instance*)instance;
-(void)destroyAll;
-(int)getNextInstanceID;

-(void)update:(float)dt;
-(Instance*) GetPlayer;
-(int) GetNumEnemies;

@end
