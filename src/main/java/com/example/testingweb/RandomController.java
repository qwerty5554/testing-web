package com.example.testingweb;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class RandomController {

  @RequestMapping("/api/v1/random")
  public @ResponseBody String random() {
    try
    {
        Thread.sleep((long)(Math.random() * 1000));
    }
    catch(InterruptedException e)
    {
         return "{\"status\": \"interrupted\"}";
    }
    return "{\"status\": \"ok\"}";
  }

}
