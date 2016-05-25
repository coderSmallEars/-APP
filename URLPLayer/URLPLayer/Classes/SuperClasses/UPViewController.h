//
//  UPViewController.h
//  URLPlayer
//
//  Created by King on 16/5/22.
//  Copyright © 2016年 Player. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPView.h"
@interface UPViewController : UIViewController<UIViewCollectEventsDelegate>

-(void)uiview:(UIView*)view collectionEventType:(id)type params:(id)params;



@end
