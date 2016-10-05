//
//  KLNodeBasicInfo.swift
//  KLTreeDrawerModel
//
//  Created by keith.lee on 2016/10/5.
//  Copyright © 2016年 Keith. All rights reserved.
//


//This struct is to simplify initialization logic of node, the sturct might contain all the propable variables to of node (imageName, accountName, ..... etc.).
//Node should implement at least one init func with info struct parameter.

//Var should nearly as same as those defined in KLNodeInterface, which contains all needed varaiables to a specific kind of node.
//Vars which might not sure could be determined during the node initialization process are strongly recommended to be optional.

//NOTE: Could have some further discussion on this pattern.

import UIKit

//Struct - Use only in node initialization process, all propable infos should inherit this base struct
struct KLNodeBasicInfo : KLNodeBasicVariableInterface {
    var accountName: String?
    var value: Double?
    var imageName: String?
    var mainColor: UIColor?
}
