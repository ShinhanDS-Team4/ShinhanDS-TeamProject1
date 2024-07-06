package com.team4.shoppingmall.category;

import java.util.Arrays;
import java.util.List;

public enum CategoryEnum {
	highest("highest", null, Arrays.asList("woman", "man", "kids", "luxury", "sports", "bagAndShoes")),

	woman("woman", "여성",
			Arrays.asList("woman_outer", "woman_jacketAndVest", "woman_neat", "woman_shirtAndBlouse", "woman_tshirt",
					"woman_onepiece", "woman_pants", "woman_skirt", "woman_jewelryAndWatch")),

	woman_outer("woman_outer", "아우터",
			Arrays.asList("woman_outer_coat", "woman_outer_jumper", "woman_outer_padding", "woman_outer_fur")),

	woman_outer_coat("woman_outer_coat", "코트",
			Arrays.asList("woman_outer_coat_coat", "woman_outer_coat_trench", "woman_outer_coat_fur")),

	woman_outer_coat_coat("woman_outer_coat_coat", "코트_9", null),

	woman_outer_coat_trench("woman_outer_coat_trench", "트렌치_9", null),

	woman_outer_coat_fur("woman_outer_coat_fur", "퍼_9", null),

	woman_outer_jumper("woman_outer_jumper", "점퍼",
			Arrays.asList("woman_outer_jumper_jumper", "woman_outer_jumper_safari", "woman_outer_jumper_windbreak")),

	woman_outer_jumper_jumper("woman_outer_jumper_jumper", "점퍼_4", null),

	woman_outer_jumper_safari("woman_outer_jumper_safari", "야상/사파리_4", null),

	woman_outer_jumper_windbreak("woman_outer_jumper_windbreak", "바람막이_4", null),

	woman_outer_padding("woman_outer_padding", "다운/패딩_4", null),

	woman_outer_fur("woman_outer_fur", "퍼_4", null),

	woman_jacketAndVest("woman_jacketAndVest", "재킷/베스트",
			Arrays.asList("woman_jacketAndVest_jacket", "woman_jacketAndVest_blazer",
					"woman_jacketAndVest_leatherJacket", "woman_jacketAndVest_vest")),

	woman_jacketAndVest_jacket("woman_jacketAndVest_jacket", "재킷_4", null),

	woman_jacketAndVest_blazer("woman_jacketAndVest_blazer", "블레이저_4", null),

	woman_jacketAndVest_leatherJacket("woman_jacketAndVest_leatherJacket", "레더 재킷_4", null),

	woman_jacketAndVest_vest("woman_jacketAndVest_vest", "베스트_5", null),

	woman_neat("woman_neat", "니트", Arrays.asList("woman_neat_pullover", "woman_neat_cardigan", "woman_neat_vest")),

	woman_neat_pullover("woman_neat_pullover", "풀오버_2", null),

	woman_neat_cardigan("woman_neat_cardigan", "카디건_3", null),

	woman_neat_vest("woman_neat_vest", "베스트_5", null),

	woman_shirtAndBlouse("woman_shirtAndBlouse", "셔츠/블라우스",
			Arrays.asList("woman_shirtAndBlouse_shirt", "woman_shirtAndBlouse_blouse")),

	woman_shirtAndBlouse_shirt("woman_shirtAndBlouse_shirt", "셔츠",
			Arrays.asList("woman_shirtAndBlouse_shirt_sleevelong", "woman_shirtAndBlouse_shirt_sleeveshort")),

	woman_shirtAndBlouse_shirt_sleevelong("woman_shirtAndBlouse_shirt_sleevelong", "긴팔_0", null),

	woman_shirtAndBlouse_shirt_sleeveshort("woman_shirtAndBlouse_shirt_sleeveshort", "반팔_0", null),

	woman_shirtAndBlouse_blouse("woman_shirtAndBlouse_blouse", "블라우스",
			Arrays.asList("woman_shirtAndBlouse_blouse_sleevelong", "woman_shirtAndBlouse_blouse_sleeveshort",
					"woman_shirtAndBlouse_blouse_sleeveless")),

	woman_shirtAndBlouse_blouse_sleevelong("woman_shirtAndBlouse_blouse_sleevelong", "긴팔_0", null),

	woman_shirtAndBlouse_blouse_sleeveshort("woman_shirtAndBlouse_blouse_sleeveshort", "반팔_0", null),

	woman_shirtAndBlouse_blouse_sleeveless("woman_shirtAndBlouse_blouse_sleeveless", "민소매_0", null),

	woman_tshirt("woman_tshirt", "티셔츠",
			Arrays.asList("woman_tshirt_sleevelong", "woman_tshirt_sleeveshort", "woman_tshirt_sleeveless")),

	woman_tshirt_sleevelong("woman_tshirt_sleevelong", "긴팔_1", null),

	woman_tshirt_sleeveshort("woman_tshirt_sleeveshort", "반팔_1", null),

	woman_tshirt_sleeveless("woman_tshirt_sleeveless", "민소매_1", null),

	woman_onepiece("woman_onepiece", "원피스", Arrays.asList("woman_onepiece_sleevelong", "woman_onepiece_sleeveshort")),

	woman_onepiece_sleevelong("woman_onepiece_sleevelong", "긴팔_10", null),

	woman_onepiece_sleeveshort("woman_onepiece_sleeveshort", "반팔/민소매_10", null),

	woman_pants("woman_pants", "팬츠",
			Arrays.asList("woman_pants_wide", "woman_pants_straight", "woman_pants_slim", "woman_pants_jogger",
					"woman_pants_denim", "woman_pants_short", "woman_pants_jumpsuit", "woman_pants_sport")),

	woman_pants_wide("woman_pants_wide", "와이드_6", null),

	woman_pants_straight("woman_pants_straight", "스트레이트_6", null),

	woman_pants_slim("woman_pants_slim", "슬림_6", null),

	woman_pants_jogger("woman_pants_jogger", "조거_6", null),

	woman_pants_denim("woman_pants_denim", "데님", Arrays.asList("woman_pants_denim_long", "woman_pants_denim_short")),

	woman_pants_denim_long("woman_pants_denim_long", "롱/미디_6", null),

	woman_pants_denim_short("woman_pants_denim_short", "쇼트_7", null),

	woman_pants_short("woman_pants_short", "쇼츠/하프_7", null),

	woman_pants_jumpsuit("woman_pants_jumpsuit", "점프수트_11", null),

	woman_pants_sport("woman_pants_sport", "스포츠", Arrays.asList("woman_pants_sport_long", "woman_pants_sport_short")),

	woman_pants_sport_long("woman_pants_sport_long", "롱/미디 팬츠_6", null),

	woman_pants_sport_short("woman_pants_sport_short", "쇼트 팬츠_7", null),

	woman_skirt("woman_skirt", "스커트", Arrays.asList("woman_skirt_long", "woman_skirt_short")),

	woman_skirt_long("woman_skirt_long", "롱/미디_8", null),

	woman_skirt_short("woman_skirt_short", "미니_8", null),

	woman_jewelryAndWatch("woman_jewelryAndWatch", "쥬얼리/시계",
			Arrays.asList("woman_jewelryAndWatch_jewerly", "woman_jewelryAndWatch_earing",
					"woman_jewelryAndWatch_necklace", "woman_jewelryAndWatch_bracelet", "woman_jewelryAndWatch_ring",
					"woman_jewelryAndWatch_hairAccessory", "woman_jewelryAndWatch_brooch",
					"woman_jewelryAndWatch_watch")),

	woman_jewelryAndWatch_jewerly("woman_jewelryAndWatch_jewerly", "쥬얼리", null),

	woman_jewelryAndWatch_earing("woman_jewelryAndWatch_earing", "귀걸이", null),

	woman_jewelryAndWatch_necklace("woman_jewelryAndWatch_necklace", "목걸이", null),

	woman_jewelryAndWatch_bracelet("woman_jewelryAndWatch_bracelet", "팔찌", null),

	woman_jewelryAndWatch_ring("woman_jewelryAndWatch_ring", "반지", null),

	woman_jewelryAndWatch_hairAccessory("woman_jewelryAndWatch_hairAccessory", "헤어악세서리", null),

	woman_jewelryAndWatch_brooch("woman_jewelryAndWatch_brooch", "브로츠/펜던트", null),

	woman_jewelryAndWatch_watch("woman_jewelryAndWatch_watch", "시계", null),

	man("man", "남성",
			Arrays.asList("man_outer", "man_suit", "man_pants", "man_jacket", "man_shirt", "man_neat", "man_tshirt")),

	man_outer("man_outer", "아우터",
			Arrays.asList("man_outer_jumper", "man_outer_coat", "man_outer_padding", "man_outer_leatherJacket")),

	man_outer_jumper("man_outer_jumper", "점퍼",
			Arrays.asList("man_outer_jumper_jumper", "man_outer_jumper_safari", "man_outer_jumper_windbreak")),

	man_outer_jumper_jumper("man_outer_jumper_jumper", "점퍼_4", null),

	man_outer_jumper_safari("man_outer_jumper_safari", "야상/사파리_4", null),

	man_outer_jumper_windbreak("man_outer_jumper_windbreak", "바람막이_4", null),

	man_outer_coat("man_outer_coat", "코트", Arrays.asList("man_outer_coat_coat", "man_outer_coat_trench")),

	man_outer_coat_coat("man_outer_coat_coat", "코트_9", null),

	man_outer_coat_trench("man_outer_coat_trench", "트렌치_9", null),

	man_outer_padding("man_outer_padding", "다운/패딩_4", null),

	man_outer_leatherJacket("man_outer_leatherJacket", "레더재킷_4", null),

	man_suit("man_suit", "정장",
			Arrays.asList("man_suit_suitSet", "man_suit_suitJacket", "man_suit_suitPants", "man_suit_dressShirt",
					"man_suit_suitVest", "man_suit_setupSet")),

	man_suit_suitSet("man_suit_suitSet", "정장 세트", null),

	man_suit_suitJacket("man_suit_suitJacket", "정장 재킷_4", null),

	man_suit_suitPants("man_suit_suitPants", "정장 팬츠_6", null),

	man_suit_dressShirt("man_suit_dressShirt", "드레스 셔츠_0", null),

	man_suit_suitVest("man_suit_suitVest", "정장 베스트_5", null),

	man_suit_setupSet("man_suit_setupSet", "셋업 세트", null),

	man_pants("man_pants", "팬츠",
			Arrays.asList("man_pants_chinos", "man_pants_slacks", "man_pants_suitPants", "man_pants_jogger",
					"man_pants_denim", "man_pants_shorts")),

	man_pants_chinos("man_pants_chinos", "치노_6", null),

	man_pants_slacks("man_pants_slacks", "슬랙스_6", null),

	man_pants_suitPants("man_pants_suitPants", "수트팬츠_6", null),

	man_pants_jogger("man_pants_jogger", "조거/스웻_6", null),

	man_pants_denim("man_pants_denim", "데님_6", null),

	man_pants_shorts("man_pants_shorts", "쇼츠_7", null),

	man_jacket("man_jacket", "재킷/베스트",
			Arrays.asList("man_jacket_jacket", "man_jacket_blazer", "man_jacket_leatherJacket", "man_jacket_vest")),

	man_jacket_jacket("man_jacket_jacket", "재킷_4", null),

	man_jacket_blazer("man_jacket_blazer", "블레이저_4", null),

	man_jacket_leatherJacket("man_jacket_leatherJacket", "레더 재킷_4", null),

	man_jacket_vest("man_jacket_vest", "베스트_5", null),

	man_shirt("man_shirt", "셔츠", Arrays.asList("man_shirt_sleevelong", "man_shirt_sleeveshort")),

	man_shirt_sleevelong("man_shirt_sleevelong", "긴팔셔츠_0", null),

	man_shirt_sleeveshort("man_shirt_sleeveshort", "반팔셔츠_0", null),

	man_neat("man_neat", "니트", Arrays.asList("man_neat_cardigan", "man_neat_pullover", "man_neat_vest")),

	man_neat_cardigan("man_neat_cardigan", "카디건_3", null),

	man_neat_pullover("man_neat_pullover", "풀오버_2", null),

	man_neat_vest("man_neat_vest", "베스트_5", null),

	man_tshirt("man_tshirt", "티셔츠",
			Arrays.asList("man_tshirt_sleeveshort", "man_tshirt_sleevelong", "man_tshirt_sleeveless")),

	man_tshirt_sleeveshort("man_tshirt_sleeveshort", "반팔티셔츠_1", null),

	man_tshirt_sleevelong("man_tshirt_sleevelong", "긴팔티셔츠_1", null),

	man_tshirt_sleeveless("man_tshirt_sleeveless", "민소매_1", null),

	kids("kids", "키즈", Arrays.asList("kids_boy", "kids_girl")),

	kids_boy("kids_boy", "남아",
			Arrays.asList("kids_boy_outer", "kids_boy_tshirt", "kids_boy_shirt", "kids_boy_neat", "kids_boy_pants")),

	kids_boy_outer("kids_boy_outer", "아우터",
			Arrays.asList("kids_boy_outer_padding", "kids_boy_outer_jumper", "kids_boy_outer_coat",
					"kids_boy_outer_jacket")),

	kids_boy_outer_padding("kids_boy_outer_padding", "다운/패딩_4", null),

	kids_boy_outer_jumper("kids_boy_outer_jumper", "점퍼_4", null),

	kids_boy_outer_coat("kids_boy_outer_coat", "코트_9", null),

	kids_boy_outer_jacket("kids_boy_outer_jacket", "재킷/베스트_5", null),

	kids_boy_tshirt("kids_boy_tshirt", "티셔츠",
			Arrays.asList("kids_boy_tshirt_sleevelong", "kids_boy_tshirt_sleeveshort")),

	kids_boy_tshirt_sleevelong("kids_boy_tshirt_sleevelong", "긴팔_1", null),

	kids_boy_tshirt_sleeveshort("kids_boy_tshirt_sleeveshort", "반팔/민소매_1", null),

	kids_boy_shirt("kids_boy_shirt", "셔츠", Arrays.asList("kids_boy_shirt_sleevelong", "kids_boy_shirt_sleeveshort")),

	kids_boy_shirt_sleevelong("kids_boy_shirt_sleevelong", "긴팔_0", null),

	kids_boy_shirt_sleeveshort("kids_boy_shirt_sleeveshort", "반팔_0", null),

	kids_boy_neat("kids_boy_neat", "니트", Arrays.asList("kids_boy_neat_pullover", "kids_boy_neat_cardigan")),

	kids_boy_neat_pullover("kids_boy_neat_pullover", "풀오버_2", null),

	kids_boy_neat_cardigan("kids_boy_neat_cardigan", "카디건/베스트_3", null),

	kids_boy_pants("kids_boy_pants", "팬츠", Arrays.asList("kids_boy_pants_long", "kids_boy_pants_short")),

	kids_boy_pants_long("kids_boy_pants_long", "롱 팬츠_6", null),

	kids_boy_pants_short("kids_boy_pants_short", "쇼트 팬츠_7", null),

	kids_girl("kids_girl", "여아",
			Arrays.asList("kids_girl_outer", "kids_girl_tshirt", "kids_girl_shirtAndBlouse", "kids_girl_onepiece",
					"kids_girl_neat", "kids_girl_pantsAndSkirt")),

	kids_girl_outer("kids_girl_outer", "아우터",
			Arrays.asList("kids_girl_outer_padding", "kids_girl_outer_jumper", "kids_girl_outer_coat",
					"kids_girl_outer_jacket")),

	kids_girl_outer_padding("kids_girl_outer_padding", "다운/패딩_4", null),

	kids_girl_outer_jumper("kids_girl_outer_jumper", "점퍼_4", null),

	kids_girl_outer_coat("kids_girl_outer_coat", "코트_9", null),

	kids_girl_outer_jacket("kids_girl_outer_jacket", "재킷/베스트_4", null),

	kids_girl_tshirt("kids_girl_tshirt", "티셔츠",
			Arrays.asList("kids_girl_tshirt_sleevelong", "kids_girl_tshirt_sleeveshort")),

	kids_girl_tshirt_sleevelong("kids_girl_tshirt_sleevelong", "긴팔_1", null),

	kids_girl_tshirt_sleeveshort("kids_girl_tshirt_sleeveshort", "반팔/민소매_1", null),

	kids_girl_shirtAndBlouse("kids_girl_shirtAndBlouse", "셔츠/블라우스",
			Arrays.asList("kids_girl_shirtAndBlouse_sleevelong", "kids_girl_shirtAndBlouse_sleeveshort")),

	kids_girl_shirtAndBlouse_sleevelong("kids_girl_shirtAndBlouse_sleevelong", "긴팔_0", null),

	kids_girl_shirtAndBlouse_sleeveshort("kids_girl_shirtAndBlouse_sleeveshort", "반팔_0", null),

	kids_girl_onepiece("kids_girl_onepiece", "원피스_10", null),

	kids_girl_neat("kids_girl_neat", "니트", Arrays.asList("kids_girl_neat_pullover", "kids_girl_neat_cardigan")),

	kids_girl_neat_pullover("kids_girl_neat_pullover", "풀오버_2", null),

	kids_girl_neat_cardigan("kids_girl_neat_cardigan", "카디건/베스트_3", null),

	kids_girl_pantsAndSkirt("kids_girl_pantsAndSkirt", "팬츠/스커트",
			Arrays.asList("kids_girl_pantsAndSkirt_long", "kids_girl_pantsAndSkirt_skirt",
					"kids_girl_pantsAndSkirt_short")),

	kids_girl_pantsAndSkirt_long("kids_girl_pantsAndSkirt_long", "롱 팬츠_6", null),

	kids_girl_pantsAndSkirt_skirt("kids_girl_pantsAndSkirt_skirt", "스커트_8", null),

	kids_girl_pantsAndSkirt_short("kids_girl_pantsAndSkirt_short", "쇼트 팬츠_7", null),

	luxury("luxury", "럭셔리",
			Arrays.asList("luxury_woman", "luxury_womanBag", "luxury_womanShoes", "luxury_womanWatch", "luxury_man",
					"luxury_manBag", "luxury_manShoes", "luxury_manWatch")),

	luxury_woman("luxury_woman", "여성의류",
			Arrays.asList("luxury_woman_outer", "luxury_woman_jacketAndVest", "luxury_woman_tshirt",
					"luxury_woman_shirtAndBlouse", "luxury_woman_neat", "luxury_woman_onepiece", "luxury_woman_pants",
					"luxury_woman_skirt", "luxury_woman_beachwear")),

	luxury_woman_outer("luxury_woman_outer", "아우터",
			Arrays.asList("luxury_woman_outer_coat", "luxury_woman_outer_jumper", "luxury_woman_outer_padding",
					"luxury_woman_outer_fur", "luxury_woman_outer_trench")),

	luxury_woman_outer_coat("luxury_woman_outer_coat", "코트_9", null),

	luxury_woman_outer_jumper("luxury_woman_outer_jumper", "점퍼_4", null),

	luxury_woman_outer_padding("luxury_woman_outer_padding", "다운/패딩_4", null),

	luxury_woman_outer_fur("luxury_woman_outer_fur", "퍼_4", null),

	luxury_woman_outer_trench("luxury_woman_outer_trench", "트렌치_9", null),

	luxury_woman_jacketAndVest("luxury_woman_jacketAndVest", "재킷/베스트",
			Arrays.asList("luxury_woman_jacketAndVest_jacket", "luxury_woman_jacketAndVest_blazer",
					"luxury_woman_jacketAndVest_leatherJacket", "luxury_woman_jacketAndVest_vest")),

	luxury_woman_jacketAndVest_jacket("luxury_woman_jacketAndVest_jacket", "재킷_4", null),

	luxury_woman_jacketAndVest_blazer("luxury_woman_jacketAndVest_blazer", "블레이저_4", null),

	luxury_woman_jacketAndVest_leatherJacket("luxury_woman_jacketAndVest_leatherJacket", "레더 재킷_4", null),

	luxury_woman_jacketAndVest_vest("luxury_woman_jacketAndVest_vest", "베스트_5", null),

	luxury_woman_tshirt("luxury_woman_tshirt", "티셔츠",
			Arrays.asList("luxury_woman_tshirt_sleevelong", "luxury_woman_tshirt_sleeveshort",
					"luxury_woman_tshirt_sleeveless")),

	luxury_woman_tshirt_sleevelong("luxury_woman_tshirt_sleevelong", "긴팔_1", null),

	luxury_woman_tshirt_sleeveshort("luxury_woman_tshirt_sleeveshort", "반팔_1", null),

	luxury_woman_tshirt_sleeveless("luxury_woman_tshirt_sleeveless", "민소매_1", null),

	luxury_woman_shirtAndBlouse("luxury_woman_shirtAndBlouse", "셔츠/블라우스",
			Arrays.asList("luxury_woman_shirtAndBlouse_shirtSleeveshort",
					"luxury_woman_shirtAndBlouse_blouseSleeveshort", "luxury_woman_shirtAndBlouse_shirtSleevelong",
					"luxury_woman_shirtAndBlouse_blouseSleevelong", "luxury_woman_shirtAndBlouse_blouseSleeveless")),

	luxury_woman_shirtAndBlouse_shirtSleeveshort("luxury_woman_shirtAndBlouse_shirtSleeveshort", "반팔 셔츠_0", null),

	luxury_woman_shirtAndBlouse_blouseSleeveshort("luxury_woman_shirtAndBlouse_blouseSleeveshort", "반팔 블라우스_0", null),

	luxury_woman_shirtAndBlouse_shirtSleevelong("luxury_woman_shirtAndBlouse_shirtSleevelong", "긴팔 셔츠_0", null),

	luxury_woman_shirtAndBlouse_blouseSleevelong("luxury_woman_shirtAndBlouse_blouseSleevelong", "긴팔 블라우스_0", null),

	luxury_woman_shirtAndBlouse_blouseSleeveless("luxury_woman_shirtAndBlouse_blouseSleeveless", "민소매 블라우스_0", null),

	luxury_woman_neat("luxury_woman_neat", "니트",
			Arrays.asList("luxury_woman_neat_pullover", "luxury_woman_neat_cardigan", "luxury_woman_neat_vest")),

	luxury_woman_neat_pullover("luxury_woman_neat_pullover", "풀오버_2", null),

	luxury_woman_neat_cardigan("luxury_woman_neat_cardigan", "카디건_3", null),

	luxury_woman_neat_vest("luxury_woman_neat_vest", "베스트_5", null),

	luxury_woman_onepiece("luxury_woman_onepiece", "원피스",
			Arrays.asList("luxury_woman_onepiece_sleevelong", "luxury_woman_onepiece_sleeveshort")),

	luxury_woman_onepiece_sleevelong("luxury_woman_onepiece_sleevelong", "긴팔_10", null),

	luxury_woman_onepiece_sleeveshort("luxury_woman_onepiece_sleeveshort", "반팔/민소매_10", null),

	luxury_woman_pants("luxury_woman_pants", "팬츠",
			Arrays.asList("luxury_woman_pants_long", "luxury_woman_pants_short")),

	luxury_woman_pants_long("luxury_woman_pants_long", "롱/미디 팬츠_6", null),

	luxury_woman_pants_short("luxury_woman_pants_short", "쇼트 팬츠_7", null),

	luxury_woman_skirt("luxury_woman_skirt", "스커트",
			Arrays.asList("luxury_woman_skirt_long", "luxury_woman_skirt_short")),

	luxury_woman_skirt_long("luxury_woman_skirt_long", "롱/미디_8", null),

	luxury_woman_skirt_short("luxury_woman_skirt_short", "미니_8", null),

	luxury_woman_beachwear("luxury_woman_beachwear", "비치웨어",
			Arrays.asList("luxury_woman_beachwear_swimsuit", "luxury_woman_beachwear_bikini",
					"luxury_woman_beachwear_coverup", "luxury_woman_beachwear_etc")),

	luxury_woman_beachwear_swimsuit("luxury_woman_beachwear_swimsuit", "스윔수트", null),

	luxury_woman_beachwear_bikini("luxury_woman_beachwear_bikini", "비키니", null),

	luxury_woman_beachwear_coverup("luxury_woman_beachwear_coverup", "커버업/로브", null),

	luxury_woman_beachwear_etc("luxury_woman_beachwear_etc", "기타", null),

	luxury_womanBag("luxury_womanBag", "여성가방/지갑", Arrays.asList("luxury_womanBag_bag", "luxury_womanBag_purse")),

	luxury_womanBag_bag("luxury_womanBag_bag", "가방",
			Arrays.asList("luxury_womanBag_bag_clutch", "luxury_womanBag_bag_backpack", "luxury_womanBag_bag_shopper",
					"luxury_womanBag_bag_carrier", "luxury_womanBag_bag_tote", "luxury_womanBag_bag_cross")),

	luxury_womanBag_bag_clutch("luxury_womanBag_bag_clutch", "클러치", null),

	luxury_womanBag_bag_backpack("luxury_womanBag_bag_backpack", "백팩", null),

	luxury_womanBag_bag_shopper("luxury_womanBag_bag_shopper", "쇼퍼", null),

	luxury_womanBag_bag_carrier("luxury_womanBag_bag_carrier", "캐리어", null),

	luxury_womanBag_bag_tote("luxury_womanBag_bag_tote", "토트", null),

	luxury_womanBag_bag_cross("luxury_womanBag_bag_cross", "숄더/크로스", null),

	luxury_womanBag_purse("luxury_womanBag_purse", "지갑",
			Arrays.asList("luxury_womanBag_purse_card", "luxury_womanBag_purse_long", "luxury_womanBag_purse_etc",
					"luxury_womanBag_purse_mini")),

	luxury_womanBag_purse_card("luxury_womanBag_purse_card", "명함/카드지갑", null),

	luxury_womanBag_purse_long("luxury_womanBag_purse_long", "장지갑", null),

	luxury_womanBag_purse_etc("luxury_womanBag_purse_etc", "동전지갑/파우치/기타", null),

	luxury_womanBag_purse_mini("luxury_womanBag_purse_mini", "미니/반지갑", null),

	luxury_womanShoes("luxury_womanShoes", "여성슈즈",
			Arrays.asList("luxury_womanShoes_sandal", "luxury_womanShoes_slipper", "luxury_womanShoes_slipon",
					"luxury_womanShoes_flat", "luxury_womanShoes_walker", "luxury_womanShoes_sneakers",
					"luxury_womanShoes_heel")),

	luxury_womanShoes_sandal("luxury_womanShoes_sandal", "샌들", null),

	luxury_womanShoes_slipper("luxury_womanShoes_slipper", "슬리퍼/뮬", null),

	luxury_womanShoes_slipon("luxury_womanShoes_slipon", "슬립온", null),

	luxury_womanShoes_flat("luxury_womanShoes_flat", "플랫/로퍼", null),

	luxury_womanShoes_walker("luxury_womanShoes_walker", "워커/부츠", null),

	luxury_womanShoes_sneakers("luxury_womanShoes_sneakers", "운동화/스니커즈", null),

	luxury_womanShoes_heel("luxury_womanShoes_heel", "펌프스/힐", null),

	luxury_womanWatch("luxury_womanWatch", "여성 쥬얼리/시계",
			Arrays.asList("luxury_womanWatch_earing", "luxury_womanWatch_necklace", "luxury_womanWatch_bracelet",
					"luxury_womanWatch_ring", "luxury_womanWatch_hairAccessory", "luxury_womanWatch_brooch",
					"luxury_womanWatch_watch")),

	luxury_womanWatch_earing("luxury_womanWatch_earing", "귀걸이", null),

	luxury_womanWatch_necklace("luxury_womanWatch_necklace", "목걸이", null),

	luxury_womanWatch_bracelet("luxury_womanWatch_bracelet", "팔찌", null),

	luxury_womanWatch_ring("luxury_womanWatch_ring", "반지", null),

	luxury_womanWatch_hairAccessory("luxury_womanWatch_hairAccessory", "헤어악세서리", null),

	luxury_womanWatch_brooch("luxury_womanWatch_brooch", "브로치/펜던트", null),

	luxury_womanWatch_watch("luxury_womanWatch_watch", "시계", null),

	luxury_man("luxury_man", "남성의류",
			Arrays.asList("luxury_man_outer", "luxury_man_jacket", "luxury_man_tshirt", "luxury_man_shirt",
					"luxury_man_neat", "luxury_man_pants", "luxury_man_beachwear")),

	luxury_man_outer("luxury_man_outer", "아우터",
			Arrays.asList("luxury_man_outer_jumper", "luxury_man_outer_coat", "luxury_man_outer_padding",
					"luxury_man_outer_trench")),

	luxury_man_outer_jumper("luxury_man_outer_jumper", "점퍼_4", null),

	luxury_man_outer_coat("luxury_man_outer_coat", "코트_9", null),

	luxury_man_outer_padding("luxury_man_outer_padding", "다운/패딩_4", null),

	luxury_man_outer_trench("luxury_man_outer_trench", "트렌치_9", null),

	luxury_man_jacket("luxury_man_jacket", "재킷/베스트",
			Arrays.asList("luxury_man_jacket_jacket", "luxury_man_jacket_blazer", "luxury_man_jacket_leatherJacket",
					"luxury_man_jacket_vest")),

	luxury_man_jacket_jacket("luxury_man_jacket_jacket", "재킷_4", null),

	luxury_man_jacket_blazer("luxury_man_jacket_blazer", "블레이저_4", null),

	luxury_man_jacket_leatherJacket("luxury_man_jacket_leatherJacket", "레더 재킷_4", null),

	luxury_man_jacket_vest("luxury_man_jacket_vest", "베스트_5", null),

	luxury_man_tshirt("luxury_man_tshirt", "티셔츠",
			Arrays.asList("luxury_man_tshirt_sleeveshort", "luxury_man_tshirt_sleevelong",
					"luxury_man_tshirt_sleeveless")),

	luxury_man_tshirt_sleeveshort("luxury_man_tshirt_sleeveshort", "반팔_1", null),

	luxury_man_tshirt_sleevelong("luxury_man_tshirt_sleevelong", "긴팔_1", null),

	luxury_man_tshirt_sleeveless("luxury_man_tshirt_sleeveless", "민소매_1", null),

	luxury_man_shirt("luxury_man_shirt", "셔츠",
			Arrays.asList("luxury_man_shirt_sleevelong", "luxury_man_shirt_sleeveshort")),

	luxury_man_shirt_sleevelong("luxury_man_shirt_sleevelong", "긴팔_0", null),

	luxury_man_shirt_sleeveshort("luxury_man_shirt_sleeveshort", "반팔_0", null),

	luxury_man_neat("luxury_man_neat", "니트",
			Arrays.asList("luxury_man_neat_cardigan", "luxury_man_neat_pullover", "luxury_man_neat_vest")),

	luxury_man_neat_cardigan("luxury_man_neat_cardigan", "카디건_3", null),

	luxury_man_neat_pullover("luxury_man_neat_pullover", "풀오버_2", null),

	luxury_man_neat_vest("luxury_man_neat_vest", "베스트_5", null),

	luxury_man_pants("luxury_man_pants", "팬츠",
			Arrays.asList("luxury_man_pants_casualLong", "luxury_man_pants_denim", "luxury_man_pants_formal",
					"luxury_man_pants_suitPants", "luxury_man_pants_casualShort")),

	luxury_man_pants_casualLong("luxury_man_pants_casualLong", "캐주얼 롱 팬츠_6", null),

	luxury_man_pants_denim("luxury_man_pants_denim", "데님_6", null),

	luxury_man_pants_formal("luxury_man_pants_formal", "포멀_6", null),

	luxury_man_pants_suitPants("luxury_man_pants_suitPants", "정장_6", null),

	luxury_man_pants_casualShort("luxury_man_pants_casualShort", "캐주얼 쇼트 팬츠_7", null),

	luxury_man_beachwear("luxury_man_beachwear", "비치웨어",
			Arrays.asList("luxury_man_beachwear_swim", "luxury_man_beachwear_pants", "luxury_man_beachwear_etc")),

	luxury_man_beachwear_swim("luxury_man_beachwear_swim", "수영복", null),

	luxury_man_beachwear_pants("luxury_man_beachwear_pants", "비치팬츠", null),

	luxury_man_beachwear_etc("luxury_man_beachwear_etc", "기타", null),

	luxury_manBag("luxury_manBag", "남성가방/지갑", Arrays.asList("luxury_manBag_bag", "luxury_manBag_purse")),

	luxury_manBag_bag("luxury_manBag_bag", "가방",
			Arrays.asList("luxury_manBag_bag_clutch", "luxury_manBag_bag_tote", "luxury_manBag_bag_sling",
					"luxury_manBag_bag_briefcase", "luxury_manBag_bag_carrier", "luxury_manBag_bag_shoulder",
					"luxury_manBag_bag_backpack")),

	luxury_manBag_bag_clutch("luxury_manBag_bag_clutch", "클러치", null),

	luxury_manBag_bag_tote("luxury_manBag_bag_tote", "토트", null),

	luxury_manBag_bag_sling("luxury_manBag_bag_sling", "슬링백/힙색", null),

	luxury_manBag_bag_briefcase("luxury_manBag_bag_briefcase", "브리프케이스", null),

	luxury_manBag_bag_carrier("luxury_manBag_bag_carrier", "캐리어", null),

	luxury_manBag_bag_shoulder("luxury_manBag_bag_shoulder", "숄더/메신저", null),

	luxury_manBag_bag_backpack("luxury_manBag_bag_backpack", "백팩", null),

	luxury_manBag_purse("luxury_manBag_purse", "지갑",
			Arrays.asList("luxury_manBag_purse_moneyclip", "luxury_manBag_purse_card", "luxury_manBag_purse_long",
					"luxury_manBag_purse_keyholder", "luxury_manBag_purse_half", "luxury_manBag_purse_medium")),

	luxury_manBag_purse_moneyclip("luxury_manBag_purse_moneyclip", "머니클립", null),

	luxury_manBag_purse_card("luxury_manBag_purse_card", "명함/카드지갑", null),

	luxury_manBag_purse_long("luxury_manBag_purse_long", "장지갑", null),

	luxury_manBag_purse_keyholder("luxury_manBag_purse_keyholder", "키홀더/여권지갑", null),

	luxury_manBag_purse_half("luxury_manBag_purse_half", "반지갑", null),

	luxury_manBag_purse_medium("luxury_manBag_purse_medium", "중지갑", null),

	luxury_manShoes("luxury_manShoes", "남성슈즈",
			Arrays.asList("luxury_manShoes_slipon", "luxury_manShoes_shoes", "luxury_manShoes_slipper",
					"luxury_manShoes_sandal", "luxury_manShoes_sneakers", "luxury_manShoes_walker")),

	luxury_manShoes_slipon("luxury_manShoes_slipon", "슬립온", null),

	luxury_manShoes_shoes("luxury_manShoes_shoes", "구두", null),

	luxury_manShoes_slipper("luxury_manShoes_slipper", "슬리퍼/뮬", null),

	luxury_manShoes_sandal("luxury_manShoes_sandal", "샌들", null),

	luxury_manShoes_sneakers("luxury_manShoes_sneakers", "운동화/스니커즈", null),

	luxury_manShoes_walker("luxury_manShoes_walker", "워커/부츠", null),

	luxury_manWatch("luxury_manWatch", "남성 쥬얼리/시계",
			Arrays.asList("luxury_manWatch_jewerly", "luxury_manWatch_watch", "luxury_manWatch_etc")),

	luxury_manWatch_jewerly("luxury_manWatch_jewerly", "쥬얼리", null),

	luxury_manWatch_watch("luxury_manWatch_watch", "시계", null),

	luxury_manWatch_etc("luxury_manWatch_etc", "기타", null),

	sports("sports", "스포츠",
			Arrays.asList("sports_outdoor", "sports_running", "sports_yoga", "sports_fitness", "sports_athleisure",
					"sports_tennis", "sports_swim", "sports_soccer")),

	sports_outdoor("sports_outdoor", "아웃도어/캠핑",
			Arrays.asList("sports_outdoor_man", "sports_outdoor_woman", "sports_outdoor_shoes",
					"sports_outdoor_headgear", "sports_outdoor_bag")),

	sports_outdoor_man("sports_outdoor_man", "남성 의류",
			Arrays.asList("sports_outdoor_man_outer", "sports_outdoor_man_jacket", "sports_outdoor_man_hoodie",
					"sports_outdoor_man_tshirt", "sports_outdoor_man_pants")),

	sports_outdoor_man_outer("sports_outdoor_man_outer", "아우터_4", null),

	sports_outdoor_man_jacket("sports_outdoor_man_jacket", "재킷/베스트_4", null),

	sports_outdoor_man_hoodie("sports_outdoor_man_hoodie", "맨투맨/후디_1", null),

	sports_outdoor_man_tshirt("sports_outdoor_man_tshirt", "티셔츠/슬리브리스_1", null),

	sports_outdoor_man_pants("sports_outdoor_man_pants", "팬츠/타이즈_6", null),

	sports_outdoor_woman("sports_outdoor_woman", "여성 의류",
			Arrays.asList("sports_outdoor_woman_outer", "sports_outdoor_woman_jacket", "sports_outdoor_woman_hoodie",
					"sports_outdoor_woman_tshirt", "sports_outdoor_woman_pants")),

	sports_outdoor_woman_outer("sports_outdoor_woman_outer", "아우터_4", null),

	sports_outdoor_woman_jacket("sports_outdoor_woman_jacket", "재킷/베스트_4", null),

	sports_outdoor_woman_hoodie("sports_outdoor_woman_hoodie", "맨투맨/후디_1", null),

	sports_outdoor_woman_tshirt("sports_outdoor_woman_tshirt", "티셔츠/슬리브리스_1", null),

	sports_outdoor_woman_pants("sports_outdoor_woman_pants", "팬츠/타이즈_6", null),

	sports_outdoor_shoes("sports_outdoor_shoes", "슈즈",
			Arrays.asList("sports_outdoor_shoes_tracking", "sports_outdoor_shoes_hicking",
					"sports_outdoor_shoes_walking")),

	sports_outdoor_shoes_tracking("sports_outdoor_shoes_tracking", "트레킹", null),

	sports_outdoor_shoes_hicking("sports_outdoor_shoes_hicking", "하이킹", null),

	sports_outdoor_shoes_walking("sports_outdoor_shoes_walking", "워킹", null),

	sports_outdoor_headgear("sports_outdoor_headgear", "헤드기어", null),

	sports_outdoor_bag("sports_outdoor_bag", "배낭",
			Arrays.asList("sports_outdoor_bag_hicking", "sports_outdoor_bag_lifestyle")),

	sports_outdoor_bag_hicking("sports_outdoor_bag_hicking", "하이킹", null),

	sports_outdoor_bag_lifestyle("sports_outdoor_bag_lifestyle", "라이프스타일", null),

	sports_running("sports_running", "러닝/사이클",
			Arrays.asList("sports_running_man", "sports_running_woman", "sports_running_running",
					"sports_running_cycle")),

	sports_running_man("sports_running_man", "남성 의류",
			Arrays.asList("sports_running_man_outer", "sports_running_man_jacket", "sports_running_man_hoodie",
					"sports_running_man_tshirt", "sports_running_man_pants")),

	sports_running_man_outer("sports_running_man_outer", "아우터_4", null),

	sports_running_man_jacket("sports_running_man_jacket", "재킷/베스트_4", null),

	sports_running_man_hoodie("sports_running_man_hoodie", "맨투맨/후디_1", null),

	sports_running_man_tshirt("sports_running_man_tshirt", "티셔츠/슬리브리스_1", null),

	sports_running_man_pants("sports_running_man_pants", "팬츠/타이즈_6", null),

	sports_running_woman("sports_running_woman", "여성 의류",
			Arrays.asList("sports_running_woman_outer", "sports_running_woman_jacket", "sports_running_woman_hoodie",
					"sports_running_woman_tshirt", "sports_running_woman_pants")),

	sports_running_woman_outer("sports_running_woman_outer", "아우터_4", null),

	sports_running_woman_jacket("sports_running_woman_jacket", "재킷/베스트_4", null),

	sports_running_woman_hoodie("sports_running_woman_hoodie", "맨투맨/후디_1", null),

	sports_running_woman_tshirt("sports_running_woman_tshirt", "티셔츠/슬리브리스_1", null),

	sports_running_woman_pants("sports_running_woman_pants", "팬츠/타이즈_6", null),

	sports_running_running("sports_running_running", "러닝 용품",
			Arrays.asList("sports_running_running_shoes", "sports_running_running_accessory")),

	sports_running_running_shoes("sports_running_running_shoes", "러닝화", null),

	sports_running_running_accessory("sports_running_running_accessory", "액세서리", null),

	sports_running_cycle("sports_running_cycle", "사이클 용품",
			Arrays.asList("sports_running_cycle_shoes", "sports_running_cycle_accessory")),

	sports_running_cycle_shoes("sports_running_cycle_shoes", "사이클화", null),

	sports_running_cycle_accessory("sports_running_cycle_accessory", "액세서리", null),

	sports_yoga("sports_yoga", "요가/필라테스", Arrays.asList("sports_yoga_woman", "sports_yoga_supplies")),

	sports_yoga_woman("sports_yoga_woman", "여성 의류",
			Arrays.asList("sports_yoga_woman_outer", "sports_yoga_woman_top", "sports_yoga_woman_pants")),

	sports_yoga_woman_outer("sports_yoga_woman_outer", "아우터_4", null),

	sports_yoga_woman_top("sports_yoga_woman_top", "탑_1", null),

	sports_yoga_woman_pants("sports_yoga_woman_pants", "팬츠_6", null),

	sports_yoga_supplies("sports_yoga_supplies", "용품",
			Arrays.asList("sports_yoga_supplies_mat", "sports_yoga_supplies_hat", "sports_yoga_supplies_etc")),

	sports_yoga_supplies_mat("sports_yoga_supplies_mat", "매트", null),

	sports_yoga_supplies_hat("sports_yoga_supplies_hat", "모자/헤어밴드", null),

	sports_yoga_supplies_etc("sports_yoga_supplies_etc", "기타용품", null),

	sports_fitness("sports_fitness", "피트니스",
			Arrays.asList("sports_fitness_man", "sports_fitness_woman", "sports_fitness_supplies")),

	sports_fitness_man("sports_fitness_man", "남성의류",
			Arrays.asList("sports_fitness_man_outer", "sports_fitness_man_jacket", "sports_fitness_man_hoodie",
					"sports_fitness_man_tshirt", "sports_fitness_man_pants")),

	sports_fitness_man_outer("sports_fitness_man_outer", "아우터_4", null),

	sports_fitness_man_jacket("sports_fitness_man_jacket", "재킷/베스트_4", null),

	sports_fitness_man_hoodie("sports_fitness_man_hoodie", "맨투맨/후디_1", null),

	sports_fitness_man_tshirt("sports_fitness_man_tshirt", "티셔츠/슬리브리스_1", null),

	sports_fitness_man_pants("sports_fitness_man_pants", "팬츠/타이즈_6", null),

	sports_fitness_woman("sports_fitness_woman", "여성의류",
			Arrays.asList("sports_fitness_woman_outer", "sports_fitness_woman_jacket", "sports_fitness_woman_hoodie",
					"sports_fitness_woman_tshirt", "sports_fitness_woman_pants")),

	sports_fitness_woman_outer("sports_fitness_woman_outer", "아우터_4", null),

	sports_fitness_woman_jacket("sports_fitness_woman_jacket", "재킷/베스트_4", null),

	sports_fitness_woman_hoodie("sports_fitness_woman_hoodie", "맨투맨/후디_1", null),

	sports_fitness_woman_tshirt("sports_fitness_woman_tshirt", "티셔츠/슬리브리스_1", null),

	sports_fitness_woman_pants("sports_fitness_woman_pants", "팬츠/타이즈_6", null),

	sports_fitness_supplies("sports_fitness_supplies", "용품",
			Arrays.asList("sports_fitness_supplies_shoes", "sports_fitness_supplies_accessory")),

	sports_fitness_supplies_accessory("sports_fitness_supplies_accessory", "액세서리", null),

	sports_fitness_supplies_shoes("sports_fitness_supplies_shoes", "슈즈", null),

	sports_athleisure("sports_athleisure", "애슬레저",
			Arrays.asList("sports_athleisure_man", "sports_athleisure_woman", "sports_athleisure_supplies")),

	sports_athleisure_man("sports_athleisure_man", "남성 의류",
			Arrays.asList("sports_athleisure_man_outer", "sports_athleisure_man_top", "sports_athleisure_man_pants")),

	sports_athleisure_man_outer("sports_athleisure_man_outer", "아우터_4", null),

	sports_athleisure_man_top("sports_athleisure_man_top", "탑_1", null),

	sports_athleisure_man_pants("sports_athleisure_man_pants", "팬츠_6", null),

	sports_athleisure_woman("sports_athleisure_woman", "여성 의류",
			Arrays.asList("sports_athleisure_woman_outer", "sports_athleisure_woman_top",
					"sports_athleisure_woman_pants")),

	sports_athleisure_woman_outer("sports_athleisure_woman_outer", "아우터_4", null),

	sports_athleisure_woman_top("sports_athleisure_woman_top", "탑_1", null),

	sports_athleisure_woman_pants("sports_athleisure_woman_pants", "팬츠_6", null),

	sports_athleisure_supplies("sports_athleisure_supplies", "용품",
			Arrays.asList("sports_athleisure_supplies_shoes", "sports_athleisure_supplies_accessory",
					"sports_athleisure_supplies_etc")),

	sports_athleisure_supplies_shoes("sports_athleisure_supplies_shoes", "슈즈", null),

	sports_athleisure_supplies_accessory("sports_athleisure_supplies_accessory", "액세서리", null),

	sports_athleisure_supplies_etc("sports_athleisure_supplies_etc", "기타용품", null),

	sports_tennis("sports_tennis", "테니스",
			Arrays.asList("sports_tennis_man", "sports_tennis_woman", "sports_tennis_supplies")),

	sports_tennis_man("sports_tennis_man", "남성의류",
			Arrays.asList("sports_tennis_man_outer", "sports_tennis_man_top", "sports_tennis_man_pants")),

	sports_tennis_man_outer("sports_tennis_man_outer", "아우터_4", null),

	sports_tennis_man_top("sports_tennis_man_top", "탑_1", null),

	sports_tennis_man_pants("sports_tennis_man_pants", "팬츠_6", null),

	sports_tennis_woman("sports_tennis_woman", "여성의류",
			Arrays.asList("sports_tennis_woman_outer", "sports_tennis_woman_top", "sports_tennis_woman_pants")),

	sports_tennis_woman_outer("sports_tennis_woman_outer", "아우터_4", null),

	sports_tennis_woman_top("sports_tennis_woman_top", "탑_1", null),

	sports_tennis_woman_pants("sports_tennis_woman_pants", "팬츠/스커트_6", null),

	sports_tennis_supplies("sports_tennis_supplies", "용품",
			Arrays.asList("sports_tennis_supplies_bag", "sports_tennis_supplies_shoes",
					"sports_tennis_supplies_accessory", "sports_tennis_supplies_etc")),

	sports_tennis_supplies_bag("sports_tennis_supplies_bag", "테니스 가방", null),

	sports_tennis_supplies_shoes("sports_tennis_supplies_shoes", "슈즈", null),

	sports_tennis_supplies_accessory("sports_tennis_supplies_accessory", "액세서리", null),

	sports_tennis_supplies_etc("sports_tennis_supplies_etc", "기타용품", null),

	sports_swim("sports_swim", "수영", Arrays.asList("sports_swim_man", "sports_swim_woman", "sports_swim_supplies")),

	sports_swim_man("sports_swim_man", "남성 의류",
			Arrays.asList("sports_swim_man_indoors", "sports_swim_man_beachwearTop",
					"sports_swim_man_beachwearBottom")),

	sports_swim_man_indoors("sports_swim_man_indoors", "실내 수영복", null),

	sports_swim_man_beachwearTop("sports_swim_man_beachwearTop", "비치웨어 상의", null),

	sports_swim_man_beachwearBottom("sports_swim_man_beachwearBottom", "비치웨어 하의", null),

	sports_swim_woman("sports_swim_woman", "여성 의류",
			Arrays.asList("sports_swim_woman_general", "sports_swim_woman_bikini", "sports_swim_woman_beachwearTop",
					"sports_swim_woman_beachwearBottom")),

	sports_swim_woman_general("sports_swim_woman_general", "전신 수영복", null),

	sports_swim_woman_bikini("sports_swim_woman_bikini", "비키니", null),

	sports_swim_woman_beachwearTop("sports_swim_woman_beachwearTop", "비치웨어 상의", null),

	sports_swim_woman_beachwearBottom("sports_swim_woman_beachwearBottom", "비치웨어 하의", null),

	sports_swim_supplies("sports_swim_supplies", "용품",
			Arrays.asList("sports_swim_supplies_swim", "sports_swim_supplies_shoes", "sports_swim_supplies_accessory")),

	sports_swim_supplies_swim("sports_swim_supplies_swim", "수영용품", null),

	sports_swim_supplies_shoes("sports_swim_supplies_shoes", "슈즈", null),

	sports_swim_supplies_accessory("sports_swim_supplies_accessory", "액세서리", null),

	sports_soccer("sports_soccer", "축구",
			Arrays.asList("sports_soccer_uniform", "sports_soccer_shoes", "sports_soccer_supplies")),

	sports_soccer_uniform("sports_soccer_uniform", "유니폼", null),

	sports_soccer_shoes("sports_soccer_shoes", "축구화", null),

	sports_soccer_supplies("sports_soccer_supplies", "축구용품", null),

	bagAndShoes("bagAndShoes", "백＆슈즈",
			Arrays.asList("bagAndShoes_womanBag", "bagAndShoes_womanPurse", "bagAndShoes_womanShoes",
					"bagAndShoes_manBag", "bagAndShoes_manPurse", "bagAndShoes_manShoes")),

	bagAndShoes_womanBag("bagAndShoes_womanBag", "여성 가방",
			Arrays.asList("bagAndShoes_womanBag_tote", "bagAndShoes_womanBag_cross", "bagAndShoes_womanBag_shopper",
					"bagAndShoes_womanBag_clutch", "bagAndShoes_womanBag_backpack", "bagAndShoes_womanBag_echo",
					"bagAndShoes_womanBag_mini", "bagAndShoes_womanBag_carrier")),

	bagAndShoes_womanBag_tote("bagAndShoes_womanBag_tote", "토트", null),

	bagAndShoes_womanBag_cross("bagAndShoes_womanBag_cross", "숄더/크로스", null),

	bagAndShoes_womanBag_shopper("bagAndShoes_womanBag_shopper", "쇼퍼", null),

	bagAndShoes_womanBag_clutch("bagAndShoes_womanBag_clutch", "클러치", null),

	bagAndShoes_womanBag_backpack("bagAndShoes_womanBag_backpack", "백팩", null),

	bagAndShoes_womanBag_echo("bagAndShoes_womanBag_echo", "에코백", null),

	bagAndShoes_womanBag_mini("bagAndShoes_womanBag_mini", "미니백", null),

	bagAndShoes_womanBag_carrier("bagAndShoes_womanBag_carrier", "캐리어", null),

	bagAndShoes_womanPurse("bagAndShoes_womanPurse", "여성 지갑",
			Arrays.asList("bagAndShoes_womanPurse_mini", "bagAndShoes_womanPurse_medium", "bagAndShoes_womanPurse_long",
					"bagAndShoes_womanPurse_card", "bagAndShoes_womanPurse_etc")),

	bagAndShoes_womanPurse_mini("bagAndShoes_womanPurse_mini", "미니/반지갑", null),

	bagAndShoes_womanPurse_medium("bagAndShoes_womanPurse_medium", "중지갑", null),

	bagAndShoes_womanPurse_long("bagAndShoes_womanPurse_long", "장지갑", null),

	bagAndShoes_womanPurse_card("bagAndShoes_womanPurse_card", "명함/카드지갑", null),

	bagAndShoes_womanPurse_etc("bagAndShoes_womanPurse_etc", "동전지갑/파우치/기타", null),

	bagAndShoes_womanShoes("bagAndShoes_womanShoes", "여성 슈즈",
			Arrays.asList("bagAndShoes_womanShoes_heel", "bagAndShoes_womanShoes_flat", "bagAndShoes_womanShoes_sandal",
					"bagAndShoes_womanShoes_slipper", "bagAndShoes_womanShoes_sneakers",
					"bagAndShoes_womanShoes_slipon", "bagAndShoes_womanShoes_walker",
					"bagAndShoes_womanShoes_mountain")),

	bagAndShoes_womanShoes_heel("bagAndShoes_womanShoes_heel", "펌프스/힐", null),

	bagAndShoes_womanShoes_flat("bagAndShoes_womanShoes_flat", "플랫/로퍼", null),

	bagAndShoes_womanShoes_sandal("bagAndShoes_womanShoes_sandal", "샌들", null),

	bagAndShoes_womanShoes_slipper("bagAndShoes_womanShoes_slipper", "슬리퍼/뮬", null),

	bagAndShoes_womanShoes_sneakers("bagAndShoes_womanShoes_sneakers", "운동화/스니커즈", null),

	bagAndShoes_womanShoes_slipon("bagAndShoes_womanShoes_slipon", "슬립온", null),

	bagAndShoes_womanShoes_walker("bagAndShoes_womanShoes_walker", "워커/부츠", null),

	bagAndShoes_womanShoes_mountain("bagAndShoes_womanShoes_mountain", "등산화/골프화", null),

	bagAndShoes_manBag("bagAndShoes_manBag", "남성 가방",
			Arrays.asList("bagAndShoes_manBag_shoulder", "bagAndShoes_manBag_backpack", "bagAndShoes_manBag_briefcase",
					"bagAndShoes_manBag_clutch", "bagAndShoes_manBag_tote", "bagAndShoes_manBag_sling",
					"bagAndShoes_manBag_echo", "bagAndShoes_manBag_carrier")),

	bagAndShoes_manBag_shoulder("bagAndShoes_manBag_shoulder", "숄더/메신저", null),

	bagAndShoes_manBag_backpack("bagAndShoes_manBag_backpack", "백팩", null),

	bagAndShoes_manBag_briefcase("bagAndShoes_manBag_briefcase", "브리프케이스", null),

	bagAndShoes_manBag_clutch("bagAndShoes_manBag_clutch", "클러치", null),

	bagAndShoes_manBag_tote("bagAndShoes_manBag_tote", "토트", null),

	bagAndShoes_manBag_sling("bagAndShoes_manBag_sling", "슬링백/힙색", null),

	bagAndShoes_manBag_echo("bagAndShoes_manBag_echo", "에코백", null),

	bagAndShoes_manBag_carrier("bagAndShoes_manBag_carrier", "캐리어", null),

	bagAndShoes_manPurse("bagAndShoes_manPurse", "남성 지갑",
			Arrays.asList("bagAndShoes_manPurse_half", "bagAndShoes_manPurse_medium", "bagAndShoes_manPurse_long",
					"bagAndShoes_manPurse_moneyclip", "bagAndShoes_manPurse_card", "bagAndShoes_manPurse_keyholder")),

	bagAndShoes_manPurse_half("bagAndShoes_manPurse_half", "반지갑", null),

	bagAndShoes_manPurse_medium("bagAndShoes_manPurse_medium", "중지갑", null),

	bagAndShoes_manPurse_long("bagAndShoes_manPurse_long", "장지갑", null),

	bagAndShoes_manPurse_moneyclip("bagAndShoes_manPurse_moneyclip", "머니클립", null),

	bagAndShoes_manPurse_card("bagAndShoes_manPurse_card", "명함/카드지갑", null),

	bagAndShoes_manPurse_keyholder("bagAndShoes_manPurse_keyholder", "키홀더/여권지갑", null),

	bagAndShoes_manShoes("bagAndShoes_manShoes", "남성 슈즈",
			Arrays.asList("bagAndShoes_manShoes_sneakers", "bagAndShoes_manShoes_walker",
					"bagAndShoes_manShoes_slipper", "bagAndShoes_manShoes_slipon", "bagAndShoes_manShoes_shoes",
					"bagAndShoes_manShoes_sandal", "bagAndShoes_manShoes_mountain")),

	bagAndShoes_manShoes_sneakers("bagAndShoes_manShoes_sneakers", "운동화/스니커즈", null),

	bagAndShoes_manShoes_walker("bagAndShoes_manShoes_walker", "워커/부츠", null),

	bagAndShoes_manShoes_slipper("bagAndShoes_manShoes_slipper", "슬리퍼/뮬", null),

	bagAndShoes_manShoes_slipon("bagAndShoes_manShoes_slipon", "슬립온", null),

	bagAndShoes_manShoes_shoes("bagAndShoes_manShoes_shoes", "구두", null),

	bagAndShoes_manShoes_sandal("bagAndShoes_manShoes_sandal", "샌들", null),

	bagAndShoes_manShoes_mountain("bagAndShoes_manShoes_mountain", "등산화/골프화", null);

	private final String name;
	private final String name_kor;
	private final List<String> children;

	public String getSelf() {
		String[] nameArr = name.split("_");
		return nameArr[nameArr.length - 1];
	}

	public String getParent() {
		String[] nameArr = name.split("_");

		if (nameArr.length == 1) {
			return null;
		} else {
			return String.join("_", Arrays.copyOfRange(nameArr, 0, nameArr.length - 1));
		}
	}

	public String getNameKor() {
		return name_kor;
	}

	public List<String> getChildren() {
		return children;
	}

	CategoryEnum(String name, String name_kor, List<String> children) {
		this.name = name;
		this.name_kor = name_kor;
		this.children = children;
	}

}
