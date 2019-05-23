/*
 * AdministratorController.java
 * 
 * Copyright (C) 2019 Universidad de Sevilla
 * 
 * The use of this project is hereby constrained to the conditions of the
 * TDG Licence, a copy of which you may download from
 * http://www.tdg-seville.info/License.html
 */

package controllers;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import services.ActorService;

@Controller
@RequestMapping("/profile")
public class ActorController extends AbstractController {

	@Autowired
	private ActorService	actorService;


	// Constructors -----------------------------------------------------------

	public ActorController() {
		super();
	}

	@RequestMapping(value = "/download", method = RequestMethod.GET)
	public void getProfileData(HttpServletResponse response) {

		try {
			File file = this.actorService.getProfileFile();
			Path path = file.toPath();

			response.setContentType("text/plain");
			response.addHeader("Content-Disposition", "attachment; filename=" + "user_profile.txt");

			Files.copy(path, response.getOutputStream());
			response.getOutputStream().flush();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

	}

}
