/*Copyright 2017 Bright Interactive, All Rights Reserved.*/
package com.acme.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/")
public class AController
{
	@RequestMapping
	public String success()
	{
		return "PROJECT_NAME pipeline setup complete!";
	}
}
