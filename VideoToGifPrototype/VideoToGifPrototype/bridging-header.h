//
//  bridging-header.h
//  VideoToGifPrototype
//
//  Created by Mohan Dhar on 1/12/16.
//  Copyright © 2016 Mohan Dhar. All rights reserved.
//

#ifndef bridging_header_h
#define bridging_header_h

//CoreSurface:
#import <CoreSurface/CoreSurface.h>

//IOKit:
#import <IOKit/IOBSD.h>
#import <IOKit/IOCFBundle.h>
#import <IOKit/IOCFPlugIn.h>
#import <IOKit/IOCFSerialize.h>
#import <IOKit/IOCFURLAccess.h>
#import <IOKit/IOCFUnserialize.h>
#import <IOKit/IODataQueueClient.h>
#import <IOKit/IODataQueueShared.h>
#import <IOKit/IOKitKeys.h>
#import <IOKit/IOKitLib.h>
#import <IOKit/IOKitServer.h>
#import <IOKit/IOMessage.h>
#import <IOKit/IOReturn.h>
#import <IOKit/IOSharedLock.h>
#import <IOKit/IOTypes.h>
#import <IOKit/OSMessageNotification.h>
#import <IOKit/iokitmig.h>

//IOSurface:
#import <IOMobileFramebuffer.h>
#import <IOSurface.h>
#import <IOSurfaceAPI.h>
#import <IOSurfaceAccelerator.h>
#import <IOSurfaceBase.h>

#endif /* bridging_header_h */
