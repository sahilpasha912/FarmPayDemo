//
//  CardDetails.swift
//  FarmPayDemo
//
//  Created by iPHTech20 on 23/05/21.
//

import Foundation

struct CardDetail : Codable {
    let card_groups : [Card_groups]?

    enum CodingKeys: String, CodingKey {

        case card_groups = "card_groups"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        card_groups = try values.decodeIfPresent([Card_groups].self, forKey: .card_groups)
    }

}

struct Card_groups : Codable {
    let id : Int?
    let name : String?
    let design_type : String?
    let cards : [Cards]?
    let is_scrollable : Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case design_type = "design_type"
        case cards = "cards"
        case is_scrollable = "is_scrollable"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        design_type = try values.decodeIfPresent(String.self, forKey: .design_type)
        cards = try values.decodeIfPresent([Cards].self, forKey: .cards)
        is_scrollable = try values.decodeIfPresent(Bool.self, forKey: .is_scrollable)
    }
    
}

struct Cards : Codable {
    let name : String?
    let title : String?
    let formatted_title : Formatted_title?
    let description : String?
    let formatted_description : Formatted_description?
    let icon : Icon?
    let url : String?
    let is_disabled : Bool?
    let bg_color : String?
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case title = "title"
        case formatted_title = "formatted_title"
        case description = "description"
        case formatted_description = "formatted_description"
        case icon = "icon"
        case url = "url"
        case is_disabled = "is_disabled"
        case bg_color = "bg_color"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        formatted_title = try values.decodeIfPresent(Formatted_title.self, forKey: .formatted_title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        formatted_description = try values.decodeIfPresent(Formatted_description.self, forKey: .formatted_description)
        icon = try values.decodeIfPresent(Icon.self, forKey: .icon)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        is_disabled = try values.decodeIfPresent(Bool.self, forKey: .is_disabled)
        bg_color = try values.decodeIfPresent(String.self, forKey: .bg_color)
    }
    
}

struct Formatted_title : Codable {
    let text : String?
    let align : String?
    let entities : [String]?
    
    enum CodingKeys: String, CodingKey {
        
        case text = "text"
        case align = "align"
        case entities = "entities"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        align = try values.decodeIfPresent(String.self, forKey: .align)
        entities = try values.decodeIfPresent([String].self, forKey: .entities)
    }
    
}


struct Formatted_description : Codable {
    let text : String?
    let align : String?
    let entities : [String]?

    enum CodingKeys: String, CodingKey {

        case text = "text"
        case align = "align"
        case entities = "entities"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        align = try values.decodeIfPresent(String.self, forKey: .align)
        entities = try values.decodeIfPresent([String].self, forKey: .entities)
    }

}

struct Icon : Codable {
    let image_type : String?
    let image_url : String?

    enum CodingKeys: String, CodingKey {

        case image_type = "image_type"
        case image_url = "image_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        image_type = try values.decodeIfPresent(String.self, forKey: .image_type)
        image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
    }

}
