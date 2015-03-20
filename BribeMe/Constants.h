//
//  Constants.h
//  BribeMe
//
//  Created by William Gu on 2/27/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#ifndef BribeMe_Constants_h
#define BribeMe_Constants_h

#define kBMBASE_URL                 @"http://bribeme.com"
#define loginAction                 @"/?vhg_action=d56b699830e77ba53855679cb1d252da"
#define createAccountAction         @"/?vhg_action=9de4a97425678c5b1288aa70c1669a64"

#define GETMYBRIBES                 @"/?vhg_action=0a1f15b7ebb31fd565ef5ac6c99dacfa" //requires user_id addon
#define POSTBRIBE                   @"/?vhg_action=a11359392dbc4a455dc8c7749467edb5"


#define GETFEATURED                 @"/?vhg_action=e6828e0be1da29273209c67ef44878e5"
#define GETDINING                   @"/?vhg_action=7f9c2dadbdfbd95c32fcc47421a098e2"
#define GETNIGHTLIFE                @"/?vhg_action=e6a1cd62cb23d782ce2900faa1b67ba1"
#define GETSHOPPING                 @"/?vhg_action=a9a2057fc0671aa00fa1d5905d9ff70c"
#define GETSERVICES                 @"/?vhg_action=ab88757ccd9ed00caf8900b0f8fdb296"

#define MYBRIBES 0
#define FEATURED  1
#define DINING 2
#define NIGHTLIFE 3
#define SHOPPING 4
#define SERVICES 5


//Bribe Value Keys
#define B_author_id @"author_id"
#define B_author_image @"author_image"
#define B_author_name @"author_name"
#define B_expire_in @"expire_in"
#define B_featured_image @"featured_image"
#define B_is_mybribe @"is_mybribe"
#define B_post_content @"post_content"
#define B_post_id @"post_id"


#endif
