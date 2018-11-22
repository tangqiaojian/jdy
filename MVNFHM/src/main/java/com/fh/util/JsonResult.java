package com.fh.util;

import java.util.HashMap;

public class JsonResult extends HashMap<String, Object> {

	/**
	 * 
	 */
	private static final long serialVersionUID = -594475513708446194L;

	public static JsonResult of() {
		return new JsonResult();
	}

}
