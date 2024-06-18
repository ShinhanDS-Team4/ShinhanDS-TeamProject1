package com.team4.shoppingmall.customerTest;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.siot.IamportRestClient.IamportClient;

import oracle.net.aso.a;

@Service
public class PaymentService {
	
    private RestTemplate restTemplate = new RestTemplate();
    
    @Value("${imp.api.key}")
    private String apiKey;
    
    @Value("${imp.api.secretkey}")
    private String apiSecret;
    
    
	private String getAccessToken() {
        // Access Token �߱��� ���� API ȣ��
		
		
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/json");

        Map<String, String> body = new HashMap<>();
        body.put("imp_key", apiKey);
        body.put("imp_secret", apiSecret);

        HttpEntity<Map<String, String>> request = new HttpEntity<>(body, headers);

        ResponseEntity<Map> response = restTemplate.exchange(
                "https://api.iamport.kr/users/getToken", HttpMethod.POST, request, Map.class);

        Map<String, Object> responseBody = (Map<String, Object>) response.getBody().get("response");
        return (String) responseBody.get("access_token");
    }

    public String registerPaymentAmount(String merchantUid, int amount) {
        String accessToken = getAccessToken();

        // ���� �ݾ� ���� ����� ���� API ȣ��
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/json");
        headers.set("Authorization", accessToken);

        Map<String, Object> body = new HashMap<>();
        body.put("merchant_uid", merchantUid);
        body.put("amount", amount);

        HttpEntity<Map<String, Object>> request = new HttpEntity<>(body, headers);

        ResponseEntity<Map> response = restTemplate.exchange(
                "https://api.iamport.kr/payments/prepare", HttpMethod.POST, request, Map.class);
        
        if (response.getStatusCode().is2xxSuccessful()) {
            return "Payment amount registered successfully";
        } else {
            return "Failed to register payment amount";
        }
    }

    public String verifyPayment(String impUid, String merchantUid) {
        String accessToken = getAccessToken();

        // ���� ���� ��ȸ�� ���� API ȣ��
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", accessToken);

        HttpEntity<Void> entity = new HttpEntity<>(headers);
        ResponseEntity<Map> response = restTemplate.exchange(
                "https://api.iamport.kr/payments/" + impUid, HttpMethod.GET, entity, Map.class);

        Map<String, Object> paymentInfo = (Map<String, Object>) response.getBody().get("response");

        int actualAmount = (int) paymentInfo.get("amount");//�̴Ͻý��� ���ؼ� ������ ������ �ݾ�

        //��������� ���� �ݾ� ��������
        ResponseEntity<Map> prePaymentResponse = restTemplate.exchange(
                "https://api.iamport.kr/payments/prepare/" + merchantUid, HttpMethod.GET, entity, Map.class);
        
        Map<String, Object> prePaymentInfo = (Map<String, Object>) prePaymentResponse.getBody().get("response");
        int preRegisteredAmount = (int) prePaymentInfo.get("amount");
        
        if (actualAmount == preRegisteredAmount) {
            return "success";
        } else {
            // ���� �ݾ��� ��ġ���� ���� ��� ���� ���
            Map<String, String> body = new HashMap<>();
            body.put("merchant_uid", merchantUid);
            body.put("reason", "���� �ݾ� ����ġ");

            headers = new HttpHeaders();
            headers.set("Content-Type", "application/json");
            headers.set("Authorization", accessToken);

            HttpEntity<Map<String, String>> cancelRequest = new HttpEntity<>(body, headers);
            restTemplate.exchange("https://api.iamport.kr/payments/cancel", HttpMethod.POST, cancelRequest, Map.class);

            return "fail";
        }
    }
}
