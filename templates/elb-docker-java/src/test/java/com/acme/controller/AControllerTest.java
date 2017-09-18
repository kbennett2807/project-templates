/*Copyright 2017 Bright Interactive, All Rights Reserved.*/
package com.acme.controller;

import static org.mockito.MockitoAnnotations.initMocks;

import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import org.junit.Before;
import org.junit.Test;
import org.mockito.InjectMocks;

public class AControllerTest
{
	private MockMvc mockMvc;

	@InjectMocks
	private AController controller;

	@Before
	public void setUp() throws Exception
	{
		initMocks(this);
		mockMvc = MockMvcBuilders.standaloneSetup(controller).build();
	}


	@Test
	public void successContainsAppName() throws Exception
	{
		mockMvc.perform(MockMvcRequestBuilders.get("/"))
			.andExpect(MockMvcResultMatchers.status().isOk())
			.andExpect(MockMvcResultMatchers.content().string("PROJECT_NAME pipeline setup complete!"));
	}
}