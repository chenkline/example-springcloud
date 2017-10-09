package cxy.example;

import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@EnableDiscoveryClient
@SpringBootApplication
public class ExampleProviderApp {

	public ExampleProviderApp() {
	}

	public static void main(String[] args) {
		new SpringApplicationBuilder(ExampleProviderApp.class).web(true).run(args);
	}

}
