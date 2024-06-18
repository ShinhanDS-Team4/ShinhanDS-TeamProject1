package com.team4.shoppingmall.category;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CategoryDTO {
	Integer category_id;
	String category_name;
	Integer category_depth;
	Integer parent_category_id;
}