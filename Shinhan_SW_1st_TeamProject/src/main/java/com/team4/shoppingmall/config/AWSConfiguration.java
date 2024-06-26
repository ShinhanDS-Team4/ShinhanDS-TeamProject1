package com.team4.shoppingmall.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;



@Configuration
@EnableWebMvc
public class AWSConfiguration implements WebMvcConfigurer{
	
	@Value("${aws.accesskey}")
	private String accessKey;

	@Value("${aws.secretkey}")
	private String secretKey;
	
	@Bean
	public BasicAWSCredentials AwsCredentials() {
		BasicAWSCredentials AwsCreds = new BasicAWSCredentials(accessKey, secretKey);	
		return AwsCreds;
	}	
	
	@Bean
	public AmazonS3 AwsS3Client() {
		
		AmazonS3 s3Builder = AmazonS3ClientBuilder.standard()
				.withRegion(Regions.AP_NORTHEAST_2)
				.withCredentials(new AWSStaticCredentialsProvider(this.AwsCredentials()))
				.build();	

		return s3Builder;
	}
}