package com.team4.shoppingmall.prod_image;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Prod_ImageDTO {
	Integer img_id;
	Integer prod_id;
	String email;
	String img_url;
}