package com.revature.service;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.revature.dao.UserDAOImpl;
import com.revature.model.User;

public class UserServiceImpl implements UserService {
	
	private static UserService userService;
	private final ObjectMapper mapper = new ObjectMapper();

	@Override
	public Object process(HttpServletRequest request, HttpServletResponse response) {
		if (request.getMethod().equals("GET")) {
			return getPlayer("admin");
		}
		if (request.getMethod().equals("POST")){
			try {
				User logPlayer = null;
				logPlayer = mapper.readValue(request.getReader(), User.class);
				final String username = logPlayer.getUsername();
				final String password = logPlayer.getPassword();
				User attempting = attemptAuthentication(username, password);
				if (attempting != null) {
					HttpSession session = request.getSession();
					session.setAttribute("username", attempting.getUsername());
					session.setAttribute("id", attempting.getId());
					String url = "https://www.google.com/";
					response.setHeader("Location", url);
					return attempting;
					}
			}catch (JsonParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JsonMappingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		return null; // TODO: Remove this later
		}
		
		
		return null;
	}
	
	public User attemptAuthentication(String username, String password) {
		return UserDAOImpl.getUserDAO().attemptAuthentication(username, password);
	}
	public User getPlayer(String username) {
		return UserDAOImpl.getUserDAO().getUser(username);
	}
	

}