//
//  FirstViewController.h
//  SUPORTE
//
//  Created by Victor Antoniazzi on 20/07/12.
//  Copyright (c) 2012 UCPel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController <NSXMLParserDelegate>{
    
    UIScrollView *scroll;
    NSMutableArray *FotosTirinhas;
    
    
    NSMutableArray* noticiasArray;
    NSMutableDictionary* noticiaDict;
    NSMutableString* elementString;
    NSString* currentElement;
    
}

-(void)analisaXML;
-(void)adicionaImagens;

-(IBAction)atualiza;

@property (nonatomic,retain) IBOutlet UIScrollView *scroll;


@end
