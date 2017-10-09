package cxy.example;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.client.discovery.DiscoveryClient;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RefreshScope
public class ProviderController {

	
	private static final Logger LOG = LoggerFactory.getLogger(ProviderController.class);
    
    @Autowired
    private DiscoveryClient client;
    
	@Value("${testCount}")
    private Integer testCount;
	
	public Integer getTestCount() {
		return testCount;
	}
	
	@RequestMapping("/testCount")
    public String testCount() {
        return this.testCount.toString();
    }	
	
    @RequestMapping(value = "/add" ,method = RequestMethod.GET)
    public Integer add(@RequestParam Integer a, @RequestParam Integer b) {
    	
        //ServiceInstance instance = client.getLocalServiceInstance();
        Integer r = a + b;
        //LOG.info("/add, host:" + instance.getHost() + ", service_id:" + instance.getServiceId() + ", result:" + r);
        LOG.info("/add, result:" + r);
        return r;
    }

}
